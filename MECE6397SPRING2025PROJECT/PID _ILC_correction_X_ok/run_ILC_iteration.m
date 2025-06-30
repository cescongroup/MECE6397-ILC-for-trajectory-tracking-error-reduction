disp('simulating ILC_pidQuadsim')
    if idx_ILC==1
      correction_ILC(:,1)=control(:);
      x(:,1)= state_lin(:,1);
      err_x=norm(x_c-state_lin(:,1));
      %pitch_c_ILC(:,1)=pitch_c;
      pitch_error(:,1)=pitch_c-pitch.Data;
      err=norm(pitch_error(:,1));
      pitch_c_ILC(:,1)=pitch_c-pi/3;
    end

% save the ILC plot output as an animation
% vidObj = VideoWriter('animation_ILC_PID_x_ok.avi'); % Create a video object
% vidObj.Quality = 100;
% %vidObj.FrameRate = 10;
% vidObj.FrameRate = 10; % Set the frame rate
% open(vidObj); % Open the video file for writing

for it=1:50
 
  output=sim('ILC_pidQuadsim');
  

idx_ILC = idx_ILC+1





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

  % figure(100)
  % subplot(211)
  % hold on
  % plot(time_ILC,x_error_ILC(:,idx_ILC),'g','LineWidth',1.3); 
  % plot(time_ILC,correction_ILC(:,idx_ILC),'r', 'LineWidth',1.3);
  % hold off; grid on
  % legend('pitch error', 'correction u_{k+1} ')
  % title('pitch error and ILC-correction')
  % % subplot(312)
  % % plot(err,'r*','DisplayName','e_{\theta}'); hold on
  % % plot(err,'r','LineWidth',1.3);
  % % %legend()
  % 
  % subplot(212)
  % plot(err_x,'k*','DisplayName','e_x'); hold on
  % plot(err_x,'k','LineWidth',1.3);
  % hold off
  % ylabel('|error|')
  % xlabel('iteration number')
  % title('Norm of x error')
  % grid on
  % %legend()
  % set(gcf,'color','white')
  % 
  % figure(101)
  % subplot(2,2,1)
  % hold on
  % h1=plot(time_ILC,x_c,'r','LineWidth',1.3);
  % if idx_ILC==2
  %   %x(:,1)= state_lin(:,1);
  %   h2=plot(t,x(:,1),'g');
  % end
  % %h2=plot(t,x(:,1),'g', 'LineWidth',1.3);
  % h3=plot(time_ILC,x(:,idx_ILC),'b', 'LineWidth',1.3);
  % hold off;
  % title('Simulated: x and xc')
  % xlabel('Time (s)');
  % ylabel('Position (m)');
  % grid on
  % legend([h1,h2,h3],'xc','x-PID','x-PID-ILC');
  % 
  % subplot(2,2,2)
  % hold on
  % plot(time_ILC,y_c,'r', 'LineWidth',1.3);
  % plot(t,state_lin(:,2),'g', 'LineWidth',1.3);
  % hold off
  % title('Simulated: y and yc')
  % xlabel('Time (s)');
  % ylabel('Position (m)');
  % grid on
  % legend('yc','y-PID')
  % 
  % subplot(2,2,3)
  %   %plot(t,state(:,3),'LineWidth',1.3);
  %   grid on;
  %   hold on;
  %   plot(t,state_lin(:,3),'LineWidth',1.3,'Color',green);
  %   plot(t,z_c*ones(size(x_c)),'--r','LineWidth',1.3);
  %   hold off
  %   title('Z Position');
  %   xlabel('Time (s)');
  %   ylabel('Position (m)');
  %   legend('zc','z-PID')
  % 
  %   subplot(2,2,4)
  %   %plot(t,state(:,4)*180/pi,'LineWidth',1.3);
  %   grid on;
  %   hold on;
  %   plot(t,state_lin(:,4)*180/pi,'LineWidth',1.3,'Color',green);
  %   plot(t,psi_c,'--r','LineWidth',1.3);
  %   hold off
  %   title('Yaw angle');
  %   xlabel('Time (s)');
  %   ylabel('Angle (deg)');
  %   legend('Yawc','Yaw-PID')
  % set(gcf,'color','white')

figure(102)
    subplot(2,1,1)
    hold on
    h1=plot(time_ILC,x_c,'r','LineWidth',1.3);
    if idx_ILC==2
    %x(:,1)= state_lin(:,1);
    h2=plot(t,x(:,1),'g');
    end
    %h2=plot(t,x(:,1),'g', 'LineWidth',1.3);
    h3=plot(time_ILC,x(:,idx_ILC),'b', 'LineWidth',1.3);
    hold off;
    title('Simulated: x and xc')
    xlabel('Time (s)');
    ylabel('Position (m)');
    grid on
    legend([h1,h2,h3],'xc','x-PID','x-PID-ILC');
    hold off
    
    
    subplot(212)
    hold on
    plot(err_x,'k*','DisplayName','e_x'); hold on
    plot(err_x,'k','LineWidth',1.3);
    hold off
    ylabel('|error|')
    xlabel('iteration number')
    title('Norm of x error')
    grid on
    %legend()
    set(gcf,'color','white')

    % Capture the current plot as a frame and write it to the video
    %frame = getframe(gcf); % Get the current figure
    %writeVideo(vidObj, frame); % Write the frame to the video
    
    %pause(2); % Pause to control the animation speed

end
%close(vidObj);