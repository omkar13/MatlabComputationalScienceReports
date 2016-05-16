% this program simulates the motion of a ball as it is throen upwards in
% the air. We first experiment with low speeds of 1m/s, 10m/s, 40m/s and
% then with larger speeds of 1000m/s, 5000m/s and 10000m/s where the change
% in gravitational constant needs to be taken into account.
% Also we observe the concept of escape velocity by simulation.
% finnaly we make a movie of a bouncing ball


clear all;
close all;
global G M R ;
G = 6.67e-11;       %gravitational constant
M = 6e24;           % mass of earth
R = 6.4e6;          % radius of earth

initial_pos_x = 0;
initial_pos_y = 0;
initial_vel_x = 10;
initial_vel_y = 10;
niter = 1000;

start_time = 0;
end_time = 50*initial_vel_x/9.8;         % approximately
dt = (end_time - start_time) /niter;

nframe = niter + 1;
%mov(1:nframe)=struct('cdata',[],'colormap',[]);

% Prepare the new file.
vidObj = VideoWriter('BouncingballMotion3_projectile.avi');
open(vidObj);

set(gca,'nextplot','replacechildren');

u0 = zeros(4 , 1);

u0(1) = initial_pos_x;
u0(2) = initial_vel_x;
u0(3) = initial_pos_y;
u0(4) = initial_vel_y;

%figure
pause on

%[ t, u ] = ode45(@rhs , start_time : dt : end_time, u0);

%we will try using loop method instead of ode for bouncing ball example.

position_x = zeros(niter);
velocity_x = zeros(niter);
position_y = zeros(niter);
velocity_y = zeros(niter);

position_x(1) = initial_pos_x;
velocity_x(1) = initial_vel_x;
position_y(1) = initial_pos_y;
velocity_y(1) = initial_vel_y;


for step=1 : niter-1
    position_x(step + 1 ) = position_x(step) + dt*velocity_x(step);
    velocity_x(step + 1 ) = velocity_x(step) + dt*(-G*M/(power(position_x(step) + R,2)));
    
    %this if statement handles the case when the ball hits the ground.
    
    if(position_x(step + 1) < 0 && velocity_x(step + 1) < 0)
       % velocity has been decreased by 0.9 in magnitude.
        velocity_x(step + 1) = velocity_x(step + 1)* -0.9 ; 
    end
    
    position_y(step + 1 ) = position_y(step) + dt*velocity_y(step);
    velocity_y(step + 1 ) = velocity_y(step) + dt*0;    
    hold on
    plot(position_x(step) , position_y(step) , '.')
       currFrame = getframe;
    writeVideo(vidObj,currFrame);
    axis([0 6 0 400])
    pause(0.01);
end



%{
for i=1 : length(u(:,1))
    plot(u(i,1) , u(i,3) , 'O')
    axis([0 0.06 0 0.25])
 %   mov(i) = getframe(gcf);
       currFrame = getframe;
    writeVideo(vidObj,currFrame);
     pause(0.01);
end
%}
% Close the file.
close(vidObj);




%movie2avi(mov, 'moviename1.avi', 'compression', 'None');
%set(gca,'nextplot','replacechildren');

%{
% quiver plot
figure
quiver(u(:, 1) , u(: , 3) , u(: , 2) , u(: , 4) , 0.5)
xlabel('X-Axis')
ylabel('Y-Axis')
%}

%plot phase space trajectories.

%{
figure
plot(u(:, 1) , u(: , 2) )
xlabel('position x')
ylabel('velocity x')
%}



