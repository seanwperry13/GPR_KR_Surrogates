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

Tp=1000;
Ttp=500;
Tttp=2000;
Perm=randperm(d1,Tp+Ttp+Tttp);

Pp=Ppp(Perm(1:Tp),:);
Qp=Qpp(Perm(1:Tp),:);

Ptp=Ppp(Perm(Tp+1:Tp+Ttp),:);
Qtp=Qpp(Perm(Tp+1:Tp+Ttp),:);

Pttp=Ppp(Perm(Tp+Ttp+1:Tp+Ttp+Tttp),:);
Qttp=Qpp(Perm(Tp+Ttp+1:Tp+Ttp+Tttp),:);

T=300;
[P,Q]=Declump2(Pp,Qp,T);
Tt=300;
[Pt,Qt]=Declump2(Ptp,Qtp,Tt);
Ttt=2000;
[Ptt,Qtt]=Declump2(Pttp,Qttp,Ttt);

M=20;
Band = BandwidthSelector(P,Q,Pt,Qt,M);

[KRPtt,KRErrors] = KernelErrors(P,Q,Band,Ptt,Qtt);

[GPPtt, GPErrors] = GPRErrors(P,Q,Ptt,Qtt);


MeanAbsGPError=mean(abs(GPErrors));
MeanAbsKRError=mean(abs(KRErrors));
MaxAbsGPError=max(abs(GPErrors));
MaxAbsKRError=max(abs(KRErrors));
toc; 

fig1 = figure(1);  clf(fig1); hold on;
plot(Qtt(:,1),Qtt(:,2),'b*');
plot(KRPtt(:,1),KRPtt(:,2),'r*');
plot(GPRPtt(:,1),GPRPtt(:,2),'g*');

