.pos 0x1000
code:
                 ld $i, r0                # r0 = &i
                 ld 0(r0), r0             # r0 = i
                 ld $s, r1                # r1 = &s
                 ld (r1, r0, 4), r2       # r2 = s.x[i]
                 ld $v0, r3               # r3 = &v0
                 st r2, 0(r3)             # v0 = s.x[i];

                 ld 0x8(r1), r4           # r4 = &(s.*y)
                 ld (r4, r0, 4), r5       # r5 = s.*y[i]
                 ld $v1, r6               # r6 = &v1
                 st r5, 0(r6)             # v1 = s.y[i]

                 ld 0xc(r1), r7           # r7 = &(s.*z)
                 ld (r7, r0, 4), r2       # r7 = s.*z->x[i]
                 ld $v2, r3               # r3 = &v2
                 st r2, 0(r3)             # v2 = s.z->x[i];

                 ld 0xc(r7), r4          # r4 = &(s.*z->z)
                 ld 0x8(r4), r4           # r4 = &(s.*z->z->*y)
                 ld (r4, r0, 4), r4       # r4 = s.*z->z->*y[i]
                 ld $v3, r6               # r6 = &v3
                 st r4, 0(r6)             # v2 = s.z->x[i];
                                          # v3 = s.z->z->y[i]
                 halt

.pos 0x2000
static:
i:               .long 0x00000001         # i
v0:              .long 0x00000000         # v0
v1:              .long 0x00000000         # v1
v2:              .long 0x00000000         # v2
v3:              .long 0x00000000         # v3
s:               .long 0x00000001         # x[0]
                 .long 0x00000002         # x[1]
                 .long s_y                # *y
                 .long s_z                # *z

.pos 0x3000
heap:
s_y:             .long 0x00000003         # s_y[0]
                 .long 0x00000004         # s_y[1]
s_z:             .long 0x00000005         # s_z->x[0]
                 .long 0x00000006         # s_z->x[1]
                 .long 0x00000000         # s_z->*y
                 .long s_z_z              # s_z->*z
s_z_z:           .long 0x00000007         # s_z_z->x[0]
                 .long 0x00000008         # s_z_z->x[1]
                 .long s_z_z_y            # s_z_z->*y
                 .long 0x00000000         # s_z_z->*z
s_z_z_y:         .long 0x00000009         # s_z_z->y[0]
                 .long 0x00000000         # s_z_z->y[1]


