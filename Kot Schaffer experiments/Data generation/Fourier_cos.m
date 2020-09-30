function f=Fourier_cos(a,x,n)

% 0-th Fourier cosine coefficient
f(1)=abs(x(2)-x(1))*trapz(a)/(2*pi);

% other Fourier cosine coefficients
for i=2:n+1
    integrand=a.*cos((i-1)*x);
    f(i)=abs(x(2)-x(1))*trapz(integrand)/(2*pi);
end;