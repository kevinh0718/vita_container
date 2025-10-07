# Stage 1: The Build Stage
FROM ubuntu:22.04 AS builder

# Set the DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    tar \
    ca-certificates \
    git \
    libgl1-mesa-dev \
    libxt-dev \
    qtbase5-dev \
    qttools5-dev \
    libqt5x11extras5-dev \
    libxkbcommon-x11-dev \
    python3-dev \
    python3-pip \
    # Clean up apt cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Install specific CMake version
RUN wget https://github.com/Kitware/CMake/releases/download/v3.5.0/cmake-3.5.0-Linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.5.0-Linux-x86_64.tar.gz && \
    rm cmake-3.5.0-Linux-x86_64.tar.gz
ENV PATH="/cmake-3.5.0-Linux-x86_64/bin:${PATH}"

# Set the working directory inside the container
WORKDIR /app

# All the build commands combined into a single RUN instruction
RUN git clone https://github.com/GonzaloMaso/VItA.git vita_source && \
    mkdir vita_build && \
    cd vita_build && \
    # This workaround is now part of the automated build
    ln -s /lib/x86_64-linux-gnu/libidn2.so.0 /lib/x86_64-linux-gnu/libidn.so.11 && \
    # The CMake command with flags
    cmake -DCMAKE_INSTALL_PREFIX=/app ../vita_source/ && \
    # Parallel compilation
    make -j$(nproc) && \
    make install

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/app/vita_build/lib"
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/vita_build/lib


# -----------------------------------------------------------------

# Start from your previously built, non-working image
FROM kevinh0718/vita_talou_cco:from_dkfile AS final

# Define a working directory
WORKDIR /app

# Copy the vita_build/lib folder from your local machine to the container
# This assumes you are running docker build from the directory that contains the vita_build folder.
COPY ./vita_build/lib /app/vita_build/lib/