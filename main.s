.global _start

.include "IO.s"
.include "gridManipulation.s"
.include "solver.s"

.macro mainLoop
    writeToScreen gridStr, #819
recordValues:
    obtainInput

    insertValueToGrid

    insertValueToGridString

    writeToScreen gridStr, #819
askForConfirm:
    writeToScreen confirmationMsg, #60
recordConfirmation:
    MOV x0, #0
    LDR x1, =userConfirmValue 
    MOV x2, #1
    MOV x8, #63
    SVC 0

    LDR x1, =returnBuffer
    SVC 0

    LDR x1, =userConfirmValue

checkValue:
    LDRB w3, [x1]
    CMP x3, #89

    BEQ recordValues

    CMP x3, #121

    BEQ recordValues

    CMP x3, #110
    BNE askForConfirm
.endm

_start:
    //mainLoop

    solver

    updateGridStrInAccordanceToGrid

    writeToScreen gridStr, #819



exit:
    MOV x0, #0
    MOV x8, #93
    SVC 0


.data
    returnBuffer: .fill 1,1,0

    enterCoords: .asciz "Enter the grid coord for the number in the format yx: " //54 characters, excluding x0
    enterValue: .asciz "Enter the value at your provided coordinates: " //46 excl x0

    confirmationMsg: .asciz "Would you like to insert another value onto the grid (Y/n): " //60 excp x0

    userCoords: .fill 2,1,0
    userValue: .fill 1,1,0
    userConfirmValue: .fill 1,1,0

    grid: .byte 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0

    //Horizontal Freq: 
    //For each 9 byte, the selection's bytes represents whether the numbers 1-9 
    //(from respective index of 0-8 of each selection) have already been used in each row.
    //Analogously the same logic applies to verticals and groups
    horizontals: .byte 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0
    verticals: .byte 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0      
    groups: .byte 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0        


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