cfunction [I]=DeclumpI(P,T)
%Returns Indecies to delete to declump P

Tp=size(P,1);
N=Tp-T;
J=zeros(N,2);
for n=1:N
    [D,~]=pdist2(P,P,'euclidean','Smallest',2);
    D=D(2,:);
    del=find(D==min(D));
    J(n,1)=del(1);
    c=0;
    for i=n-1:-1:1
        if J(i,1)<=del(1)+c
            c=c+1;
        end
    end
    P(del(1),:)=[];
    J(n,2)=del(1)+c;
end


I=J(:,2);