% @author: xuyuanfang
clear 
clc
tic

c = 316.2;  % ËãÀı1.1 316.2 ËãÀı1.2 41.67
k = 1e5;    % ËãÀı1.1 1e5 ËãÀı1.2 2953.5
m = 100;    % ËãÀı1.1 100 ËãÀı1.2 30
total_t = 1;      % ËãÀı1.1 1 ËãÀı1.2 10
delta_t = 0.005;    % ËãÀı1.1 0.005 ËãÀı1.2 0.01
total_exciting_t = 0.06;    % ËãÀı1.1 0.06 ËãÀı1.2 8
x0 = 0;
v0 = 0;

[Data_matrix, new_delta_t] = F(delta_t, total_exciting_t);

div_num = ceil(total_t/new_delta_t);
new_total_t = div_num*new_delta_t;

if size(Data_matrix,1) < div_num
	line = size(Data_matrix,1);
	for i = line + 1:div_num + 1
        Data_matrix(i, 2) = 0;
	end
end

t_matrix = 0:new_delta_t:new_total_t;
F_matrix = Data_matrix(:, 2);
x_matrix = zeros(div_num + 1,1);
v_matrix = zeros(div_num + 1,1);
a_matrix = zeros(div_num + 1,1);
precision = 1;

omega0 = sqrt(k/m)
zeta = c/2/m/omega0
omegad = omega0*sqrt(1 - zeta^2)

for i = 1:div_num + 1
    tau = i*new_total_t/div_num;
    x = x0;
    init = exp(-zeta*omega0*tau)*(x0*cos(omegad*tau) + ...
        (v0 + zeta*omega0*x0)/omegad*sin(omegad*tau));
    for j = 1:i
        tau0 = (j - 1)*new_total_t/div_num;
        tau1 = j*new_total_t/div_num;
        % Duhamel(a, b, t, c, k, m, precision)
        D = F_matrix(j)*Duhamel(tau0, tau1, tau, c, k, m, precision);
        x = x + D;
    end
    x_matrix(i) = init + x;
end

v_matrix(1) = v0;
for i = 1:div_num
    v_matrix(i + 1) = (x_matrix(i + 1) - x_matrix(i))/new_delta_t;
end

a_matrix(1) = F_matrix(1)/m;
for i = 1:div_num
    a_matrix(i + 1) = (v_matrix(i + 1) - v_matrix(i))/new_delta_t;
end

subplot(2,2,1)
plot(t_matrix, F_matrix);
grid on
title('EXCITING FORCE - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Exciting Force (Newton)', 'FontSize', 12)

subplot(2,2,2)
plot(t_matrix, x_matrix);
grid on
title('DISPLACEMENT - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Displacement (Meter)', 'FontSize', 12)

subplot(2,2,3)
plot(t_matrix, v_matrix);
grid on
title('VELOCITY - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Velocity (Meter per Sec)', 'FontSize', 12)

subplot(2,2,4)
plot(t_matrix, a_matrix);
grid on
title('ACCELERATION - TIME', 'FontSize', 16)
xlabel('Time (Sec)', 'FontSize', 12)
ylabel('Acceleration (Meter per Sec^2)', 'FontSize', 12)

toc