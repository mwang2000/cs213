.pos 0x100
                 ld   $tmp, r0            # r0 = address of tmp
                 ld   $tos, r1            # r1 = address of tos
                 ld   $0, r2              # r2 = 0

                 # tos  = 0;
                 st   r2, 0(r0)           # tmp = 0
                 st   r2, 0(r1)           # tos = 0


                 # i  = a[i];
                 ld   (r1, r2, 4), r3     # r3 = value of a[i]
                 st   r3, 0(r0)           # i  = a[i]

                 # p  = &j;
                 ld   $j, r4              # r4 = address of j
                 ld   $p, r5              # r5 = address of p 
                 st   r4, 0(r5)           # p = &j

                 # *p = 4;
                 ld   $4, r6              # r6 = 4
                 ld   0x0(r5), r7         # r7 = value of p (address of j)
                 st   $4, 0(r7)           # *p = 4;           

                 # p  = &a[a[2]];        
                 ld   0x8(r1), r0         # r0 = value of a[2]
                 

                 halt                 



.pos 0x2000
tmp:             .long 0x00000000         # tmp
too:             .long 0x00000000         # tos
a:               .long 0x00000001         # a[0]
                 .long 0x00000002         # a[1]
                 .long 0x00000003         # a[2]
s:               .long 0x00000001         # s[0]
                 .long 0x00000002         # s[1]
                 .long 0x00000003         # s[2]
                 .long 0x00000004         # s[3]             
                 .long 0x00000005         # s[4]