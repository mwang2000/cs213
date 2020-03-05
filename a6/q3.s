.pos 0x1000
      ld $n, r0         # r0 = &n
      ld 0(r0), r0      # r0 = n
      ld $s, r2         # r2 = &s
      ld 0(r2), r2      # r2 = s[0]
      ld $24, r3        # r3 = sizeof(struct Student)
      ld $0, r7         # r7 = 0 (counter)

compute_avg_iterate:
      beq r0, median    # if n = 0 go straight to median
      mov r0, r1        # r1 = r0
      not r1                  
      inc r1            # r1 = -r0 = -n
      add r7, r1        # r7 + r1
      beq r1, sort_init # if counter - n = 0, go to sort
      inc r7            # counter++
      br compute_avg    # go to compute_avg function

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
      add r3, r2        # &s[0] + 24
      br compute_avg_iterate  # keep looping

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
      bgt r4, j_loop    # if n - 1 - j > 0, go to inner loop

j_loop:
      mov r3, r5        # r5 = j
      mov r2, r4        # r4 = i
      not r4
      inc r4            # r4 = -i
      add r5, r4        # j - i
      bgt r4, i_loop    # if j - i = 0, go to outer loop

      mov r3, r4        # r4 = j
      mov r3, r5        # r5 = j
      shl $3, r4        # j * 8
      shl $4, r5        # j * 16
      add r5, r4        # j * 24
      add r1, r4        # r4 = &s[j]
      mov r4, r5        # r5 = r4

      deca r5           # decrease address 6x
      deca r5           # didn't want to make another loop :(
      deca r5
      deca r5
      deca r5
      deca r5

      ld $5, r7              # 57 = 5 (index of average)
      ld (r5, r7, 4), r6     # r5 = s[j-1].average
      ld (r4, r7, 4), r7     # r7 = s[j].average
      not r7            
      inc r7            # r7 = -s[j].average
      add r7, r6        # r5 = s[j-1].average - s[j].average
      bgt r6, swap      # if avg of previous s[j-1] is bigger, swap

      inc r3            # j++
      br j_loop         # go to j_loop

swap:   
      ld $6, r0         # r0 = 6 = swap counter

swap_loop:
      ld 0(r4), r7      # r7 = s[j].somefield
      ld 0(r5), r6      # r6 = s[j-1].somefield
      st r7, (r5)       # swap s[j] field with s[j-1] field
      inca r5           # &s[j-1]+4
      st r6, (r4)       # swap s[j-1] field with s[j] field
      inca r4           # &s[j]+4
      dec r0            # decrease swap counter
      beq r0, j_loop    # if swap counter = 0, go back to inner loop
      br swap_loop      # else, keep swapping

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
