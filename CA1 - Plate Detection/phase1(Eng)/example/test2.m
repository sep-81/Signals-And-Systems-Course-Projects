ts=0.01;
fs=1/ts;

t=0:ts:10;
t_len=length(t);

x=zeros(1,t_len);
x=zeros(size(t));

N=round(t_len/10);
x(1:N)=1;
x(1:N)=ones(1,N);

y=zeros(size(x));
s=ones(1,N);
idx=501;
y(idx:idx+N-1)=0.1*s;

plot(t,x,'LineWidth',2)
hold on
plot(t,y,'LineWidth',2,'color','r')
xlim([-0.5 10.5])
ylim([-0.5 1.5])

noise=0.1*randn(1,t_len);
z=y+noise;
plot(t,z,'LineWidth',4,'color','g')


ro=zeros(1,t_len-N-1);
for i=1:t_len-N-1
    ro(i)=innerproduct(z(i:i+N-1),s); 
end


figure
plot(t(1:t_len-N-1),abs(ro))


[val,pos]=max(abs(ro));
t(pos)


