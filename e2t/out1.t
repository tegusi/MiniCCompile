f_T0 [1] [21]
store s0 0
store s1 1
store s2 2
store s3 3
store s4 4
store s5 5
store s6 6
store s7 7
store s8 8
t1 = a0
s10 = 2
t2 = t1 < s10
s10 = 0
if t2==s10 goto l0
a0 = 1
load 0 s0
load 1 s1
load 2 s2
load 3 s3
load 4 s4
load 5 s5
load 6 s6
load 7 s7
load 8 s8
return
goto l1
l0:
s10 = 1
store t2 13
t2 = t1 - s10
store t2 16
store t2 14
load 16 t2
t2 = t2
s10 = 2
store t1 12
t1 = t1 - s10
store t1 17
store t1 15
load 17 t1
t1 = t1
store t2 16
load 14 t2
a0 = t2
store t1 17
store t2 14
call f_T0
load 17 t1
load 14 t2
store t2 14
t2 = a0
store t1 17
load 15 t1
a0 = t1
store t1 15
store t2 18
call f_T0
load 15 t1
load 18 t2
store t1 15
t1 = a0
store t1 19
t1 = t2 + t1
a0 = t1
load 0 s0
load 1 s1
load 2 s2
load 3 s3
load 4 s4
load 5 s5
load 6 s6
load 7 s7
load 8 s8
return
l1:
end f_T0
f_T9 [1] [66]
store s0 0
store s1 1
store s2 2
store s3 3
store s4 4
store s5 5
store s6 6
store s7 7
store s8 8
t1 = a0
s9 = 4
s10 = 0
t3 = s9 * s10
loadaddr 13 s11
s11 = s11 + t3
s9 = 1
s11[0] = s9
s9 = 4
s10 = 1
store t3 53
t3 = s9 * s10
loadaddr 13 s11
s11 = s11 + t3
s9 = 1
s11[0] = s9
store t3 54
t3 = 2
l2:
s10 = 1
t4 = t1 + s10
store t4 56
t4 = t3 < t4
s10 = 0
if t4==s10 goto l3
s10 = 1
store t4 57
t4 = t3 - s10
s9 = 4
store t4 58
t4 = s9 * t4
loadaddr 13 s11
s11 = s11 + t4
t4 = s11[0]
s10 = 2
t5 = t3 - s10
s9 = 4
store t5 60
t5 = s9 * t5
loadaddr 13 s11
s11 = s11 + t5
t5 = s11[0]
store t4 59
t4 = t4 + t5
s9 = 4
store t5 61
t5 = s9 * t3
loadaddr 13 s11
s11 = s11 + t5
s11[0] = t4
s10 = 1
store t4 62
t4 = t3 + s10
t3 = t4
goto l2
l3:
s9 = 4
store t1 12
t1 = s9 * t1
loadaddr 13 s11
s11 = s11 + t1
t1 = s11[0]
a0 = t1
load 0 s0
load 1 s1
load 2 s2
load 3 s3
load 4 s4
load 5 s5
load 6 s6
load 7 s7
load 8 s8
return
end f_T9
v0 = 0
v1 = 0
f_main [0] [20]
store s0 0
store s1 1
store s2 2
store s3 3
store s4 4
store s5 5
store s6 6
store s7 7
store s8 8
call f_getint
t1 = a0
store t1 12
loadaddr v0 s11
s11[0] = t1
load 12 t1
t1 = t1
store t1 12
load v0 t1
s10 = 0
t2 = t1 < s10
s10 = 30
t3 = t1 > s10
store t2 13
t2 = t2 || t3
s10 = 0
if t2==s10 goto l4
a0 = 1
load 0 s0
load 1 s1
load 2 s2
load 3 s3
load 4 s4
load 5 s5
load 6 s6
load 7 s7
load 8 s8
return
l4:
a0 = t1
loadaddr v0 s11
s11[0] = t1
store t2 15
store t3 14
call f_T9
load v0 t1
load 15 t2
load 14 t3
store t2 15
t2 = a0
store t2 16
loadaddr v1 s11
s11[0] = t2
load 16 t2
t2 = t2
store t2 16
load v1 t2
a0 = t2
loadaddr v0 s11
s11[0] = t1
loadaddr v1 s11
s11[0] = t2
store t3 14
call f_putint
load v0 t1
load v1 t2
load 14 t3
loadaddr v1 s11
s11[0] = t2
t2 = a0
store t2 17
load v1 t2
loadaddr v1 s11
s11[0] = t2
load 17 t2
t2 = t2
a0 = t1
loadaddr v0 s11
s11[0] = t1
store t2 17
store t3 14
call f_T0
load v0 t1
load 17 t2
load 14 t3
store t2 17
t2 = a0
t1 = t2
a0 = t1
loadaddr v0 s11
s11[0] = t1
store t2 18
store t3 14
call f_putint
load v0 t1
load 18 t2
load 14 t3
loadaddr v0 s11
s11[0] = t1
t1 = a0
store t1 19
load v0 t1
loadaddr v0 s11
s11[0] = t1
load 19 t1
t1 = t1
a0 = 0
load 0 s0
load 1 s1
load 2 s2
load 3 s3
load 4 s4
load 5 s5
load 6 s6
load 7 s7
load 8 s8
return
end f_main
