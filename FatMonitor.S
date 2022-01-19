   .data
   
   .comm gender, 1
   .global gender
   .comm age, 1
   .global age
   .comm fat, 1
   .global fat
   .text
       .global lightup
       .global fatmonitor
lightup:                    ; lights up all of the lights (ex. when we initially tested)
       ldi  r18, 0b00110001
       out  0x04, r18   ; 0x04 is I/O address of DDRB
       out  0x05, r18   ; 0x05 is I/O address of PORTB
       ret
; use conditional branches: (BRSH, BRLO) or equality branches: (BREQ, BRNE)
fatmonitor:
       lds r18, gender  ;holds the gender value to be input
       lds r19, age     ;holds the age value to be input
       lds r20, fat     ;holds the fat value to be input

       cpi r18, 0x0A    ;checks to see if we have a male, if so then we branch to malelabel
       breq malelabel

       cpi r18, 0x0F    ;checks to see if we have a female, if so then we branch to femalelabel
       breq femalelabel

       ret
malelabel:
       cpi r19, 40      ;checks to see if "young"
       brlo mYoung
       cpi r19, 60      ;checks to see if "medium"
       brlo mMedium
       cpi r19, 80      ;checks to see if "old"
       brlo mOld
mYoung:
       cpi r20, 8     ;blinks blue if condition is met
       brlo mBlue
       cpi r20, 20    ;blinks green if condition is met
       brlo mGreen
       cpi r20, 25    ;blinks red if condition is met
       brlo mRed      
       cpi r20, 25    ;lights them all if condition is met
       brsh mAll      
mMedium:
       cpi r20, 11    ;blinks blue if condition is met
       brlo mBlue
       cpi r20, 22    ;blinks green if condition is met
       brlo mGreen
       cpi r20, 28    ;blinks red if condition is met
       brlo mRed
       cpi r20, 28    ;lights them all if condition is met
       brsh mAll
mOld:
       cpi r20, 13    ;blinks blue if condition is met
       brlo mBlue
       cpi r20, 25    ;blinks green if condition is met
       brlo mGreen
       cpi r20, 30    ;blinks red if condition is met
       brlo mRed
       cpi r20, 30    ;lights them all if condition is met
       brsh mAll
mBlue:
       ldi  r21, 0b00100000 ;the actual code for the blue blink
       jmp testf
       ;out  0x04, r18    (0x04 is I/O address of DDRB, determines I/O)
       ;out  0x05, r18    (0x05 is I/O address of PORTB - 0x03,0x04,0x05)
mGreen:
       ldi  r21, 0b00010000 ;the actual code for the green blink
       jmp testf
mRed:
       ldi  r21, 0b00000001 ;the actual code for the red blink
       jmp testf
mAll:
       ldi  r18, 0b00110001 ;the actual code that lights them all
       out  0x04, r18   ; 0x04 is I/O address of DDRB
       out  0x05, r18   ; 0x05 is I/O address of PORTB
       ret
femalelabel:
       cpi r19, 40      ;checks to see if "young"
       brlo fYoung
       cpi r19, 60      ;checks to see if "medium"
       brlo fMedium
       cpi r19, 80      ;checks to see if "old"
       brlo fOld
fYoung:
       cpi r20, 21      ;blinks blue if condition is met
       brlo fBlue
       cpi r20, 33      ;blinks green if condition is met
       brlo fGreen
       cpi r20, 39      ;blinks red if condition is met
       brlo fRed        
       cpi r20, 39      ;lights them all if condition is met
       brsh fAll
fMedium:
       cpi r20, 23      ;blinks blue if condition is met
       brlo fBlue
       cpi r20, 34      ;blinks green if condition is met
       brlo fGreen
       cpi r20, 40      ;blinks red if condition is met
       brlo fRed
       cpi r20, 40      ;lights them all if condition is met
       brsh fAll
fOld:
       cpi r20, 24      ;blinks blue if condition is met
       brlo fBlue
       cpi r20, 36      ;blinks green if condition is met
       brlo fGreen
       cpi r20, 42      ;blinks red if condition is met
       brlo fRed
       cpi r20, 42      ;lights them all if condition is met
       brsh fAll
fBlue:
       ldi  r21, 0b00100000 ;the actual code for the blue blink
       jmp testf
fGreen:
       ldi  r21, 0b00010000 ;the actual code for the green blink
       jmp testf
fRed:
       ldi  r21, 0b00000001 ;the actual code for the red blink
       jmp testf
fAll:
       ldi  r18, 0b00110001 ;the actual code that lights them all
       out  0x04, r18   ; 0x04 is I/O address of DDRB
       out  0x05, r18   ; 0x05 is I/O address of PORTB
       ret

testf:                  ;this with our modifications, will do the blinking for the needed color
    
      out    0x04, r21
      ldi    r16, 50
all:  
      out    0x05, r21
      ldi    r18, 0xff
dl1:  ldi    r19, 0xff
dl2:  nop
      nop
      nop
      nop
      dec    r19
      brne   dl2
      dec    r18
      brne   dl1
      ldi    r17, 0x00
      out    0x05, r17
      ldi    r18, 0xff
dl3:  ldi    r19, 0xff
dl4:  nop
      nop
      nop
      nop
      dec    r19
      brne   dl4
      dec    r18
      brne   dl3
      dec    r16
      brne   all
      ret
