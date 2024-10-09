%% Requirements
% qMRLab must be installed: git clone https://www.github.com/qMRLab/qMRLab.git
% The mooc chapter branch must be checked out: git checkout mooc-03-T2
% qMRLab must be added to the path inside the MATLAB session: startup
% The QSM dataset needs to be downloaded from: https://osf.io/9d8kz

% Define the model
Model = qsm_sb;

% Define protocol
xDim = 0.6;
yDim = 0.6;
zDim = 0.6;
Model.Prot.Resolution.Mat = [xDim  yDim  zDim];
TE = 0.0081;
Model.Prot.Timing.Mat = [TE];

% Load data into environment (phase, magnitude and mask)
data = struct();

load('example_data/qsm_sb/PhaseGRE.mat'); 
load('example_data/qsm_sb/MagnGRE.mat'); 
load('example_data/qsm_sb/Mask.mat');

data.PhaseGRE = double(PhaseGRE);
data.MagnGRE = double(MagnGRE);
data.Mask = double(Mask);

%% QSM data fitting with magnitude weighing (chiSBM and chiL2M)
% Parameters
Model.options.MagnitudeWeighting = true;

% Fit data
FitResults_with_MW = FitData(data, Model, 0);

% Display results for chiSB
QSM_chiSBM = squeeze(FitResults_with_MW.chiSBM.*data.Mask);
QSM_chiL2M = squeeze(FitResults_with_MW.chiL2M.*data.Mask);

%% QSM data fitting without magnitude weighing (chiSB and chiL2)
% Parameters
Model.options.MagnitudeWeighting = false; 

% Fit data
FitResults_without_MW = FitData(data, Model, 0);

% Results
QSM_chiSB = squeeze(FitResults_without_MW.chiSB.*data.Mask);
QSM_chiL2 = squeeze(FitResults_without_MW.chiL2.*data.Mask);
