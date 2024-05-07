clear
clc
format long g

% Project 03 / Part 01 / IRAN ZARE , SEPEHR AZARDAR / Signals & Systems


% ================================ Part 1 - 1 =============================

% Sampling frequency = 50 Hz  | x1

Fs = 50;                                
ts = 1/Fs;
t = -1 : ts : 1 - ts;
N = length(t);
freq = -Fs/2: Fs/N : Fs/2 - Fs/N;
x1 = cos(10*pi*t);
figure ( 1 ) 
stem (t , x1 , ' .r','linewidth',0.02) ;
xlabel ( ' t  ' )
ylabel ( ' cos(10*pi*t) ' )

% Fourier Transform
fx1 = fftshift(fft(x1));
fx1 = abs(fx1) / max(abs(fx1));
figure ( 2 ) 
plot (freq,fx1,'r');
xlabel ( ' Frequency (Hz)   ' )
ylabel ( ' Fourier transform of function fx1 ' )

% ================================ Part 2 - 1 =============================

% Sampling frequency = 50 Hz  | x2

Fs = 50;                                
ts = 1/Fs;
t = -1 : ts : 1 - ts;
N = length(t);
freq = -Fs/2: Fs/N : Fs/2 - Fs/N;
x2 = rectangularPulse(t);
figure ( 3 ) 
stem (t , x2 , '.g','linewidth',0.02) ;
xlabel ( ' t  ' )
ylabel ( ' Rectangular Pulse ' )

% Fourier Transform
fx2 = fftshift(fft(x2));
fx2 = abs(fx2) / max(abs(fx2));
figure ( 4 ) 
plot (freq,fx2,'g');
xlabel ( ' Frequency (Hz)   ' )
ylabel ( ' Fourier transform of function fx2 ' )

% ================================ Part 3 - 1 =============================

% Sampling frequency = 50 Hz  | x3

Fs = 50;                                
ts = 1/Fs;
t = -1 : ts : 1 - ts;
N = length(t);
freq = -Fs/2: Fs/N : Fs/2 - Fs/N;
x3 = x2 .* x1 ;
figure ( 5 ) 
stem (t , x3 , ' .b','linewidth',0.03) ;
xlabel ( ' t  ' )
ylabel ( ' Rectangular Pulse * cos(10*pi*t) ' )

% Fourier Transform
fx3 = fftshift(fft(x3));
fx3 = abs(fx3) / max(abs(fx3));
figure ( 6 ) 
plot (freq,fx3,'b');
xlabel ( ' Frequency (Hz)   ' )
ylabel ( ' Fourier transform of function fx3 ' )

% ================================ Part 4 - 1 =============================

% Sampling frequency = 100 Hz  | x4

Fs = 100;                                
ts = 1/Fs;
t = 0 : ts : 1 - ts;
N = length(t);
freq = -Fs/2: Fs/N : Fs/2 - Fs/N;
x4 = cos ( 30 * pi * t + pi/4 );
figure ( 7 ) 
stem (t , x4 , ' .c','linewidth',0.02) ;
xlabel ( ' t  ' )
ylabel ( ' cos ( 30 /* \pi /* t + \pi/4 ) ' )

% Fourier Transform
fx4 = fftshift(fft(x4));
x2f4 = abs(fx4) / max(abs(fx4));

figure ( 8 ) 
plot(freq,x2f4,'c');

tol = 1e-6;
fx4(abs(fx4) < tol) = 0;
theta = angle(fx4);
figure ( 9 ) 
plot(freq,theta/pi,'c')
xlabel 'Frequency (Hz)'
ylabel 'Phase / \pi'

% ================================ Part 5 - 1 =============================

% Sampling frequency = 50 Hz  | x5

Fs = 50;                                
ts = 1/Fs;
t = -19 : ts : 19 - ts;
N = length(t);
freq = -Fs/2: Fs/N : Fs/2 - Fs/N;
x5 = 0;
for k = -9 : 9
    x5 = rectangularPulse( t - 2*k )+ x5;
end
plot(t, x5)
figure ( 10 ) 
stem (t , x5 , '.y' , 'linewidth' , 0.001) ;
xlabel ( ' t  ' )
ylabel ( ' \Sigma \Pi(t-2k) ' )

% Fourier Transform
fx5 = fftshift(fft(x5));
fx5 = abs(fx5) / max(abs(fx5));
figure ( 11 ) 
plot (freq,fx5,'y');
xlabel ( ' Frequency (Hz)   ' )
ylabel ( ' Fourier transform of function fx5 ' )
