% In this question we observe the kinetic energy, magnitude of velocity and acceleration, angle between velocity and acceleration as a function of time.

close all;
clear all;

global G Ms year area1 area2 theta theta_prev prevx prevy dt; 

%theta_prev = 0;
area1 = 0;
area2 = 0;
%prevx = 0;
%prevy = 0;
G = 6.67e-11;
Ms = 1.989e30;
Mp = 5.97e24;
%interesting observation....no where in the calculations have we used
%the mass of the planet !!!!!!
% so the orbit just depends on the initital conditions of the plante namely distance from sun and initial velocity !

niter =  1000;
start_time = 0;
year = 365*24*3600;
end_time = 75*year;
dt = (end_time - start_time)/niter;

AU = 149.6e9;
%initial_distance_between_planet_and_sun = 149.6e9;
actual_aphelion_distance_between_planet_and_sun = 152.1e9;
initial_distance_between_planet_and_sun = 35*AU;

varyingFactor1 = 0;
varyingFactor2 = 1;


initial_x = 1*initial_distance_between_planet_and_sun;
initial_y = 0;
initial_vx = -sqrt(G*Ms/actual_aphelion_distance_between_planet_and_sun)*varyingFactor1;
%initial_vy = -sqrt(G*Ms/actual_aphelion_distance_between_planet_and_sun)*varyingFactor2;
initial_vy = - 879;
%initial_vy = -52300;
u0 = zeros(4 , 1);

u0(1) = initial_x;
u0(2) = initial_y;
u0(3) = initial_vx;
u0(4) = initial_vy;
options=odeset('RelTol',1e-6);      % important to specify relative tolerance
[t,u] = ode45(@rhs , [start_time : dt : end_time] , u0 ,options );

figure
plot(u(: , 1) / AU , u(: , 2)/AU , 0 , 0 , 'O');
xlabel('X axis in AU')
ylabel('Y axis in AU')

%figure

x = u(: , 1);
y = u(: , 2);
ux = u(: , 3);
uy = u(: , 4);
u = sqrt(ux.*ux + uy.*uy);
r = sqrt(x.*x + y.*y);
KE = (0.5*Mp).*u.*u;
PE = -(G*Ms*Mp)./r;
TE = KE + PE;
t_years = t./(3.15e7);

accl = -(G*Ms)./(r.*r);
theta_rad = atan2(y,x);
theta_degrees = theta_rad.*(180/pi);

accl_rad = atan2(-y , -x);
accl_x = accl.*cos(accl_rad);
accl_y = accl.*sin(accl_rad);

accl_degrees = accl_rad.*(180/pi);

vel_rad = atan2(uy , ux);
vel_degrees = vel_rad.*(180/pi);

%lets calculate angel between velocity and acceleration
angle_diff = acosd((accl_x.*ux + accl_y.*uy)./(accl.*u));

angle_diff_momentum = acos((x.*ux + y.*uy)./(r.*u));

angular_momentum = 6e24.*r.*u.*sin(angle_diff_momentum);

%{
figure
plot(t_years , u );
xlabel('time in years');
ylabel('magnitude of velocity in m/s');

figure
subplot(2,1,1)
plot(t_years , r);
xlabel('time in years');
ylabel('distance from sun');
title('distance from sun as function of time')

subplot(2,1,2);
plot(t_years , KE);
xlabel('time in years');
ylabel('KE in Joules');
title('KE as a function of time')

figure
subplot(3,1,1);
plot(t_years , KE);
xlabel('time in years');
ylabel('KE in Joules');
title('KE as a function of time')


subplot(3,1,2);
plot(t_years , PE);
xlabel('time in years');
ylabel('PE in Joules');
title('PE as a function of time')


subplot(3,1,3);
%}
%{
figure
plot(t_years , TE);
xlabel('time in years');
ylabel('Total Energy in Joules');
title('Total Energy as a function of time')

figure
plot(t_years,angular_momentum);
%}
%{
figure

subplot(2 , 1  , 1);
plot(t_years , u );
xlabel('time in years');
ylabel('magnitude of velocity in m/s');


subplot(2 , 1  , 2);

plot(t_years , accl );
xlabel('time in years');
ylabel('magnitude of acceleration in m/s^2');

figure

subplot(2 , 1 , 1);
plot(t_years , accl_degrees);
xlabel('time in years');
ylabel('angle made by acceleration vector wrt +ve X axis');

subplot(2 , 1 , 2);
plot(t_years , vel_degrees);
xlabel('time in years');
ylabel('angle made by velocity vector wrt +ve X axis');

%subplot(3 , 1 , 3);
%plot(t , accl_degrees - vel_degrees);

figure
plot(t_years , angle_diff );
xlabel('time in years');
ylabel('angle between velocity and acceleration');

%}
%{
quiver(x , y , ux , uy);
quiver(x , y , accl_x , accl_y);
area1

area2
%}
