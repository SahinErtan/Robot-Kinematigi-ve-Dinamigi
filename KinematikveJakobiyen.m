
%% DH tablosu (tabloyu dodurunuz)
% eklem  alfa   a   d    teta
% 1      -90    0   d1    0            
% 2       90    0   0     th2                     
% 3        0    20  0     th3                             

%% Homojen dünüşüm matrisi
syms alpha a d th

T = [cos(th) -cos(alpha)*sin(th) sin(alpha)*sin(th) a*cos(th)
   sin(th) cos(alpha)*cos(th) -sin(alpha)*cos(th) a*sin(th)
   0       sin(alpha)          cos(alpha)         d
   0       0                   0                  1];
syms l1 l2
syms alpha1 a1 d1 th1
T10 = subs(T,{alpha,a,d,th},{0,l1,0,th1})
%% T21 homojen dönüşüm matrisinin elde edilmesi
syms alpha2 a2 d2 th2
T21 = subs(T,{alpha,a,d,th},{0,l2,0,th2})
%% T32 homojen dönüşüm matrisinin elde edilmesi
syms alpha3 a3 d3 th3
T32 = subs(T,{alpha,a,d,th},{0,20,0,th3})

T20 = simplify(T10*T21)
T20_s = vpa(subs(T20,{d1,th2,th3},{15,pi/6,pi/3}));
%% T30 homojen dönüşüm matrisinin sembolik olarak elde edilmesi
T30 = simplify(T10*T21*T32);
%% T30 homojen dönüşüm matrisinin sayısal olarak elde edilmesi
T30_s=vpa(subs(T30,{d1,th2,th3},{15,pi/6,pi/3}));

%% Ters Kinematik 

position = T30(1:3,4:4)

R10 = T10(1:3,1:3)
R20 = T20(1:3,1:3)
z0 = [0;0;1]
z1 = R10 * z0
z2 = R20 * z0

%% Prismatic

Jv1 = z0
Jw1 = [0;0;0]

Jv2 = z1
Jw2 = [0;0;0]

Jv3 = z2
Jw3 = [0;0;0]

%% Revolute 

Jw1 = z0
Jv1 = cross(z0,T30(1:3,4:4))

Jw2 = z1
Jv2 = cross(z1,(T30(1:3,4:4) - T10(1:3,4:4)))

Jw3 = z2
Jv3 = cross(z2,(T30(1:3,4:4) - T20(1:3,4:4)))



Jv=[Jv1 Jv2 Jv3]
Jw=[Jw1 Jw2 Jw3]
J = [Jv;Jw]

%% Hiz Kinematigi
syms dth1 dth2 dth3
dth1 = 1
dth2 = 1
dth3 = 1
dth=[dth1;dth2;dth3]

Hkinematik = J * dth

%% Ters Hiz Kinematigi
% J matrisi kare matris olmalı yani 3x3 bu yuzden matristen sifir olan
% satirlar cikarilir
Js1 = J(1:1,1:3)
Js2 = J(2:2,1:3)
Js3 = J(3:3,1:3)
Js4 = J(4:4,1:3)
Js5 = J(5:5,1:3)
Js6 = J(6:6,1:3)

Jkare = [Js1;Js2;Js3
Jters = inv(Jkare)

v1 = 0
v2 = 0
v3 = 0
w1 = 0
w2 = 0
w3 = 0

hizlar = [v1;v2;w3]

acilar = Jters * hizlar

%% Tekillik

denklem = simplify(det(Jv))
