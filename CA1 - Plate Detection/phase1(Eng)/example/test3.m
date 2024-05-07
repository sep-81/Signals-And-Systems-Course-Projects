

t=0:0.1:12;
y=sin(pi/6*t);
plot(t,y)
noise=0.2*randn(size(y));

z=y+noise;
plot(t,z)