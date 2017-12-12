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
var t43
t43 = call f_T16
T42 = t43
param p0
param p1
param T18
param p3
var t44
t44 = call f_T16
T42 = t44
return 1
goto l8
l2:
return 1
l8:
end f_T16
f_main [0]
var T45
var 80 T46
var t47
t47 = call f_getint
T45 = t47
var T48
T48 = 1
l9:
var t49
t49 = T45 + 1
var t50
t50 = T48 < t49
if t50 == 0 goto l10
var t51
t51 = call f_getint
var t52
t52 = 4 * T48
T46[t52] = t51
var t53
t53 = T48 + 1
T48 = t53
goto l9
l10:
var T54
param T46
param T45
var t55
t55 = call f_T7
T54 = t55
var T56
T56 = 1
var T57
T57 = T45
param T46
param T45
param T56
param T57
var t58
t58 = call f_T16
T54 = t58
param T46
param T45
var t59
t59 = call f_T7
T54 = t59
return 0
end f_main
