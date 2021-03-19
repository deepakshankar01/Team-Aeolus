function demodulated1 = bpsk_demodulation(equalized2)
%---equalized : equalized data to be demodulated---
%----demodulated1 : demodulated data--------
demodulated1 = [];
size4 = length(equalized2);
n4 = size4/100;
for cnt = 1:n4
for x = 1:100
v(x) = equalized2((cnt-1)*100 + x);
end
T1 = 1; %sinewave of Time Period To
x1 = linspace(0,10*(T1),100); %sine period with 10 periods, 25 points per period
y1 = sin(((2*pi)/T1)*x1);
f = [];
f = v.*y1;
Tb = 1;
n = 100;
h = Tb/n;
for k = 1:10
s1 = 0;
s2 = 0;
for i = (10*(k-1))+1 : k*10
if mod(i,3)==0
    s1 = s1+f(i);
else
    s2 = s2+f(i)-f(k*10);
end
end
vdm(k*Tb) = 3*h/8*(f(k*10)+3*(s2)+2*(s1));
end
vdm = 2*vdm;
vdmb = [];
for i = 1:10
if vdm(i)<0
    vdmb(i)=0;
else
vdmb(i) = 1;
end
end
demodulated1=[demodulated1, vdmb];
end