
.macro loopForSuitableNum
    MOV x5, #0
    B forLoop
forLoopIncr:
    ADD x5, x5, #1
forLoop:

    MOV x0, #1
    LDR x1, =userValue
    MOV x2, #1
    MOV x8, #64
    SVC 0


    CMP x5, #0
    BLT forLoopIncr

.endm



.macro solver
    MOV x0, #0
    MOV x1, #0
    MOV x2, #0

    LDR x19, =grid 
    LDR x20, =horizontals
    LDR x21, =verticals
    LDR x22, =groups

    BL function
    B end


function:
    STP LR, FP, [SP,#-16]!
    MOV FP, SP

    STP x1, x2, [SP,#-16]! //Store param states

    //Calculate cumulative index into x3
    MOV x7, #9
    MUL x3, x1, x7 
    ADD x3, x3, x2


    CMP x3, #81
    BGE baseCase 

    loopForSuitableNum

    LDP x1, x2, [SP], #16

    CMP x2, #8
    BEQ carry
    ADD x2, x2, #1
    BL function
    B restoreParams

carry:
    ADD x1, x1, #1
    MOV x2, #0

    BL function
    B restoreParams
baseCase:
    MOV x0, #1 //Return True for success
    LDP x1, x2, [SP], #16
restoreParams:
    //LDP x1, x2, [SP], #16
returner:
    LDP LR, FP, [SP], #16
    RET
end:

.endm