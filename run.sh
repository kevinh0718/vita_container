#!/bin/bash

# This script automates the process of running the VItA container

# Check if the data directory exists
if [ ! -d "vita_example" ]; then
  echo "Error: The 'vita_example' directory was not found."
  echo "Please make sure you are running this script from the root of the project."
  exit 1
fi

# Run the Docker container with the volume mount
docker run -it --rm \
  -v "$(pwd)/vita_example":/app/vita_example \
  -v "$(pwd)/run_example.sh":/app/run_example.sh \
  kevinh0718/vita_talou_cco:latest \
  bash /app/run_example.sh