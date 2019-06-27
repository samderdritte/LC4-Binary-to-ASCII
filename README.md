# LC4 Binary to ASCII

## Description

**LC4 Binary to ASCII** is a subroutine for the LC4 (Little Computer 4). It converts a binary number and stores its ASCII representation.

## Usage

Value to be converted has to be stored in Register R0.

ASCII values of the converted number will be stored in data memory at x2000 following:
x2000     : +/- Sign (ASCII x2B or x2D)
x2001     : hundreds-digit
x2002     : tens-digit
x2003     : ones-digit


Works with signed 2C numbers between -999 and +999.

## Source

This code is an updated version of the LC3-code from _Patt/Patel. Introduction to Computing Systems. From Bits and Gates and Beyond. 2nd ed. 2005, p. 276f._
