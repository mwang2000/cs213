.pos 0x100
                 ld   $1, r0              # r0 = 1
                 ld   $4, r1              # r1 = 4
                 ld   $2, r2              # r2 = 2
                 ld   $a, r3              # r3 = address a
                 ld   $b, r4              # r4 = address b
                 ld   0x0(r4), r5         # r5 = value of b

                 add  r5, r0              # b + 1
                 add  r0, r1              # (b+1) + 4
                 shr  $1, r1              # ((b+1) + 4)/2
                 and  r1, r5              # (((b+1) + 4)/2) & b
                 shl  $2, r5              # ((((b+1) + 4)/2) & b) << 2
                 st   r5, 0x0(r3)         # storing answer in a
                 halt                     # halt

.pos 0x1000
a:               .long 0xffffffff         # a
b:               .long 0x00000001         # b