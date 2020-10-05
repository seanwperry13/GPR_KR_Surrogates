%data is two 2xn arrays, points in a time series and their successors  

load PKSlong.dat;
load QKSlong.dat;

d1=size(PKSlong,1);
d2=size(PKSlong,2);




%Size of training set (pre and post-declump)
Tp=2000;
T=1000;

%Size of bandwidth testing set (pre and post-declump)
Ttp=1000;
Tt=500;

%Size of testing set (pre and post-declump)
Tttp=2000;
Ttt=1000;

%Neccessary that d1 > Tp + Ttp +Tttp*A 
tic;

PKS=PKSlong;
QKS=QKSlong;
    
%Random disjoint points for kernel model, bandwidth selection and error testing
    Perm=randperm(d1,Tp+Ttp+Tttp);

    P=zeros(Tp,d2);
    Q=zeros(Tp,d2);
    for i=1:Tp
    for j=1:d2
        P(i,j)=PKS(Perm(1,i),j);
        Q(i,j)=QKS(Perm(1,i),j);
    end
    end

    
    Pt=zeros(Ttp,d2);
    Qt=zeros(Ttp,d2);
    for i=1:Ttp
    for j=1:d2
        Pt(i,j)=PKS(Perm(1,i+Tp),j);
        Qt(i,j)=QKS(Perm(1,i+Tp),j);
    end
    end
    
    
    Ptt=zeros(Tttp,d2);
    Qtt=zeros(Tttp,d2);
    for i=1:Tttp
    for j=1:d2
        Ptt(i,j)=PKS(Perm(1,i+Tp+Ttp),j);
        Qtt(i,j)=QKS(Perm(1,i+Tp+Ttp),j);
    end
    end

%Declump training points
[P,Q]=Declump2(P,Q,T);

%Declump bandwidth testing points
[Pt,Qt]=Declump2(Pt,Qt,Tt);

%Declump testing points
[Ptt,Qtt]=Declump2(Ptt,Qtt,Ttt);
 
%M test bandwiths in a log block around Silverman [-3,1]
M=20;
Band=BandwidthSelector(P,Q,Pt,Qt,M);

%KR surrogate
[KRPtt,KErrors]=KernelErrors(P,Q,Band,Ptt,Qtt);

%GP surrogate
[GPPtt,GErrors]=GPErrors(P,Q,Ptt,Qtt);

KAbsErrors=sort(sum(times(KErrors,KErrors),2));
GAbsErrors=sort(sum(times(GErrors,GErrors),2));


toc;