%the loop is set for plotting amplitude vs frequency . now we need to calculate amplitude for each frequency and plot 

clear all;
close all;

global C mass l g beta Fd driver_angular_freq max_ampl driver_time_period simulationt;


g=9.8;
l=9.8; % so that g/l is 1
%natural angular_frequency is 1. We will run the code for driving_freq = 0
%to 5.

timescale=2*pi*sqrt(l/g);

mass = 0.1;

%we will be considering only the underdamped case.
C = 0.02 % C is the drag constant Fdamp = C*length*omega 
beta = C/(2*mass);
Fd = 1.5 % this is the driving force

driver_angular_freq = 1; % its the angular frequency
 
dt=timescale/100;
simulationt=50*timescale;
start_time = 0;

%{
npoints=round(simulationt/dt);
 
theta=zeros(npoints,1);
omega=zeros(npoints,1);
time=zeros(npoints,1);
 %}

theta_degrees_initial = 0.5*180/pi; %given 0.5 radians
omega_initial = 0;
%theta_degrees = 10 ;        
%theta(1)= theta_degrees * pi / 180;
 
%for step=1:npoints-1
%omega(step+1)=omega(step)-(g/length)*theta(step)*dt;
%theta(step+1)=theta(step)+omega(step +1)*dt;
%time(step+1)=time(step)+dt;
%end
 
%the following code is for simulating damp driven system
%{
for step=1:npoints-1
omega( step + 1) = omega (step) - (g/length)*sin(theta(step))*dt - (C/mass)*omega(step)*dt + (Fd/(mass*length))*sin(driver_freq*time(step))*dt;
theta(step+1)=theta(step)+omega(step + 1)*dt;
 57.5*theta
if theta(step + 1) > pi
       theta (step +1) = theta (step +1) - 2*pi;
elseif theta(step + 1) < -pi       
        theta (step +1) = theta (step +1) + 2*pi;
end
 
time(step+1)=time(step)+dt;
end
%} 

%using ode solver
%give initial conditions
u0 = zeros(2,1);
u0(1) = theta_degrees_initial*pi/180;
u0(2) = omega_initial;

%{
C = 0.2;
beta = C/(2*mass);
%for critical damping 
[t,u] = ode45(@damp_driven_function , [start_time : dt : simulationt] , u0); 

theta1=u(:,1)*180/pi;
omega1 = u(:,2);
%}
start_freq = 0.1;
end_freq = 5;
incremental_freq = 0.01;

frequency_array = start_freq : incremental_freq : end_freq ; 
amplitude_array = zeros(length(frequency_array));
index = 1;


for driver_angular_freq = start_freq : incremental_freq : end_freq    
    
    max_ampl = 0;
    driver_time_period = 2*pi / driver_angular_freq;
    
    %explain this step 
    simulationt = -48.979*driver_angular_freq + 304.897;                % for optimising the simulation time
    %for under damping
    [t,u] = ode45(@damp_driven_function , [start_time : dt : simulationt] , u0); 
    amplitude_array(index) = max_ampl;
    index = index + 1;
    %theta2=u(:,1)*180/pi;
    omega2 = u(:,2);
end
%{
C = 1;
beta = C/(2*mass);
%for over damping
[t,u] = ode45(@damp_driven_function , [start_time : dt : simulationt] , u0);

theta3=u(:,1)*180/pi;
omega3 = u(:,2);
%}

%{
plot(t,theta1,'g',t,theta2,'r',t,theta3,'b')
plot(t, theta2)
xlabel('time')
ylabel('theta in degrees')
grid on;
figure
%plot(t,omega1,'g',t,omega2,'r',t,omega3,'b')
plot(t,omega2)
xlabel('time')
ylabel('angular velocity')
grid on;
figure
%plot(theta1,omega1,'g',theta2,omega2,'r',theta3 ,omega3 , 'b')
plot(theta2, omega2)
xlabel('theta')
ylabel('angular velocity')
grid on;
%}

plot(frequency_array , amplitude_array);
xlabel('frequency of driving force')
ylabel('amplitude of oscillations')
title('observation of resonance phenomena')
%figure()
%plot(t , omega2 )