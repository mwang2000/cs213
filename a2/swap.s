.pos 0x100
                 ld   $t, r0              # r0 = address of t
                 ld   $array, r1          # r1 = address of array
                 ld   0x0(r1), r2         # r2 = value of array[0]
                 ld   0x04(r1), r3        # r3 = value of array[1]
                 st   r2, 0x0(r0)         # t = array[0]             
                 st   r3, 0x0(r1)         # array[0] = array[1]
                 ld   0x0(r0), r0         # r0 = value of t
                 st   r0, 0x04(r1)        # array[1] = t
                 halt                     # halt

.pos 0x1000
t:               .long 0xffffffff         # t
.pos 0x2000
array:           .long 0x00000005         # array[0]
                 .long 0x00000006         # array[1]
