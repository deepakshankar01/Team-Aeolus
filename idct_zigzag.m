function image_recov = idct_zigzag(string,diag1,max,min,...
    High,Ro,Co,Do,block_size2,row,column,dim)
%------image_recov : Recovered Image-------------%
h=0;
for di = 1:Do
cell_block = cell(Ro/block_size2,Co/block_size2);
for i1 = 1:(Ro/block_size2)
for j1 = 1:(Co/block_size2)
R1 = zeros(block_size2,block_size2);
ru = [];
r = [];
ru = string((1+(block_size2*block_size2)*h):(block_size2*block_size2)*(h+1));
r = ru*((max(i1,j1,di)-min(i1,j1,di))/High)+ min(i1,j1,di);

if block_size2==16
    c =[1 1;2 3;4 6;7 10;11 15;16 21;22 28;29 36;37 45;46 55;56 66;67 78;79 91;92 105;106 120;121 136;137 151;152 165;166 178;179 190;191 201;202 211;212 220;221 228;229 235;236 241;242 246;247 250;251 253;254 255;256 256];
end

if block_size2==8
    c =[1 1;2 3;4 6;7 10;11 15;16 21;22 28;29 36;37 43;44 49;50 54;55 58;59 61;62 63;64 64];
end

if block_size2==4
    c=[1 1;2 3;4 6;7 10;11 13;14 15;16 16];
end

if block_size2==2
    c=[1 1;2 3;4 4];
end

for k=1:diag1
if mod(k,2)==0
    R1 = R1+diag(r(c(k,1):c(k,2)),k-block_size2);
else
    R1=R1+diag(fliplr(r(c(k,1):c(k,2))),k-block_size2);
end
end

R0 = fliplr(R1');
Rtrd = R0';
Rtrdi = idct(Rtrd);
cell_block(i1,j1)={Rtrdi};
h=h+1;
end
end
y1(:,:,di)=cell2mat(cell_block);
end
image_recov = y1(1:row,1:column,1:dim);