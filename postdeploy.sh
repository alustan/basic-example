#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -workspace=<workspace> -region=<region>"
    exit 1
}

# Parse arguments
for arg in "$@"
do
    case $arg in
        -workspace=*)
        WORKSPACE="${arg#*=}"
        shift
        ;;
        -region=*)
        REGION="${arg#*=}"
        shift
        ;;
        *)
        usage
        ;;
    esac
done

# Check if both arguments are provided
if [ -z "$WORKSPACE" ] || [ -z "$REGION" ]; then
    usage
fi

# Generate the output
output=$(cat <<EOF
{
    "outputs": {
        "Workspace": "$WORKSPACE",
        "Region": "$REGION"
    }
}
EOF
)

# Print the output
echo "$output"
