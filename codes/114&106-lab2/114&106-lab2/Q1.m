clear all;
clc;
total_time = 100;
init_x = 0;
dt = 0.001;                           % time step 
niter = total_time/dt;
vel = 50;                          

x = zeros(niter,1);                   % x is array for storing computational result
x_exact = zeros(niter,1);             % x_exact is array for storing exact result

time = zeros(niter,1);

%initialisation
x(1) = init_x;
x_exact(1) = init_x;
time(1) = 0;

 

for step = 1 : niter-1 
    x(step + 1) = x(step) + vel*dt;
    time(step + 1) = time(step) + dt;
end

x_exact = 50 .* time;           % exact result 

figure(1);
plot(time,x , 'b+', time, x_exact, 'r')          
ylabel('displacement')
xlabel('time')