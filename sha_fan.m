function [sf_code, data_length, str_code, data]=sha_fan(signal,Probability,High1)
lp=length(Probability);
pyo=Probability;
pr=fliplr(sort((pyo)));
for ar=1:High1+1
if pr(ar)==0;
data_length=ar-1;
break;
else data_length=ar;
end
end
pr1=zeros(1,data_length);
for j=1:data_length
pr1(j)=pr(j);
end
data_length;
pr1;
code=5*ones(length(pr1),length(pr1)+1);
t=[1 data_length+1];
temp=[];
i=1;
while((length(t)-1)<length(pr1))
if i+1>length(t)
i=1;
end
diff(i)=t(i+1)-t(i)-1;
if diff(i)>0
ss=sum(pr1(t(i):(t(i+1)-1)))/2 ;
for k=t(i):(t(i+1)-1)
if (sum(pr1(t(i):k))<(ss))
else
k;
h=1;
for r=(t(i)):k
while((code(r,h)==0)||(code(r,h)==1))
h=h+1;
end
code(r,h)=0;
end
for rr=k+1:(t(i+1)-1)
code(rr,h)=1;
end
temp=k+1;
break;
end
end
t=[t temp];
t=sort(t);
end
i=i+1;
end
a=length(pr1);
str_code=cell(a,1);
for i=1:a
h=1;
dt=[];
for j=1:a
if(code(i,j)==0)
dt(h)=0;
h=h+1;
else
if (code(i,j)==1)
dt(h)=1;
h=h+1;
end
end
end
dt;
str_code(i)=({dt});
end
xm=[];
for i=1:High1+1
u=0;
for j=0:(High1)
if ((Probability(j+1))==(pr(i)))
len(j+1)=round(length(signal)*pr(i));
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
for f=1:length(tra)
for g=1:data_length
if (data(g)==tra(f))
lstrg=length(cell2mat(str_code(g)));
compr(lcomp+1:lcomp+lstrg)=cell2mat(str_code(g));
lcomp=lcomp+lstrg;
forming_compressed_string = lcomp
break
end
end
end
sf_code=compr(1:lcomp);