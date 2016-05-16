function F = LorentzForceFunction( t , u )
%LORENTZFORCEFUNCTION Summary of this function goes here

% u
% x y z
% vx vy vz

% F
% vx vy vz
% dvx/dt dvy/dt dvz/dt

global q m qom g;
global Bx By Bz;
global Ex Ey Ez;

% for question 1-part c
 Bz = 0.11 * u(1);
 By = u(2);   
 Bx = u(3);
 
F = zeros ( length(u) , 1);

F(1) = u (4) ;
F(2) = u (5) ;
F(3) = u (6) ;


F(4) = (qom) * ( Ex + u(5)*Bz - u(6)*By) ;
F(5) = (qom) * ( Ey - u(4)*Bz + u(6)*Bx) ;
F(6) = (qom) * ( Ez + u(4)*By - u(5)*Bx) ;


%{
% for Q1 part4 gravitation y direction
F(4) = ((qom) * (u(5)*Bz - u(6)*By));
F(5) = ((qom) * (-u(4)*Bz + u(6)*Bx)) + g;
F(6) = ((qom) * (u(4)*By - u(5)*Bx));
%}
end

