function encoded1 = ch_encoding(comp2)
% comp2 : compressed data whose encoding is to be done
% encoded1 : encoded data of the compressed data
size1=length(comp2);
n1=size1/4;
encoded1=[];
for cnt=1:n1
for x=1:4
di(x)=comp2((cnt-1)*4 + x);
end
G=[1 0 0 0 1 1 1;
0 1 0 0 1 1 0;
0 0 1 0 1 0 1;
0 0 0 1 0 1 1];
for j=1:7
ci(j)=0;
for i=1:4
ci(j)=xor ((di(i)*G(i,j)),ci(j)) ;
end
end;
ci;
encoded1=[encoded1 ci];
end