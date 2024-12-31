#!/bin/bash

# Colors for output
colorize() {
    local color_code=$1
    shift
    echo -e "\e[${color_code}m$*\e[0m"
}

red() {
    colorize "31" "$@"
}

yellow() {
    colorize "33" "$@"
}

green() {
    colorize "32" "$@"
}

# Default parameters
log_dir_base="/var/log/hosts/"
search_hosts=()
search_stores=()
search_date=""
search_range_days=""
grep_patterns=()
out_file="log_analysis_$(date +%Y%m%d_%H%M%S).txt"

# Help message
usage() {
    echo "Usage: sudo $0 [-h host1 host2 ...] [-s store1 store2 ...] [-d days_ago] [-r range_days] [-g grep_pattern] [-o output_file]"
    echo "Options:"
    echo "  -h   Specify hosts to search logs for"
    echo "  -s   Specify stores to search logs for"
    echo "  -d   Specify number of days ago for logs (default is today, cannot be used with -r)"
    echo "  -r   Specify number of days to check logs (cannot be used with -d)"
    echo "  -g   Specify a pattern to grep in the logs (can be used multiple times)"
    echo "  -o   Specify output file for the results (default: $out_file)"
    echo "Examples:"
    echo "  sudo $0 -h tst1111red1 -d 10"
    echo "  sudo $0 -s 1111 -r 5"
    echo "  sudo $0 -h tst1111red1 -g 'error' -g 'warning'"
    echo "  sudo $0 -h tst1111red1 -o custom_output.txt"
    echo "  sudo $0 -h tst1111red1 -r 5 -g 'critical'"
    exit 1
}

# Parse command-line arguments
while getopts "h:s:d:r:g:o:" opt; do
    case $opt in
        h) search_hosts+=(${OPTARG//,/ });;
        s) search_stores+=(${OPTARG//,/ });;
        d) search_date=$(sudo date -d "$OPTARG days ago" +%Y/%m/%d);;
        r) search_range_days=$OPTARG;;
        g) grep_patterns+=($OPTARG);;
        o) out_file=$OPTARG;;
        *) usage;;
    esac
done

# Validate conflicting options
if [ -n "$search_date" ] && [ -n "$search_range_days" ]; then
    red "Error: -d and -r cannot be used together."
    usage
fi

# Ensure at least one target is provided
if [ ${#search_hosts[@]} -eq 0 ] && [ ${#search_stores[@]} -eq 0 ]; then
    red "Error: You must specify at least one host (-h) or one store (-s)."
    usage
fi

# Analyze logs
analyze_logs() {
    local log_file=$1
    local log_date=$2
    if [ ! -f "$log_file" ]; then
        yellow "Warning: Log file $log_file not found."
        return
    fi

    echo -e "\nAnalyzing log file from date: $log_date" | tee -a "$out_file"
    echo "Log file: $log_file" | tee -a "$out_file"

    local total_lines=$(sudo wc -l < "$log_file")
    local error_count=$(sudo grep -c -Ei "Error|failed" "$log_file")
    local warning_count=$(sudo grep -c -Ei "Warning" "$log_file")

    echo "Total lines processed: $total_lines" | tee -a "$out_file"
    echo -e "Total Errors: $(red $error_count)" | tee -a "$out_file"
    echo -e "Total Warnings: $(yellow $warning_count)" | tee -a "$out_file"

    # Top 5 error messages
    echo "Top 5 Error Messages:" | tee -a "$out_file"
    sudo grep -Ei "Error|failed" "$log_file" | sort | uniq -c | sort -nr | head -5 | tee -a "$out_file"

    # Top 5 warning messages
    echo "Top 5 Warning Messages:" | tee -a "$out_file"
    sudo grep -Ei "Warning" "$log_file" | sort | uniq -c | sort -nr | head -5 | tee -a "$out_file"

    # Critical events
    echo "Critical Events:" | tee -a "$out_file"
    sudo grep -Eni "Critical" "$log_file" | head -5 | tee -a "$out_file"

    # Grep for specific patterns
    for pattern in "${grep_patterns[@]}"; do
        echo "Matching lines for pattern '$pattern':" | tee -a "$out_file"
        sudo grep -Ei "$pattern" "$log_file" | tee -a "$out_file"
    done
}

# Search for logs and analyze
search_logs() {
    local base_path=$1
    local current_date=$(sudo date +%Y/%m/%d)

    for host_or_store in "${@:2}"; do
        local found_logs=false

        for dir in $(sudo find "$base_path" -type d -name "*$host_or_store*" 2>/dev/null); do
            if [ -n "$search_range_days" ]; then
                for ((i=0; i<=$search_range_days; i++)); do
                    local log_date=$(sudo date -d "$i days ago" +%Y/%m/%d)
                    local log_path="$dir/$log_date/messages"

                    if [ -f "$log_path" ]; then
                        found_logs=true
                        analyze_logs "$log_path" "$log_date"
                    fi
                done
            elif [ -n "$search_date" ]; then
                local log_path="$dir/$search_date/messages"

                if [ -f "$log_path" ]; then
                    found_logs=true
                    analyze_logs "$log_path" "$search_date"
                fi
            fi
        done

        if [ "$found_logs" = false ]; then
            yellow "Warning: No logs found for $host_or_store on the specified date(s)." | tee -a "$out_file"
        fi
    done
}

# Main execution
if [ ${#search_hosts[@]} -gt 0 ]; then
    search_logs "$log_dir_base" "${search_hosts[@]}"
fi

if [ ${#search_stores[@]} -gt 0 ]; then
    search_logs "$log_dir_base" "${search_stores[@]}"
fi

# Summary
echo -e "\nSummary of Analysis:" | tee -a "$out_file"
echo "Total Hosts Analyzed: ${#search_hosts[@]}" | tee -a "$out_file"
echo "Total Stores Analyzed: ${#search_stores[@]}" | tee -a "$out_file"
echo "Output File: $out_file" | tee -a "$out_file"

green "\nAnalysis completed. Results saved to $out_file."
