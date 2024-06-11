%% T2 and T2* decay curves

% Define model
Model = mono_t2;

% Define signal parameters for different tissues
x = struct;

x.M0 = 1000;

x.T2 = 109.77; % (in ms)

% Define the signal-to-noise ratio 
Opt1.SNR = 10;
Opt2.SNR = 50;
Opt3.SNR = 90;
Opt4.SNR = 130;

% Run the simulation for T2 and T2* decay curves
figure('Name','SNR = 10');
FitResult_1 = Model.Sim_Single_Voxel_Curve(x, Opt1);
figure('Name','SNR = 50');
FitResult_2 = Model.Sim_Single_Voxel_Curve(x, Opt2);
figure('Name','SNR = 90');
FitResult_3 = Model.Sim_Single_Voxel_Curve(x, Opt3);
figure('Name','SNR = 130');
FitResult_4 = Model.Sim_Single_Voxel_Curve(x, Opt4);
