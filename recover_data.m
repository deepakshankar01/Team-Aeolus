function recov = recover_data (string1, data_length1, compressed1, padding1, data1,length_quant1)
%---------variables----------------
% string1 : set of all different codes corresponding to different probability
% data1 : all symbols whose codes are given
% recov : recovered symbols in the sequence that were transmitted after dct & quantization
le = [1]; % number of discrete codes
k = 2;
for x=1:data_length1
ck=1;
w=length(cell2mat(string1(x)));
for jj=1:length(le)
if(le(jj)==w)
ck=0;
end
end
if (ck==1)
le = [le w];
k = k+1;
end
end
if padding1==0
    truncate = 0;
else
    truncate=40-padding1;
end
str=0;
reci=1;
recov=zeros(1,length_quant1);
while(str<(length(compressed1)-truncate)) % notice :- '-40+pdg' to compensate padding
[number, position] = recover_num (str, string1, compressed1, data1, le, data_length1); % le is number of discrete codes
% calling a function which recovers single symbol at a time, one after the other
recov(reci)=number;
str=position;
reci=reci+1;
end
Recovering_compressed_string = 0;
recov;
function [number, position] =...
    recover_num(st1,stri,compressed2,data2,le2,data_length2)
%--------"number" is the one recovered symbol with its last bit's "position"---
number=[];
if compressed2(st1+1)==cell2mat(stri(1))
number=data2(1);
position=st1+length(cell2mat(stri(1)));
Recovering_compressed_string = length(compressed2)-position + 1;
return
else
for c=2:length(le2)
v=compressed2((1+st1):(le2(c)+st1));
for h=1:data_length2
if(length(cell2mat(stri(h)))==length(v))
    if(cell2mat(stri(h))==v)
    number=data2(h);
    position=st1+length(cell2mat(stri(h)));
    Recovering_compressed_string = length(compressed2)-position + 1;
    return
    end
end
end
if(c==length(le2))
    error('Data too much corrupted to be decoded')
end
end
end