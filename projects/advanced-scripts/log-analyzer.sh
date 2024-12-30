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
search_date=$(date +%Y/%m/%d)
search_days_since=""
grep_patterns=()
out_file="log_analysis_$(date +%Y%m%d_%H%M%S).txt"

# Help message
usage() {
    echo "Usage: sudo $0 [-h host1 host2 ...] [-s store1 store2 ...] [-d days_ago] [-du days_since] [-g grep_pattern]"
    echo "Options:"
    echo "  -h   Specify hosts to search logs for"
    echo "  -s   Specify stores to search logs for"
    echo "  -d   Specify number of days ago for logs (default is today, cannot be used with -du)"
    echo "  -du  Specify number of days since to check logs (cannot be used with -d)"
    echo "  -g   Specify a pattern to grep in the logs (can be used multiple times)"
    echo "  -o   Specify output file for the results (default: $out_file)"
    echo "Examples:"
    echo "  # Analyze today's logs for a specific host"
    echo "  sudo $0 -h tst1111red1"
    echo "  "
    echo "  # Analyze logs for a specific store from 10 days ago"
    echo "  sudo $0 -s 1111 -d 10"
    echo "  "
    echo "  # Analyze logs for multiple hosts over the last 5 days"
    echo "  sudo $0 -h tst1111red1 -h tst1111red0 -du 5"
    echo "  "
    echo "  # Analyze logs for a specific host and grep multiple patterns"
    echo "  sudo $0 -h tst1111red1 -g 'error' -g 'warning'"
    echo "  "
    echo "  # Save results to a custom output file"
    echo "  sudo $0 -h tst1111red1 -o custom_output.txt"
    echo "  "
    echo "  # Error example: Using -d and -du together"
    echo "  sudo $0 -h tst1111red1 -d 10 -du 5"
    echo "  # Output: Error: -d and -du cannot be used together."
    exit 1
}

# Parse command-line arguments
while getopts "h:s:d:du:g:o:" opt; do
    case $opt in
        h) search_hosts+=(${OPTARG//,/ });;
        s) search_stores+=(${OPTARG//,/ });;
        d) 
            if [ -n "$search_days_since" ]; then
                red "Error: -d and -du cannot be used together."
                exit 1
            fi
            search_date=$(sudo date -d "$OPTARG days ago" +%Y/%m/%d);;
        du) 
            if [ -n "$search_date" ]; then
                red "Error: -d and -du cannot be used together."
                exit 1
            fi
            search_days_since=$OPTARG;;
        g) grep_patterns+=($OPTARG);;
        o) out_file=$OPTARG;;
        *) usage;;
    esac
done

if [ ${#search_hosts[@]} -eq 0 ] && [ ${#search_stores[@]} -eq 0 ]; then
    usage
fi

# Analyze logs
analyze_logs() {
    local log_file=$1
    if [ ! -f "$log_file" ]; then
        red "Error: Log file $log_file not found."
        return
    fi

    local total_lines=$(sudo wc -l < "$log_file")
    local error_count=$(sudo grep -c -Ei "Error|failed" "$log_file")
    local warning_count=$(sudo grep -c -Ei "Warning" "$log_file")

    echo -e "\nAnalyzing log file: $log_file" | tee -a "$out_file"
    echo "Total lines processed: $total_lines" | tee -a "$out_file"
    echo -e "Total Errors: $(red $error_count)" | tee -a "$out_file"
    echo -e "Total Warnings: $(yellow $warning_count)" | tee -a "$out_file"

    for pattern in "${grep_patterns[@]}"; do
        echo "Matching lines for pattern '$pattern':" | tee -a "$out_file"
        local matches=$(sudo grep -Ei "$pattern" "$log_file")
        if [ -n "$matches" ]; then
            echo "$matches" | tee -a "$out_file"
        else
            yellow "No matches found for pattern '$pattern'." | tee -a "$out_file"
        fi
    done
}

# Search for logs and analyze
search_logs() {
    local base_path=$1
    local current_date=$(sudo date +%Y/%m/%d)

    for host_or_store in "${@:2}"; do
        local found_logs=false

        for dir in $(sudo find "$base_path" -type d -name "*$host_or_store*" 2>/dev/null); do
            if [ -n "$search_days_since" ]; then
                for ((i=$search_days_since; i>=0; i--)); do
                    local log_date=$(sudo date -d "$i days ago" +%Y/%m/%d)
                    local log_path="$dir/$log_date/messages"

                    if [ ! -f "$log_path" ]; then
                        # Check for compressed logs
                        log_path_gz="$log_path.gz"
                        log_path_tz="$log_path.tz"
                        if [ -f "$log_path_gz" ]; then
                            sudo gunzip -c "$log_path_gz" > "/tmp/messages"
                            log_path="/tmp/messages"
                        elif [ -f "$log_path_tz" ]; then
                            sudo tar -O -xzf "$log_path_tz" -C "/tmp" messages
                            log_path="/tmp/messages"
                        else
                            continue
                        fi
                    fi

                    found_logs=true
                    analyze_logs "$log_path"
                done
            else
                local log_path="$dir/$search_date/messages"

                if [ ! -f "$log_path" ]; then
                    # Check for compressed logs
                    log_path_gz="$log_path.gz"
                    log_path_tz="$log_path.tz"
                    if [ -f "$log_path_gz" ]; then
                        sudo gunzip -c "$log_path_gz" > "/tmp/messages"
                        log_path="/tmp/messages"
                    elif [ -f "$log_path_tz" ]; then
                        sudo tar -O -xzf "$log_path_tz" -C "/tmp" messages
                        log_path="/tmp/messages"
                    else
                        continue
                    fi
                fi

                found_logs=true
                analyze_logs "$log_path"
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

echo -e "\nAnalysis completed. Results saved to $out_file." | green
