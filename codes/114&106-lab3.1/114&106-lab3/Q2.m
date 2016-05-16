clear;close all;
% declare the pendulam variables to be global and set it
global g;
global theta;
global us;
global uk; 
g = 9.8;
theta = 30 * pi / 180;
us = 0.4;
uk = 0.3;

initial_vel = 0;
initial_pos = 0;

timescale=1;
dt=timescale/100;

% set the initial and final times
tstart=0;
tfinal=10*timescale;

% set the initial conditions in the y0 column vector
u0=zeros(2,1);  
u0(1)=0; % initial position; %theta(1)=.2;
u0(2)=0; % initial velocity

% set the solve options
%options=odeset('RelTol',1e-8); %%%%%% Assignment to understand "options"
%[t,u]=ode45(@odeFunction,[tstart,tfinal],u0,options);
if us < tan(theta) 
    [t,u]=ode45(@odeFunctionQ2,[tstart:dt:tfinal],u0);
    x_exact = (g*sin(theta)/2).*t.*t + initial_vel.*t +  initial_pos - uk*g*cos(theta).*t.*t/2;
    v_exact = g*sin(theta).*t + initial_vel - uk*g*cos(theta).*t;
else
   t = zeros(1001,1); 
   u = zeros(1001,2);
   x_exact = (g*sin(theta)/2).*t.*t + initial_vel.*t +  initial_pos - uk*g*cos(theta).*t.*t/2;
   v_exact = g*sin(theta).*t + initial_vel - uk*g*cos(theta);
end

% store the solution that comes back into x and v arrays
x=u(:,1); 
v=u(:,2);

% plot the position vs. time
plot(t,x,'g^',t,x_exact)
title('Position vs. Time')
figure;
plot(t,v,'g^' , t , v_exact)
title('Velocity vs Time')
% make a "phase-space" plot of v vs. x
%figure
%plot(x,v)