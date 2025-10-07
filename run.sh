#!/bin/bash

# This script automates the process of running the VItA container

#
# -----------------------------------------------
# UPDATE THESE VARIABLES ONLY
# -----------------------------------------------
TARGET_FOLDER="vita_example"
SCRIPT_NAME="gen_example.sh"
# -----------------------------------------------
# DO NOT EDIT BELOW THIS LINE
# -----------------------------------------------
#

# Check if the data directory exists using the variable
if [ ! -d "$TARGET_FOLDER" ]; then
  echo "Error: The '$TARGET_FOLDER' directory was not found."
  echo "Please make sure you are running this script from the root of the project."
  exit 1
fi

# Run the Docker container with the volume mounts
# Both volume paths are now constructed using the variables
docker run -it --rm \
  -v "$(pwd)/$TARGET_FOLDER":/app/"$TARGET_FOLDER" \
  -v "$(pwd)/$SCRIPT_NAME":/app/"$SCRIPT_NAME" \
  kevinh0718/vita_talou_cco:latest \
  bash /app/"$SCRIPT_NAME"