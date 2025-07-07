.macro fetchUserCoords
    LDR x1, =userCoords
    LDRB w5,[x1] //y coord
    LDRB w6, [x1,#1] //x coord
    SUB x5, x5, #48
    SUB x6, x6, #48
.endm

.macro insertValueToGrid
    fetchUserCoords

    //Store int value of user value (stored as ascii equiv) to x10
    SUB x10, x4, #49

    MOV x7, #9

    MUL x9, x5, x7
    ADD x9, x9, x6 //Calculate final coord in 2D grid flattened to 1D

    //Change byte grid
    LDR x1, =grid
    STRB w10, [x1,x9]


.endm 

.macro insertValueToGridString
    fetchUserCoords

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

    STRB w4, [x1,x5]
.endm