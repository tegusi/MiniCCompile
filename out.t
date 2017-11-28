v0 = 0
v1 = malloc 400
f_main [0] [36]
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
t2 = a0
t3 = t2
store t2 12
loadaddr v0 s11
s11[0] = t3
call f_getchar
load v0 t3
t0 = a0
t2 = 0
l0:
t4 = t2 < t3
s10 = 0
if t4==s10 goto l1
store t0 13
store t2 14
loadaddr v0 s11
s11[0] = t3
store t4 15
call f_getchar
load 14 t2
load v0 t3
t4 = a0
s9 = 4
t5 = s9 * t2
loadaddr v1 s11
s11 = s11 + t5
s11[0] = t4
s10 = 1
store t4 16
t4 = t2 + s10
t2 = t4
goto l0
l1:
t2 = 0
l2:
s10 = 2
store t4 18
t4 = t3 / s10
store t5 17
t5 = t2 < t4
s10 = 0
if t5==s10 goto l3
s9 = 4
store t4 19
t4 = s9 * t2
loadaddr v1 s11
s11 = s11 + t4
t4 = s11[0]
store t5 20
t5 = t4
s10 = 1
store t4 22
t4 = t3 - s10
t6 = t4 - t2
s9 = 4
store t4 23
t4 = s9 * t6
loadaddr v1 s11
s11 = s11 + t4
t4 = s11[0]
s9 = 4
store t6 24
t6 = s9 * t2
loadaddr v1 s11
s11 = s11 + t6
s11[0] = t4
s10 = 1
store t4 25
t4 = t3 - s10
store t6 26
t6 = t4 - t2
s9 = 4
store t4 27
t4 = s9 * t6
loadaddr v1 s11
s11 = s11 + t4
s11[0] = t5
s10 = 1
store t4 29
t4 = t2 + s10
t2 = t4
goto l2
l3:
t2 = 0
l4:
store t4 30
t4 = t2 < t3
s10 = 0
if t4==s10 goto l5
s9 = 4
store t4 31
t4 = s9 * t2
loadaddr v1 s11
s11 = s11 + t4
t4 = s11[0]
store t2 14
loadaddr v0 s11
s11[0] = t3
store t4 32
store t5 21
store t6 28
load 32 a0
call f_putchar
load 14 t2
load v0 t3
t0 = a0
s10 = 1
t4 = t2 + s10
t2 = t4
goto l4
l5:
store t0 33
store t2 14
loadaddr v0 s11
s11[0] = t3
store t4 34
a0 = 10
call f_putchar
t0 = a0
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
