function [y, msg_length, freqs_true] = coding_freq(massage, rate, noise_power)
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
    freq_diff_num = 2^rate;
    ts = 1/100;
    if mod(bits_length, rate) ~=0 
        all_bits = append(all_bits, char(zeros(1, ...
            (rate - mod(bits_length, rate)))+ '0'));
        bits_length = strlength(all_bits);
        display(bits_length);
        display(all_bits);
    end
    fs = 100;
    freq_end = fs/2 - 1;
    freq_start = 0;
    freqs_true = cell(1,freq_diff_num);
%      each freq corespond to the binary form of its index;
    step = floor((freq_end - freq_start) / freq_diff_num);
    for i=1:freq_diff_num
        freqs_true{1, i} = (step*i - step/2);
    end
    fprintf("defined freqs");
    disp(freqs_true);

    iter_num = bits_length / rate;
    t = 0 : ts :iter_num- ts;
    result_massage=0;

    figure(1)
%    temp_freqs = zeros(1,iter_num);
    for i= 0:iter_num-1
        hold on
        bits = all_bits(i*rate+1: (i+1)*rate);
        freq = freqs_true{1,bin2dec(bits)+1};
%         temp_freqs(1,i+1) = freq;
        freq_ft = sin(2*pi*freq*t).*(heaviside(t-i)-heaviside(t-i-1));
        plot(t,freq_ft);
        hold off
        result_massage = result_massage+freq_ft;
    end

%     disp(temp_freqs);
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
    figure(10+rate);
%     plot(t, result_massage);
    xlabel('t');
    ylabel('coded message');
    y = result_massage;
    plot(t,y);
end

