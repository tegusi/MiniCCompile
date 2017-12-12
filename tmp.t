v0 = malloc 400
v1 = 0
f_T2 [3] [19]
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
t2 = a1
t3 = a2
store t1 12
store t2 13
store t3 14
load 12 a0
call f_putint
load 13 t2
load 14 t3
t1 = a0
t0 = t1
store t0 15
store t1 16
store t2 13
store t3 14
load 13 a0
call f_putint
load 14 t3
t1 = a0
t0 = t1
store t1 17
store t3 14
load 14 a0
call f_putint
t1 = a0
t0 = t1
end f_T2
f_T7 [2] [22]
store s0 0
store s1 1
store s2 2
store s3 3
store s4 4
store s5 5
store s6 6
store s7 7
store s8 8
t2 = a0
t1 = a1
t3 = 1
l0:
s10 = 1
t4 = t1 + s10
t5 = t3 < t4
s10 = 0
if t5==s10 goto l1
s9 = 4
store t4 16
t4 = s9 * t3
loadaddr 12 s11
s11 = s11 + t4
t4 = s11[0]
store t5 17
t5 = t4
store t1 13
store t2 12
store t3 14
store t4 19
store t5 18
load 18 a0
call f_putint
load 13 t1
load 12 t2
load 14 t3
t4 = a0
t0 = t4
s10 = 1
t3 = t3 + s10
goto l0
l1:
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
end f_T7
f_T16 [4] [44]
store s0 0
store s1 1
store s2 2
store s3 3
store s4 4
store s5 5
store s6 6
store s7 7
store s8 8
t4 = a0
t5 = a1
t3 = a2
t6 = a3
a2 = t3 < t6
s10 = 0
if a2==s10 goto l2
s10 = 1
store a2 18
a2 = t3 + s10
a3 = t6
l3:
a4 = a2 < a3
s10 = 0
if a4==s10 goto l4
s9 = 4
store a4 20
a4 = s9 * a2
loadaddr 12 s11
s11 = s11 + a4
a4 = s11[0]
s9 = 4
a5 = s9 * t3
loadaddr 12 s11
s11 = s11 + a5
a5 = s11[0]
a6 = a4 > a5
s10 = 0
if a6==s10 goto l5
s9 = 4
store a4 21
a4 = s9 * a2
loadaddr 12 s11
s11 = s11 + a4
a4 = s11[0]
store a5 22
a5 = a4
s9 = 4
store a4 25
a4 = s9 * a3
loadaddr 12 s11
s11 = s11 + a4
a4 = s11[0]
s9 = 4
store a6 23
a6 = s9 * a2
loadaddr 12 s11
s11 = s11 + a6
s11[0] = a4
s9 = 4
store a4 26
a4 = s9 * a3
loadaddr 12 s11
s11 = s11 + a4
s11[0] = a5
s10 = 1
a3 = a3 - s10
goto l6
l5:
s10 = 1
a2 = a2 + s10
l6:
goto l3
l4:
s9 = 4
t1 = s9 * a2
loadaddr 12 s11
s11 = s11 + t1
t1 = s11[0]
s9 = 4
store a4 28
a4 = s9 * t3
loadaddr 12 s11
s11 = s11 + a4
a4 = s11[0]
s10 = 1
store a5 24
a5 = a4 - s10
store a4 32
a4 = t1 > a5
s10 = 0
if a4==s10 goto l7
s10 = 1
a2 = a2 - s10
l7:
s9 = 4
t2 = s9 * t3
loadaddr 12 s11
s11 = s11 + t2
t2 = s11[0]
store t1 31
t1 = t2
s9 = 4
store t2 37
t2 = s9 * a2
loadaddr 12 s11
s11 = s11 + t2
t2 = s11[0]
s9 = 4
store a4 34
a4 = s9 * t3
loadaddr 12 s11
s11 = s11 + a4
s11[0] = t2
s9 = 4
store t2 38
t2 = s9 * a2
loadaddr 12 s11
s11 = s11 + t2
s11[0] = t1
store t1 36
store t2 40
store t3 14
store t4 12
store t5 13
store t6 15
load 12 a0
load 13 a1
store a2 16
load 14 a2
store a3 17
load 16 a3
call f_T16
load 12 t4
load 13 t5
load 15 t6
t1 = a0
t0 = t1
store t0 41
store t1 42
store t4 12
store t5 13
store t6 15
load 12 a0
load 13 a1
load 17 a2
load 15 a3
call f_T16
t1 = a0
t0 = t1
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
goto l8
l2:
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
l8:
end f_T16
f_main [0] [106]
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
t2 = t1
store t1 93
t1 = 1
l9:
s10 = 1
t3 = t2 + s10
t4 = t1 < t3
s10 = 0
if t4==s10 goto l10
store t1 94
store t2 12
store t3 95
store t4 96
call f_getint
load 94 t1
load 12 t2
load 96 t4
t3 = a0
s9 = 4
t5 = s9 * t1
loadaddr 13 s11
s11 = s11 + t5
s11[0] = t3
s10 = 1
t1 = t1 + s10
goto l9
l10:
store t1 94
store t2 12
store t3 97
store t4 96
store t5 98
load 12 a1
call f_T7
load 12 t2
a0 = a0
t0 = a0
t1 = 1
t3 = t2
store t0 100
store t1 102
store t2 12
store t3 103
store a0 101
load 12 a1
load 102 a2
load 103 a3
call f_T16
load 12 t2
t1 = a0
t0 = t1
store t1 104
store t2 12
load 12 a1
call f_T7
t1 = a0
t0 = t1
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
