.pos 0x100
start:
    ld $sb, r5          # r5 = stack pointer
    inca    r5          # r5 = stack pointer + 1
    gpc $6, r6          # r6 = address to return to after function
    j main              # jump to function main
    halt

f:
    deca r5             # r5 = stack pointer - 1
    ld $0, r0           # r0 = 0
    ld 4(r5), r1        # r1 = arg1
    ld $0x80000000, r2  # r2 = 80000000
f_loop:
    beq r1, f_end       # if arg1 = 0, go to f_end function
    mov r1, r3          # r3 = r1 = arg1
    and r2, r3          # r3 = arg1 & 80000000
    beq r3, f_if1       # if r3 = 0, go to f_if1 function
    inc r0              # r0 = r0 + 1
f_if1:
    shl $1, r1          # r1 = arg1 << 1
    br f_loop           # jump to f_loop function
f_end:
    inca r5             # deallocate argument for f_loop
    j(r6)               # jump to return address in main_loop

main:
    deca r5             # stack pointer - 1
    deca r5             # stack pointer - 1 - 1
                        # stack now has room for 2 objects
    st r6, 4(r5)        # store return address at bottom of stack
    ld $8, r4           # r4 = 8
main_loop:
    beq r4, main_end    # if r4 = 0, go to main_end function
    dec r4              # r4 = r4 - 1 = count1
    ld $x, r0           # r0 = &x
    ld (r0,r4,4), r0    # r0 = x[count1]
    deca r5             # stack pointer -1 -1 -1
    st r0, (r5)         # r5 = r0 -> put r0 on stack
    gpc $6, r6          # r6 = address to return to after function
    j f                 # jump to function f
    inca r5             # deallocate argument for function f from stack
    ld $y, r1           # r1 = &y
    st r0, (r1,r4,4)    # y[count1] = r0 (from f)
    br main_loop        # jump to beginning of main_loop
main_end:
    ld 4(r5), r6        # r6 = update return address from main
    inca r5             # deallocate space for arguments
    inca r5             # deallocate space for arguments
    j (r6)              # jump to halt

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long -1
    .long -2
    .long 0
    .long 184
    .long 340057058

y:
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

