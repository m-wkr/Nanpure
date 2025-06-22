.global _start

.include "printing.s"

_start:
    writeToScreen grid, #801
_exit:
    MOV x0, #1
    MOV x8, #93
    SVC 0

.data
    enterMessage: .asciz "Enter the grid coord for the number in the format yx: " //54 characters, excluding x0
    grid: .asciz "
(x position is horizontal, y position is vertical, both starting from 00 at the top left corner) 
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
"  //grid has 801 characters, 705 excluding tagline (x0 omitted)