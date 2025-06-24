.global _start

.include "printing.s"

_start:
    writeToScreen grid, #819

    B obtainInput
exit:
    MOV x0, #1
    MOV x8, #93
    SVC 0

obtainInput: //name WIP
    writeToScreen enterCoords, #54

    MOV x0, #0
    LDR x1, =userCoords 
    MOV x2, #2
    MOV x8, #63
    SVC 0


    writeToScreen userCoords, #2

    writeToScreen enterValue, #46

    MOV x0, #0
    LDR x1, =userValue
    MOV x2, #1
    MOV x8, #63
    SVC 0


    writeToScreen userValue, #1

    B exit

.data
    enterCoords: .asciz "Enter the grid coord for the number in the format yx: " //54 characters, excluding x0
    enterValue: .asciz "Enter the value at your provided coordinates: " //46 excl x0
    userCoords: .fill 2,1,0
    userValue: .fill 1,1,0
    grid: .asciz "(x position is horizontal, y position is vertical, both starting from 00 at the top left corner)
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