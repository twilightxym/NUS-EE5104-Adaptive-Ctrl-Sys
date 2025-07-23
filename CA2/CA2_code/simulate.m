clear; clc; close all;

% Parameters
a = 2; b = 1;
c1 = 1; c2 = 1;
dmax = 0.9;
mu = 0.5;
epsilon = 0.01;

tspan = [0, 10];  % time span
x0 = [1.0; 0];  % initial state: [x1, x2]

% Control mode: 'sign' or 'sat'
for mode = 1:2
    clearvars t x u
    switch mode
        case 1
            control_mode = 'sign'; 
        case 2
            control_mode = 'sat'; 
        otherwise
            fprintf('Error: Undefined mode!');
    end
    
    [t, x] = ode45(@(t, x) dynamics(t, x, a, b, c1, c2, mu, dmax, control_mode, epsilon), tspan, x0);
    
    % Calculate control signal
    for i = 1:length(t)
        x1 = x(i,1); 
        x2 = x(i,2);
        sigma = c1*x1 + c2*x2;
        if strcmp(control_mode, 'sign')
            u(i) = -(1/(b * c1))*((a*c1 + c2)*x1 + mu * sign(sigma));
        else
            u(i) = -(1/(b * c1))*((a*c1 + c2)*x1 + mu * sat(sigma/epsilon));
        end
    end
    
    % --------- Plot Results ---------
    save_path='./image/';
    f=figure;
    plot(x(:,1), x(:,2), 'LineWidth', 1.5);
    xlabel('x_1'); ylabel('x_2'); title(sprintf('Phase Portrait (%s)',control_mode)); grid on;
    exportgraphics(f, [save_path, control_mode, '_PhasePortrait.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);

    f=figure;
    plot(t, x); legend('x_1','x_2');
    xlabel('Time (s)'); ylabel('States'); title(sprintf('System States (%s)',control_mode));
    exportgraphics(f, [save_path, control_mode, '_SystemStates.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);
    
    f=figure;
    plot(t, u, 'r'); xlabel('Time (s)'); ylabel('u(t)');
    title(sprintf('Control Input (%s)',control_mode)); grid on;
    exportgraphics(f, [save_path, control_mode, '_ControlInput.png'], ...
    'ContentType', 'image', ...
    'Resolution', 300);
end