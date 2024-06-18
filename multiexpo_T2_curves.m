x = struct;
x.MWF = 50.0001;
x.T2MW = 20.0001;
x.T2IEW = 120;
% Set simulation options
Opt.SNR = 200;
Opt.T2Spectrumvariance_Myelin = 5;
Opt.T2Spectrumvariance_IEIntraExtracellularWater = 20;
% run simulation
figure('Name','Single Voxel Curve Simulation');
FitResult = Model.Sim_Single_Voxel_Curve(x,Opt);