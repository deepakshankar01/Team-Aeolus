function [xc,cxc,lxc,perf0] = wdencmp(o,varargin)
% Get Inputs
w = varargin{indarg};
n = varargin{indarg+1};
thr = varargin{indarg+2};
sorh = varargin{indarg+3};
if (o=='gbl') , keepapp = varargin{indarg+4}; 
end
% Wavelet decomposition of x
[c,l] = wavedec2(x,n,w);
% Wavelet coefficients thresholding.
if keepapp
% keep approximation.
cxc = c;
if dim == 1, inddet = l(1)+1:length(c);
else, inddet = prod(l(1,:))+1:length(c); 
end
% threshold detail coefficients.
cxc(inddet) = c(inddet).*(abs(c(inddet)>thr)); % hard thresholding
else
% threshold all coefficients.
cxc = c.*(abs(c)>thr); % hard thresholding
end
lxc = l;
% Wavelet reconstruction of xd.
if dim == 1,xc = waverec(cxc,lxc,w);
else xc = waverec2(cxc,lxc,w);
end
% Compute compression score.
perf0 = 100*(length(find(cxc==0))/length(cxc));