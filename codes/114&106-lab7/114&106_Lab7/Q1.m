close all;
clear all;

global G Ms;

%G = 1.1888e-4;        %AU units
G = 6.67e-11;
%Ms = 332946; %AU mass
Ms = 1.989e30;
%interesting observation....no where in the calculations have we used
%the mass of the planet !!!!!!
% so the orbit just depends on the initital conditions of the plante namely distance from sun and initial velocity !

niter =  100000;
start_time = 0;
year = 365*24*3600;
end_time = 1*year;
dt = (end_time - start_time)/niter;

AU = 149.6e9;
initial_distance_between_planet_and_sun = 149.6e9;

varyingFactor1 = 0;
varyingFactor2 = 1/1.4;


initial_x = 1*initial_distance_between_planet_and_sun;
initial_y = 0;
initial_vx = -sqrt(G*Ms/initial_distance_between_planet_and_sun)*varyingFactor1;
initial_vy = -sqrt(G*Ms/initial_distance_between_planet_and_sun)*varyingFactor2;

u0 = zeros(4 , 1);

u0(1) = initial_x;
u0(2) = initial_y;
u0(3) = initial_vx;
u0(4) = initial_vy;

[t,u] = ode45(@rhs , [start_time : dt : end_time] , u0);

figure
plot(u(: , 1) / AU , u(: , 2)/AU)
xlabel('X axis in AU')
ylabel('Y axis in AU')



