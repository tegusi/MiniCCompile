v0 = 0
f_main [0] [68]
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
l0:
s10 = 5
store t1 39
t1 = t2 == s10
s10 = 0
if t1==s10 goto l1
s10 = 1
t2 = t2 + s10
goto l0
l1:
store t1 40
t1 = 0
store t2 38
t2 = 0
t3 = 0
t4 = 0
t5 = 0
t6 = 0
a0 = 0
a1 = 0
a2 = 0
a3 = 0
a4 = 0
a5 = 0
a6 = 0
a7 = 0
s0 = 0
s1 = 0
s2 = 0
s3 = 0
s4 = 0
s5 = 0
s6 = 0
s7 = 0
s8 = 0
store s8 34
s8 = 0
store s8 35
load 34 s8
store s8 34
s8 = 0
store s8 36
load 34 s8
store s8 34
s8 = 0
store s8 37
load 34 s8
s10 = 1
t2 = t1 + s10
s10 = 1
t3 = t2 + s10
s10 = 1
t4 = t3 + s10
s10 = 1
t5 = t4 + s10
s10 = 1
t6 = t5 + s10
s10 = 1
a0 = t6 + s10
s10 = 1
a1 = a0 + s10
s10 = 1
a2 = a1 + s10
s10 = 1
a3 = a2 + s10
s10 = 1
a4 = a3 + s10
s10 = 1
a5 = a4 + s10
s10 = 1
a6 = a5 + s10
s10 = 1
a7 = a6 + s10
s10 = 1
s0 = a7 + s10
s10 = 1
s1 = s0 + s10
s10 = 1
s2 = s1 + s10
s10 = 1
s3 = s2 + s10
s10 = 1
s4 = s3 + s10
s10 = 1
s5 = s4 + s10
s10 = 1
s6 = s5 + s10
s10 = 1
s7 = s6 + s10
s10 = 1
s8 = s7 + s10
s10 = 1
s8 = s8 + s10
s10 = 1
s8 = s8 + s10
s10 = 1
s8 = s8 + s10
store t1 12
store t2 13
store t3 14
store t4 15
store t5 16
store t6 17
store a0 18
a0 = s8
call f_putint
t0 = a0
a0 = s8
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
