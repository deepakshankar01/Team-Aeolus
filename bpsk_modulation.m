function modulated1 = bpsk_modulation(encoded1)
%---encoded1 : encoded data which modulates the carrier----
%--- modulated1 : modulated carrier--------
modulated1 = [];
size2 = length(encoded1); % size + 3*(size/4)= 70
n2 = size2/10;
for cnt=1:n2
for x = 1:10
b(x) = encoded1((cnt-1)*10 + x);
end
T1 = 1; %sinewave of Time Period T1
x1 = linspace(0,10*(T1),100); %sine period with 10 periods, 10 points per period
y1 = sin(((2*pi)/T1)*x1);
y = [];
for i = 1:10
t = 0.01 : 0.1 : 1 ; % T(bit)= T(carrier)
y2 = b(i)*((1+(square(2*pi*0.5*t)))/2) ; % square wave with a period of 2, 0.5 Hz
y = [y y2];
end
y = 2*(y-(1/2));
t = 0.01:0.1:1;
%---------------MODULATION-------------------
t = 0.01:0.1:1;
vm = [];
vm = y.*y1;
modulated1 = [modulated1 vm];
end