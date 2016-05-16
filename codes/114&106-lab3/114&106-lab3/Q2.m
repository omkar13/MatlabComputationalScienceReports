clear;close all;

global g theta us uk; 
g = 9.8;
theta = 30 * pi / 180;
us = 0.4;
uk = 0.3;

initial_vel = -10;
initial_pos = 0;

timescale=1;
dt=timescale/100;

% set the initial and final times
tstart=0;
tfinal=10*timescale;

% set the initial conditions in the y0 column vector
u0=zeros(2,1);  
u0(1)=initial_pos; % initial position; 
u0(2)=initial_vel; % initial velocity

    [t,u]=ode45(@odeFunctionQ2,[tstart:dt:tfinal],u0);
    x_exact = (g*sin(theta)/2).*t.*t + initial_vel.*t +  initial_pos - uk*g*cos(theta).*t.*t/2;
    v_exact = g*sin(theta).*t + initial_vel - uk*g*cos(theta).*t;

% store the solution that comes back into x and v arrays
x=u(:,1); 
v=u(:,2);

% plot the position vs. time
plot(t,x,'g')
title('Position vs. Time')
figure;
plot(t,v,'g' )
title('Velocity vs Time')
% make a "phase-space" plot of v vs. x
figure
plot(x,v)
title('Velocity vs position')
