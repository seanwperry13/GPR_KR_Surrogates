function [HD,minMN, minNM]=HaussDist(M,N)

%Calculate Hausdorf distance between two R^x subsets M and N
%M and N must be arrays of dimesion (m,x) and (n,x)

DimM=size(M);
DimN=size(N);
if DimM(2)~=DimN(2) 
    error('Dimension mismatch in M,N');
end

MNDist=pdist2(M,N);

%for each x in M find min of d(x,y) over y in N
minMN=min(MNDist,[],2);

%for each y in N find min of d(x,y) pver x in N
minNM=min(MNDist,[],1);

%max{sup_{x\in M}(inf_{y\in N}(d(x,y))),sup_{y\in N}(inf_{x\in M}(d(x,y)))
HD=max(max(minMN),max(minNM));


