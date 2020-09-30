function z=KSR_2d(fc)

% "true" 2d-map on Fourier coefficients induce from KSR 

% spatial domain
x=[-1:0.01:1]*pi;

% evaluate function 
a=fc(1)+2*fc(2)*cos(x);

% apply KSR map
a=KSR(a,x);

% compute Fourier coefficients
z=Fourier_cos(a,x,1);




    