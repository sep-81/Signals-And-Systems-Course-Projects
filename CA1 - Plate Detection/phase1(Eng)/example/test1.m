%%  calculation of inner product
%
clc
clearvars;
x=[1 -2 4]
y=randn(1,3);

N=length(x);

ro1=0;
for n=1:N
    ro1=ro1+x(n)*y(n);
end

sum(x.*y)


ro2=x*(y');
 [ro1,ro3]=innerproduct(x,y);

[ro1 ro2]
sprintf('The inner product is %d and %d:',ro1,ro2)
%}
%%
close all
n=0:1:10;

x=cos(pi/8*n);

y=cos(15*pi/8*n);

figure
stem(n,x,'LineWidth',6)
hold on
stem(n,y,'LineWidth',3,'color','r')


t=0:0.1:10;
x=cos(pi/8*t);
y=cos(15*pi/8*t);

figure
plot(t,x);
hold on
plot(t,y,'color','r')
xlabel('Time (Seconds)');


subplot(2,1,1)
plot(t,x);
subplot(2,1,2)
plot(t,y,'color','r')














