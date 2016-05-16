%{
we have a look at use of quiver(arrows) function and streamline function.   
Q1. Physical insight - 
-> we can predict that if a particle starts at a particular point, then how
will it move with the wind.
 
Q2. Arrows in quiver command 
-> it shows the velocity at each point.

Q3. streamlines.
-> the path the particle will take if it starts at one of the end point.

%}

% first we make meshgrid of co-ordinates




[x,y] = meshgrid(-10 : 0.5 : 10 , -10 : 0.5 : 10);

vx = 0.2.*x.*x + 0.5.*y.*y + 20;

vy = -0.1.*power(y,3) + 0.5.*x.*x - 10;

figure
% note x,y,vx,vy are 2D arrays containing values of respective quantities
% at those points.

quiver(x,y,vx,vy)

% startx and starty will give the set of points from where we want the
% streamlines to start.

starty = [-10 : 0.5 : 10 ];
startx = ones(size(starty)).*-10 ;

streamline(x , y , vx , vy , startx , starty)