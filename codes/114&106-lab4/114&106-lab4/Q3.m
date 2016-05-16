clear all;
close all;

global q m qom g;
global Bx By Bz;
global base_point_x_coordinate ;
global measurement_point_time ;

base_point_x_coordinate = 0;
measurement_point_time = 1;
q = -1.6e-19;      
m = 9.1e-31;

g=9.8;
qom = (q/m) ; 

Bx = 0;
By = 0;
Bz = 5e-5;

temp = 1000 ; %in kelvin
k = 1.38e-23 ; 

initial_vel = sqrt(k*temp/m);

starttime = 0;
totaltime = 1e-4;
dt = (totaltime-starttime) / 10000;
npoints = totaltime/dt

u0 = zeros (6 , 1);

u0(1) = 0 ;          %x
u0(2) = 0 ;          %y
u0(3) = 0 ;          %z

u0(4) = initial_vel ;          %vx
u0(5) = 0 ;          %vy
u0(6) = 0 ;          %vz

tic
options=odeset('RelTol',1e-13);
[t,u] = ode45(@Q3Function , [starttime : dt : totaltime] , u0, options) ; 

% u contains the position vectors and the velocity vectors at each point.

index = 1;

% now let us find the drift velocity.- its in the -ve x-direction

%{
while index<=npoints
   if(u(index,2) < 1e-11) 
        base_point_x_coordinate = u(index , 1);
        measurement_point_index = index ; 
   end
   index = index + 1;
end
%}

toc

base_point_x_coordinate

drift_velocity = base_point_x_coordinate / measurement_point_time


%drift_velocity = u(length(t),1)/t(length(t))

plot3( u(:,1) , u(:,2) , u(:,3) )
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');
title('electron released with velocity perpendicular to B')
