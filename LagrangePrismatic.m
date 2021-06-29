

syms alpha a d th

T = [cos(th) -cos(alpha)*sin(th) sin(alpha)*sin(th) a*cos(th)
   sin(th) cos(alpha)*cos(th) -sin(alpha)*cos(th) a*sin(th)
   0       sin(alpha)          cos(alpha)         d
   0       0                   0                  1]


syms d1
T10 = subs(T,{alpha,a,d,th},{-pi/2,0,d1,-pi/2})

syms d2
T21 = subs(T,{alpha,a,d,th},{0,0,d2,0});
T20 = simplify(T10*T21)

%T20_s=vpa(subs(T20,{d1,th2,th3},{15,pi/6,pi/3}))

R00=[1 0 0;0 1 0;0 0 1]
R10 = T10(1:3,1:3)
R20 = T20(1:3,1:3)

z0=[0;0;1]
z1=R10*[0;0;1]

%% J Matris Hesabi

Jv1 = [z0 [0;0;0]]
Jv2 = [z0 z1]

syms m1 m2 g

M = m1 * Jv1' * Jv1 + m2 * Jv2' * Jv2;
M = simplify(M)

g01=[0;0;-m1*g]
g02=[0;0;-m2*g]

g1 = -Jv1(:,1:1)' * g01 - Jv2(:,1:1)' *g02;
g1 = simplify(g1)

g2= -Jv1(:,2:2)' * g01 - Jv2(:,2:2)' *g02;
g2= simplify(g2)

g = [g1;g2]

syms ddth1 ddth2
syms dth1 dth2

ddth=[ddth1;ddth2]
dth=[dth1;dth2]


