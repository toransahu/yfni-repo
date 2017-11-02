#!/bin/python3

"""
Title: Next Palindrome Number

Desc: Given a palindrome number find the next smallest number which is a palindrome. A palindrome
        number is a sequence of digits that reads the same forward and reverse. For e.g. 121 is a
        palindrome.
        [+]Input: The input number will contain 2 to 15 digits.
        [+]Output: Output should be a number which is the next palindrome.
Approach:

"""

import math
import sys

def next_palindrome(num):
    l = len(str(num))
    if l%2 == 0:
        return num + (11 * 10**((l-2)//2))
    return num + (10**((l-1)//2))

print("Enter a palindrome number")
num = int(input().strip())
print(next_palindrome(num))

#if __name__ == '__main__':
#    while(str.lower(input().strip()) != 'no'):


    
