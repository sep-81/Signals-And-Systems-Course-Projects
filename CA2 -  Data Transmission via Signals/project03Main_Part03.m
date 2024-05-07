clear
clc
format long g

% Project 03 / Part 03 / IRAN ZARE , SEPEHR AZARDAR / Signals & Systems

% ================================ Part 1 - 3 =============================

% Cell A : a,b,c,...,x,y,z, ,!,,,",.,;
% project03_Part03_A = cell(2,32);
% project03_Part03_A {1,1} = 'a' ; project03_Part03_A {1,2} = 'b'; project03_Part03_A {1,3} = 'c'; project03_Part03_A {1,4} = 'd'; project03_Part03_A {1,5} = 'e'; project03_Part03_A {1,6} = 'f';
% project03_Part03_A {1,7} = 'g' ; project03_Part03_A {1,8} = 'h'; project03_Part03_A {1,9} = 'i';  project03_Part03_A {1,10} = 'j';project03_Part03_A {1,11} = 'k';project03_Part03_A {1,12} = 'l';
% project03_Part03_A {1,13} = 'm'; project03_Part03_A {1,14} = 'n';project03_Part03_A {1,15} = 'o'; project03_Part03_A{1,16} = 'p';project03_Part03_A {1,17} = 'q';project03_Part03_A {1,18} = 'r';
% project03_Part03_A {1,19} = 's'; project03_Part03_A {1,20} = 't';project03_Part03_A {1,21} = 'u'; project03_Part03_A {1,22} = 'v';project03_Part03_A {1,23} = 'w';project03_Part03_A {1,24} = 'x';
% project03_Part03_A {1,25} = 'y'; project03_Part03_A {1,26} = 'z';project03_Part03_A {1,27} = ' '; project03_Part03_A {1,28} = '.';project03_Part03_A {1,29} = ',';project03_Part03_A {1,30} = '!';
% project03_Part03_A {1,31} = ';'; project03_Part03_A {1,32} = '"';

A = load ('project03_Part03_A.mat');
% display(A)
A = A.A;

j = 1;
while j < length(A) + 1

    A{2,j} = dec2bin(j-1,5);
    j = j + 1 ;
end
save project03_Part03_A

% a = input('Please enter your input: ','s');
a = 'iran';

for i=1:3
    rate = i;
%     noise = 0.0001;
%     noise = 0.001;
     noise = 0.1;
    [y,msg_length] = amp_coding(a,rate,noise);
    % display(y);
    
    result_msg = decoder(y,rate,msg_length,noise);
    
    fprintf('decoded message is:\n')
    fprintf('%s', result_msg{:});
    fprintf('\n')
end
%%%%%%%







