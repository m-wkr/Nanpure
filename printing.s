//Containing writing to stdout

.macro writeToScreen strPtr length
    MOV x0, #1
    LDR x1, =\strPtr
    MOV x2, \length    
    MOV x8, #64
    SVC 0
.endm