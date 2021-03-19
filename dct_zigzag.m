function [sequence, Highm, maximum, minimum, Ro2, Co2, Do2] =...
dct_zigzag(yimu, Ro1, Co1, Do1, dia, quantization_level1, block_size1)
%----Discrete Cosine Transform - ZigZag Transverse----%
%--------------Variables--------------
% yimu : Image Matrix having size Ro1 Co1 Do1.
% sequence : Output Linear Data Sequence after DCT, Quantization &
% ZigZag Traversing.
% dia : No. of diagonals whose values are considered during ZigZag
% traversing.

%Padding Rows & Columns for Blocks
pad_row = mod(Ro1,block_size1);
pad_col = mod(Co1,block_size1);

if (pad_row~=0 && pad_col~=0)
    yim1=zeros(Ro1+block_size1-pad_row,Co1+block_size1-pad_col,Do1);
end

if (pad_row~=0 && pad_col==0)
    yim1=zeros(Ro1+block_size1-pad_row,Co1,Do1);
end

if (pad_row==0 && pad_col~=0)
    yim1=zeros(Ro1,Co1+block_size1-pad_col,Do1);
end

if (pad_row==0 && pad_col==0)
    yim1=yimu;
end

yim1(1:Ro1,1:Co1,1:Do1) = yimu;
[Ro2, Co2,Do2] = size(yim1);
n1 = Ro2/block_size1;
n2 = Co2/block_size1;
sequence = [];
for dd = 1:Do2
cell_image=mat2cell(yim1(:,:,dd),block_size1*ones(1,n1),block_size1*ones(1,n2));
for i = 1:n1
for j = 1:n2
image_block = []; %#ok<*NASGU>
image_block = cell2mat(cell_image(i,j));
image_block_dct = dct(image_block);

%-----------QUANTIZATION-----------
minimum(i,j,dd) = min(image_block_dct(:)'); %#ok<*UDIM>
maximum(i,j,dd) = max(image_block_dct(:)');
Highm = 2^quantization_level1-1;
image_block_dct = round((image_block_dct-minimum(i,j,dd))*...
    Highm/(maximum(i,j,dd)-minimum(i,j,dd)));
x = image_block_dct;
x1 = fliplr(x');
v = cell(2*block_size1-1,1);
s = 1;
a = -(block_size1-1);
b = block_size1+1;
for k = a:b
d = diag(x1,k);
v(s,1) = {d};
s = s+1;
end
ct = dia;
seq1 = [];

%-----------------ZIGZAG TRAVERSING------------------
for u=1:ct
    if mod((2*block_size1-u),2)== 0
        seq1 = [seq1 (cell2mat(v(2*block_size1-u))')];
    else
        seq1 = [seq1 fliplr(cell2mat(v(2*block_size1-u))')]; %#ok<*AGROW>
    end
end
sequence1 = [seq1 zeros(1,(block_size1*block_size1-length(seq1)))];
sequence =[sequence sequence1];
end
end
end