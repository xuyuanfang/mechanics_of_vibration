% @author: xuyuanfang
function D = Duhamel(a, b, t, c, k, m, precision)
    % Simpson
    if a == b
        D = 0;
    else
        omega0 = sqrt(k/m);
        zeta = c/2/m/omega0;
        omegad = omega0*sqrt(1 - zeta^2);

        h = @(tau, t)1./m./omegad.*exp(-zeta.*omega0.*(t - tau))...
            .*sin(omegad.*(t- tau));

        c = (b - a)/2/precision;
        A = a:c:b;       % A为(a,b)的n等分横坐标向量
        B = h(A, t);     % B为A对应的函数值向量
        D = 0;
        for i = 1:precision; 
            s = c/3*(B(2*i - 1) + 4*B(2*i) + B(2*i + 1));
            D = D + s;
        end
    end
end