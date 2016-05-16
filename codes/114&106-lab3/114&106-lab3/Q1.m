clear;close all;

global cnst initial_vel;
g=9.8;
theta= 30 * pi / 180;
cnst=g*sin(theta);
initial_vel = -20;
initial_pos = 10;

timescale=1;
dt=timescale/100;

% set the initial and final times
tstart=0;
tfinal=10*timescale;

% set the initial conditions in the u0 column vector
u0=zeros(2,1);  
u0(1)=initial_pos; % initial position; 
u0(2)=initial_vel; % initial velocity

% set the solve options
%options=odeset('RelTol',1e-8); %%%%%% Assignment to understand "options"
%[t,u]=ode45(@odeFunction,[tstart,tfinal],u0,options);
[t,u]=ode45(@odeFunctionq1,[tstart:dt:tfinal],u0);

% store the solution that comes back into x and v arrays
x=u(:,1); 
v=u(:,2);

x_exact = (cnst/2).*t.*t + initial_vel.*t +  initial_pos;
v_exact = cnst.*t + initial_vel;
% plot the position vs. time
plot(t,x,'g^',t,x_exact)
title('Position vs. Time')
figure;
plot(t,v,'g^' , t , v_exact)
title('Velocity vs Time')
figure;
plot(x,v, 'g^' , x_exact, v_exact)
title('phase-space plot of v vs. x')