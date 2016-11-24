%@author: xuyuanfang
clear
clc

for zeta = 0.2:0.2:1
    lambda = 0:0.01:3;
    theta = atan(2*zeta*lambda./(1 - lambda.^2)).*180./pi;
    for i = 1:length(theta)
        if theta(i) < 0
            theta(i) = theta(i) + 180;
        end
    end
    plot(lambda, theta)
    text(1.5, 180 + atan(2*zeta*1.5/(1 - 1.5^2)).*180./pi, num2str(zeta));
    hold on
end

plot([1,1], [0,180], '--')
title('ÏàÆµÇúÏß', 'FontSize', 20)
xlabel('lambda', 'FontSize', 16)
ylabel('theta(¡ã)', 'FontSize', 16)