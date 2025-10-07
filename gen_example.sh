#!/bin/bash

cd vita_example 
cmake .
# If using the ccmake, then configure the project with pressing c, and one more c, then g, to generate the Makefile.
make
./example_1