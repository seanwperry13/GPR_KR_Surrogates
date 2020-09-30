function z=b_kernel(x)

% b kernel from original KSR paper
z=1+(1-1/105)*cos(x);

% decay rate lambda=1/15
for i=2:20
    z=z+2*(1/15)^i*cos(i*x);
end

% % new b kernel -- rescaled to be Gaussian-shaped over [-2pi, 2pi]
% lambda=1/15;
% 
%  z=1+2*(0.5-(lambda)^2/(1-lambda))*cos(0.5*x);
% % 
%  % decay rate lambda=??
%   for i=2:20
%       z=z+2*(lambda)^i*cos((i/2)*x);
%   end

% square wave
% d=0.5;
% z=(1/(2*d))*heaviside(x+d).*(1-heaviside(x-d));




% x =  -pi:pi/10:pi;
% z=b_kernel(x);
% plot(x, z)