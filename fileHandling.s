.equ AT_FDCWD, 100
.equ O_RDONLY, 0

.macro openGridFile
    MOV x0, #AT_FDCWD
    NEG x0, x0
    LDR x1, =filePath
    MOV x2, #O_RDONLY 
    MOV x3, #0
    MOV x8, #56
    SVC 0
.endm