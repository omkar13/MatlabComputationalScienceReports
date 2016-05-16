% this script is used to computationally observe the damped oscillator and
% its 3 different cases of underdamped, critically damped and over damped.


clear all;
close all;

global C mass l g beta;

g=9.8;
l=9.8; % so that g/l is 1

timescale=2*pi*sqrt(l/g);

mass = 0.1;

%C = 0.05 % C is the drag constant Fdamp = C*length*omega 

dt=timescale/1000;
simulationt=10*timescale;
start_time = 0;

%{
npoints=round(simulationt/dt);
 
theta=zeros(npoints,1);
omega=zeros(npoints,1);
time=zeros(npoints,1);
 %}

theta_degrees_initial = 0.5*180/pi; %given 0.5 radians
omega_initial = 0.3;
%theta_degrees = 10 ;        
%theta(1)= theta_degrees * pi / 180;
 
%using ode solver
%give initial conditions
u0 = zeros(2,1);
u0(1) = theta_degrees_initial*pi/180;
u0(2) = omega_initial;

C = 0.2;
beta = C/(2*mass);
%for positive angular velocity 
[t,u] = ode45(@dampingFunction , [start_time : dt : simulationt] , u0); 

theta1=u(:,1)*180/pi;
omega1 = u(:,2);

%C = 0.02;
%beta = C/(2*mass);
%for zero angular velocity
u0(2) = 0;
[t,u] = ode45(@dampingFunction , [start_time : dt : simulationt] , u0); 

theta2=u(:,1)*180/pi;
omega2 = u(:,2);

%C = 1;
%beta = C/(2*mass);
%for negative angular velocity
u0(2) = -0.9;
[t,u] = ode45(@dampingFunction , [start_time : dt : simulationt] , u0);

theta3=u(:,1)*180/pi;
omega3 = u(:,2);

plot(t,theta1,'g',t,theta2,'r',t,theta3,'b')
xlabel('time')
ylabel('theta in degrees')
grid on;
figure
plot(t,omega1,'g',t,omega2,'r',t,omega3,'b')
xlabel('time')
ylabel('angular velocity')
grid on;
figure
plot(theta1,omega1,'g',theta2,omega2,'r',theta3 ,omega3 , 'b+')
xlabel('theta')
ylabel('angular velocity')
grid on;