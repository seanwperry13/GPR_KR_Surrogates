function [GPPtt, Errors] = GPErrors(P,Q,Ptt,Qtt)


%Determines the errors using a gaussian regression model based on P 
%mapping to Q and uses the model to evaluate a testing set of Ptt mapping to Qtt
%P, Q =: the training set for the kernel (must be D by N array)
%Ptt, Qtt =: the testing set for the error (must be D' by N array)



%Check and record pertinent dimensions
DimP=size(P);
DimQ=size(Q);
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

G1 = fitrgp(P,Q(:,1));
GPPtt = predict(G1,Ptt);
if DimP(2) > 1
    for i=2:DimP(2)
        G2 = fitrgp(P,Q(:,i));
        GPPtt2 = predict(G2,Ptt);
        GPPtt = cat(2,GPPtt,GPPtt2);
    end
end

Errors = minus(Qtt,GPPtt);