.pos 0x1000
ld $0, r0                   # r0 = i' = 0
ld $n, r1                   # r1 = &n
ld (r1), r1                 # r1 = n
ld $a, r2                   # r2 = &a
ld $b, r3                   # r3 = &b
ld $0, r4                   # r4 = c' = 0
not r1          
inc r1                      # r1 = -n

loop:   mov r0, r5          # r5 = i'
        add r1, r5          # r5 = i'-n
        beq r5, done        # goto done if i' == n 
        ld (r2,r0,4), r6    # r6 = a[i]
        ld (r3,r0,4), r7    # r7 = b[i]
        not r7              
        inc r7              # r7 = -b[i]
        add r6,r7           # r7 = a[i] - b[i]
        bgt r7, then        # goto then if a[i] > b[i]
        inc r0              # i++
        br loop             # goto loop

then:   inc r4              # c'++
        inc r0              # i++
        br loop             # goto loop

done:   ld $i, r2           # r2 = &i
        st r0, (r2)         # i = i'
        ld $c, r1           # r1 = &c
        st r4, (r1)         # c = c'
        halt

.pos 0x2000
i:  .long -00000001
n:  .long 00000005
a:  .long 00000010
    .long 00000020
    .long 00000030
    .long 00000040
    .long 00000050
b:  .long 00000011
    .long 00000020
    .long 00000028
    .long 00000044
    .long 00000048
c:  .long 0
