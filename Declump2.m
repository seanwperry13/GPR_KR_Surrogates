function [P,Q]=Declump2(P,Q,T)
%Declump two matched arrays longer than T down to T data points
%Clumpiest parts of P and coressponding parts of Q are removed
Tp=size(P,1);

N=Tp-T;
for j=1:N
    [D,~]=pdist2(P,P,'euclidean','Smallest',2); 
    D=D(2,:);
    I=find(D==min(D));
    P(I(1),:)=[];
    Q(I(1),:)=[];
end


%function [P,Q]=Declump2(P,Q,T)
%Declump two matched arrays longer than T down to T data points
%Tp=size(P,1);

%N=Tp-T;
%for j=1:N
%    [D,DI]=pdist2(P,P,'euclidean','Smallest',2); 
%    D=D(2,:);
%    DI=DI(2,:);
%    I=find(D==min(D));
%    J=find([1:size(P,1)]'~=DI(I(1)));
%    P=P(J,:);
%    Q=Q(J,:);
%end
