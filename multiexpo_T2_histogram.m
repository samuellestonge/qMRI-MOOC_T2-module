%% Requirements
% qMRLab must be installed: git clone https://www.github.com/qMRLab/qMRLab.git
% The mooc chapter branch must be checked out: git checkout mooc-03-T2
% qMRLab must be added to the path inside the MATLAB session: startup
% The Matlab Statistics and Machine Learning Toolbox must be installed

% Define the model 
Model = mwf;

%Add rician noise
Opt.SNR = 200;

% Set simulation options
Opt.T2Spectrumvariance_Myelin = 100;
Opt.T2Spectrumvariance_IEIntraExtracellularWater = 100;

% Generate synthetic MRI data
data = struct;

data.T2MW = 40;
MW = data.T2MW;

data.T2IEW = 120;
IEW = data.T2IEW;

% Get the echo times
EchoTimes = Model.Prot.MET2data.Mat;  % Get the echo times
T2 = getT2(Model, EchoTimes);          % Get the T2 values
T2_vals = T2.vals;                     % Extract the T2 values

%% Case 1 : MWF = 0
data.MWF = 0;

% Run gitting simulation and plot the respective curve
figure('Name','Single Voxel Curve Simulation');
FitResult_1 = Model.Sim_Single_Voxel_Curve(data, Opt);
[Smodel_1, Spectrum_1] = Model.equation(data, Opt); % Get the Spectrum

%% Case 2 : MWF = 25
data.MWF = 25;

% Run gitting simulation and plot the respective curve
figure('Name','Single Voxel Curve Simulation');
FitResult_2 = Model.Sim_Single_Voxel_Curve(data, Opt);
[Smodel_2, Spectrum_2] = Model.equation(data, Opt); % Get the Spectrum

%% Case 3 : MWF = 50
data.MWF = 50;

% Run gitting simulation and plot the respective curve
figure('Name','Single Voxel Curve Simulation');
FitResult_3 = Model.Sim_Single_Voxel_Curve(data, Opt);
[Smodel_3, Spectrum_3] = Model.equation(data, Opt); % Get the Spectrum

%% Case 4 : MWF = 75
data.MWF = 75;

% Run gitting simulation and plot the respective curve
figure('Name','Single Voxel Curve Simulation');
FitResult_4 = Model.Sim_Single_Voxel_Curve(data, Opt);
[Smodel_4, Spectrum_4] = Model.equation(data, Opt); % Get the Spectrum

%% Case 5 : MWF = 100
data.MWF = 100;

% Run gitting simulation and plot the respective curve
figure('Name','Single Voxel Curve Simulation');
FitResult_5 = Model.Sim_Single_Voxel_Curve(data, Opt);
[Smodel_5, Spectrum_5] = Model.equation(data, Opt); % Get the Spectrum
