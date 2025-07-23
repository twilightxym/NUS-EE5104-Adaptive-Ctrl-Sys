% First simulation
clear;

%Plant Param
K = 6.2;
tau = 0.25;

%Reference Model Params
C = 0.7;
w = 5;

Am = [0 1;-w^2 -2*C*w];
gm = [0;w^2];

%Gamma and gamma
Gamma = [1 0;0 1];
gamma = 1;

% Lyapunov
Q=[1 0; 0 1];
b = [0;1];
P = lyap(Am', Q);
fprintf('The solution to the Lyapunov equation is: \n')
disp(P)

%Measurement Noise
noise_gain_x1 = 0.0;
noise_gain_x2 = 0.0;