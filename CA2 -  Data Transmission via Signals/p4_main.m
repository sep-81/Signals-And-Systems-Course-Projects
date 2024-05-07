clear
clc
format long g
A = load ('project03_Part03_A.mat');
% display(A)
A = A.A;

j = 1;
while j < length(A) + 1

    A{2,j} = dec2bin(j-1,5);
    j = j + 1 ;
end
save project03_Part03_A;

% a = input('Please enter your input: ','s');
a = 'iran sepehr';

for i=1:3
    rate = i;
%     noise = 0.0001;
%     noise = 0.001;
     noise = 1.4;
%      noise = 0;
    [y,msg_length, freqs] = coding_freq(a,rate,noise);
    % display(y);
    fprintf('========================\n');
    result_msg = decoding_freq(y,rate,msg_length,noise, freqs);
    
    fprintf('decoded message is:\n')
    fprintf('%s', result_msg{:});
    fprintf('\n')
end