.global _start

.include "IO.s"
.include "gridManipulation.s"

.macro mainLoop
    writeToScreen gridStr, #819
1:
    obtainInput

    insertValueToGrid

    insertValueToGridString

    writeToScreen gridStr, #819
2:
    writeToScreen confirmationMsg, #60
3:
    MOV x0, #0
    LDR x1, =returnBuffer 
    MOV x2, #1
    MOV x8, #63
    SVC 0
4:
    LDRB w3, [x1]
    CMP x3, #89

    SVC 0 //Read and move past return character

    BEQ 1b

    CMP x3, #121

    BEQ 1b

    CMP x3, #110
    BNE 2b
.endm

_start:
    mainLoop

exit:
    MOV x0, #1
    MOV x8, #93
    SVC 0


.data
    returnBuffer: .fill 1,1,0

    enterCoords: .asciz "Enter the grid coord for the number in the format yx: " //54 characters, excluding x0
    enterValue: .asciz "Enter the value at your provided coordinates: " //46 excl x0

    confirmationMsg: .asciz "Would you like to insert another value onto the grid (Y/n): " //60 excp x0

    userCoords: .fill 2,1,0
    userValue: .fill 1,1,0

    grid: .byte 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0

    gridStr: .asciz "(x position is horizontal, y position is vertical, both starting from 00 at the top left corner)
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
|   |   |   |   |   |   |   |   |   |
 --- --- --- --- --- --- --- --- --- 
"  //grid has 819 (x0 omitted)