%% 1. a)

%f(W_EE*s+s_in) = r_zero + r_max*(S^x/(S^x+sigma^x)) if S>0
%else =r_zero is S<=0

D = 1; %depression variable
alpha_zero = 0.5;
W_EE = 8;
pr = 1;
tau_s = 2;
x = 1.2;
r_zero = 0.1;
r_max = 100;
sigma = 0.5;
tau_r = 10;

%%

s = 0:0.005:1/W_EE;
r = 0:4:100;

% s from 0 to 1/W_EE => plot f(W_EE*s)

%firing rate as a function of synaptic conductance and excitatory feedback(fixed)and in the absence of input
for i=1:length(s)
    fs(i) = r_zero + r_max*((W_EE*s(i))^x/((W_EE*s(i))^x+sigma^x));
end

for i=1:length(r)
    sr(i) = alpha_zero*D*pr*r(i)*tau_s/(1+alpha_zero*D*pr*r(i)*tau_s);
end

plot(W_EE*s, fs);
hold on
plot(sr, r);

%% ODEs

t0 = 0;
tmax = 20;
dt = 0.001;
tvec = t0:dt:tmax;
r = zeros(size(tvec));
s = zeros(size(tvec));
s_in = zeros(size(tvec));
s_in(10/dt:(10/dt+50*10^(-3)/dt)) = 0.05;

firing_rate_function = @(W_EE, s, s_in) r_zero + r_max*((W_EE*s+s_in)^x/((W_EE*s+s_in)^x+sigma^x));

for i = 2:length(tvec)
    drdt = (-r(i-1) + firing_rate_function(W_EE, s(i-1), s_in(i)))/tau_r;
    dsdt = -s(i-1)/tau_s + alpha_zero*D*pr*r(i-1)*(1-s(i-1));
    r(i) = r(i-1) + drdt*dt;
    s(i) = s(i-1) + dsdt*dt;
end

plot(r)
figure(2)
plot(s,r)









