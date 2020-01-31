.pos 0x100
                 ld   $i, r0              # r0 = address of i
                 ld   $a, r1              # r1 = address of a

                 # i  = a[3];
                 ld   0xc(r1), r2         # r2 = value of a[3]
                 st   r2, 0(r0)           # i = a[3]
                 
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
                 st   r6, 0(r7)           # *p = 4;           

                 # p  = &a[a[2]];        
                 ld   0x8(r1), r0         # r0 = value of a[2]
                 shl  $2, r0              # r0 = 4 * a[2]
                 add  r1, r0              # r0 = r0 + r1
                 st   r0, 0(r5)           # r5 = p = address of a[a[2]]
                 
                 # *p = *p + a[4];
                 ld   $p, r3              # r3 = address of p
                 ld   0x0(r3), r7          # r7 = address of a[a[2]]
                 ld   0x0(r7), r2          # r2 = val of a[a[2]]

                 ld   0x10(r1), r6        # r6 = value of a[4]
                 add  r2, r6              # r6 = a[4] + a[a[2]]
                 st   r6, 0(r7)           # [a[a[2]]] = [a[a[2]]+a[4]]

                 halt                 

.pos 0x2000
i:               .long 0x00000000         # i
j:               .long 0x00000000         # j
p:               .long 0x00000000         # p
a:               .long 0x00000001         # a[0]
                 .long 0x00000002         # a[1]
                 .long 0x00000003         # a[2]
                 .long 0x00000004         # a[3]             
                 .long 0x00000005         # a[4]
                 .long 0x00000006         # a[5]
                 .long 0x00000007         # a[6]
                 .long 0x00000008         # a[7]
                 .long 0x00000009         # a[8]
                 .long 0x0000000a         # a[9]    