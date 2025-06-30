# MECE6397-ILC-fro-trajectory-tracking-error-reduction

Author: Lea Prade NJOUA DONGMO

Advisor: Dr. Marzia CESCON

Course: MECE6397 Learning-Based Control SPRING2025 

Affiliation: University Of Houston

# Crazyflie Drone as Satellite surrogate: tracking error reduction using Iterative Learning Control (ILC)

This project has been devoloped using MATLAB 2024b, in Ubuntu 20.04.  

A cascaded PID developed by C. Luis and J. Le Ny [1] is used as nominal control architecture to track a circular orbitral trajectory. This project implements an ILC to reduce the tracking error deriving from the execution of the PID controller. 

To obtain simulation outputs, assuming MATLAB and SIMULINK are already installed:

0- Download and unzip MECE6397SPRING2025PROJECT

1- Select MECE6397SPRING2025PROJECT directory as active directory in MATLAB

2- Run PID_Controller.slx located in PID_beforeILC/PID to display the tracking state before application of ILC

3- In MECE6397SPRING2025PROJECT there is PID_ILC_correction_X_ok directory, access it and run in this order 
	- (i) PID_Controller.slx
	- (ii) ILC_setup.m in in which ILC parameter are defined for error in X-cordinate reduction
	- (iii) run_ILC_iteration.m (this will run the ILC-PID for 50 iteration), the number of iterations can be changed at line 19 of this same file. To save the output as an animation, uncomment lines from 13 to 17, then 166 to 169 and line 172 to close the videowriter object
	- To run the simulation again run (ii) and (iii)
	
4- Same steps as in 3 are applied to other directories PID_ILC_correction_Y_ok, PID_ILC_correction_X_Y_ok and PID_ILC_correction_X_Y__disturbances_ok. Optional:  to run and save animation with run_ILC_iteration.m in step (iii).	
	


[1] C. Luis and J. Le Ny, "Design of a Trajectory Tracking Controller for a Nanoquadcopter”, Technical report, Mobile Robotics and Autonomous Systems Laboratory, Polytechnique Montreal, August, 2016. Source code can be accessed at this github repository: https://github.com/cipherlab-poly/crazyflie-public.git. 
