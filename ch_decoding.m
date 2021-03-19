function decoded1=ch_decoding(demodulated2)
%---------demodulated2 : demodulated data whose decoding is to be done--
%---------decoded1 : obtained decoded data---------
decoded1=[];
size5=length(demodulated2);
n5=round(size5/7);
for cnt=1:n5
for x=1:7
cd(x)=demodulated2((cnt-1)*7 + x);
end
% ----test for ERROR---
H=[1 1 1 0 1 0 0;
1 1 0 1 0 1 0;
1 0 1 1 0 0 1];
T=H';
for j=1:3
S(j)=0;
for i=1:7
S(j)=xor ((cd(i)*T(i,j)),S(j)) ;
end
end;
S;
e=0;
for i=1:7
if S == T(i,:)
e=i;
end
end
% ------error Correction-----
R=[]; % initialization
for i=1:7
R(i)=cd(i);
end
if e==0
else
for j=1:3
S1(j)=0;
for i=1:7
S1(j)=xor ((cd(i)*T(i,j)),S1(j)) ;
end
end;
S1;
e1=0;
for i=1:7
if S1 == T(i,:)
e1=i;
end
end
if e1==0
R=cd;
else
R(e1)=1-R(e1);
R;
end
end % for "if e==0"
% -----Channel Decoding--------
d=[];
d(1,:)=[0 0 0 0];
d(2,:)=[0 0 0 1];
d(3,:)=[0 0 1 0];
d(4,:)=[0 0 1 1];
d(5,:)=[0 1 0 0];
d(6,:)=[0 1 0 1];
d(7,:)=[0 1 1 0];
d(8,:)=[0 1 1 1];
d(9,:)=[1 0 0 0];
d(10,:)=[1 0 0 1];
d(11,:)=[1 0 1 0];
d(12,:)=[1 0 1 1];
d(13,:)=[1 1 0 0];
d(14,:)=[1 1 0 1];
d(15,:)=[1 1 1 0];
d(16,:)=[1 1 1 1];
G=[1 0 0 0 1 1 0;
0 1 0 0 0 1 1;
0 0 1 0 1 0 1;
0 0 0 1 1 1 1];
for x=1:16
for j=1:7
c1(x,j)=0;
for i=1:4
c1(x,j)=xor ((d(x,i)*G(i,j)),c1(x,j)) ;
end
end;
end
n=0;
for j=1:16
if R==c1(j,:)
n=j;
end
end
n;
c1(n,:);
d(n,:);
decoded1=[decoded1 d(n,:)];
end