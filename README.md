# Proiect-ASC

## Overview

The project is written in AT&T x86 assembly language and solves a classic programming problem. A directed graph is given. To display:
1) The adjacency matrix
2) The number of paths of length k from node i to node j

To be able to solve this problem, it is necessary to raise the respective matrix to the power k, and the element on position [i][j] will have the answer to the problem.

To be able to run the code you will need 2 files:

1) assmebly.s ( the file that contains the code above )
2) data ( a text file that contains the input )

To execute the code you will have to type in terminal the following 2 commands:

```sh-session
gcc -m32 assembly.s -o objfile -no-pie
```
```
./objfile < data
```
Note: To make the 32-bit version work, considering that the operating system is 64-bit, you will have to install an additional library with the following command:
```
sudo apt-get install g++-multilib
```
## First Exercise
### Input:
```
1   // 1 means it will display the matrix, 2 means the algorithm will display the number of paths

4   // this is the number of nodes

2   // this means that node 0 will have 2 connections (1,2)

2   // this means that node 1 will have 2 connections (2,3)

1   // this means that node 2 will have 1 connection (3)

0   // this means that node 3 will have 0 connections 

1   // first connection of node 0

2   // second connesction of node 0

2   // first connection of node 1

3   // second connection of node 1

3   // the only connection of node 2

```
### Output:
```
0 1 1 0
0 0 1 1
0 0 0 1
0 0 0 0
```

## Second Exercise
### Input:

```
2   // 1 means it will display the matrix, 2 means the algorithm will display the number of paths

4   // this is the number of nodes

2   // this means that node 0 will have 2 connections (1,2)

2   // this means that node 1 will have 2 connections (2,3)

1   // this means that node 2 will have 1 connection (3)

0   // this means that node 3 will have 0 connections 

1   // first connection of node 0

2   // second connesction of node 0

2   // first connection of node 1

3   // second connection of node 1

3   // the only connection of node 2

2   // the length of the path ( k )

0   // start node             ( i )

3   // finish node            ( j )
```

### Output:
```
2
```
