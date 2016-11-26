# 振动力学程序作业-20161119
# 
**0.计算模型**

**1.使用杜哈梅积分计算任意非周期激励的响应（水塔算例）**

**附.Code-MATLAB**

## Student Info
- 姓名：徐远方
- 学号：

## 0. 计算模型
### 水塔
 <img src="img/water_tower.png" width = "217" height = "400" alt="图片名称" align=center />
### 参数
------
| k (N/m) | m (kg) | c (N*s/m) | t (s) | delta_t (s) | x0 (m) | v0 (m/s)
| :------- | :-------| :-------| :-------| :------- | :-------| :-------|
| 1e5 | 100 | 316.2 | 1 | 0.005 | 0 | 0 |
------

## 1. 使用杜哈梅积分计算任意非周期激励的响应（水塔算例）
### Figure
<center>
![figure1](img/force.png)
![figure2](img/displacement.png)
![figure3](img/velocity.png)
![figure4](img/acceleration.png)
</center>

## 附: Code-MATLAB
### Main Program (Duhamel.m)
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
    v0 = 0;
    
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
        x = 0;
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
    
    v_matrix(1) = 0;
    for i = 1:div_num
        v_matrix(i + 1) = (x_matrix(i + 1) - x_matrix(i))/delta_t;
    end
    
    a_matrix(1) = F(1)/m;
    for i = 1:div_num
        a_matrix(i + 1) = (v_matrix(i + 1) - v_matrix(i))/delta_t;
    end
    
    subplot(2,2,1)
    plot(t_matrix, x_matrix);
    grid on
    title('DISPLACEMENT - TIME', 'FontSize', 16)
    xlabel('Time (Sec)', 'FontSize', 12)
    ylabel('Displacement (Meter)', 'FontSize', 12)
    
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
    plot(t_matrix, F_matrix);
    grid on
    title('FORCE - TIME', 'FontSize', 16)
    xlabel('Time (Sec)', 'FontSize', 12)
    ylabel('Force (Newton)', 'FontSize', 12)
    toc

### Subprogram (Duhamel.m)
    %@author: xuyuanfang
    function D = Duhamel(a, b, t, c, k, m, precision)
        %Simpson
        if a == b
            D = 0;
        else
            omega0 = sqrt(k/m);
            zeta = c/2/m/omega0;
            omegad = omega0*sqrt(1 - zeta^2);
    
            h = @(tau, t)1./m./omegad.*exp(-zeta.*omega0.*(t - tau))...
                .*sin(omegad.*(t- tau));
    
            c = (b - a)/2/precision;
            A = a:c:b;       %A为(a,b)的n等分横坐标向量
            B = h(A, t);     %B为A对应的函数值向量
            D = 0;
            for i = 1:precision; 
                s = c/3*(B(2*i - 1) + 4*B(2*i) + B(2*i + 1));
                D = D + s;
            end
        end
    end

### Subprogram (F.m)
    %@author: xuyuanfang
    function F = F(t)
        %激励力
        if t <= 0.02
            F = 6e6*t;
        elseif t > 0.02 && t <= 0.04
            F = 1.2e5;
        elseif t >0.04 && t <= 0.06
            F = 3.6e5 - 6e6*t;
        else
            F = 0;
        end
    end

----
###### 本文由Markdown编排，图片使用的png格式，图片清晰度不及LaTex使用的pdf图片格式，故将此次作业的电子版二维码置于下方。
<center>
 <img src="img/github.png" width = "200" height = "200" alt="" />
</center>

#### 电子版地址 https://github.com/xuyuanfang/mechanics_of_vibration