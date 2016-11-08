%@author: xuyuanfang
clear
clc

for zeta = 0:0.2:1
    lambda = 0:0.01:3;
    beta = 1./sqrt((1 - lambda.^2).^2 + (2*zeta*lambda).^2);
    plot(lambda, beta)
    text(1.1, 1/sqrt((1 - 1.1^2)^2 + (2*zeta*1.1)^2), num2str(zeta));
    hold on;
end

plot([1,1], [0,5], '--')
axis([0 3 0 5])
title('·ùÆµÌØĞÔÇúÏß')
xlabel('lambda')
ylabel('beta')