clear all;
total_time=300; % length of simulation
init_vel=0;
dt=.1;
niter=total_time/dt;

time=zeros(niter,1);
speed=zeros(niter,1);
speedr=zeros(niter,1);

time(1)=0;
speed(1)=init_vel;
speedr(1)=init_vel;

mass=75;
power=400;

constant_force = power / 5 ;          % force for low velocities. 5m/s is taken to be the cross over 
constant=.5;
density=1.225;
area=.33;

for step=1:niter-1
speed(step+1)=speed(step)+power*dt/(mass*speed(step));
%if(speedr(step)>5)
    speedr(step+1)=speedr(step)+power*dt/(mass*speedr(step))-dt*constant*density*area*speedr(step)*speedr(step)/(mass)
%else
 %   speedr(step+1)=speedr(step)+constant_force*dt/(mass);
%end
time(step+1)=time(step)+dt;
end


plot(time,speedr, 'b+')
xlabel ('time')
ylabel('velocity')
