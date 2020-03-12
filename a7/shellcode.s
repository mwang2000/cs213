ld $0, r0       # r0 = 0    
ld $7, r1       # r1 = 7
gpc $4, r0      # r0 = return address
sys $2          # call exec
halt

.long 0x2f62696e
.long 0x2f7368a0