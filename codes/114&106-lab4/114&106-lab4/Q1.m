clear all;
close all;

global q m qom g;
global Bx By Bz;
global Ex Ey Ez;

%q = 1.6e-19;       %why does this not work ??
%m = 9.1e-31;

g=9.8;
qom = 1 ; 

Bx = 0;
By = 0;
Bz = 1;

Ex = 0;
Ey = 0;
Ez = 0;

starttime = 0;
totaltime =30;
dt = (totaltime-starttime) / 1000;

u0 = zeros (6 , 1);

u0(1) = 0 ;          %x
u0(2) = 0 ;          %y
u0(3) = 0 ;          %z

u0(4) = 1 ;          %vx
u0(5) = 0 ;          %vy
u0(6) = 0 ;          %vz

[t1,u1] = ode45(@LorentzForceFunction , [starttime : dt : totaltime] , u0) ; 
qom = -1;
[t2,u2] = ode45(@LorentzForceFunction , [starttime : dt : totaltime] , u0) ;

plot3( u1(:,1) , u1(:,2) , u1(:,3) , 'b' );%, u2(:,1) , u2(:,2) , u2(:,3) , 'r' )
grid on
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');
title('Bz = 0.11 * x, By = y, Bx = x, vinitial=(1,0,0), initialpos=(0,0,0), qom = 1. Blue +ve , Red -ve');
