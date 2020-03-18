.pos 0x0
                 ld   $0x1028, r5           # r5 = 1028 = stack pointer
                 ld   $0xfffffff4, r0       # r0 = -12
                 add  r0, r5                # r5 = stack pointer + 3
                 ld   $0x200, r0            # r0 = 0x200 = &a 
                 ld   0x0(r0), r0           # r0 = value at 0x200 = a
                 st   r0, 0x0(r5)           # add a to stack
                 ld   $0x204, r0            # r0 = 0x204 = &b
                 ld   0x0(r0), r0           # r0 = value at 0x204 = b
                 st   r0, 0x4(r5)           # add b to stack
                 ld   $0x208, r0            # r0 = 0x208 = &c
                 ld   0x0(r0), r0           # r0 = value at 0x208 = c
                 st   r0, 0x8(r5)           # add c to stack
                 gpc  $6, r6                # r6 = return address 6 bytes ahead
                 j    0x300                 # jump to 0x300, call function
                 ld   $0x20c, r1            # r1 = &returned_value
                 st   r0, 0x0(r1)           # r0 = returned_value
                 halt                       # stop
.pos 0x200
                 .long 0x00000000           # a
                 .long 0x00000000           # b
                 .long 0x00000000           # c
                 .long 0x00000000           # space for another argument
.pos 0x300
                 ld   0x0(r5), r0           # r0 = a
                 ld   0x4(r5), r1           # r1 = b
                 ld   0x8(r5), r2           # r2 = c
                 ld   $0xfffffff6, r3       # r3 = -10
                 add  r3, r0                # r0 = a-10
                 mov  r0, r3                # r3 = (a-10)
                 not  r3                    # not(r3)
                 inc  r3                    # r3 = -(a-10)
                 bgt  r3, L6                # go to L6 if a < 10             
                 mov  r0, r3                # r3 = (a-10)
                 ld   $0xfffffff8, r4       # r4 = -8
                 add  r4, r3                # r3 = (a-10)-8
                 bgt  r3, L6                # go to L6 if a > (10+8)
                 ld   $0x400, r3            # r3 = &0x400 = jump table
                 ld   (r3, r0, 4), r3       # r3 = jump table[a-10] function
                 j    (r3)                  # go to function
.pos 0x330
                 add  r1, r2                # r2 = r1 + r2 = b + c
                 br   L7                    # go to L7
                 not  r2                    # not(r2)
                 inc  r2                    # r2 = -(c)
                 add  r1, r2                # r2 = b - c
                 br   L7                    # go to L7
                 not  r2                    # not(c)
                 inc  r2                    # r2 = -c
                 add  r1, r2                # r2 = b - c
                 bgt  r2, L0                # if b > c, go to L0 
                 ld   $0x0, r2              # r2 = c = 0
                 br   L1                    # go to L1
L0:              ld   $0x1, r2              # r2 = c = 1
L1:              br   L7                    # go to L7
                 not  r1                    # not(b)
                 inc  r1                    # r1 = -b
                 add  r2, r1                # r1 = c - b
                 bgt  r1, L2                # if c > b, go to L2
                 ld   $0x0, r2              # r2 = c = 0
                 br   L3                    # go to L3
L2:              ld   $0x1, r2              # r2 = c = 1
L3:              br   L7                    # go to L3
                 not  r2                    # not(c)
                 inc  r2                    # r2 = -c
                 add  r1, r2                # r2 = -c + b
                 beq  r2, L4                # go to L4 if ( c = b)
                 ld   $0x0, r2              # r2 = c = 0
                 br   L5                    # go to L5
L4:              ld   $0x1, r2              # r2 = c = 1
L5:              br   L7                    # go to L7
L6:              ld   $0x0, r2              # r2 = c = 0
                 br   L7                    # go to L7
L7:              mov  r2, r0                # r0 = r2
                 j    0x0(r6)               # go to return address r6
.pos 0x400
                 .long 0x00000330           # case a = 10
                 .long 0x00000384           # case a = 11
                 .long 0x00000334           # case a = 12
                 .long 0x00000384           # case a = 13
                 .long 0x0000033c           # case a = 14
                 .long 0x00000384           # case a = 15
                 .long 0x00000354           # case a = 16
                 .long 0x00000384           # case a = 17
                 .long 0x0000036c           # case a = 18
.pos 0x1000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000 
                 .long 0x00000000 
                 .long 0x00000000
                 .long 0x00000000
