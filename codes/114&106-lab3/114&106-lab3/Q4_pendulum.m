clear all;
close all;
g=9.8;
length=9.8;
timescale=2*pi*sqrt(length/g);
mass = 0.1;
C = 0.05 % C is the drag constant Fdamp = C*length*omega 
Fd = 1.5 % this is the driving force
driver_freq = 0.66; % its the angular frequency

dt=timescale/1000;
simulationt=10*timescale;
npoints=round(simulationt/dt);

theta=zeros(npoints,1);
omega=zeros(npoints,1);
time=zeros(npoints,1);

theta_degrees = 10 ;
theta(1)= theta_degrees * pi / 180;

%for step=1:npoints-1
%omega(step+1)=omega(step)-(g/length)*theta(step)*dt;
%theta(step+1)=theta(step)+omega(step +1)*dt;
%time(step+1)=time(step)+dt;
%end

%the following code is for simulating damp driven system
for step=1:npoints-1
omega( step + 1) = omega (step) - (g/length)*sin(theta(step))*dt - (C/mass)*omega(step)*dt + (Fd/(mass*length))*sin(driver_freq*time(step))*dt;
theta(step+1)=theta(step)+omega(step + 1)*dt;

if theta(step + 1) > pi
       theta (step +1) = theta (step +1) - 2*pi;
elseif theta(step + 1) < -pi       
        theta (step +1) = theta (step +1) + 2*pi;
end

time(step+1)=time(step)+dt;
end

theta=57.5*theta;
plot(time,theta)
xlabel('time')
ylabel('theta in degrees')
grid on;
figure
plot(time,omega)
xlabel('time')
ylabel('angular velocity')
grid on;
figure
plot(theta ,omega)
xlabel('theta')
ylabel('angular velocity')
grid on;
