function decoded_result = decoding_freq(coded_msg, rate, msg_length, noise, freqs_true)
    Mapset = load ('project03_Part03_A.mat');
%     display(Mapset);
    Mapset = Mapset.A;
    fs = 100;
    iter_num = length(coded_msg)/fs; 

%     iter_num ====> number of signals that has drawn;
    all_bits_length = iter_num * rate;
    appended_bits = all_bits_length - (5*msg_length);
    
        
    t_start = 0;
    t = t_start: 1/fs : iter_num - 1/fs;
    coef_diff_count = 2 ^ rate;
    cor_freq_result = zeros(1,iter_num);
    Fs = 100;
    temp = -Fs/2: 1 : Fs/2 - 1;
    for i=1: iter_num
%         plot(temp, fftshift(fft(coded_msg((i-1)*fs+1:i*fs))));
        [~, max_freq] = max(abs(fftshift(fft(coded_msg((i-1)*fs+1:i*fs)))));
        cor_freq_result(i) = abs(51 - max_freq);
    end
    disp(cor_freq_result);
%     coefs_true = zeros(1, coef_diff_count);
%     for i=0: coef_diff_count-1
%         coefs_true(i+1) = i / (coef_diff_count-1);
%     end
%     
    decoded_result = strings(1, msg_length);
    msg_bits = strings(1, iter_num);


   tresh = (freqs_true{1,2} - freqs_true{1,1})/2;
   for i=1: iter_num
       flag = true;
       for j=1: coef_diff_count
            
            if abs(cor_freq_result(i) - freqs_true{1,j}) < tresh
                msg_bits(i) =  dec2bin(j-1, rate);
                flag = false;
                break;
            end
       end
       if flag && noise
            diff1 = abs(cor_freq_result(i) - freqs_true{1,1});
            diff_end = abs(cor_freq_result(i) - ...
                freqs_true{1,coef_diff_count});
            if diff1 < diff_end
                msg_bits(i) =  dec2bin( 0, rate);
            else
                msg_bits(i)=dec2bin(coef_diff_count-1, ...
                    rate);
            end                  
       end
    end
    

    msg_bits = join(msg_bits, '');
    msg_bits = char(msg_bits);
    if appended_bits > 0
        msg_bits = msg_bits(1:length(msg_bits)-appended_bits);
    end
    for i=1:msg_length
        for j=1: length(Mapset)
             if Mapset{2, j} == msg_bits((i-1)*5+1:(i*5))
                decoded_result(i)=Mapset{1, j};
                break;
            end
        end
    end
  
    
end