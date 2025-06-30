  disp('simulating ILC_pidQuadsim')
    if idx_ILC==1
      correction_ILC(:,1)=control(:);
      x(:,1)= state_lin(:,1);
      err_x=norm(x_c-state_lin(:,1));
      %pitch_c_ILC(:,1)=pitch_c;
      pitch_error(:,1)=pitch_c-pitch.Data;
      err=norm(pitch_error(:,1));
      pitch_c_ILC(:,1)=pitch_c-pi/3;
      %Roll
      % correction_roll_ILC(:,1)=control_roll(:);
      y(:,1)= state_lin(:,2);
      err_y=norm(y_c-state_lin(:,2));
      %pitch_c_ILC(:,1)=pitch_c;
      roll_error(:,1)=roll_c-roll.Data;
      err_roll=norm(roll_error(:,1));
      roll_c_ILC(:,1)=roll_c;
    end
  output=sim('ILC_pidQuadsim');
  

idx_ILC = idx_ILC+1




%% x correction
% match time vectors in input and output to equal length

x(:,idx_ILC) = interp1(output.ILC_x.time,output.ILC_x.signals.values,time_ILC')' ; 
x_error_ILC(:,idx_ILC) = x_c-x(:,idx_ILC);

pitch=interp1(output.pitch.time,output.pitch.Data,time_ILC')';
%pitch_c=interp1(output.pitch_c.time,output.pitch_c.Data,time_ILC')';
%pitch_c=output.pitch_c;
pitch_c=pitch_ILC(:,1);
pitch_error(:,idx_ILC)=pitch_c-pitch;

%
%norm(angle_error_ILC(:,idx_ILC))
err = [err;norm(pitch_error(:,idx_ILC-1))];
err_x = [err_x;norm(x_error_ILC(:,idx_ILC))];

    
%====  update according to u_{k+1}= Q(u_k + L e_k) =========

Ld_err = noncausalfilter(Ld,x_error_ILC(:,idx_ILC),tsamp_ILC); 
%Ld_err = noncausalfilter(Ld,pitch_error(:,idx_ILC-1),tsamp_ILC); 
uold = correction_ILC(:,idx_ILC-1);
u = filtfilt(Qd_B,Qd_A, uold+Ld_err);
correction_ILC(:,idx_ILC) = u;
pitch_c_ILC(:,idx_ILC)=pitch_c;
pitch_ILC(:,idx_ILC)=pitch;

%% y correction
y(:,idx_ILC) = interp1(output.ILC_y.time,output.ILC_y.signals.values,time_ILC')' ; 
y_error_ILC(:,idx_ILC) = -y_c+y(:,idx_ILC);
y_e_b=interp1(output.ye_b.time,output.ye_b.signals.values,time_ILC')' ;

roll=interp1(output.roll.time,output.roll.Data,time_ILC')';
%roll_c=interp1(output.roll_c.time,output.roll_c.Data,time_ILC')';
%roll_c=output.pitch_c;
roll_c=roll_ILC(:,1);
roll_error(:,idx_ILC)=roll_c-roll;

%
%norm(angle_error_ILC(:,idx_ILC))
err_roll = [err_roll;norm(roll_error(:,idx_ILC-1))];
err_y = [err_y;norm(y_error_ILC(:,idx_ILC))];

    
%====  update according to u_{k+1}= Q(u_k + L e_k) =========

Ld_err_y = noncausalfilter(Ld_y,y_error_ILC(:,idx_ILC),tsamp_ILC); 
%Ld_err_y = noncausalfilter(Ld_y,roll_error(:,idx_ILC),tsamp_ILC);
%Ld_err_y = noncausalfilter(Ld_y,y_e_b,tsamp_ILC);
uold = correction_roll_ILC(:,idx_ILC-1);
u_r = filtfilt(Qd_By,Qd_Ay, uold+Ld_err_y);
correction_roll_ILC(:,idx_ILC) = u_r;
roll_c_ILC(:,idx_ILC)=roll_c;
roll_ILC(:,idx_ILC)=roll;

figure(100)
subplot(321)
plot(err_x,'k*','DisplayName','e_x'); hold on
plot(err_x,'k');
hold off
ylabel('|error|')
xlabel('iteration number')
title('Norm of x error')
grid on



subplot(322)
plot(err_y,'k*','DisplayName','e_y'); hold on
plot(err_y,'k');
hold off
ylabel('|error|')
xlabel('iteration number')
title('Norm of y error')
grid on

% plot(err,'r*','DisplayName','e_{\theta}'); hold on
% plot(err,'r');
% title('pitch error');
%legend()

subplot(323)
hold on
if idx_ILC==2
%x(:,1)= state_lin(:,1);
plot(time_ILC,x_c,'r');
plot(t,x(:,1),'g');
end  
plot(time_ILC,x(:,idx_ILC),'b');
hold off;
title('Simulated: x and x-ref')
grid on
%legend()

subplot(324)
hold on
if idx_ILC==2
  plot(time_ILC,y_c,'r');
  plot(t,state_lin(:,2),'g');
end
plot(time_ILC,y(:,idx_ILC),'b');
hold off
title('Simulated: y and y-ref')
grid on
% plot(err_y,'k*','DisplayName','e_y'); hold on
% plot(err_y,'k');
% hold off
% ylabel('|error|')
% xlabel('iteration number')
% title('Norm of y error')
% grid on
%legend()

subplot(325)
hold on
plot(time_ILC,correction_ILC(:,idx_ILC),'r', 'LineWidth',1.3);
title('ILC-correction-x')
grid on
hold off


subplot(326)
hold on
plot(time_ILC,correction_roll_ILC(:,idx_ILC),'r', 'LineWidth',1.3);
title('ILC-correction-y')
grid on
hold off



figure(101)
subplot(2,1,1)
hold on
if idx_ILC==2
%x(:,1)= state_lin(:,1);
plot(time_ILC,x_c,'r');
plot(t,x(:,1),'g');
end  
plot(time_ILC,x(:,idx_ILC),'b');
hold off;
title('Simulated: x and x-ref')
grid on

subplot(2,1,2)
hold on
if idx_ILC==2
  plot(time_ILC,y_c,'r');
  plot(t,state_lin(:,2),'g');
end
plot(time_ILC,y(:,idx_ILC),'b');
hold off
title('Simulated: y and y-ref')
grid on


figure (102)
hold on
h1=plot3(state_lin(:,1),state_lin(:,2),state_lin(:,3),'LineWidth',1.3);
grid on
hold on
h2=plot3(output.state_lin(:,1),output.state_lin(:,2),output.state_lin(:,3),'LineWidth',1.3,'Color','g');
h3=plot3(x_c,y_c,z_c*ones(size(x_c)),'--r','LineWidth',1.3);
title('3D Trajectory');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
ylim([-1,1]);
xlim([-1,1]);
zlim([0,2.1]);
%legend([h2 h1 h3],'Linear','Non-linear','Reference');
legend([h1 h2 h3],'PID','PID-ILC','Reference');
hold off

set(gca, 'Color', 'white');

%%%%%%% % Annimation
figure (104)
% x1 = linspace(0, 10, 100); % Example x data (from 0 to 10 with 100 points)
% y1 = sin(x1); % Example y data (sine wave)
% 
% plot(x1, y1, 'b', 'LineWidth', 2); % Plot the curve with blue color and thick line
% 
% hold on;
% grid on;
hold on
h1=plot3(state_lin(:,1),state_lin(:,2),state_lin(:,3),'LineWidth',1.3);
grid on
%hold on
%h2=plot3(output.state_lin(:,1),output.state_lin(:,2),output.state_lin(:,3),'LineWidth',1.3,'Color',green);
h3=plot3(x_c,y_c,z_c*ones(size(x_c)),'--r','LineWidth',1.3);
title('3D Trajectory');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
ylim([-1,1]);
xlim([-1,1]);
zlim([0,2.1]);
%legend([h2 h1 h3],'Linear','Non-linear','Reference');
legend([h1 h2 h3],'PID','PID-ILC','Reference');
hold off


%%%%%%% 3D animation
% Define sample data points
x = output.state_lin(:,1); %linspace(0, 10, 100); % X-coordinates
y = output.state_lin(:,2); %sin(x);               % Y-coordinates
z = output.state_lin(:,3); %cos(x);               % Z-coordinates

% Create a figure
figure;

hold on;
grid on;

h1=plot3(state_lin(:,1),state_lin(:,2),state_lin(:,3),'LineWidth',1.3);

h3=plot3(x_c,y_c,z_c*ones(size(x_c)),'--r','LineWidth',1.3);
title('3D Trajectory');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
ylim([-1,1]);
xlim([-1,1]);
zlim([0,2.1]);

% Initialize the plot for the curve and the marker
h2 = plot3(NaN, NaN, NaN, 'g-', 'LineWidth', 2); % Empty curve

marker = plot3(NaN, NaN, NaN, 'kX', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Marker
legend([h1 h2 h3 marker],'PID','PID-ILC','Reference','Drone');
% Animate the marker moving and drawing the curve
for i = 1:length(x)
    % Update the curve data to progressively draw
    set(h2, 'XData', x(1:i), 'YData', y(1:i), 'ZData', z(1:i));
    
    % Update the marker position
    set(marker, 'XData', x(i), 'YData', y(i), 'ZData', z(i));
    
    % Pause for a short time to create the animation effect
    pause(0.05);
end

hold off;




