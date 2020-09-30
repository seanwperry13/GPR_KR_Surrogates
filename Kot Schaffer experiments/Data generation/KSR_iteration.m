clear; clc; close all; format compact

% iterate KSR map to generate a time series of Fourier coefficients

% spatial domain
x=[-1:0.005:1]*pi;

% number of iterates
% N=6000;
N=2000;

% initial condition
a=1+rand(size(x))-0.5;

% remove transients
for n=1:10
    n
    a=KSR(a,x);
end
    
% ts=zeros(N,2);     % first two Fourier Coefficients
% tsi=zeros(N,2);    % first two Fourier Coefficients of image

M=3;
ts=zeros(N,M);     % first M Fourier Coefficients
tsi=zeros(N,M);    % first M Fourier Coefficients of image

% iterate for time series of Fourier coefficients
for n=1:N
    if ((mod(n,100)==0)||(n<11)), iteration=[n N], end
    zz=Fourier_cos(a,x,M-1);
    ts(n,:)=zz; %ts(n,:)=[zz(1) zz(2) zz(3)];
    a=KSR(a,x);
    zz=Fourier_cos(a,x,M-1);
    tsi(n,:)=zz; %tsi(n,:)=[zz(1) zz(2) zz(3)];
end

% plot
figure(15); hold on
plot3(ts(:,1),ts(:,2), ts(:,3), 'ko')

% save data
save('P.dat','ts','-ascii')
save('Q.dat','tsi','-ascii')



    