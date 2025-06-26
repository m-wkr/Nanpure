.global _start

.include "IO.s"

// x0-3 and 8 are reserved for syscall values

.macro insertValue
    //Immediately after obtain Input, x4 holds the ascii value of userValue
    SUB x4,x4, #48

    LDR x1, =userCoords
    LDRB w5,[x1] //y coord
    LDRB w6, [x1,#1] //x coord
    SUB x5, x5, #48
    SUB x6, x6, #48

    MOV x7, #9

    MUL x9, x5, x7
    ADD x9, x9, x6 //Calculate final coord in 2D grid flattened to 1D

    //Change byte grid
    LDR x1, =grid
    STRB w4, [x1,x9]

    //update gridStr
    LDR x1, =gridStr
    ADD x1, x1, #97 //offset

    LSL x5, x5, #1 //multiply by 2
    ADD x5, x5, #1
    
    MOV x7, #38
    MUL x5, x5, x7

    ADD x6, x6, #1
    MOV x7, #4
    MUL x6, x6, x7
    SUB x6, x6, #2

    ADD x5, x5, x6

    ADD x4, x4, #48

    STRB w4, [x1,x5]
.endm


_start:
    writeToScreen gridStr, #819

    obtainInput

    insertValue

    writeToScreen gridStr, #819

exit:
    MOV x0, #1
    MOV x8, #93
    SVC 0


.data
    returnBuffer: .fill 1,1,0

    enterCoords: .asciz "Enter the grid coord for the number in the format yx: " //54 characters, excluding x0
    enterValue: .asciz "Enter the value at your provided coordinates: " //46 excl x0

    userCoords: .fill 2,1,0
    userValue: .fill 100,1,0

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