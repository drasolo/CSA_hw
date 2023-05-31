# Counting Paths in a Directed Graph Assembly Script

This script, written in x86 assembly language, calculates the number of paths of length 'k' between two nodes in a directed graph. It utilizes matrix multiplication to efficiently perform the calculation.

## Description

The script begins by reading the input values, including the length of paths ('lungime'), source node ('sursa'), and destination node ('destinatie'). It then iteratively multiplies the adjacency matrix 'matrix' with itself 'lungime' number of times using the 'matrix_mult' function.

The 'matrix_mult' function is responsible for multiplying two matrices, which in this case represents the graph's adjacency matrix. The resulting matrix is stored in 'matrixrezult' and represents the number of paths of length 'k' between each pair of nodes. The script repeats this multiplication process 'lungime' times, gradually increasing the length of paths.

Finally, the script outputs the number of paths between the source and destination nodes for each specified length.

Please note that this script is written in x86 assembly language and requires an appropriate assembler and hardware platform to run. It is designed specifically for calculating path counts in directed graphs and can be used as a tool for graph analysis and related algorithms.

## Usage

To use the script, assemble it using an appropriate x86 assembler and run it on a compatible hardware platform. The script prompts for input values including 'lungime', 'sursa', and 'destinatie', allowing you to specify the desired length of paths and the source and destination nodes. The script then performs the path count calculation and displays the results.

## Requirements

- x86 assembler
- Compatible hardware platform


