.pos 0x1000
      ld $n, r0         # r0 = &n
      ld 0(r0), r0      # r0 = n
      ld $s, r2         # r2 = &s
      ld 0(r2), r2      # r2 = s[0]
      ld $24, r3        # r3 = sizeof(struct Student)
      ld $0, r7

compute_avg_iterate:
      beq r0, median 
      mov r0, r1
      not r1
      inc r1
      add r7, r1
      beq r1, sort_init
      inc r7
      br compute_avg

compute_avg:
      ld $0, r4         # r4 = 0
      ld 4(r2), r5      # r5 = grade1
      add r5, r4        # r4 = 0 + grade1
      ld 8(r2), r5      # r5 = grade2
      add r5, r4        # r4 = grade1 + grade2
      ld 12(r2), r5     # r5 = grade3
      add r5, r4        # r4 = grade1 + grade2 + grade3
      ld 16(r2), r5     # r5 = grade4
      add r5, r4        # r4 = grade1 + grade2 + grade3 + grade4
      shr $2, r4        # r4 = r4/4
      st r4, 20(r2)     # s.avg = r4
      add r3, r2
      br compute_avg_iterate

sort_init: 
      ld $n, r0         # r0 = &n
      ld $s, r1         # r1 = &s
      ld 0(r0), r0      # r0 = n
      ld 0(r1), r1      # r1 = s[0][0]
      mov r0, r2        # r2 = n
      ld $1, r3         # r3 = j = 1

i_loop: 
      dec r2            # r2 = n' - 1 = i' 
      beq r2, median    # if only one student, go to calculate median
      mov r3, r4        # r4 = j
      not r4                      
      inc r4            # r4 = -j
      add r2, r4        # r4 = n - 1 - j
      bgt r4, j_loop

j_loop:
      mov r3, r5        # r5 = j
      mov r2, r4        # r4 = i
      not r4
      inc r4            # r4 = -i
      add r5, r4
      bgt r4, i_loop

      mov r3, r4        # r4 = j
      mov r3, r5        # r5 = j
      shl $3, r4        # j * 8
      shl $4, r5        # j * 16
      add r5, r4        # j * 24
      add r1, r4        # r4 = &s[j]
      mov r4, r5        # r5 = r4
      ld $-24, r7       # r7 = -24
      add r7, r5        # r5 = &s[j] - 24
      ld 20(r4), r7     # r7 = s[j].average
      ld 20(r5), r6     # r5 = s[j-1].average
      not r7            
      inc r7            # r7 = -s[j].average
      add r7, r6        # r5 = s[j-1].average - s[j].average
      bgt r6, swap      
      inc r3
      br j_loop

swap:   
      ld $6, r0         # r6 = 6

swap_loop:
      beq r0, j_loop
      ld 0(r4), r7
      ld 0(r5), r6
      st r7, (r5)
      st r6, (r4)
      inca r4
      inca r5
      dec r0
      br swap_loop

median:
                ld $n, r7                   # r7 = n
                ld 0(r7), r7
                shr $1, r7                  # r7 = n'/2 = m
                ld $s, r0                   # r0 = &s
                ld (r0), r0                 # r0 = &s[0][0]
                mov r7, r1                  # r1 = m'
                mov r7, r2                  # r2 = m'
                shl $4, r1                  # r1 = m' * 16
                shl $3, r2                  # r2 = m' * 8
                add r2, r1                  # r4 = m' * 24
                add r1, r0                  # r0 = &s[m']
                ld (r0), r0                 # r0 = s[m']
                ld $m, r2                   # r2 = &m
                st r0, (r2)                 # m = s[m']
                halt

.pos 0x200
n:      .long 3
m:      .long 0
s:      .long base

.pos 0x3000
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

.pos 0x2000
n:    .long 5     # num students

m:    .long 0     # put the answer here

s:    .long base  # address of the array

.pos 0x3000
base: .long 1234  # student1 ID      
      .long 80    # grade 0
      .long 60    # grade 1
      .long 78    # grade 2
      .long 90    # grade 3
      .long 0     # computed average

      .long 3456  # student2 ID      
      .long 10    # grade 0
      .long 20    # grade 1
      .long 30    # grade 2
      .long 40    # grade 3
      .long 0     # computed average

      .long 5678  # student3 ID      
      .long 20    # grade 0
      .long 30    # grade 1
      .long 60    # grade 2
      .long 80    # grade 3
      .long 0     # computed average

      .long 2345  # student4 ID      
      .long 80    # grade 0
      .long 20    # grade 1
      .long 10    # grade 2
      .long 90    # grade 3
      .long 0     # computed average

      .long 6789  # student5 ID      
      .long 90    # grade 0
      .long 90    # grade 1
      .long 95    # grade 2
      .long 95    # grade 3
      .long 0     # computed average
