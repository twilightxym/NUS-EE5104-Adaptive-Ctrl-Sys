clc;clear;

%% initial parameters
zeta=0.2;                 % damping coefficient
wn=3;                     % natural frequency
Tp=[1 2*zeta*wn wn^2];    % observer 
disp("Observer poles: ")  % Observer poles
disp(roots(Tp))

ga=100;                   % weight
Ga=diag([12*ga,10*ga,20*ga,200*ga,200*ga]);
disp("Gamma: ")
disp(Ga)

%% Plant model
a1=0.22;
a2=6.1;
b0=-0.5;
b1=-1;

Kp=b0;
Zp=[1 b1/b0];              % Plant zero 
Rp=[1 a1 a2];              % Plant pole
disp("Plant poles: ")      % Observer poles
disp(roots(Rp))

%% Reference model 
am=5;
Rm=[1 am];
Km=am;

%% Optimal control gains
[E,F]=deconv(conv(Tp,Rm), Rp) % T*Rm=Rp*E+F
Fbar = F/Kp
Gbar = conv(E, Zp)
G1 = Gbar - Tp

Kaster = Km/Kp
f1 = Fbar(3);
f2 = Fbar(4);
g1 = G1(2);
g2 = G1(3);
theta_bar_aster = [Kaster, -g2, -g1 , -f2, -f1];
disp("Exact control gains (theta_bar_aster): ")
disp(theta_bar_aster')
