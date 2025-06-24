.global _start

.include "printing.s"

.macro obtainInput 
1:  
    //Ask for coords
    writeToScreen enterCoords, #54

    MOV x0, #0
    LDR x1, =userCoords 
    MOV x2, #2
    MOV x8, #63
    SVC 0
2:
    //Check if 2 len input by checking 3rd char is a line feed
    LDR x1, =returnBuffer
    MOV x2, #1
    SVC 0

    LDRB w3, [x1]

    
    CMP x3, #10
    BNE 1b
3:
    //Print values (as part of testing THEN value)
    writeToScreen userCoords, #2
4:
    writeToScreen enterValue, #46

    MOV x0, #0
    LDR x1, =userValue
    MOV x2, #1
    MOV x8, #63
    SVC 0
5:
    LDR x1, =returnBuffer
    SVC 0

    LDRB w3, [x1]
    CMP x3, #10
    BNE 4b
6:
    //Apparently bash inserts a line feed after enter... 
    writeToScreen userValue, #1

.endm



_start:
    writeToScreen grid, #819

    obtainInput
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