.pos 0x100
    # tmp = 0
    ld $tmp, r0             # r0 = address of tmp
    ld 0(r0), r1            # r1 = value of tmp
    ld $0, r2               # r2 = 0
    st r2, 0(r0)            # tmp = 0 
    ld 0(r2), r1               # r1 = tmp

    # tos = 0
    ld $tos, r3             # r3 = address of tos
    ld 0(r3), r4            # r4 = value of tos
    st r2, 0(r3)            # tos = 0
    ld 0(r2), r4               # r4 = tos

    #s[tos] = a[0]
    ld $s, r5               # r5 = address of s
    ld $a, r6               # r6 = address of a
    ld (r6, r2, 4), r7      # r7 = a[0]
    st r7, (r5,r4,4)        # s[tos] = a[0]

    # tos++
    inc r4                 # tos++
    st r4, 0(r3)            # store tos into memory

    #s[tos] = a[1]
    inc r2                  # r2 ++
    ld (r6, r2, 4), r7      # r7 = a[1]
    st r7, (r5,r4,4)        # s[tos] = a[1]

    # tos ++
    inc r4                 # tos++
    st r4, 0(r3)            # store tos into memory

    # s[tos] = a[2]
    inc r2                  # r2 ++
    ld (r6, r2, 4), r7      # r7 = a[2]
    st r7, (r5,r4,4)        # s[tos] = a[2]

    # tos ++
    inc r4                 # tos++
    st r4, 0(r3)            # store tos into memory

    # tos --
    dec r4                  # tos--
    st r4, 0(r3)            # store tos into memory

    # tmp = s[tos]
    ld (r5,r4,4), r7        # r7 = s[tos]
    st r7, 0(r0)            # tmp = s[tos]
    ld $tmp, r1             # r1 = address of tmp
    ld 0(r1), r1            # r1 = value of tmp

    # tos --
    dec r4                  # tos--
    st r4, 0(r3)            # store tos into memory

    # tmp = tmp + s[tos]
    ld (r5,r4,4), r7        # r7 = s[tos]
    add r1, r7              # r7 = s[tos] + tmp
    st r7,0(r0)             # tmp = tmp + s[tos]
    ld $tmp,r1              # r1 = address of tmp
    ld 0(r1), r1            # r1 = value of tmp

    # tos--
    dec r4                  # tos--
    st r4, 0(r3)            # store tos into memory

    # tmp = tmp + s[tos]
    ld (r5,r4,4), r7        # r7 = s[tos]
    add r1, r7              # r7 = s[tos] + tmp
    st r7,0(r0)             # tmp = tmp + s[tos]
    ld $tmp, r1             # r1 = address of tmp
    ld 0(r1), r1            # r1 = value of tmp

    halt                    # halt

.pos 0x200
    a:  .long 0
        .long 1
        .long 2
    s:  .long 3
        .long 4
        .long 5
        .long 6
        .long 7
    tos:.long 1
    tmp:.long 1