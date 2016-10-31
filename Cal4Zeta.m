%@author: xuyuanfang
clear 
clc

zeta = 0.1;
Q = 1/2/zeta;

syms Q_divsqrt2
lambda = solve('(1 - lambda^2)^2 + (2*0.1*lambda)^2 = 1/Q_divsqrt2^2', 'lambda');

Q_divsqrt2 = Q/sqrt(2);
lambda = eval(lambda);
lambda = abs(lambda);
lambda = unique(lambda);
zeta_cal = 1/2*abs(lambda(1) - lambda(2))
