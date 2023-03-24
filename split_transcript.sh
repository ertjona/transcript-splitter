#!/bin/bash

### This script splits a transcript file into smaller chunks based on a specified number of characters.
### Usage: split_transcript.sh <input_file> <output_prefix> <max_chars_per_chunk>
function usage() {
    echo "Usage: $0 <input_file> <output_prefix> <max_chars_per_chunk>"
    echo ""
    echo " input_file: The path to the input transcript file."
    echo " output_prefix: The prefix to use for the output files."
    echo " max_chars_per_chunk: The maximum number of characters to include in each output file."
    echo ""
    echo "Example: $0 transcript.txt chunk_ 1000"
    echo " This will split the transcript.txt file into chunks of up to 1000 characters each, with output files named chunk_001.txt, chunk_002.txt, etc."
}

if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    usage
    exit 0
fi

# read input parameters
input_file="$1"
output_prefix="$2"
max_chars_per_chunk="$3"

# validate input parameters
if [[ -z "$input_file" ]]; then
    echo "Please specify the input file"
    exit 1
fi

if [[ ! -f "$input_file" ]]; then
    echo "Input file does not exist"
    exit 1
fi

if [[ -z "$output_prefix" ]]; then
    echo "Please specify the output prefix"
    exit 1
fi

if [[ -z "$max_chars_per_chunk" || "$max_chars_per_chunk" -le 100 ]]; then
    echo "Max characters per chunk must be greater than 100"
    exit 1
fi

# split file into sections
num_lines=$(wc -l < "$input_file")
num_files=1
chars_so_far=0
current_file="$output_prefix$num_files.txt"

while read line; do
    # skip lines with less than 5 words
    words=$(echo "$line" | wc -w)
    if [[ $words -lt 5 ]]; then
        continue
    fi
    
    line_len=${#line}
    if [[ $((chars_so_far + line_len)) -gt $max_chars_per_chunk ]]; then
        num_files=$((num_files + 1))
        current_file="$output_prefix$(printf "%03d" $num_files).txt"
        chars_so_far=0
    fi
    
    echo "$line" >> "$current_file"
    chars_so_far=$((chars_so_far + line_len))
done < "$input_file"

echo "Split $input_file into $num_files files with up to $max_chars_per_chunk characters per file."
