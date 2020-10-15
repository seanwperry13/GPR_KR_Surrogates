%Iteration and Hausdorff Distance Comparison betweeen GPR and KR on MER
%data

load TS_ribbon.txt
tic;
TS=TS_ribbon;

dim=2;
lag=1;
DR=DelayReconstr(TS,dim,lag);

s=30000;
t=40000;
d1=t-s;
Ppp=DR(s:t,:);
Qpp=DR(s+1:t+1,:);

%pre/post declump sizes for training, bandwidth, and testing sets.
Tp=1000;
T=300;
Ttp=500;
Tt=300;
Tttp=1000;
Ttt=500;

%Random selection
Perm=randperm(d1,Tp+Ttp+Tttp);
Pp=Ppp(Perm(1:Tp),:);
Qp=Qpp(Perm(1:Tp),:);
Ptp=Ppp(Perm(Tp+1:Tp+Ttp),:);
Qtp=Qpp(Perm(Tp+1:Tp+Ttp),:);
Pttp=Ppp(Perm(Tp+Ttp+1:Tp+Ttp+Tttp),:);
Qttp=Qpp(Perm(Tp+Ttp+1:Tp+Ttp+Tttp),:);

%Declumping
[P,Q]=Declump2(Pp,Qp,T);
[Pt,Qt]=Declump2(Ptp,Qtp,Tt);
[Ptt,Qtt]=Declump2(Pttp,Qttp,Ttt);

M=20;
Band = BandwidthSelector(P,Q,Pt,Qt,M);

[KRPtt,KRErrors] = KernelErrors(P,Q,Band,Ptt,Qtt);

[GPPtt, GPErrors] = GPRErrors(P,Q,Ptt,Qtt);

IterGP = Ptt;
len=1000;
for i=len
   IterGPx = predict(GPRModx,IterGP);
   IterGPy = predict(GPRMody,IterGP);
   IterGP = cat(2,IterGPx,IterGPy);
end
toc;

IterKR = Ptt;
dumZ = zeros(Ttt,dim);
for j=1:len
    IterKR = KernelErrors(P,Q,Band,IterKR,dumZ);
end
toc;

fig2 = figure(2); clf(fig2); hold on;
plot(Qtt(:,1),Qtt(:,2),'b*');
plot(IterKR(:,1),IterKR(:,2),'r*');
plot(IterGP(:,1),IterGP(:,2),'g*');

toc;
