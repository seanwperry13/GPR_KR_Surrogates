function [KRPtt,Errors]=KernelErrors(P,Q,Band,Ptt,Qtt)

%Determines the errors using a exponential product kernel based on P 
%mapping to  Q with bandwith Band to evaluate a testing set of Ptt mapping  to Qtt
%P, Q =: the training set for the kernel (must be N by D array)
%Band =: bandwidth for the kernel in each dimension (must be 1 by D)
%Ptt, Qtt =: the testing set for the error (must be M by D array)

%Check and record pertinent dimensions
DimP=size(P);
DimQ=size(Q);
DimB=size(Band);
DimPtt=size(Ptt);
DimQtt=size(Qtt);

if DimP(1)~=DimQ(1) || DimP(2)~=DimQ(2)
    error('Dimension mismatch in P,Q');
end
if DimPtt(1)~=DimQtt(1) || DimPtt(2)~=DimQtt(2)
    error('Dimension mismatch in Ptt,Qtt');
end
if DimP(2)~=DimPtt(2)
    error('Dimension mismatch between training/testing sets')
end
if DimB(2)~=DimPtt(2)
    error('Dimension mismatch between bandwidth and training/testing sets')
end




Errors=zeros(DimPtt(1),DimP(2));
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
    Errors(i,:)=Qtt(i,:)-KRPtt(i,:); 
end

  
  