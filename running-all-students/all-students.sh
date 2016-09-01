#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "This is a quick script to test many students in one go, with stacscheck"
    echo "It is designed to be super-simple! please feel free to edit it."
    echo "Usage: all-students.sh <location of tests> <directory of student submissions> <output dir>"
    echo "Inside <output dir> two subdirectories will be created, one called 'txt' and one called 'html'."
    exit 0
fi;

# From http://stackoverflow.com/questions/3915040/bash-fish-command-to-print-absolute-path-to-a-file/21188136#21188136
get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

mkdir -p "$3/txt"
mkdir -p "$3/html"

practical=$(get_abs_filename "$1")
submissions=$(get_abs_filename "$2")
outdir=$(get_abs_filename "$3")


for dir in "${submissions}/"*/; do
    (
        echo $dir
        ulimit -t 600 # Put a limit on runtime
        studentid=$(basename "${dir}")
        cd "${dir}"
        stacscheck ${practical} --id="${studentid}" --html="${outdir}/html/${studentid}.html" > "${outdir}/txt/${studentid}"
    )
done