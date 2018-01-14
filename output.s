.comm v0,160000,4
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
  mv t4,a1
  li t5,1
  sw t2,48(sp)
  sw t4,52(sp)
  sw t5,56(sp)
  call putint
  lw t2,48(sp)
  lw t4,52(sp)
  lw t5,56(sp)
  mv t0,a0
  mv t1,t3
  mv s11,t2
  add s11,s11,t3
  lw t3,0(s11)
  li s10,1
  add t1,t4,s10
.l0:
  ble t1,t5,.l1
  slli t3,t5,2
  li s10,1
  add t5,t5,s10
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
  mv a3,a0
  mv a4,a1
  mv t1,a2
  mv t2,a3
  ble t2,t1,.l2
  li s10,1
  add t3,t1,s10
  mv t4,t2
.l6:
.l5:
  j .l6
  mv s11,a3
  add s11,s11,t6
  sw t5,0(s11)
  mv s11,a3
  add s11,s11,a0
  sw a1,0(s11)
  mv s11,a3
  add s11,s11,a1
  lw a1,0(s11)
  mv t5,a2
  mv s11,a3
  add s11,s11,a2
  lw a2,0(s11)
  slli t5,t1,2
  li s10,1
  add t3,t3,s10
.l3:
  ble t4,t3,.l4
  slli t6,t3,2
  mv s11,a3
  add s11,s11,t6
  lw t6,0(s11)
  mv s11,a3
  add s11,s11,t5
  lw t5,0(s11)
  ble t6,t5,.l5
  slli a2,t3,2
  slli a1,t4,2
  slli a0,t3,2
  slli t6,t4,2
  li s10,1
  sub t4,t4,s10
  j .l3
.l4:
  slli t5,t3,2
  mv s11,a3
  add s11,s11,t5
  lw t5,0(s11)
  slli t6,t1,2
  mv s11,a3
  add s11,s11,t6
  lw t6,0(s11)
  li s10,1
  sub a0,t6,s10
  ble t5,a0,.l7
  li s10,1
  sub t3,t3,s10
.l7:
  slli t5,t1,2
  mv s11,a3
  add s11,s11,t5
  lw t5,0(s11)
  mv t6,t5
  slli t5,t3,2
  mv s11,a3
  add s11,s11,t5
  lw t5,0(s11)
  slli a0,t1,2
  mv s11,a3
  add s11,s11,a0
  sw t5,0(s11)
  slli t5,t3,2
  mv s11,a3
  add s11,s11,t5
  sw t6,0(s11)
  sw t2,60(sp)
  sw t4,68(sp)
  mv a0,t1
  mv a1,a3
  mv a2,a4
  sw a3,48(sp)
  mv a3,t1
  sw a4,52(sp)
  mv a4,t3
  call f_T16
  lw t2,60(sp)
  lw t4,68(sp)
  mv t0,a0
  lw a0,48(sp)
  lw a1,52(sp)
  mv a2,t4
  mv a3,t2
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
  add sp,sp,-160112
  sw ra,160108(sp)
  li s8,4
  call getint
  mv t5,a0
  li t6,1
  li s10,1
  add t6,t6,s10
  add s11,sp,52
  add s11,s11,t2
  sw t1,0(s11)
  slli t2,t6,2
  sw t5,48(sp)
  sw t6,160056(sp)
  call getint
  lw t5,48(sp)
  lw t6,160056(sp)
  mv t1,a0
  ble t3,t6,.l10
  li s10,1
  add t3,t5,s10
.l9:
  j .l9
.l10:
  sw t5,48(sp)
  add a0,sp,52
  lw a1,48(sp)
  call f_T7
  lw t5,48(sp)
  mv t0,a0
  li t1,1
  mv t2,t5
  sw t5,48(sp)
  add a0,sp,52
  lw a1,48(sp)
  mv a2,t1
  mv a3,t2
  call f_T16
  lw t5,48(sp)
  mv t0,a0
  add a0,sp,52
  mv a1,t5
  call f_T7
  mv t0,a0
  li a0,0
  lw ra,160108(sp)
add sp,sp,160112
jr ra
  .size main, .-main
