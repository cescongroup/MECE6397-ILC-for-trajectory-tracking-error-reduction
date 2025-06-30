
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Author: Lea Prade NJOUA DONGMO
Advisor: Dr. Marzia CESCON
Related Course: MECE6397 Learning-Based Control SPRING2025 
Affiliation: University Of Houston

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Crazyflie Drone as Satellite surrogate: tracking error reduction using Iterative Learning Control (ILC) %%%

This project is an extension to previous study on modeling crazyflie drone for error tracking which original code is in github directory https://github.com/cipherlab-poly/crazyflie-public.git.

Only MATLAB and SIMULINK code has been considered and used. ROS code was not accounted in the simulation.

A circular orbitral trajectory is considered and cascaded PID as nominal control architecture is used with ILC.

This project has been devoloped using matlab 2024b, in Ubuntu 20.04.

To obtain simulation outputs, assuming MATLAB and SIMULINK are already installed:

0- Download and unzip MECE6397SPRING2025PROJECT

1- Select MECE6397SPRING2025PROJECT directory as active directory in MATLAB

2- Run PID_Controller.slx located in PID_beforeILC/PID to display the tracking state before application of ILC

3- In MECE6397SPRING2025PROJECT there is PID_ILC_correction_X_ok directory, access it and run in this order 
	- (i) PID_Controller.slx
	- (ii) ILC_setup.m in which ILC parameter are defined for error in X-cordinate reduction
	- (iii) run_ILC_iteration.m ( this will run the ILC-PID for 50 iteration), the number of iteration can be changed at line 19 of this same file. To save output as animation, uncomment from 13 to 17, then 166 to 169 and line 172 to close the videowriter object
	- To run the simulation again run (ii) and (iii)
	
4- Same steps as in 3 are applyied to other directories PID_ILC_correction_Y_ok, PID_ILC_correction_X_Y_ok and PID_ILC_correction_X_Y__disturbances_ok . With an option to run and save animation with run_ILC_iteration.m in step (iii).	
	



