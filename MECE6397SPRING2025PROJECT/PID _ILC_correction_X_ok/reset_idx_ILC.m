ILC_setup;

idx_ILC=1;
err=[];
x_error_ILC=[];
sim('ILC_pidQuadsim')

% dummy to update diagram
figure(101); clf; title('initialized for ILC\_pidQuadsim') 
figure(100); clf; title('initialized for ILC\_pidQuadsim') 