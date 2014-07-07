neurons = 2;

w_n1_to_n2 = 0.1;

lr = 0.2;

input = 1;

cycles = 10;
for c = 1:cycles
    inputs = w_n1_to_n2;

    
    
% weight updating here
%output weights
for i = 1:I
    for j = 1:J
        if wx(j,i) ~= 0
            wx_cur = wx(j,i);
            delta_wx = eta*y(j) * (x(i) - y*wx(:,i));
            temp_x = wx_cur + delta_wx ;
            d = decay * (temp_x - wx_cur);
            wx(j,i) = temp_x - d;
        end
    end
end

% input weights
[J I] = size(wy);
for k = 1:I
    for l = 1:J
        if wy(l,k) ~= 0
            wy_cur = wy(l,k);
            delta_wy = eta*y(l) * (alpha*value*y_old(l) - y*wy(k,:)');
            temp_y = wy_cur + delta_wy ;
            d = decay * (temp_y - wy_cur);
            wy(l,k) = temp_y - d;
        end
    end
end
end