clear all;
close all;

global g R constant xvel_wind yvel_wind;
g = 9.8;
R = 6400e3;
dt=.01;
initial_x_pos = 0;
initial_y_pos =0;
initv=750;
xvel_wind = 10 ;
yvel_wind = 0 ;

constant=4e-5;

g=9.8;

thetadegree=45;
theta=.0174*thetadegree;

% time given so that projectile reaches ground
totaltime= 2*initv*sin(theta)/g;
starttime = 0;

%{
for step=2:npoints
x(step)=x(step-1)+vx*dt;
y(step)=y(step-1)+vy*dt;
drag=constant*sqrt(vx*vx+vy*vy);
vx=vx-drag*vx*dt;
vy=vy-drag*vy*dt-g*dt;
if(y(step)<=0)
break
end
end
%}

%ux0 should contain initial conditions for x and vx
u0 = zeros(4,1);
u0(1) = initial_x_pos; 
u0(2) = initv*cos(theta);
u0(3) = initial_y_pos; 
u0(4) = initv*sin(theta);

[t,u]=ode45(@odeFunctionQ3d , [starttime:dt:totaltime] , u0);

x = u (: , 1);
y = u (: , 3);

% now we will calculate exact solutions

%{
x_exact = initv * cos(theta) .*t;
y_exact = initv * sin(theta).* t - 0.5 * g .* t .* t; 
%}

plot(x,y, 'g') %, x_exact,y_exact , 'r')
xlabel('x -->')
ylabel('y -->')
title('Ideal case without considering effect of air drag and air density - computationally-black  and exact - green')

