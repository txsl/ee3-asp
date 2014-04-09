function v=rp1(M,N)
a=0.02;
b=5;
Mc=ones(M,1)*b*sin((1:N)*pi/N);
assignin('base', 'Mc', Mc);
Ac=a*ones(M,1)*[1:N];
assignin('base', 'Ac', Ac);
v=(rand(M,N)-0.5).*Mc+Ac;
end