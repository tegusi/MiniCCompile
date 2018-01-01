v0 = malloc 400
f_T2 [3] [19]
s8 = 4
t1 = a0
t2 = a1
t3 = a2
store t2 13
store t3 14
a0 = t1
call f_putint
load 13 t2
load 14 t3
t0 = a0
store t3 14
a0 = t2
call f_putint
load 14 t3
t0 = a0
a0 = t3
call f_putint
t0 = a0
end f_T2
f_T7 [2] [22]
s8 = 4
t2 = a0
t1 = a1
t3 = 1
l0:
s10 = 1
t4 = t1 + s10
if t3 >= t4 goto l1
t4 = s8 * t3
s11 = t2
s11 = s11 + t4
t4 = s11[0]
t5 = t4
store t1 13
store t2 12
store t3 14
a0 = t5
call f_putint
load 13 t1
load 12 t2
load 14 t3
t0 = a0
s10 = 1
t3 = t3 + s10
goto l0
l1:
a0 = 1
return
end f_T7
f_T16 [4] [44]
s8 = 4
t2 = a0
t3 = a1
t1 = a2
t4 = a3
if t1 >= t4 goto l2
s10 = 1
t5 = t1 + s10
t6 = t4
l3:
if t5 >= t6 goto l4
a0 = s8 * t5
s11 = t2
s11 = s11 + a0
a0 = s11[0]
a1 = s8 * t1
s11 = t2
s11 = s11 + a1
a1 = s11[0]
if a0 <= a1 goto l5
a0 = s8 * t5
s11 = t2
s11 = s11 + a0
a0 = s11[0]
a1 = a0
a0 = s8 * t6
s11 = t2
s11 = s11 + a0
a0 = s11[0]
a2 = s8 * t5
s11 = t2
s11 = s11 + a2
s11[0] = a0
a0 = s8 * t6
s11 = t2
s11 = s11 + a0
s11[0] = a1
s10 = 1
t6 = t6 - s10
goto l6
l5:
s10 = 1
t5 = t5 + s10
l6:
goto l3
l4:
a0 = s8 * t5
s11 = t2
s11 = s11 + a0
a0 = s11[0]
a1 = s8 * t1
s11 = t2
s11 = s11 + a1
a1 = s11[0]
s10 = 1
a2 = a1 - s10
if a0 <= a2 goto l7
s10 = 1
t5 = t5 - s10
l7:
a0 = s8 * t1
s11 = t2
s11 = s11 + a0
a0 = s11[0]
a1 = a0
a0 = s8 * t5
s11 = t2
s11 = s11 + a0
a0 = s11[0]
a2 = s8 * t1
s11 = t2
s11 = s11 + a2
s11[0] = a0
a0 = s8 * t5
s11 = t2
s11 = s11 + a0
s11[0] = a1
store t2 12
store t3 13
store t4 15
store t6 17
load 12 a0
load 13 a1
a2 = t1
a3 = t5
call f_T16
load 12 t2
load 13 t3
load 15 t4
load 17 t6
t0 = a0
a0 = t2
a1 = t3
a2 = t6
a3 = t4
call f_T16
t0 = a0
a0 = 1
return
goto l8
l2:
a0 = 1
return
l8:
end f_T16
f_main [0] [106]
s8 = 4
call f_getint
t2 = a0
t3 = 1
l9:
s10 = 1
t4 = t2 + s10
if t3 >= t4 goto l10
store t2 12
store t3 94
call f_getint
load 12 t2
load 94 t3
t4 = a0
t5 = s8 * t3
loadaddr 13 s11
s11 = s11 + t5
s11[0] = t4
s10 = 1
t3 = t3 + s10
goto l9
l10:
store t2 12
loadaddr 13 a0
load 12 a1
call f_T7
load 12 t2
t0 = a0
t3 = 1
t4 = t2
store t2 12
loadaddr 13 a0
load 12 a1
a2 = t3
a3 = t4
call f_T16
load 12 t2
t0 = a0
loadaddr 13 a0
a1 = t2
call f_T7
t0 = a0
a0 = 0
return
end f_main
