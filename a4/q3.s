.pos 0x100
                 ld   $d0, r0             # r0 = & d0
                 ld   0x4(r0), r1         # r1 = d0.f
                 st   r1, 0x0(r0)         # d0.e = d0.f
                 ld   $d1, r0             # r0 = & d1
                 ld   0x0(r0), r0         # r0 = d1
                 ld   0x4(r0), r1         # r1 = d1->f
                 st   r1, 0x0(r0)         # d1->e = d1->f
                 halt                     
.pos 0x2000
d0:              .long 0x00000001         # d0.e
                 .long 0x00000002         # d0.f
.pos 0x3000
d1:              .long 0x00004000         # d1
.pos 0x4000
d1_data:         .long 0x00000003         # d1->e
                 .long 0x00000004         # d1->f


## Will delete above code later, using as ref

.pos 0x1000
code:

.pos 0x2000
static:
i:               .long 0                  # i
v0:              .long 0                  # v0
v1:              .long 0                  # v1
v2:              .long 0                  # v2
v3:              .long 0                  # v3
s:               .long 0                  # x[0]
                 .long 0                  # x[1]
                 .long s_y                # *y
                 .long s_z                # *z

.pos 0x3000
heap:
s_y:             .long 0                  # 
                 .long 0                  # v
s_z:             .long 0                  # v
                 .long 0                  # v
                 .long 0                  # v
                 .long 0                  # v
s_z_z:           .long 0                  # v
                 .long 0                  # v
                 .long 0                  # v
                 .long 0                  # v
s_z_z_y:         .long 0                  # v
                 .long 0                  # v


