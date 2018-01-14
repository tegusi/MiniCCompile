v0 = malloc 40000
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
t4 = a1
t5 = 1
store t2 12
store t4 13
store t5 14
call f_putint
load 12 t2
load 13 t4
load 14 t5
t0 = a0
t1 = t3
s11 = t2
s11 = s11 + t3
t3 = s11[0]
s10 = 1
t1 = t4 + s10
l0:
if t5 >= t1 goto l1
t3 = s8 * t5
s10 = 1
t5 = t5 + s10
goto l0
l1:
a0 = 1
return
end f_T7
f_T16 [4] [44]
s8 = 4
a3 = a0
a4 = a1
t1 = a2
t2 = a3
if t1 >= t2 goto l2
s10 = 1
t3 = t1 + s10
t4 = t2
l6:
l5:
goto l6
s11 = a3
s11 = s11 + t6
s11[0] = t5
s11 = a3
s11 = s11 + a0
s11[0] = a1
s11 = a3
s11 = s11 + a1
a1 = s11[0]
t5 = a2
s11 = a3
s11 = s11 + a2
a2 = s11[0]
t5 = s8 * t1
s10 = 1
t3 = t3 + s10
l3:
if t3 >= t4 goto l4
t6 = s8 * t3
s11 = a3
s11 = s11 + t6
t6 = s11[0]
s11 = a3
s11 = s11 + t5
t5 = s11[0]
if t6 <= t5 goto l5
a2 = s8 * t3
a1 = s8 * t4
a0 = s8 * t3
t6 = s8 * t4
s10 = 1
t4 = t4 - s10
goto l3
l4:
t5 = s8 * t3
s11 = a3
s11 = s11 + t5
t5 = s11[0]
t6 = s8 * t1
s11 = a3
s11 = s11 + t6
t6 = s11[0]
s10 = 1
a0 = t6 - s10
if t5 <= a0 goto l7
s10 = 1
t3 = t3 - s10
l7:
t5 = s8 * t1
s11 = a3
s11 = s11 + t5
t5 = s11[0]
t6 = t5
t5 = s8 * t3
s11 = a3
s11 = s11 + t5
t5 = s11[0]
a0 = s8 * t1
s11 = a3
s11 = s11 + a0
s11[0] = t5
t5 = s8 * t3
s11 = a3
s11 = s11 + t5
s11[0] = t6
store t2 15
store t4 17
a0 = t1
a1 = a3
a2 = a4
store a3 12
a3 = t1
store a4 13
a4 = t3
call f_T16
load 15 t2
load 17 t4
t0 = a0
load 12 a0
load 13 a1
a2 = t4
a3 = t2
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
f_main [0] [40026]
s8 = 4
call f_getint
t5 = a0
t6 = 1
s10 = 1
t6 = t6 + s10
loadaddr 13 s11
s11 = s11 + t2
s11[0] = t1
t2 = s8 * t6
store t5 12
store t6 40014
call f_getint
load 12 t5
load 40014 t6
t1 = a0
if t6 >= t3 goto l10
s10 = 1
t3 = t5 + s10
l9:
goto l9
l10:
store t5 12
loadaddr 13 a0
load 12 a1
call f_T7
load 12 t5
t0 = a0
t1 = 1
t2 = t5
store t5 12
loadaddr 13 a0
load 12 a1
a2 = t1
a3 = t2
call f_T16
load 12 t5
t0 = a0
loadaddr 13 a0
a1 = t5
call f_T7
t0 = a0
a0 = 0
return
end f_main
