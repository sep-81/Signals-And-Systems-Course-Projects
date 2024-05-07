function [y, msg_length] = amp_coding(massage, rate, noise_power)
    msg_length = strlength(massage);
    y = cell(1,strlength(massage));
    Mapset = load ('project03_Part03_A.mat');
%     display(Mapset);
    Mapset = Mapset.A;
    % display(y)
    % display(A);
    % pat = " ";
    % n = extract(a,pat);
    % s = textscan(massage,'%s');  %character to cell
    % display(s(1,1))
    for i = 1 : length(massage)
        for j = 1 : length(Mapset)
            if ismember(massage(i),Mapset{1,j}) == 1 
                y{1,i} = Mapset{2,j};
                break;
            end
        end
    end
    
    all_bits = strjoin(y,'');
    bits_length = strlength(all_bits);
    signal_diff_num = 2^rate;
    ts = 1/100;
    if mod(bits_length, rate) ~=0 
        all_bits = append(all_bits, char(zeros(1, ...
            (rate - mod(bits_length, rate)))+ '0'));
        bits_length = strlength(all_bits);
        display(bits_length);
        display(all_bits);
    end
    iter_num = bits_length / rate;
    t = 0 : ts :iter_num- ts;
    result_massage=0;
    for i= 0:iter_num-1
        bits = all_bits(i*rate+1: (i+1)*rate);
        result_massage = result_massage + (bin2dec(bits)/(signal_diff_num-1))*...
            sin(2*pi*t).* (heaviside(t-i)-heaviside(t-i-1));
    end
    
%   y(isnan(str2double(y))) = [];
    % for w = 1 : strlength(y) - 1 
    % y = [y{1,1},y{1,w}];
    % end
    % display(y);
%   plot(t, result_massage);
%     display(noise_power);
    noise = randn(1, length(result_massage)) * noise_power;
    result_massage = noise+result_massage;
%   figure(2)
%   plot(t, noise);
%    close();
    figure(rate);
%     plot(t, result_massage);
    xlabel('t');
    ylabel('coded message');
    y = result_massage;
    plot(t,y);
end

