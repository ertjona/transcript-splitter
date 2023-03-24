# Split Transcript Script

This script splits a transcript file into smaller chunks based on a specified number of characters.

## Usage
To use this script, provide the following command line arguments:

$ ./split_transcript.sh <input_file> <output_prefix> <max_chars_per_chunk>

- `input_file`: The path to the input transcript file.
- `output_prefix`: The prefix to use for the output files.
- `max_chars_per_chunk`: The maximum number of characters to include in each output file.

### Example:

```bash
$ ./split_transcript.sh transcript.txt chunk_ 1000

This will split the transcript.txt file into chunks of up to 1000 characters each, with output files named chunk_001.txt, chunk_002.txt, etc.

