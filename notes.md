# Lab 2: Return Stack

## Introduction

The goal of this assignment is to write a RISC-V program that creates a stack to simulate a Return-Address Stack.

The internal architecture of most advanced microprocessors contains a mechanism called the Return-Address Stack. Conceptually it is simple:

> each time that a function call is executed, the memory address of the instruction where execution must continue after the function returns is pushed into the stack. Whenever a return instruction is executed, the top of the stack is popped to discover the address where execution will continue.

A **stack** is a data structure that occupies a space in memory where data can be stored. To make the programming assignment simpler, the program created processes a string of characters. `Open parenthesis` `(` stands for *function calls* and `closing parenthesis` `)` stands for *function return*.

Next to each open parenthesis, there is always be a single character (*byte*) that stands for the *return address*. Thus, the solution will use a stack to store characters. Data is *added* to the stack by **pushing** it onto the stack, and data is *removed* from the stack by **popping** it from the stack. Popping a value from the stack does not remove the value from memory, it simply *changes the address of the top of the stack*. The popped value is no longer part of the active stack and will be overwritten later when another value is pushed to that position of the stack.

When storing a stack in memory, a buffer must be allocated to contain the stack. This buffer is a contiguous sequence of bytes in memory. Stacks can be implemented to grow in one of two different ways. A stack can grow either by adding to or subtracting from the address of the top of the stack. In this lab, we will be asking you to grow the stack by *subtracting* from the provided stack address, in other words, as you push items onto the stack you will have to decrement the value provided to you in a1 for the first byte of the memory space reserved to contain the stack. For example, if the stack is to contain bytes, and starts at address 0x10001024 then the first item pushed onto the stack would be stored at address 0x10001024 and the second element pushed onto the stack will be stored at address 0x10001023.

## Task

Create a program that, given a string of characters, containing opening parenthesis, closing parenthesis, and other characters, will print another string containing only alpha characters. Each time that a closing parenthesis is encountered in the input string, the character that immediately follows the open parenthesis must be printed.

## Input

Your program will read characters from a provided string. Each character occupies a byte in memory. Therefore you can read a character from the string using the lb or lbu instruction (lbu is recommended for loading characters) --- you are supplied (in `common.s`) with code that reads the string from a file and stores it in the memory before your program executes.

`common.s` is in the starter code zip file linked above.

A valid input string is formed by ASCII character and must follow these constraints:

* "`(`": symbolizes a function call and must be immediately followed by an ID
* "`)`": symbolizes a function return
* "`a-z`" or "`A-Z`":
  * if preceded by an "(", is the ID of that function
  * otherwise, is meaningless
* Any other ASCII character: is meaningless
* Parenthesis are balanced: there must be a "`)`" to match every "`(`"
* The string is null-terminated: there is a character with value zero at the end of the string.

