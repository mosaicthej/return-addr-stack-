#
# CMPUT 229 Student Submission License
# Version 1.0
#
# Copyright 2019 <student name>
#
# Redistribution is forbidden in all circumstances. Use of this
# software without explicit authorization from the author or CMPUT 229
# Teaching Staff is prohibited.
#
# This software was produced as a solution for an assignment in the course
# CMPUT 229 - Computer Organization and Architecture I at the University of
# Alberta, Canada. This solution is confidential and remains confidential 
# after it is submitted for grading.
#
# Copying any part of this solution without including this copyright notice
# is illegal.
#
# If any portion of this software is included in a solution submitted for
# grading at an educational institution, the submitter will be subject to
# the sanctions for plagiarism at that institution.
#
# If this software is found in any public website or public repository, the
# person finding it is kindly requested to immediately report, including 
# the URL or other repository locating information, to the following email
# address:
#
#          cmput229@ualberta.ca
#
#---------------------------------------------------------------
# CCID:                 
# Lecture Section:      
# Instructor:           J. Nelson Amaral
# Lab Section:          
# Teaching Assistant:   
#---------------------------------------------------------------
# 
.include "common.s"

#----------------------------------
#        STUDENT SOLUTION
#----------------------------------
rsa:
# Arguments:
# a0: address of the string to parse.
# a1: address of the memory that is to be used as a stack.
# Effect:
# print the function IDs in the order they return, based on the string representation of some program's control flow. Do not print a newline after printing the order so that the solution works well with the automated grading scripts.

# t6 <- 'left is character'
# t5 <- 'stack offset' (

li      t6, 0        # leftLetter = false
li      t5, 0       # stackOffset = 0

# read the character
read_char:
    lb      t0, 0(a0)    # t0 <- character
    beq     t0, zero, rsa_done  # done all str and exit

    # check if the character is a bracket
    # la      t1, brackets 
    # lb      t2, 0(t1)    # t2 <- '('
    li      t2, '('
    beq     t0, t2, rsa_left_bracket  # if t0 == '('
    # lb      t2, 1(t1)    # t2 <- ')'
    li      t2, ')'
    beq     t0, t2, rsa_right_bracket # if t0 == ')'

# check if the character is a valid letter
        # check if the character is a letter [a-z|A-Z]
        # confirm character NOT: x < 'A' or x > 'z' or (x > 'Z' and x < 'a')
        # la      t1, bounds
        # lb      t2, 0(t1)    # t2 <- 'A'
        li      t2, 'A'
        blt     t0, t2, next_char  # if t0 < 'A'
        # lb      t2, 3(t1)    # t2 <- 'z'
        li      t2, 'z'
        bgt     t0, t2, next_char  # if t0 > 'z'
        # lb      t2, 1(t1)    # t2 <- 'Z'
        li      t2, 'Z'
        ble     t0, t2, check_left_is_char  # if t0 <= 'Z'
        # lb      t2, 2(t1)    # t2 <- 'a'    x > 'Z'
        li      t2, 'a'
        blt     t0, t2, next_char  # if t0 < 'a'
        # x is a letter, now check if left is a letter
    check_left_is_char:
        bne     t6, zero, next_char # left is already a letter, skip
    check_num_brackets:
        bge     t5, zero, next_char # if stackOffset > 0, stack is not ready

letter_is_valid:
    addi    t6, zero, 1  # leftLetter = true, so letters after can't enter stack
    # save the character to the stack
    add     t1, a1, t5  # t1 <- stack + stackOffset
    # t1 is the address where the character will be saved
    sb      t0, 0(t1)   # save the character
    j       next_char   # jump to next character

rsa_left_bracket:
    mv      t6, zero    # leftLetter = false
    addi    t5, t5, -1  # move for 1 position
    j       next_char   # jump to next character

rsa_right_bracket:
    mv      t6, zero    # leftLetter = false
    # print the character
    add     t1, a1, t5  # t1 <- stack + stackOffset
    # find the character on top of stack
    lb      a0, 0(t1)   # t0 <- character
    li      a7, 11      # print character
    ecall
    addi    t5, t5, 1   # pop from stack
    
next_char:
    addi    a0, a0, 1    # a0 <- a0 + 1
    j       read_char    # jump to read_char

rsa_done:
jr ra   # jump to ra
