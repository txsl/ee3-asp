function a = ASP_Part_1_2()
a = rp1(100,100)
assignin('base', 'a', a)
plot(a) % Do mean() and std()
figure;
b = rp2(100,100)
assignin('base', 'b', b)
plot(b)
figure;
c = rp3(100,100)
assignin('base', 'c', c)
plot(c)

M = 4;
N = 1000;
a = rp1(M,N)
assignin('base', 'a', a)
plot(a)
figure;
b = rp2(M,N)
assignin('base', 'b', b)
plot(b)
figure;
c = rp3(M,N)
assignin('base', 'c', c)
plot(c.')
end

function v=rp1(M,N)
a=0.02;
b=5;
Mc=ones(M,1)*b*sin((1:N)*pi/N);
Ac=a*ones(M,1)*[1:N];
v=(rand(M,N)-0.5).*Mc+Ac;
end

function v=rp2(M,N)
Ar=rand(M,1)*ones(1,N);
Mr=rand(M,1)*ones(1,N);
v=(rand(M,N)-0.5).*Mr+Ar;
end

function v=rp3(M,N)
a=0.5;
m=3;
v=(rand(M,N)-0.5)*m + a;
end

% function ASP_Part_1_2_given_funcs()
% rp1(100,100)

% end