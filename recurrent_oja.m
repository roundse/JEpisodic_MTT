function [wy wx] = recurrent_oja(output, old_output, input, ...
                                 output_weights, input_weights, value)

global is_pfc;
                             
if nargin < 6
    value = 0;
end

global learning_rate;
global pfc_learning_rate;

global pfc_max;
global hpc_max;
global max_max_weight;

alpha = 2;
alpha = sqrt(alpha);
max = max_max_weight;

if is_pfc
    eta = pfc_learning_rate;
    pfc_decay = 0;
    decay = pfc_decay;
    max = pfc_max;
else
    eta = learning_rate;
    decay = 0;
    max = hpc_max;
end

x = input;
y_old = old_output;
y = output;
wx = output_weights';
wy = input_weights';

[J, I, ~] = find(wx);
K = size(J);
y_wx =  y*wx;

weight_decay = 1 - decay;

wx_bin = wx~=0;
wy_bin = wy~=0;

% output weights
for k = 1:K
    j = J(k);
    i = I(k);

    delta_wx = eta*y(j) * (x(i) - y_wx(i));
    wx(j,i) = (wx(j,i) + delta_wx) * weight_decay;
end

% input weights
[J, I, ~] = find(wy);
K = size(J);
y_wy =  y*wy';

for k = 1:K
    j = J(k);
    i = I(k);

    delta_wy = eta*y(i) * (alpha*value*y_old(i) - y_wy(j));
    wy(j,i) = (wy(j,i) + delta_wy) * weight_decay;
end

wx = wx .* wx_bin;
wy = wy .* wy_bin;

wx(wx>20) = 20;
wy(wy>20) = 20;

wx(wx<-20) = -20;
wy(wy<-20) = -20;

end

% function [wy wx] = recurrent_oja(output, old_output, input, ...
%                                  output_weights, input_weights, value)
% 
% global is_pfc;
%                              
% if nargin < 6
%     value = 0;
% end
% 
% global learning_rate;
% global pfc_learning_rate;
% 
% global pfc_max;
% global hpc_max;
% global max_max_weight;
% 
% global pfc_cur_decay;
% 
% alpha = 5;
% alpha = sqrt(alpha);
% max = max_max_weight;
% 
% tic
% 
% if is_pfc
%     eta = pfc_learning_rate;
%     %decay = .000000001;
%     %pfc_cur_decay = pfc_cur_decay + 0.00002;
%     pfc_decay = .23;
% %     if pfc_cur_decay > 1
% %        disp('HPC DECAY TOO LARGE!!!!!!!!!!!!!!!!!!'); 
% %     end
%     decay = pfc_decay;
%     max = pfc_max;
%     %value = 0;
% else
%     eta = learning_rate;
%     decay = 0;
%     max = hpc_max;
% end
% 
% x = input;
% y_old = old_output;
% y = output;
% wx = output_weights';
% wy = input_weights';
% 
% n = length(x);
% m = length(y);
% 
% [J I] = size(wx);
% 
% % output weights
% for i = 1:I
%     for j = 1:J
%         if wx(j,i) ~= 0
%             wx_cur = wx(j,i);
%             delta_wx = eta*y(j) * (x(i) - y*wx(:,i));
%             temp_x = wx_cur + delta_wx ;
%             d = decay * (temp_x - wx_cur);
%             wx(j,i) = temp_x - d;
%         end
%     end
% end
% 
% % input weights
% [J I] = size(wy);
% for i = 1:I
%     for j = 1:J
%         if wy(j,i) ~= 0
%             wy_cur = wy(j,i);
%             delta_wy = eta*y(i) * (alpha*value*y_old(i) - y*wy(j,:)');
%             temp_y = wy_cur + delta_wy ;
%             d = decay * (temp_y - wy_cur);
%             wy(j,i) = temp_y - d;
%         end
%     end
% end
% 
% toc
% 
% end