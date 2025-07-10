//Contain IO manipulation macros

.macro writeToScreen strPtr length
    MOV x0, #1
    LDR x1, =\strPtr
    MOV x2, \length    
    MOV x8, #64
    SVC 0
.endm

.macro gainInput FD strPtr length
    MOV x0, \FD
    LDR x1, =\strPtr
    MOV x2, \length    
    MOV x8, #63
    SVC 0
.endm

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
    //Absorb linefeed
    LDR x1, =returnBuffer
    MOV x2, #1
    SVC 0

    LDR x1, = userCoords

    //Check first character is within range
    LDRB w4, [x1,#1]!
    
    CMP x4, #47
    BLE 1b
    CMP x4, #57
    BGE 1b

    //Check second character is within range
    LDRB w4, [x1]

    CMP x4, #47
    BLE 1b
    CMP x4, #57
    BGE 1b
3:
    writeToScreen enterValue, #46

    MOV x0, #0
    LDR x1, =userValue
    MOV x2, #1
    MOV x8, #63
    SVC 0
4:
    //Absorb linefeed
    LDR x1, =returnBuffer
    SVC 0

    LDR x1, =userValue

    LDRB w4, [x1]

    CMP x4, #48
    BLE 3b
    CMP x4, #58
    BGE 3b

    //Apparently bash inserts a line feed (#10) after enter... 

.endm