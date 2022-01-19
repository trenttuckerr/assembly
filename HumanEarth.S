# HumanEarth.S
    .text
    .global flash_human_earth
flash_human_earth:
.extern delay
        ldi  R22, 0xb0
        ldi  R23, 0x00
        ldi  R24, 0x00
        ldi  R25, 0x00
        call delay

    

.macro pushall  ; saves all my register's value(from r16 through r31 on the stack)
push r16
push r17
push r18
push r19
push r20
push r21
push r22
push r23
push r24
push r25
push r26
push r27
push r28
push r29
push r30
push r31
.endm ; of pushall

.macro popall ; restores them back in the reverse order
pop r31
pop r30
pop r29
pop r28
pop r27
pop r26
pop r25
pop r24
pop r23
pop r22
pop r21
pop r20
pop r19
pop r18
pop r17
pop r16
.endm ; of popall

pushall
       ldi  R22, 0xb0
       ldi  R23, 0x00
       ldi  R24, 0x00
       ldi  R25, 0x00
       call delay
       popall
RET
         
