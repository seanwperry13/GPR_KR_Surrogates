function [KRPtt]=MultiExpKern(P,Q,Band,Ptt)


DimP=size(P);
DimQ=size(Q);
DimPtt=size(Ptt);

if DimP(1)~=DimQ(1) || DimP(2)~=DimQ(2)
    error('Dimension mismatch in P,Q');
end

if DimP(2)~=DimPtt(2)
    error('Dimension mismatch between training/bandwidth/testing sets')
end

KRPtt=zeros(DimPtt(1),DimP(2));
for i=1:DimPtt(1)
Gsum=0;
Z=zeros(1,DimP(2));
    for j=1:DimP(1)
    %Gaussian Product Kernel Exponential term
    E=0;
        for l=1:DimP(2)
            u=(Ptt(i,l)-P(j,l))/Band(l);
            E=E+u^2/2;
        end
        %Exponential kernel    
     Gsum=Gsum+exp(-E);
     Z=Z+Q(j,:).*exp(-E);
    end    
    if Gsum==0
        Z=0;
    else
        Z=Z./Gsum; 
    end    
    KRPtt(i,:)=Z;
end
