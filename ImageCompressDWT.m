X=imread...
('E:\Projects\Defence Serv. Hackathon\ImageProcessingCodes/TankPlatoonHDImage.jpg');
x = rgb2gray(X);
img = x;
figure(3)
imshow(x)
map = colormap;
figure (1)
image(x)
title('ColourMapped Image')
colormap(map)

n = 7; % Decomposition Level
w = 'sym8'; % Near symmetric wavelet
[Lo_D,Hi_D] = wfilters(w,'d');

% Initialization.
a = x;
l = [size(a)];
c = [];

for i = 1:n
[a,h,v,d] = dwt2(a,Lo_D,Hi_D); % Decomposition -> a is approximation Matrix
c = [h(:)' v(:)' d(:)' c]; % store details
l = [size(a);l]; % store size
end
% Last approximation.
c = [a(:)' c];
l = [size(a);l];
% In this first method, the WDENCMP function performs a compression process
% from the wavelet decomposition structure [c,l] of the image.
thr = 45.5; % Threshold
keepapp = 1; % Approximation coefficients cannot be thresholded

%[cxd,perf0] = compress_dwt(c,l,thr,keepapp);

if (keepapp == 1)
    % keep approximation.
    cxd = c;
    inddet = prod(l(1,:))+1:length(c);
    cxd(inddet) = c(inddet).*(abs(c(inddet))>thr); % threshold detail coefficients.
else
    cxd = c.*(abs(c)>thr); % threshold all coefficients.
end
% Compute compression score.
perf0 = 100*(length(find(cxd==0))/length(cxd));
dwt_compression_score_in_percentage = perf0 % Compression score
dwt_compression_ratio=100/(100-perf0) % Compression ratio