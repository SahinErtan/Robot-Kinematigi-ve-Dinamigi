
syms alpha a d th

T = [cos(th) -cos(alpha)*sin(th) sin(alpha)*sin(th) a*cos(th)
   sin(th) cos(alpha)*cos(th) -sin(alpha)*cos(th) a*sin(th)
   0       sin(alpha)          cos(alpha)         d
   0       0                   0                  1]


syms lc1 lc2 l1 l2
syms th1 th2
l1 = 0.6
l2 = 0.4
lc1 = 0.3
lc2 = 0.2
T10 = subs(T,{alpha,a,d,th},{0,l1,0,th1});
Tc10 = subs(T,{alpha,a,d,th},{0,lc1,0,th1});
T21 = subs(T,{alpha,a,d,th},{0,l2,0,th2});
Tc21 = subs(T,{alpha,a,d,th},{0,lc2,0,th2});
p10 = T10(1:3,4:4)
pc1 = Tc10(1:3,4:4)
Tc20 = simplify(Tc10*Tc21)
pc2 = simplify(T10*Tc21)
pc2 = pc2(1:3,4:4)
T20= simplify(T10*T21)

z0=[0;0;1]
Jv11=cross(z0,pc1)
Jv12 = [0;0;0]
Jv1 = [Jv11 Jv12]
Jw1=[0 0;0 0;1 0]

Jw21 = [0;0;1]
R10 = T10(1:3,1:3)
z1=simplify(R10*[0;0;1])
Jw2 = [Jw21 z1]

R20 = T20(1:3,1:3)
Jv21 = cross(z0,pc2)
Jv22 = cross(z1,(pc2-p10))
Jv2 = [Jv21 Jv22]

syms m1 m2
syms Ixx1 Ixy1 Ixz1 Ixy1 Iyy1 Iyz1 Ixz1 Iyz1 Izz1
syms Ixx2 Ixy2 Ixz2 Ixy2 Iyy2 Iyz2 Ixz2 Iyz1 Izz2

I1 = [0.01 0 0;0 0.02 0;0 0 0.03]
I2 = [0.04 0 0;0 0.05 0;0 0 0.06]
m1 = 10
m2 = 5
M = m1 * Jv1.' * Jv1 + m2 * Jv2.' * Jv2 + Jw1.' * R10 * I1 * R10' * Jw1 + Jw2.' * R20 * I2 * R20.' * Jw2;
M = simplify(M)

syms g
g= 9.81
g01 = [0;0;-m1*g]
g02 = [0;0;-m2*g]

g1 = - Jv11.' * g01 - Jv21.' * g02
g2 = - Jv12.' * g01 - Jv22.' * g02

g= [g1 g1]

%% C Matrisi M matrisinden Kısmi Turev ile Hesaplanir

C11 = - 0.6 * sin(th2) * dth2
C12 = -0.6 * sin(th2) * dth1 - 0.6 * sin(th2) * dth2
C21 = 0.6 * sin(th2) * dth1
C22 = 0

C = [C11 C12;C21 C22]


