clear;
save_path='./image/';
%% Potentiometer calibration
theta_deg = [-180:36:180]';         % Angular Position (degrees)
theta_rad = deg2rad(theta_deg);     % convert to rad
X1 = (-5:1:5)';                     % Potientiometer output (volts)

P = (theta_rad'*theta_rad)^(-1);
K_theta = P*theta_rad'*X1;
X1_hat = K_theta*theta_rad;
fprintf("K_theta = %.4f\n", K_theta);

f=figure;
hold on;
plot(theta_rad,X1,'bx');
plot(theta_rad,X1_hat,'r-');
grid on;
xlabel('Angular position (rad)');
ylabel('Output voltage of Potentiometer (volts)');
legend('Data point','LS Fit', 'Location','northwest');
title('Calibration of K_\theta');
hold off;
exportgraphics(f, [save_path, 'Cali_K_theta.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);

%% Tachometor calibration
omega_radpersec = [-31.52, -24.82, -18.01, -11.31, -4.71, 0, 5.03, 11.62, 18.33, 25.03, 31.73]';  % rad/sec
u = (-5:1:5)';
omega_rpm = [-301, -237, -172, -108, -45, 0, 48, 111, 175, 239, 303]';   % Angular Velocity (rpm)
%omega_radpersec = omega_rpm*(2*pi)/60;                                   % convert to rad/sec
X2 = [-4.03, -3.17, -2.3, -1.45, -0.6, 0, 0.62, 1.48, 2.33, 3.2, 4.06]'; % Tachometer output (volts)

Q = (omega_radpersec'*omega_radpersec)^(-1);
K_omega = Q*omega_radpersec'*X2;
X2_hat = K_omega*omega_radpersec;
fprintf("K_omega = %.4f\n", K_omega);

f=figure;
hold on;
plot(omega_radpersec,X2,'bx');
plot(omega_radpersec,X2_hat,'r-');
grid on;
xlabel('Angular Velocity (rad/sec)');
ylabel('Output voltage of Tachometor (volts)');
legend('Data point','LS Fit', 'Location','northwest');
title('Calibration of K_\omega');
hold off;
exportgraphics(f, [save_path, 'Cali_K_omega.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);

R = (u'*u)^(-1);
K_s = R*u'*omega_radpersec;
omega_hat = K_s*u;
fprintf("K_s = %.4f\n", K_s);

f=figure;
hold on;
plot(u,omega_radpersec,'bx');
plot(u,omega_hat,'r-');
grid on;
xlabel('Input voltage (volts)');
ylabel('Angular Velocity (rad/sec)');
legend('Data point','LS Fit', 'Location','northwest');
title('Calibration of K_s');
hold off;
exportgraphics(f, [save_path, 'Cali_K_s.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);

close all;