# Check if the folder exists
template="tree-slide"
if [ ! -d "$template" ]
then
  echo "Error: Folder $template does not exist."
  echo "Make sure you are in QuartoTemplates. Process terminated."
  exit 1
else
  echo "$template exists."
fi

cd $template

# Handling flags

force=0
verbose=0

## Function to display non-existence flag message.
nosuchflag() {
  echo "$0 does not support this flag."
  exit 1
}

## Parse options
while getopts ":vf" opt; do
  case ${opt} in
    v )
      verbose=1
      ;;
    f )
      force=1
      ;;
    \? ) ## matches any unknown options.
      nosuchflag
      ;;
  esac
done

#  Shifts the positional parameters so that the non-option arguments are correctly assigned from `$1`.
shift $((OPTIND -1))



target="../$1"

echo "Target: $target"

mkdir -p $target

node render.js


index0="index.qmd"
index1="$target/$index0"
custom0="custom.scss"
custom1="$target/$custom0"

# Files to copy

sources=("$index0" "$custom0")
dests=("$index1" "$custom1")

# Get the length of the files array
len=${#sources[@]}

# Loop through the arrays and copy the files to their corresponding targets
for (( i=0; i<$len; i++ )); do
    file0=${sources[$i]}
    file1=${dests[$i]}

    # Create the target directory if it does not exist
    target_dir=$(dirname "$file1")
    mkdir -p "$target_dir"

    if [force]
        cp -f "$file0" "$file1"
    else
        cp "$file0" "$file1"
    fi
done

echo "Files have been copied successfully."

