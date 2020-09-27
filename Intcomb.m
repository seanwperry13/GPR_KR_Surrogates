function I=Intcomb(M,N)
%integer combinations of M things in N sized groups with repitition 
%Useful for indexing

I=ones(M^N,N);
i=2;
j=N;
while j>0 && i<=M^N
    if I(i-1,j)==M
       I(i,j)=1;
       j=j-1;
    else
       I(i,j)=I(i-1,j)+1;          
       i=i+1;
       j=N;
       if i<=M^N
           I(i,:)=I(i-1,:); 
       end
    end
end