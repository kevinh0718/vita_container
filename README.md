# VItA Container

This repository contains the `Dockerfile` and instructions to utilize a Docker container for the [VItA](https://github.com/GonzaloMaso/VItA) project, which is a key component for the implementation of the Constrained Constructive Optimization (CCO) algorithm. The purpose of this container is to provide a pre-compiled environment, avoiding the need for repetitive and complex compilation of the `VItA` source code.

The pre-built Docker image is available on [Docker Hub](https://hub.docker.com/r/kevinh0718/vita_talou_cco). This image includes the pre-compiled VItA libraries and binaries, which are ready for use. The container can be used to compile VItA examples and generate `.vtp` files.

## Licensing

This project and its Docker image contain software from the `VItA` project, which is distributed under the **Apache License, Version 2.0**.

By using this Docker image, you are subject to the terms of this license.

Please see the original [VItA repository](https://github.com/GonzaloMaso/VItA) for the full source code and licensing details.

# Quick start
1. Download this repo and update the `.vtk` file and `.cpp` file in the `vita_example` folder.

2. Start the container through `run.sh`.

3. Start the vessel synthesis process through `run_example.sh`.

# Start the Docker container
1. Clone the repository:
    ```bash
   git clone github.com/kevinh0718/vita_containerize.git
   ```
2. Change directory to the cloned folder:
    ```bash
    cd vita_container
    ```
3. Run the Docker container, mounting your data directory (prepare your folder that contains the `.vtk`, `.cpp`, `CMakeLists.txt` like the vita_example in this repo):

   ```bash
   docker run -it --rm -v $(pwd)/vita_example:/app/vita_example kevinh0718/vita_talou_cco:latest bash
   ```
4. Inside the container, run the following commands:
    ```bash
    cd vita_example 
    ccmake .
    # Use the ccmake interface to configure the project (press c, and one more c, then g).
    make
    ./example_1
    ```

# Explanation of the docker image
The docker file is provided. However, due to hardware setting issue, the image build process is complicated.

### ***It is not recommended to build the image based on the docker file.***

If the user want to understand how the image is built exactly, please switch to the `build_image` branch.

Following the dockerfile cannot reproduce the uploaded image.\
Instead, a base image can be built following the upper half of the dockerfile:
```bash
docker build --target builder -t kevinh0718/vita_talou_build:from_dkfile .
```
This image contains the required tools to compiled the vita_build, but during some missing record, the exact compilation process is missing.\
Instead, the successfully compiled files are uploaded to this branch as `vita_build/bin`.\
Then, by replacing the `vita_build/bin` in the `kevinh0718/vita_talou_build:from_dkfile` image, the final image can be built:
```bash
docker build --target final -t kevinh0718/vita_talou_build:latest .
```
Any suggestions in updating the dockerfile are welcome.