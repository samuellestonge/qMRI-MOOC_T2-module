% Define the model 
Model = mwf;

% Load data into environment, and rotate mask to be aligned with IR data
data = struct;
load('example_data/mwf_demo/mwf_data/MET2data.mat');
load('example_data/mwf_demo/mwf_data/Mask.mat');
data.MET2data = double(MET2data);
data.Mask = double(Mask);

% Fit the data
FitResults = FitData(data,Model,0);