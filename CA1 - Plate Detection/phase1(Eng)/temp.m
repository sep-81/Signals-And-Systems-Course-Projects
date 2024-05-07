num = [5 18; 9 8];
num;
num(1,:) = [45,66];
num(2) = 65;
t = [2,45];
num = [num; [2,55]]
disp(size(num,1));
%A = repmat(5,[2 3 1 4])
%disp(A(1,:,1,:))
A = false;
disp(A);