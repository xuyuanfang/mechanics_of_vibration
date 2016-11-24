%@author: xuyuanfang
clear 
clc
tic

c = 316.2;
k = 1e5;
m = 100;
t = 1;
delta_t = 0.005;
div_num = t/delta_t;
x0 = 0;
v0 = 10;

t_matrix = 0:delta_t:t;
F_matrix = zeros(div_num + 1,1);
x_matrix = zeros(div_num + 1,1);
v_matrix = zeros(div_num + 1,1);
a_matrix = zeros(div_num + 1,1);
precision = 1;

omega0 = sqrt(k/m)
zeta = c/2/m/omega0
omegad = omega0*sqrt(1 - zeta^2)

for i = 1:div_num + 1
    tau = i*t/div_num;
    x = x0;
    init = exp(-zeta*omega0*tau)*(x0*cos(omegad*tau) + ...
        (v0 + zeta*omega0*x0)/omegad*sin(omegad*tau));
    for j = 1:i
        tau0 = (j - 1)*t/div_num;
        tau1 = j*t/div_num;
        %Duhamel(a, b, t, c, k, m, precision)
        D = F(tau0)*Duhamel(tau0, tau1, tau, c, k, m, precision);
        x = x + D;
    end
    x_matrix(i) = init + x;
    F_matrix(i) = F(tau0);
end

v_matrix(1) = v0;
for i = 1:div_num
    v_matrix(i + 1) = (x_matrix(i + 1) - x_matrix(i))/delta_t;
end

a_matrix(1) = F(1)/m;
for i = 1:div_num
    a_matrix(i + 1) = (v_matrix(i + 1) - v_matrix(i))/delta_t;
end

subplot(2,2,1)
plot(t_matrix, F_matrix);
grid on
title('FORCE - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Force (Newton)', 'FontSize', 12)

subplot(2,2,2)
plot(t_matrix, v_matrix);
grid on
title('VELOCITY - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Velocity (Meter per Sec)', 'FontSize', 12)

subplot(2,2,3)
plot(t_matrix, a_matrix);
grid on
title('ACCELERATION - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Acceleration (Meter per Sec^2)', 'FontSize', 12)

subplot(2,2,4)
plot(t_matrix, x_matrix);
grid on
title('DISPLACEMENT - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Displacement (Meter)', 'FontSize', 12)

toc