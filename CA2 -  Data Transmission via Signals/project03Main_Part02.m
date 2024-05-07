clear
clc
format long g

% Project 03 / Part 02 / IRAN ZARE , SEPEHR AZARDAR / Signals & Systems

% ================================ Part 1 - 2 =============================

% Sampling frequency = 50 Hz  | x6

Fs = 50;                                
dt = 1/Fs;
t = -1 : dt : 1;
x6 = dirac(t);
figure ( 1 )
stem (t , x6 , ' .r','linewidth',0.02) ;
xlabel ( 't  ' )
ylabel ( ' \delta (t) ' )

% Fourier Transform
fx6 = fftshift(fft(x6));
fx6 = fx6 / max(abs(fx6));
figure ( 2 ) 
plot (t,fx6,'y');
xlabel ( ' Frequency (Hz)   ' )
ylabel ( ' Fourier transform of function fx6 ' )

% ================================ Part 2 - 2 =============================

% Sampling frequency = 50 Hz  | x7

Fs = 50;                                
dt = 1/Fs;
t = -1 : dt : 1;
for i = 1 : length(t) 
    x7(i) = 1;
end
figure ( 3 )
stem (t , x7 , ' .b','linewidth',0.02) ;
xlabel ( 't  ' )
ylabel ( ' 1 ' )

% Fourier Transform
fx7 = fftshift(fft(x7));
fx7 = fx7 / max(abs(fx7));
figure ( 4 ) 
plot (t,fx7,'b');
xlabel ( ' Frequency (Hz)   ' )
ylabel ( ' Fourier transform of function fx7 ' )





