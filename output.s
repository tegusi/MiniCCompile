.comm v0,1600,4
  .text
  .align 2
  .global f_T2
  .type f_T2, @function
f_T2:
  add sp,sp,-80
  sw ra,76(sp)
  li s8,4
  mv t1,a0
  mv t2,a1
  mv t3,a2
  sw t2,52(sp)
  sw t3,56(sp)
  mv a0,t1
  call putint
  lw t2,52(sp)
  lw t3,56(sp)
  mv t0,a0
  sw t3,56(sp)
  mv a0,t2
  call putint
  lw t3,56(sp)
  mv t0,a0
  mv a0,t3
  call putint
  mv t0,a0
  .size f_T2, .-f_T2
  .text
  .align 2
  .global f_T7
  .type f_T7, @function
f_T7:
  add sp,sp,-96
  sw ra,92(sp)
  li s8,4
  mv t2,a0
  mv t1,a1
  li t3,1
.l0:
  li s10,1
  add t4,t1,s10
  ble t4,t3,.l1
  mul t4,s8,t3
  mv s11,t2
  add s11,s11,t4
  lw t4,0(s11)
  mv t5,t4
  sw t1,52(sp)
  sw t2,48(sp)
  sw t3,56(sp)
  mv a0,t5
  call putint
  lw t1,52(sp)
  lw t2,48(sp)
  lw t3,56(sp)
  mv t0,a0
  li s10,1
  add t3,t3,s10
  j .l0
.l1:
  li a0,1
  lw ra,92(sp)
add sp,sp,96
jr ra
  .size f_T7, .-f_T7
  .text
  .align 2
  .global f_T16
  .type f_T16, @function
f_T16:
  add sp,sp,-192
  sw ra,188(sp)
  li s8,4
  mv t2,a0
  mv t3,a1
  mv t1,a2
  mv t4,a3
  ble t4,t1,.l2
  li s10,1
  add t5,t1,s10
  mv t6,t4
.l3:
  ble t6,t5,.l4
  mul a0,s8,t5
  mv s11,t2
  add s11,s11,a0
  lw a0,0(s11)
  mul a1,s8,t1
  mv s11,t2
  add s11,s11,a1
  lw a1,0(s11)
  ble a0,a1,.l5
  mul a0,s8,t5
  mv s11,t2
  add s11,s11,a0
  lw a0,0(s11)
  mv a1,a0
  mul a0,s8,t6
  mv s11,t2
  add s11,s11,a0
  lw a0,0(s11)
  mul a2,s8,t5
  mv s11,t2
  add s11,s11,a2
  sw a0,0(s11)
  mul a0,s8,t6
  mv s11,t2
  add s11,s11,a0
  sw a1,0(s11)
  li s10,1
  sub t6,t6,s10
  j .l6
.l5:
  li s10,1
  add t5,t5,s10
.l6:
  j .l3
.l4:
  mul a0,s8,t5
  mv s11,t2
  add s11,s11,a0
  lw a0,0(s11)
  mul a1,s8,t1
  mv s11,t2
  add s11,s11,a1
  lw a1,0(s11)
  li s10,1
  sub a2,a1,s10
  ble a0,a2,.l7
  li s10,1
  sub t5,t5,s10
.l7:
  mul a0,s8,t1
  mv s11,t2
  add s11,s11,a0
  lw a0,0(s11)
  mv a1,a0
  mul a0,s8,t5
  mv s11,t2
  add s11,s11,a0
  lw a0,0(s11)
  mul a2,s8,t1
  mv s11,t2
  add s11,s11,a2
  sw a0,0(s11)
  mul a0,s8,t5
  mv s11,t2
  add s11,s11,a0
  sw a1,0(s11)
  sw t2,48(sp)
  sw t3,52(sp)
  sw t4,60(sp)
  sw t6,68(sp)
  lw a0,48(sp)
  lw a1,52(sp)
  mv a2,t1
  mv a3,t5
  call f_T16
  lw t2,48(sp)
  lw t3,52(sp)
  lw t4,60(sp)
  lw t6,68(sp)
  mv t0,a0
  mv a0,t2
  mv a1,t3
  mv a2,t6
  mv a3,t4
  call f_T16
  mv t0,a0
  li a0,1
  lw ra,188(sp)
add sp,sp,192
jr ra
  j .l8
.l2:
  li a0,1
  lw ra,188(sp)
add sp,sp,192
jr ra
.l8:
  .size f_T16, .-f_T16
  .text
  .align 2
  .global main
  .type main, @function
main:
  add sp,sp,-432
  sw ra,428(sp)
  li s8,4
  call getint
  mv t2,a0
  li t3,1
.l9:
  li s10,1
  add t4,t2,s10
  ble t4,t3,.l10
  sw t2,48(sp)
  sw t3,376(sp)
  call getint
  lw t2,48(sp)
  lw t3,376(sp)
  mv t4,a0
  mul t5,s8,t3
  add s11,sp,52
  add s11,s11,t5
  sw t4,0(s11)
  li s10,1
  add t3,t3,s10
  j .l9
.l10:
  sw t2,48(sp)
  add a0,sp,52
  lw a1,48(sp)
  call f_T7
  lw t2,48(sp)
  mv t0,a0
  li t3,1
  mv t4,t2
  sw t2,48(sp)
  add a0,sp,52
  lw a1,48(sp)
  mv a2,t3
  mv a3,t4
  call f_T16
  lw t2,48(sp)
  mv t0,a0
  add a0,sp,52
  mv a1,t2
  call f_T7
  mv t0,a0
  li a0,0
  lw ra,428(sp)
add sp,sp,432
jr ra
  .size main, .-main
