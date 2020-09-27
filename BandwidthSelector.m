function [Band]=BandwidthSelector(P,Q,Pt,Qt,M)
%Determines best bandwidth for an exponential product kernel (diagonal
%bandwidth)

%P, Q =: the training set for the kernel (must be D by N array)
%Pt, Qt =: the testing set for the bandwidth vector (must be D' by N array)
%M =: Number of bandwidths to check in each dimension

%**** Requires function Intcomb *****

%Check and record pertinent dimensions
DimP=size(P);
DimQ=size(Q);
if DimP(1)~=DimQ(1) || DimP(2)~=DimQ(2)
    error('Dimension mismatch in P,Q');
end

DimPt=size(Pt);
DimQt=size(Qt);
if DimPt(1)~=DimQt(1) || DimPt(2)~=DimQt(2)
    error('Dimension mismatch in Pt,Qt');
end

if DimP(2)~=DimPt(2)
    error('Dimension mismatch between training/bandwidth/testing sets')
end

%Bandwidth vector
Band=zeros(1,DimP(2));    

%Evaluate Mean Square Error of the KR for M by DimP(2) block of bandwidths,
%logarithmically spaced, from 10^-3 to 10^1 times the Silverman bandwidth.
%Silverman rule-of-thumb bandwidth

s = std(P);
S = s*(4/((DimP(2)+2)*DimP(1)))^(1/(DimP(2)+4));

ls = logspace(-3,1,M);
BandSelection = S.'*ls;

BandIndex=Intcomb(M,DimP(2));

BandMSElog=zeros(1,M^DimP(2));
TestBand=zeros(1,DimP(2));
for h=1:M^DimP(2)
%Select Test Bandwidth
    for i=1:DimP(2)
        TestBand(1,i)=BandSelection(i,BandIndex(h,i));
    end
    
%Create KR for each bandwidth
KRtestPt=zeros(DimPt(1),DimP(2));
for j=1:DimPt(1)
        Gsum=0;
        Z=zeros(1,DimP(2));
        for k=1:DimP(1)
        %Gaussian Product Kernel Exponential term
            E=0;
            for l=1:DimP(2)
                u=(Pt(j,l)-P(k,l))/TestBand(l);
                E=E+u^2/2;
            end
        %Exponential kernel    
        Gsum=Gsum+exp(-E);
        Z=Z+Q(k,:).*exp(-E);
        end
        if Gsum==0
            Z=0;
        else
            Z=Z./Gsum; 
        end             
        KRtestPt(j,:)=Z;   
end

%Calculate cumulative square errors
cSE=0;
for j=1:DimPt(1)
for k=1:DimP(2)
    cSE=cSE+(Qt(j,k)-KRtestPt(j,k))^2;
end
end

%Calculate mean square errors
MSE=cSE/DimPt(1);
BandMSElog(h)=MSE;
end

%Determine min MSE and corresponding bandwidths
[~,I]=min(BandMSElog);

for i=1:DimP(2)
    Band(i)=BandSelection(i,BandIndex(I,i));
end
