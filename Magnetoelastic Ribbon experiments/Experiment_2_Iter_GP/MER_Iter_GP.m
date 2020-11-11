tic;

%Data
load TS_ribbon.txt
TS=TS_ribbon;

dim=2;
lag=1;

DR=DelayReconstr(TS,dim,lag);

s=30000;
t=60000;

Pinit=DR(s:t,:);
Qinit=DR(s+1:t+1,:);

d1=size(Pinit,1);
d2=size(Pinit,2);

%Random sample parameters
Tp=2000;
Ttp=2000;

%Iteration parameters
clrtrns=500;
t=1000;
ft=t+clrtrns;

%Random Sample
Perm=randperm(d1-ft,Tp+Ttp+Ttp);

Pp=Pinit(Perm(1:Tp),:);
Qp=Qinit(Perm(1:Tp),:);
Ptp=Pinit(Perm(Tp+Ttp+1:Tp+Ttp+Ttp),:);
Qtp=Qinit(Perm(Tp+Ttp+1:Tp+Ttp+Ttp),:);

toc
%Declump
T=200;
[P,Q]=Declump2(Pp,Qp,T);
Ttt=500;
[Ptt,Qtt]=Declump2(Ptp,Qtp,Ttt);

toc
%Gaussian Process Surrogate 
G1 = fitrgp(P,Q(:,1));
G2 = fitrgp(P,Q(:,2));

toc
GOrb=zeros(Ttt,d2,ft);
IterGP = Ptt;
for i=1:ft
    IterGP1 = predict(G1,IterGP);
    IterGP2 = predict(G2,IterGP);
    IterGP = cat(2,IterGP1,IterGP2);
    GOrb(:,:,i) = IterGP;
end

toc
%Discard Transients
GOrb = GOrb(:,:,clrtrns+1:clrtrns+t);


%Make figures
%1 Sampling
fig1 = figure(1); clf(fig1); hold on;
plot(Pinit(:,1),Pinit(:,2),'b*')
plot(P(:,1),P(:,2),'g*')
plot(Q(:,1),Q(:,2),'y*')

%2 Iterates
fig2 = figure(2); clf(fig2); hold on;
plot(Pinit(:,1),Pinit(:,2),'b*')
for j=1:t
GPtt = reshape(GOrb(:,:,j),[Ttt,d2]);
plot(GPtt(:,1),GPtt(:,2),'r*')
end
plot(Ptt(:,1),Ptt(:,2),'k*')

%Full
fig3 = figure(3); clf(fig3); hold on;
plot(Pinit(:,1),Pinit(:,2),'b*')
for j=1:t
GPtt = reshape(GOrb(:,:,j),[Ttt,d2]);
plot(GPtt(:,1),GPtt(:,2),'r*')
end
plot(Ptt(:,1),Ptt(:,2),'k*')
plot(P(:,1),P(:,2),'g*')
plot(Q(:,1),Q(:,2),'y*')