m1 = 290;
b1 = 1000;
m2 = 59;
k1 = 16182;
k2 = 19000;
f = 0;

x0 = [0; 0; 0; 0];
tspan = [0 10];

z1 = @(t) 0.05 * sin(0.5 * pi * t);
z2 = @(t) 0.05 * sin(20 * pi * t);

[t1, X1] = ode45(@(t,x) susp(t,x,z1), tspan, x0);
[t2, X2] = ode45(@(t,x) susp(t,x,z2), tspan, x0);

figure;
plot(t1, X1(:,1), 'b', t1, X1(:,3), 'r');
title('Caso 1: z(t) = 0.05 sin(0.5πt)');
xlabel('Tiempo (s)'); ylabel('Desplazamiento (m)');
legend('x1 (auto)', 'x2 (rueda)'); grid on;

figure;
plot(t2, X2(:,1), 'b', t2, X2(:,3), 'r');
title('Caso 2: z(t) = 0.05 sin(20πt)');
xlabel('Tiempo (s)'); ylabel('Desplazamiento (m)');
legend('x1 (auto)', 'x2 (rueda)'); grid on;

function dxdt = susp(t, x, z_func)
    m1 = 290; b1 = 1000; m2 = 59; k1 = 16182; k2 = 19000; f = 0;
    
    x1 = x(1); v1 = x(2); x2 = x(3); v2 = x(4);
    
    z = z_func(t);
    
    dxdt = zeros(4,1);
    dxdt(1) = v1;
    dxdt(2) = (1/m1) * (-b1*v1 + b1*v2 - k1*x1 + k1*x2 + f);
    dxdt(3) = v2;
    dxdt(4) = (1/m2) * (b1*v1 - b1*v2 + k1*x1 - (k1+k2)*x2 - f + k2*z);
end