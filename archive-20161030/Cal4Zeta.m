% @author: xuyuanfang
clear 
clc

for zeta = 0.002:0.002:1;
    lambda = 0:0.001:3; % 3001
    beta = 1./sqrt((1 - lambda.^2).^2 + (2*zeta*lambda).^2);
    Q = max(beta(:));
    Q_divsqrt2 = Q/sqrt(2);
    num_beta = find(beta==Q);

    div1_beta = beta(1:num_beta);
    div1_lambda = lambda(1:num_beta);
    div2_beta = beta(num_beta:3001);
    div2_lambda = lambda(num_beta:3001);

    div1_min_beta = min(abs(div1_beta - Q_divsqrt2));
    div1_num_beta = find(abs(div1_beta - Q_divsqrt2)==div1_min_beta);
    div1_rele_lambda = div1_lambda(div1_num_beta);

    div2_min_beta = min(abs(div2_beta - Q_divsqrt2));
    div2_num_beta = find(abs(div2_beta - Q_divsqrt2)==div2_min_beta);
    div2_rele_lambda = div2_lambda(div2_num_beta);

    delta_lambda = div2_rele_lambda - div1_rele_lambda;
    zeta_cal = 1/2*delta_lambda;
    rela_error = abs(zeta_cal - zeta)/zeta;
    plot(zeta, rela_error, 'o', 'MarkerSize', 3, 'MarkerEdgeColor', 'r')
    plot(zeta, zeta_cal, '+', 'MarkerSize', 5, 'MarkerEdgeColor', 'b')
    hold on;

    if rem(zeta/0.002, 25) == 0
        fprintf('%s%.4f%s%.4f%s%.4f%s\n','|',zeta,'|',zeta_cal,'|',100*rela_error,'|');
    end
end

text(0.01, zeta_cal, num2str(zeta_cal));
text(0.01, 0.05, '0.05');
text(0.05, 0.6, '红色o为相对误差', 'FontSize', 12);
text(0.05, 0.56, '蓝色+为计算得ζ值', 'FontSize', 12);
plot([0,1], [zeta_cal, zeta_cal], '--')
plot([0,1], [0.05, 0.05], '--')
title('半功率法相对误差图(含计算得ζ值)', 'FontSize', 20)
xlabel('zeta', 'FontSize', 16)
ylabel('rela error (zeta cal)', 'FontSize', 16)