.pos 0x100
                ld $0, r4                   # r4 = i = 0
                ld $n, r7                   # r7 = &n
                ld (r6), r7                 # r7 = n = n'
                not r7                      
                inc r7                      # r7 = -n' 
                ld $s, r0                   # r0 = &s

        avg:    mov r4, r5                  # r5 = i'
                add r7, r5                  # r5 = i' - n'
                beq r5, sort                # goto sort if i' == n'
                mov r4, r5                  # r5 = i'
                mov r5, r1                  # r1 = i'
                mov r5, r2                  # r2 = i'
                shl $4, r1                  # r1 = i' * 16
                shl $3, r2                  # r2 = i' * 8
                add r2,r1                   # r1 = i' * 24
                mov r0, r2                  # r2 = &s
                ld (r2), r2                 # r2 = &base
                add r2, r1                  # r1 = &s[i']                      
                ld 4(r1), r2                # r2 = s[i'].grade0
                ld 8(r1), r3                # r3 = s[i'].grade1
                add r3, r2                  # r2 = grade0 + grade1
                ld 12(r1), r3               # r3 = s[i'].grade2
                add r3, r2                  # r2 = grade0 + grade1 + grade2
                ld 16(r1), r3               # r3 = s[i'].grade3
                add r3, r2                  # r2 = grade0 + grade1 + grade2 + grade3
                shr $2, r2                  # r2 = r2/4
                st r2, 20(r1)               # s[i'].average = r2
                inc r4                      # i'++
                br avg                      # goto avg 
                
        compare:ld 20(r1), r2               # r2 = s[i'].average
                ld 44(r1), r3               # r3 = s[i'+1].average
                not r3                      
                inc r3                      # r3 = -r3
                add r3,r2                   # r2 = s[i'].average - s[i'+1].average
                bgt r2, swap                # goto swap if s[i'].average > s[i'+1].average
                j (r6)
                
        swap:   ld $6, r4                   # r4 = 6
        L0:     beq r4, L1                  # goto L1 if r4 == 0
                ld 24(r1), r2               # r2 = &s[i'+1]
                mov r1, r3                  # r3 = &s[i']
                st (r2), r1                 # r1 = &s[i'+1]
                st (r3), r2                 # r2 = &s[i']
                inca r1                     # r1 += 4
                dec r4                      # r4 --
                br L0                       # goto L0

        L1:     j (r6)

        sort:   mov r7, r2                  # r2 = -n'
                not r2
                inc r2                      # r2 = n'
                dec r2                      # r2 = n' - 1 = i'
                beq r2, median              # goto median if n'-1 == 0        
        bubble: ld $0, r3                   # r3 = j' = 0
                add r3, r4                  # r4 = j' - i'
                beq r4, end_sort            # goto end_sort if j' == i'
                mov r3, r4                  # r4 = j'
                mov r3, r5                  # r5 = j'
                shl $4, r4                  # r4 = j' * 16
                shl $3, r5                  # r5 = j' * 8
                add r5, r4                  # r4 = j' * 24
                mov r0, r5                  # r5 = &s
                ld (r5), r5                 # r5 = &base
                add r5, r1                  # r1 = &s[j']
                gpc $6, r6                  
                j compare
                inc r3                      # j'++
                br bubble                   # goto bubble
                
        end_sort: dec r2                      # i'--
                br sort                     # goto sort

        median: not r7                      
                inc r7                      # r7 = n'
                shr $1, r7                  # r7 = n'/2
                inc r7                      # r7 = n'/2 + 1 = m
                ld (r0), r0                 # r0 = &base
                mov r7, r1                  # r1 = m'
                mov r7, r2                  # r2 = m'
                shl $4, r1                  # r1 = m' * 16
                shl $3, r2                  # r2 = m' * 8
                add r2, r1                  # r4 = m' * 24
                add r1, r0                  # r0 = &s[m']
                ld (r0), r0                 # r0 = s[m']
                ld $m, r2                   # r2 = &m
                st (r0), r2                 # m = s[m']

                halt

.pos 0x200
n:      .long 3
m:      .long 0
s:      .long base

.pos 0x1000
base:   .long 1234
        .long 80
        .long 60
        .long 78
        .long 90
        .long 0
s1:     .long 2345
        .long 80
        .long 68
        .long 21
        .long 14
        .long 0
s2:     .long 3456
        .long 41
        .long 78
        .long 60
        .long 40
        .long 0