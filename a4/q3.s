.pos 0x1000
code:
                 ld $i, r0                # r0 = &i
                 ld 0(r0), r0             # r0 = i
                 halt

.pos 0x2000
static:
i:               .long 1                  # i
v0:              .long 0                  # v0
v1:              .long 0                  # v1
v2:              .long 0                  # v2
v3:              .long 0                  # v3
s:               .long 1                  # x[0]
                 .long 2                  # x[1]
                 .long s_y                # *y
                 .long s_z                # *z

.pos 0x3000
heap:
s_y:             .long 3                  # s_y[0]
                 .long 4                  # s_y[1]
s_z:             .long 5                  # s_z->x[0]
                 .long 6                  # s_z->x[1]
                 .long 0                  # s_z->*y
                 .long s_z_z              # s_z->*z
s_z_z:           .long 7                  # s_z_z->x[0]
                 .long 8                  # s_z_z->x[1]
                 .long s_z_z_y            # s_z_z->*y
                 .long 0                  # s_z_z->*z
s_z_z_y:         .long 9                  # s_z_z->y[0]
                 .long 0                  # s_z_z->y[1]


