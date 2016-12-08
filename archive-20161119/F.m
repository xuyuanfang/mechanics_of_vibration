% @author: xuyuanfang
function [Data_matrix, new_delta_t] = F(delta_t, total_exciting_t)
    if exist('input.xlsx', 'file') == 0
        div_num = ceil(total_exciting_t/delta_t);
        new_delta_t = total_exciting_t/div_num;
        data = zeros(div_num + 1, 2);
        for i = 0:div_num
            data(i + 1, 1) = i*new_delta_t;% exciting_t
            % ËãÀı1 Âö³å¼¤ÀøÊ±µÄ¼¤Àøº¯Êı
            if i*new_delta_t <= 0.02
                data(i + 1, 2) = 6e6*i*new_delta_t;
            elseif i*new_delta_t <= 0.04
                data(i + 1, 2) = 1.2e5;
            else
                data(i + 1, 2) = 3.6e5 - 6e6*i*new_delta_t;
            end
            % ËãÀı1 Âö³å¼¤ÀøÊ±µÄ¼¤Àøº¯Êı
        end
        filename = 'input.xlsx';
        sheet = 1;
        xlRange = 'A1';
        xlswrite(filename, data, sheet, xlRange)
    end
    Data_matrix = xlsread('input.xlsx');
    new_delta_t = Data_matrix(2,1) - Data_matrix(1,1);
end

%     % ËãÀı2 ÕıÏÒ¼¤ÀøÊ±µÄ¼¤Àøº¯Êı
%     data(i + 1, 2) = 30*9.81*sin(2*pi*i*new_delta_t);
%     % ËãÀı2 ÕıÏÒ¼¤ÀøÊ±µÄ¼¤Àøº¯Êı