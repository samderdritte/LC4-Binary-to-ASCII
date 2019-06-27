;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : binary_to_ascii.asm                            ;
;  author      : Samuel Spycher                                 ;
;  version     : 1.0                                            ;
;  date        : 06-29-2019                                     ;
;  description : converts a binary string to its                ;
;	             corresponding ascii value                        ;
;                                                               ;
;  This code is an updated version of the code in               ;
;  Patt / Patel - Introduction to Computing Systems. from       ;
;    Bits and Gates to C and Beyond. 2nd edition. 2005, p.276f. ;
;                                                               ;
;  This version is intended to work with LC4.                   ;
;  Tested on PennSim.                                           ;
;                                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;

.CODE
.ADDR x0000

CONST R0, #-42       ; Store the value you want to convert in R0
                    ; before calling the subroutine

JSR BinarytoASCII   ; Call Subroutine

JMP END             ; jump over subroutine


;; Start of Subroutine

.FALIGN
BinarytoASCII
  LEA R1, ASCIIBUFF   ; R1 points to string being generated
  ADD R0, R0, #0      ; R0 contains the binary value.

  BRn NegSign         ; true if the value is negative
  LC R2, ASCIIplus    ; Store the ASCII plus sign
  STR R2, R1, #0
  BRnzp Begin100

  NegSign
    LC R2, ASCIIminus ; Store the ASCII minus sign
    STR R2, R1, #0
    NOT R0, R0        ; Convert the number to absolute value,
    ADD R0, R0, #1      ; it is easier to work with
  Begin100
  LC R2, ASCIIoffset  ; Prepare for "hundreds" digit

  LC R3, Neg100       ; Determine the hundreds digit
  Loop100
    ADD R0, R0, R3
    BRn End100
    ADD R2, R2, #1
    BRnzp Loop100

  End100
    STR R2, R1, #1    ; Store ASCII code for hundreds digit
    LC R3, Pos100
    ADD R0, R0, R3    ; correct R0 for one-too-many subtracts

  LC R2, ASCIIoffset  ; Prepare for "tens" digit

  Begin10
    LC R3, Neg10      ; Determine the tens digit
    Loop10
      ADD R0, R0, R3
      BRn End10
      ADD R2, R2, #1
      BRnzp Loop10

    End10
      STR R2, R1, #2  ; Store ASCII code for tens digit
      ADD R0, R0, #10 ; Correct R0 for one-too-many subtracts

    Begin1
      LC R2, ASCIIoffset  ; Prepare for "ones" digit
      ADD R2, R2, R0
      STR R2, R1, #3
  RET

  .DATA
  .ADDR x2000       ; location to store ASCII values of the entered string
  ASCIIBUFF
    .BLKW 3

  .CODE
  ASCIIplus
    .UCONST x002B   ; ASCII code: +
  ASCIIminus
    .UCONST x002D   ; ASCII code: -
  ASCIIoffset
    .UCONST x0030   ; ASCII offset for numbers
  Neg100
    .CONST xFF9C
  Pos100
    .CONST x0064
  Neg10
    .CONST xFFF6

;; End of Subroutine
END
