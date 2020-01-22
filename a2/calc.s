.pos 0x100
                 ld   $i, r0              # r0 = address of i
                 ld   $x, r1              # r1 = address of x
                 ld   $y, r2              # r2 = address of y
                 ld   $data, r3           # r3 = address of data
                 ld   0x0(r0), r4         # r4 = value of i 
                 ld   (r3, r4, 4), r5     # r5 = value of data[i]
                 inc  r4                  # i + 1
                 ld   (r3, r4, 4), r6     # r6 = value of data[i+1]
                 add  r5, r6              # data[i] + data[i+1]
                 st   r6, 0x0(r2)         # y = data[i] + data[i+1]
                 ld   $f, r0              # r0 = address of f
                 ld   0x0(r0),r0          # r0 = value of f
                 and  r0, r6              # y & 0xff
                 st   r6, 0x0(r1)         # x = y & 0xff
                 halt                     # halt


.pos 0x1000
i:               .long 0x00000001         # i
x:               .long 0xffffffff         # x
y:               .long 0xffffffff         # y
f:               .long 0x000000ff         # f



.pos 0x2000
data:            .long 0x00000001         # data[0]
                 .long 0x00000002         # data[1]
                 .long 0x00000003         # data[2]
                 .long 0x00000004         # data[3]                 