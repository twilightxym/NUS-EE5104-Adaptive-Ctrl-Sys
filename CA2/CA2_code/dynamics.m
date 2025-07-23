function dx = dynamics(t, x, a, b, c1, c2, mu, dmax, mode, epsilon)
    x1 = x(1);
    x2 = x(2);
    sigma = c1*x1 + c2*x2;

    % Disturbance
    d = dmax * sin(628 * t);  % bounded, |d| <= 0.9

    % Control Law
    if strcmp(mode, 'sign')
        u = -(1/(b * c1))*((a*c1 + c2)*x1 + mu * sign(sigma));
    else
        u = -(1/(b * c1))*((a*c1 + c2)*x1 + mu * sat(sigma/epsilon));
    end

    dx1 = a*x1 + b*u + d;
    dx2 = x1;
    dx = [dx1; dx2];
end