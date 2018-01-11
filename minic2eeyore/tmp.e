var 400 T0
var T1
f_T2 [3]
var T3
param p0
var t4
t4 = call f_putint
T3 = t4
param p1
var t5
t5 = call f_putint
T3 = t5
param p2
var t6
t6 = call f_putint
T3 = t6
end f_T2
f_T7 [2]
var T8
var T9
T8 = 1
l0:
var t10
t10 = p1 + 1
var t11
t11 = T8 < t10
if t11 == 0 goto l1
var T12
var t13
t13 = 4 * T8
t13 = p0[t13]
T12 = t13
param T12
var t14
t14 = call f_putint
T9 = t14
var t15
t15 = T8 + 1
T8 = t15
goto l0
l1:
return 1
end f_T7
f_T16 [4]
var T17
var T18
var t19
t19 = p2 < p3
if t19 == 0 goto l2
var t20
t20 = p2 + 1
T17 = t20
T18 = p3
l3:
var t21
t21 = T17 < T18
if t21 == 0 goto l4
var t22
t22 = 4 * T17
t22 = p0[t22]
var t23
t23 = 4 * p2
t23 = p0[t23]
var t24
t24 = t22 > t23
if t24 == 0 goto l5
var T25
var t26
t26 = 4 * T17
t26 = p0[t26]
T25 = t26
var t27
t27 = 4 * T18
t27 = p0[t27]
var t28
t28 = 4 * T17
p0[t28] = t27
var t29
t29 = 4 * T18
p0[t29] = T25
var t30
t30 = T18 - 1
T18 = t30
goto l6
l5:
var t31
t31 = T17 + 1
T17 = t31
l6:
goto l3
l4:
var t32
t32 = 4 * T17
t32 = p0[t32]
var t33
t33 = 4 * p2
t33 = p0[t33]
var t34
t34 = t33 - 1
var t35
t35 = t32 > t34
if t35 == 0 goto l7
var t36
t36 = T17 - 1
T17 = t36
l7:
var T37
var t38
t38 = 4 * p2
t38 = p0[t38]
T37 = t38
var t39
t39 = 4 * T17
t39 = p0[t39]
var t40
t40 = 4 * p2
p0[t40] = t39
var t41
t41 = 4 * T17
p0[t41] = T37
var T42
param p0
param p1
param p2
param T17
