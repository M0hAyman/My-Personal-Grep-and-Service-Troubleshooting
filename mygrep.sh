#!/bin/bash

# Function to print usage information
print_usage() {
    echo "Usage: $0 [options] search_string filename"
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show non-matching lines)"
    echo "  --help  Show this help message"
    exit 1
}

# If --help is passed
if [[ "$1" == "--help" ]]; then
    print_usage
fi

# Initialize flags
show_line_numbers=false
invert_match=false

# Manual option parsing to allow combined options like -vn
while [[ "$1" == -* ]]; do
    if [[ "$1" == "--" ]]; then
        shift
        break
    fi

    case "$1" in
        -*)
            opts="${1#-}"  # remove leading dash
            for (( i=0; i<${#opts}; i++ )); do
                opt="${opts:$i:1}"
                case "$opt" in
                    n) show_line_numbers=true ;;
                    v) invert_match=true ;;
                    *) echo "Error: Unknown option -$opt"; print_usage ;;
                esac
            done
            ;;
    esac
    shift
done

# After option parsing
if [[ -z "$1" ]]; then
    echo "Error: Missing search string."
    print_usage
fi

if [[ -f "$1" && -z "$2" ]]; then
    echo "Error: Missing search string."
    print_usage
fi

if [[ -z "$2" ]]; then
    echo "Error: Missing filename."
    print_usage
fi


search_string="$1"
filename="$2"

# Validate file existence
if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Build grep options
grep_options="-i --color=always"  # case-insensitive + highlight matches

if $invert_match; then
    grep_options="$grep_options -v"
fi

# Execute grep and capture output
if $show_line_numbers; then
    output=$(grep $grep_options -n -- "$search_string" "$filename")
else
    output=$(grep $grep_options -- "$search_string" "$filename")
fi

# Check and print output
if [[ -z "$output" ]]; then
    echo "No matches found."
else
    echo "$output"
fi
