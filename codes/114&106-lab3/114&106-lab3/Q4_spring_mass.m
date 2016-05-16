clear all;
close all;
k = 1; % spring constant
mass = 1 ;
timescale=2*pi*sqrt(mass/k);
initial_disp = 10;
initial_vel = 0;

dt=timescale/1000;
simulationt=10*timescale;
npoints=round(simulationt/dt);

displacement=zeros(npoints,1);
velocity=zeros(npoints,1);
time=zeros(npoints,1);

displacement(1) = initial_disp;
velocity(1) = initial_vel;

for step=1:npoints-1
velocity(step+1)=velocity(step)-(k/mass)*displacement(step)*dt;
displacement(step+1)=displacement(step)+velocity(step)*dt;
time(step+1)=time(step)+dt;
end

plot(time,displacement)
xlabel('time in s')
ylabel('displacement in m/s')
grid on;
figure
plot(time,velocity)
xlabel('time in s')
ylabel('velocity in m/s')
grid on;
figure
plot(displacement ,velocity)
xlabel('displacement in m')
ylabel('velocity in m/s')
grid on;
