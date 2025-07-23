close all;clc;

save_path = './results/';
round = '1_';
% Get simulation data
t = out.tout;                            % time
y = out.y.Data;                          % plant output
ym = out.ym.Data;                        % reference model output
e = out.e.Data;                          % tracking error
u = out.u.Data;                          % control input

% Plot
f = figure('WindowStyle','docked');
subplot(3,1,1); plot(t, y, 'b', t, ym, 'r--');
ylim([-12,12]);
title('The output of the plant with the reference model');
legend('Plant output', 'Reference model');

subplot(3,1,2); plot(t, e);
title('Tracking error e(t) = y(t) - y_m(t)');

subplot(3,1,3); plot(t, u);
title('Control effort u(t)');

exportgraphics(f, [save_path, round, 'y_e_u.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);

