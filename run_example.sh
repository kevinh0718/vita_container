#!/bin/bash

cd vita_example 
ccmake .
# Use the ccmake interface to configure the project (press c, and one more c, then g).
make
./example_1