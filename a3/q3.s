.pos 0x100
                 ld   $a, r0              # r0 = address of a
                 ld   $3, r1              # r1 = 3
                 ld   $p, r2              # r2 = address of p

                 # a  = 3;
                 st   r1, 0(r0)           # a = 3

                 # p  = &a
                 st   r0, 0(r2)           # p = &a

                 # *p = *p - 1;
                 ld   0(r2), r3           # r3 = address of a
                 ld   0(r3), r4           # r4 = value of a
                 dec  r4
                 st   r4, 0(r3)

                 # p  = &b[0]
                 ld   $b, r5              # r5 = address of b
                 st   r5, 0(r2)           # p = &b

                 # p++;
                 ld   0(r2), r6           # r6 = p = address of b
                 inca r6                  # r6 = address of b + 4
                 st   r6, 0(r2)           # p = &b

                 # p[a] = b[a];
                 ld   (r5, r4, 4), r7     # r7 = b[a]
                 st   r7, (r2, r4, 4)     # p[a] = b[a]

                 # *(p+3) = b[0];
                 

                 halt                 



.pos 0x2000
a:               .long 0x00000000         # a
p:               .long 0x00000000         # p
b:               .long 0x00000001         # b[0]
                 .long 0x00000002         # b[1]
                 .long 0x00000003         # b[2]
                 .long 0x00000004         # b[3]             
                 .long 0x00000005         # b[4]