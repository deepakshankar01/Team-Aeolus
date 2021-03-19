function [c,s] = wavedec2(x,n,IN3)
% [C,S] = WAVEDEC2(X,N,'wname') returns the wavelet
% decomposition of the matrix X at level N, using the wavelet named in string 'wname' (see WFILTERS).
% Outputs are the decomposition vector C and the corresponding bookkeeping matrix S.
s = [size(x)];
c = [];

for i=1:n
[x,h,v,d] = dwt2(x,Lo_D,Hi_D); % decomposition
c = [h(:)' v(:)' d(:)' c]; % store details
s = [size(x);s]; % store size
end
% Last approximation.
c = [x(:)' c];
s = [size(x);s];