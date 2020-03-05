.pos 0x0
                 ld   $sb, r5           # r5 = stack pointer
                 inca r5                # r5 = stack pointer + 1
                 gpc  $6, r6            # r6 = address to return to after function
                 j    0x300             # jump to function at 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000       # pointer to array of 10 int (int *someP = someA)
.pos 0x200
                 ld   (r5), r0          # r0 = arg1
                 ld   4(r5), r1         # r1 = arg2
                 ld   $0x100, r2        # r2 = &someP
                 ld   (r2), r2          # r2 = someP = &someA
                 ld   (r2, r1, 4), r3   # r3 = someA[arg2]
                 add  r3, r0            # r0 = arg1 + someA[arg2]
                 st   r0, (r2, r1, 4)   # someA[arg2] = arg1 + someA[arg2]
                 j    (r6)              # end
.pos 0x300
                 ld   $-12, r0          # r0 = -12
                 add  r0, r5            # r5 = stack pointer - 12
                                        # stack now has 5 elements
                 st   r6, 8(r5)         # store return address at bottom of stack
                 ld   $1, r0            # r0 = 1
                 st   r0, (r5)          # local1 = 1
                 ld   $2, r0            # r0 = 2
                 st   r0, 4(r5)         # local2 = 2

                 ld   $-8, r0           # r0 = -8
                 add  r0, r5            # r5 = stack pointer - 12 - 8
                                        # stack now has 5 elements
                 ld   $3, r0            # r0 = 3
                 st   r0, (r5)          # parameter 1 is 3
                 ld   $4, r0            # r0 = 4
                 st   r0, 4(r5)         # parameter 2 is 4
                 gpc  $6, r6            # r6 = setting return address
                 j    0x200             # jump to function at 0x200 with arguments (3,4)

                 ld   $8, r0            # r0 = 8
                 add  r0, r5            # r5 = stack pointer - 12 -8 + 8 (deallocate previous 2 parameters)
                                        # stack now has 3 elements

                 ld   (r5), r1          # r1 = element at top of stack = local1 = 1
                 ld   4(r5), r2         # r2 = element just below top of stack = local2 = 2

                 ld   $-8, r0           # r0 = -8
                 add  r0, r5            # r5 = stack pointer - 12 - 8
                                        # stack now has 5 elements 
                 st   r1, (r5)          # parameter 1 = local1 = 1
                 st   r2, 4(r5)         # parameter 2 = local2 = 2
                 gpc  $6, r6            # r6 = setting return address     
                 j    0x200             # jump to function at 0x200 with arguments (1,2)

                 ld   $8, r0            # r0 = 8
                 add  r0, r5            # r5 = stack pointer - 12 - 8 + 8 (deallocate previous 2 parameters)
                                        # stack now has 3 elements
                 ld   8(r5), r6         # r6 = return address from section 0x0
                 ld   $12, r0           # r0 = 12
                 add  r0, r5            # r5 = stack pointer - 12 + 12 (deallocate previous 3 parameters)
                                        # stack now has 0 elements, everything deallocated
                 j    (r6)              # jump to halt
.pos 0x1000
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
