//Assume that x0 is the function return value which is initially 0
//Assume x1 and x2 are x and y param of the function
//x3 is cumulative 9*x + y index (local)
//x4 is an aux grid value holder
//x5 is for loop iterator (local)
//x7 is constant multiplifer holder
//x8 is [x1][x5] index
//x9 is [x2][x5] index
//x10 is [3*quo(x1,3)+quo(x2,3)][x5] index
//x11 is quo(x2,3)
//x12 is const 1 holder
.equ TRUE, 1
.equ FALSE, 0

.macro solver
    MOV x0, #FALSE
    MOV x1, #0
    MOV x2, #0

    LDR x19, =grid 
    LDR x20, =horizontals
    LDR x21, =verticals
    LDR x22, =groups

    BL function
    B end

//Standalone increment i and j index "subroutine"
incrementIndexPair:
    CMP x2, #8
    BEQ carry
    ADD x2, x2, #1
    B return
carry:
    ADD x1, x1, #1
    MOV x2, #0
return:
    RET

//Main Function starts here
function:
    STP LR, FP, [SP,#-16]!
    MOV FP, SP

    //Calculate cumulative index into x3
    MOV x7, #9
    MUL x3, x1, x7 
    ADD x3, x3, x2


    CMP x3, #81
    BGE baseCase 

//CHECK FOR FIXED VALUE IF STATEMENT
checkFixed:
    LDRB w4, [x19,x3]
    CMP x4, #1
    BGE fixedCase
//If w4 isn't a set value, go into forloop
    MOV x5, #0
    B forLoop
forLoopIncr:
    ADD x5, x5, #1
forLoop:
    CMP x5, #9
    BGE allFailed

    //Further if statement here checking the value generated here follows constraints
    // horizontal[x1][x5] setup
    MUL x8, x1, x7 
    ADD x8, x8, x5
    LDRB w4, [x20,x8]
    CMP x4, #1
    BEQ forLoopIncr //we need to add somehow oml
    //vertical[x2][x5] setup
    MUL x9, x2, x7
    ADD x9, x9, x5
    LDRB w4, [x21,x9]
    CMP x4, #1
    BEQ forLoopIncr
    //groups[3*quo(x1,3) + quo(x2,3)][x5] setup
    MOV x7, #3
    UDIV x10, x1, x7 
    MUL x10, x10, x7
    UDIV x11, x2, x7 
    MOV x7, #9
    ADD x10, x10, x11
    MUL x10, x10, x7 
    ADD x10, x10,x5 
    LDRB w4, [x22,x10]
    CMP x4, #1
    BEQ forLoopIncr

    //Save local variable values & Tempoarily update grid value and constraints and continue recursive call
    MOV x12, #1
    STRB w12, [x20,x8]
    STRB w12, [x21,x9]
    STRB w12, [x22,x10]

    STP x1, x2, [SP,#-16]!
    STP x3, x5, [SP,#-16]!
    STP x8,x9,[SP,#-16]!
    STR x10, [SP,#-16]!

    ADD x5, x5, #1
    STRB w5, [x19,x3]
    SUB x5,x5,#1

    BL incrementIndexPair

    BL function 

    //Pop local variables off stack
    LDR x10, [SP],#16
    LDP x8,x9,[SP],#16
    LDP x3,x5,[SP],#16
    LDP x1,x2,[SP],#16

    CMP x0, #1
    BEQ returner //Return if successful

    //Restore values to default
    MOV x12, #0
    STRB w12, [x20,x8]
    STRB w12, [x21,x9]
    STRB w12, [x22,x10]
    STRB w12, [x19,x3]

    B forLoopIncr

allFailed:
    MOV x0, #FALSE
    B returner
//end of for loop
fixedCase:
    STP x1, x2, [SP,#-16]!

    BL incrementIndexPair

    BL function

    LDP x1, x2, [SP], #16

    B returner

baseCase:
    MOV x0, #TRUE //Return True for success
returner:
    LDP LR, FP, [SP], #16
    RET
//end of function

end:

.endm