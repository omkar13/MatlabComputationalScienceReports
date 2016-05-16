clear all;
close all;

g = 9.8;
initial_x_pos = 0;
initial_y_pos =0;

constant=4e-5;      %       B/m

% time given so that projectile reaches ground
totaltime= 2*600*sin(pi/3)/g;
starttime = 0;
dt = 0.125 ;      

npoints = round((totaltime - starttime) / dt) ; % approx  points  - very important parameter . 
flag = 0 ;

xtarget =10000 ;           
max_ytarget_ht = 2000;
min_ytarget_ht = -2000;
dh = 100 ;              % increment in y target ht
npoints_min_vel = (max_ytarget_ht - min_ytarget_ht)/dh + 1;
min_vel_array = zeros(npoints_min_vel , 1);
firing_angle_array = zeros(npoints_min_vel , 1);
array_index = 1 ;
vel_lower_limit = -1;

%let us measure the time required for our computations
tic

for ytarget = min_ytarget_ht : dh : max_ytarget_ht     
    min_vel_array(array_index) = 1000;  % check this assumption
    flag =0;                                                % optimisation 1
    
    if(array_index - 5 > 0)
        vel_lower_limit = min_vel_array(array_index - 5) ;          % optimisation 2
    else
        vel_lower_limit = 290;
    end    
    
    for v_init = vel_lower_limit : 0.25 : 370                                   % assume this is the physical limitation
        if( flag == 1 )
                break;
        end
        
        for theta_degrees = 30 : 0.5 : 55             % assume this is the physical limitation - optimisation 3
     
            x = zeros (npoints);
            y = zeros (npoints);
            
            x(1) = initial_x_pos;
            y(1) = initial_y_pos;
            
            vx = v_init * cos(theta_degrees*0.01745);
            vy = v_init * sin(theta_degrees*0.01745);
            
            %now we simulate the motion of the projectile and break the
            %loop if we are near the target
             for step=2:npoints
                x(step)=x(step-1)+vx*dt;
                y(step)=y(step-1)+vy*dt;
                drag=constant*sqrt(vx*vx+vy*vy)*exp(-y(step)/1000);
                vx=vx-drag*vx*dt;
                vy=vy-drag*vy*dt-g*dt;
             
                % break if we are within 1m radius of the target.
                % use distance formula
                if(sqrt(power(x(step)-xtarget,2) + power(y(step)-ytarget,2)) < 20 )
                   if(v_init < min_vel_array(array_index))
                        min_vel_array(array_index) = v_init ;
                        firing_angle_array(array_index) = theta_degrees ; 
                        flag =1;
                        break;                                    %update the minimum velocity
                   end
                end
                
                if((y(step) + 100 < ytarget) && x(step) > 25000)      % break if you can't hit also make sure you don't break when you are climbing !!
                         break
                end
       
             end
                
             if(flag == 1)
                break;                              % we have got the minimum velocity ...why go further ! 
             end
        end    
    end
    array_index = array_index +1 ; 
end

time_req = toc


plot(min_ytarget_ht : dh : max_ytarget_ht , min_vel_array) 
grid on ;
xlabel('altitude of target in metres -->')
ylabel('minimum velocity required in m/s -->')
title('Finding the minimum velocity required to reach a target 10kms away at varying altitudes');

figure ; 
plot(min_ytarget_ht : dh : max_ytarget_ht , firing_angle_array) 
grid on ;
xlabel('altitude of target in metres -->')
ylabel('firing angle of minimum velocity in degrees -->')
title('Finding the firing angle of minimum velocity to reach a target 10kms away at varying altitudes');



