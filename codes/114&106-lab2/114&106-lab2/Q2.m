clear all;
clc;
total_time = 100;
init_v = 100;
dt = 0.01;
niter = total_time/dt;
a = 10;
b =1;

vel = zeros(niter,1);
v_exact = zeros(niter,1);

time = zeros(niter,1);

vel(1) = init_v;
v_exact(1) = init_v;
time(1) = 0;

 

for step = 1 : niter-1 
    vel(step + 1) = vel(step) * (1 - b*dt) + a*dt;
    time(step + 1) = time(step) + dt;
    
    if(v_exact(step) > 10)
        v_exact(step + 1) = 10 + 90 * exp(-time(step));
    else
        v_exact(step + 1) = 10 - 90 * exp(-time(step));
    end    
    
end



figure(1);
plot(time,vel)      %computational result
 figure(2);
 plot(time, v_exact)
