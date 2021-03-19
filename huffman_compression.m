function [im_compressed, data_length, str_code, data] =...
    huffman_compression (signal,Probability,Ro,Co,Do,High1)
%---------HUFFMAN COMPRESSION--------%
%------signal: Input Sequence whose Huffman Coding is to be done-------
%------im_compressed : Output Huffman's coded data sequence(binary)----
lp = length(Probability);
py=round(1000000*Probability);
pyo = zeros(1,lp);
pyo = (py);
pr = fliplr(sort((pyo)));
bit = zeros(1,length(pr));
for ar=1:High1+1
if pr(ar)==0
    data_length = ar-1;
break;
else data_length = ar;
end
end
pr1 = zeros(1,data_length);
for j=1:data_length
pr1(j) = pr(j);
end
a = data_length;
d = ones(a,a);
for h = 1:a
d(h,1) = h;
end
for e = 1:a
t = [];
ph = zeros(a,a);
for n = 1:length(pr1)
ph(n,:) = pr1(n);
end
i = 0;
for x = 2:a
y = ph((length(pr1)-i),x-1)+ ph((length(pr1)-i-1),x-1);
g = 0;
for j = 1:a
if(g~=1)
if((d(e,x-1)==(length(pr1)-i))||(d(e,x-1)==(length(pr1)-i-1)))
if (y<=(ph(j,x-1)))
ph(j,x)= ph(j,x-1);
else
ph(j,x)=y;
d(e,x)=j;
for k=(j+1):(a-1)
ph(k,x)=ph(k-1,x-1);
end
g=1;
end
else
if (y<=ph(d(e,x-1),x-1))
d(e,x)=d(e,x-1);
else
d(e,x)=d(e,x-1)+1;
end
if (y<=(ph(j,x-1)))
ph(j,x)= ph(j,x-1);
else
ph(j,x)=y;
for k=(j+1):(a-1)
ph(k,x)=ph(k-1,x-1);
end
g=1;
end
end
end
end
i=i+1;
end
end
d;
bit=5*ones(a,a-1);
for x=1:a
j=0;
for i=1:a-1
j=j+1;
if (d(x,i)-(a+1-j))==0
bit(x,i)=0;
else
if (d(x,i)-(a+1-j))==(-1)
bit(x,i)=1;
end
end
end
bit(x,:)=fliplr(bit(x,:));
end
bit;
str_code=cell(a,1);
for i=1:a
h=1;
dt=[];
for j=1:a-1
if(bit(i,j)==0)
dt(h)=0;
h=h+1;
else
if (bit(i,j)==1)
dt(h)=1;
h=h+1;
end
end
end
dt;
str_code(i)=({dt}); %notice { } sign, for conversion to cell type,
end
ph;
xm=[];
for i=1:High1+1
u=0;
for j=0:(High1)
if (round(1000000*Probability(j+1))==round(pr(i)))
len(j+1)=round(Ro*Co*pr(i)/1000000);
u=u+len(j+1);
if(length(find(xm==j))==0)
xm=[xm j];
end
end
end
i=i+u;
end
data=zeros(1,data_length);
for j=1:data_length
data(j)=xm(j);
end
lcomp=0;
tra=signal;
compr=zeros(1,2000000);
for f=1:Ro*Co*Do
for g=1:data_length
if (data(g)==tra(f))
lstrg = length(cell2mat(str_code(g)));
compr(lcomp+1:lcomp+lstrg)=cell2mat(str_code(g));
lcomp=lcomp+lstrg;
forming_compressed_string = lcomp;
break
end
end
end
im_compressed=compr(1:lcomp);