function xd = waverec2(cxd,l,w);
rmax = size(l,1);
nmax = rmax-2;
[Lo_R,Hi_R] = wfilters(w,'r');

% Initialization.
nl = l(1,1);
nc = l(1,2);
xd = zeros(nl,nc);
xd(:) = cxd_r(1:nl*nc);

% Iterated reconstruction.
rm = rmax+1;
for p=nmax:-1:1
k = size(l,1)-p;
first = l(1,1)*l(1,2)+3*sum(l(2:k-1,1).*l(2:k-1,2))+1;
add = l(k,1)*l(k,2);
last = first+add-1;
h = reshape(cxd_r(first:last),l(k,:));
first = first+add; last = first+add-1;
v = reshape(cxd_r(first:last),l(k,:));
first = first+add; last = first+add-1;
d = reshape(cxd_r(first:last),l(k,:));
xd = idwt2(xd,h,v,d,Lo_R,Hi_R,l(rm-p,:));
end

figure(2),image(xd)
title('Compressed Image - Global Threshold = 20')
colormap(map)