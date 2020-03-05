.pos 0x0
                 ld   $sb, r5
                 inca r5
                 gpc  $6, r6                  
                 j    0x300             
                 halt                     
.pos 0x100
                 .long 0x00001000         
.pos 0x200
                 ld   (r5), r0
                 ld   4(r5), r1
                 ld   $0x100, r2          
                 ld   (r2), r2
                 ld   (r2, r1, 4), r3     
                 add  r3, r0              
                 st   r0, (r2, r1, 4)     
                 j    (r6)
.pos 0x300
                 ld   $-12, r0
                 add  r0, r5              
                 st   r6, 8(r5)
                 ld   $1, r0
                 st   r0, (r5)
                 ld   $2, r0
                 st   r0, 4(r5)
                 ld   $-8, r0
                 add  r0, r5              
                 ld   $3, r0
                 st   r0, (r5)
                 ld   $4, r0
                 st   r0, 4(r5)
                 gpc  $6, r6                  
                 j    0x200
                 ld   $8, r0
                 add  r0, r5              
                 ld   (r5), r1
                 ld   4(r5), r2
                 ld   $-8, r0
                 add  r0, r5              
                 st   r1, (r5)
                 st   r2, 4(r5)
                 gpc  $6, r6                  
                 j    0x200
                 ld   $8, r0
                 add  r0, r5              
                 ld   8(r5), r6
                 ld   $12, r0
                 add  r0, r5              
                 j    (r6)
.pos 0x1000
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
                 .long 0
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
