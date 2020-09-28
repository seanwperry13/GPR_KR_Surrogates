function [P]=Declump1(P,T)
%Declump array longer than T down to T data points
Tp=size(P,1);

N=Tp-T;

for j=1:N
    [D,~]=pdist2(P,P,'euclidean','Smallest',2); 
    D=D(2,:);
    I=find(D==min(D));
    P(I(1),:)=[];
end

