## Code - TODO: Comment and translate to C in q1()
.pos 0x1000

## C statement 1
S1:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = 1
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a // a = d0
ld    (r1), r1          # r1 = &a->x[0]
ld    (r1, r0, 4), r2   # r2 = a->x[1]
ld    $v0, r3           # r3 = &v0
st    r2, (r3)          # v0 = a->x[1]

## C statement 2
S2:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = 1
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a // a = d0
inca  r1                # r1 = &a->b.y[0]
ld    (r1, r0, 4), r2   # r2 = a->b.y[1]
ld    $v1, r3           # r3 = &v1
st    r2, (r3)          # v1 = a->b.y[1]

## C statement 3
S3:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = 1
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a // a = d0
ld    20(r1), r1        # r1 = a->b.a
ld    (r1), r1          # r1 = &a->b.a->x[0]
ld    (r1, r0, 4), r2   # r2 = a->b.a->x[1]
ld    $v2, r3           # r3 = &v2
st    r2, (r3)          # v2 = a->b.a->x[1]

## C statement 4
S4:
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a // a = d0
st    r1, 20(r1)        # a->b.a = a // a = d0

## C statement 5
S5:
ld    $i, r0            # r0 = &i
ld    (r0), r0          # r0 = 1
ld    $a, r1            # r1 = &a
ld    (r1), r1          # r1 = a // a = d0
ld    20(r1), r1        # r1 = a->b.a // a->b.a = d0
inca  r1                # r1 = &a->b.a->b.y[0]
ld    (r1, r0, 4), r2   # r2 = a->b.a->b.y[1]
ld    $v3, r3           # r3 = &v3
st    r2, (r3)          # v3 = a->b.a->b.y[1]


halt


## Globals
.pos 0x2000
i:  .long 1
v0: .long 0
v1: .long 0
v2: .long 0
v3: .long 0
a:  .long d0


## Heap (these labels represent dynamic values and are thus not available to code)
.pos 0x3000
d0: .long d1   # *x
    .long 20   # B
    .long 21
    .long 22
    .long 23
    .long d2   # *A
d2: .long d3   # *x
    .long 40   # B
    .long 41
    .long 42
    .long 43
    .long 0
d1: .long 10   # x[0]
    .long 11
    .long 12
    .long 13
d3: .long 30   # x[0]
    .long 31
    .long 32
    .long 33
