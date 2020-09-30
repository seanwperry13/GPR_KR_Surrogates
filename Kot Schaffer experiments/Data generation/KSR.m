function z=KSR(a,x)

% numerical approximation of KSR map on functions

% parameters from original KSR paper:  mu=30, c=0.5+0.5*cos(x);
%   mu=100; % cool stuff/chaos (third choice for c, new b)
%   mu=75;
%   mu=60; % period 2 using higher modes
   mu=30;
   
   c=0.5+0.5*cos(x);
%   c=(0.5+0.25*cos(x)-0.25*cos(2*x))*41/32;  %max close to 1
%   c=(1+0.25*cos(x)-0.15*cos(2*x)+0.15*cos(3*x));  %max close to 1

% TRAPEZOID rule
for i=1:length(x)
    for j=1:length(x)
        integrand(j)=b_kernel(x(i)-x(j))*mu*c(j)*a(j)*exp(-a(j));
    end
    %z(i)=integrand(i);
    z(i)=trapz(integrand)*abs(x(2)-x(1))/(2*pi);    
end
