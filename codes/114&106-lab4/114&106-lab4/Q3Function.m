function F  = Q3Function( t , u )

% u
% x y z
% vx vy vz

% F
% vx vy vz
% dvx/dt dvy/dt dvz/dt

global q m qom g;
global Bx By Bz;
global base_point_x_coordinate ;
global measurement_point_time ;



F = zeros ( length(u) , 1);

F(1) = u (4) ;
F(2) = u (5) ;
F(3) = u (6) ;

%{
F(4) = (qom) * ( u(5)*Bz - u(6)*By) ;
F(5) = (qom) * ( - u(4)*Bz + u(6)*Bx);
F(6) = (qom) * ( u(4)*By - u(5)*Bx) ;
%}

% for Q1 part4 gravitation y direction

F(4) = ((qom) * (u(5)*Bz - u(6)*By));
F(5) = ((qom) * (-u(4)*Bz + u(6)*Bx)) + g ;
F(6) = ((qom) * (u(4)*By - u(5)*Bx));

if(u(2) < 1e-5) 
        base_point_x_coordinate = u(1);
        measurement_point_time = t ; 
end


end

