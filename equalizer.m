function equalized1 = equalizer(modulated2,filter_cf,snr)
%------modulated 2 : modulated data which is to be passed through channel--
%-----channel is an FIR filter with filter coefficients given by "filter_cf"
%-----equalized1 : data after passing through filter & its' equalizer----
equalized1=[];
size3=length(modulated2);
n3=size3/5;
for cnt=1:n3
cnt;
a=[];
rv=[];
for x=1:5
a(x)=modulated2((cnt-1)*5 + x);
end
%------- ADDITION OF NOISE---------
s = cov(a);
n = s/(10^((snr)));
amp = sqrt(n/2);
noise= amp*randn(1,5);
a=a+noise;
for r=1:3
a=[a a];
end
Rk=filter(filter_cf,1,a); % Received Signal
if cnt<10
beta=0.1;% step Size of the algorithm
else
beta=0.25;
end
c=zeros(5,1); % equalizer coefficients
for i=1:length(Rk)-4,
rk=flipud(Rk(i:i+4).'); % received Signal Vector
Error(i)=a(i)-c.'*rk; % Error signal, we assume a known symbol sequence
c=c+beta*Error(i)*rk; % LMS update
end
for i=31:length(Rk)-5,
rk=flipud(Rk(i:i+4).'); % received Signal Vector
Error(i)=a(i)-c.'*rk; % Error signal, we assume a known symbol sequence
rv(i-30)=c.'*rk;
end
equalized1=[equalized1 rv];
end