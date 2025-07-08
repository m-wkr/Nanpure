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
    SUB x10, x4, #48
    SUB x11, x4, #49 //Store val - 1 for indexing

    MOV x7, #9

    MUL x9, x5, x7
    ADD x9, x9, x6 //Calculate final coord in 2D grid flattened to 1D

    //Change byte grid
    LDR x1, =grid
    STRB w10, [x1,x9]
1:
    MOV x10, #1 //Value of x10 no longer useful, set to 1 for simplicity

    //Update horizontals array
    LDR x1, =horizontals

    MUL x9, x5, x7
    ADD x9, x9, x11
    STRB w10,[x1,x9]
2:
    //Update verticals array
    LDR x1, =verticals

    MUL x9, x6, x7 
    ADD x9, x9, x11
    STRB w10, [x1,x9]
3:
    //Update groups array
    LDR x1, =groups 



    MOV x9, #3

    UDIV x12, x5, x9 //Find quo(y,3)
    UDIV x13, x6, x9  //Find quo(x,3)
    MUL x12, x12, x9 
    ADD x12, x12, x13 
    MUL x12, x12, x7 

    ADD x12, x12, x11 

    STRB w10, [x1,x12]



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

.macro updateGridStrInAccordanceToGrid
    MOV x0, #0
    LDR x1,=grid
    LDR x2,=gridStr
    ADD x2, x2, #97
1:
    CMP x0, #81
    BEQ 2f


    LDRB w3,[x1,x0]
    ADD x3, x3, #48

    MOV x4, #9

    UDIV x5, x0, x4 //quo(x0,9)
    MUL x6, x5, x4
    SUB x6, x0, x6 //rem(x0,9)

    LSL x5, x5, #1 //multiply by 2
    ADD x5, x5, #1
    
    MOV x7, #38
    MUL x5, x5, x7

    ADD x6, x6, #1
    MOV x7, #4
    MUL x6, x6, x7
    SUB x6, x6, #2

    ADD x5, x5, x6

    

    STRB w3, [x2,x5]

    ADD x0, x0, #1

    B 1b
2:

.endm