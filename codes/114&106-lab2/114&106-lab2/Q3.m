clear all;
clc;
total_time = 1;                       
init_n = 1;
dt = 1e-4;
niter = total_time/dt;
a = 10;
b = 3;

N = zeros(niter,1);
N_exact = zeros(niter , 1);

time = zeros(niter,1);

N(1) = init_n;
N_exact(1) = init_n;
time(1) = 0;

 

for step = 1 : niter-1 
    N(step + 1) = N(step) +  (a*N(step) - b*N(step)*N(step))*dt ;
    time(step + 1) = time(step) + dt;
    N_exact(step + 1) = (a * init_n) / ((b * init_n) + (a - b *init_n) * exp(-1* a * time(step + 1)));
end

figure(1);
plot(time,N , 'b+' , time , N_exact , 'r')      %computational result - blue and exact result - red
xlabel('time')
ylabel('population')
% bug found --if we calculate the N_exact function directly by 
% this command     N_exact = (a * init_n) / ((b * init_n) + (a - b *init_n)* exp(-1* a * time))
% we don't get the correct result  
