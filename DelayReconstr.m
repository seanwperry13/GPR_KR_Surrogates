function [DR] = DelayReconstr(TS,dim,lag)
%performs delay reconstruction on a time series
a=length(TS);
q=a-lag*(dim-1); %if N data points  in orig TS, N-q data points in DR

DR=zeros(q,dim);
for i=1:q
    DR(i,:)=TS(i:lag:i+lag*(dim-1));
end
