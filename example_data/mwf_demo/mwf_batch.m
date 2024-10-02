% This m-file has been automatically generated using qMRgenBatch(mwf)
% Command Line Interface (CLI) is well-suited for automatization 
% purposes and Octave. 
%
% Please execute this m-file section by section to get familiar with batch
% processing for mwf on CLI.
%
% Demo files are downloaded into mwf_data folder. 
%
% Written by: Agah Karakuzu, 2017
% =========================================================================

%% I- DESCRIPTION

qMRinfo('mwf'); % Describe the model

%% II- MODEL PARAMETERS
%%       a- create object    

Model = mwf; 

%%       b- modify options
%           |- This section will pop-up the options GUI. Close window to continue.
%           |- Octave is not GUI compatible. Modify Model.options directly.

Model = Custom_OptionsGUI(Model); % You need to close GUI to move on. 

%% III- FIT EXPERIMENTAL DATASET
%%       a- set protocols via gui 
EchoTime  = [10.0000; 20.0000; 30.0000; 40.0000; 50.0000; 60.0000; 70.0000; 80.0000; 90.0000; 100.0000; 110.0000; 120.0000; 130.0000; 140.0000; 150.0000; 160.0000; 170.0000; 180.0000; 190.0000; 200.0000; 210.0000; 220.0000; 230.0000; 240.0000; 250.0000; 260.0000; 270.0000; 280.0000; 290.0000; 300.0000; 310.0000; 320.0000];
% EchoTime (ms) is a vector of [32X1]
Model.Prot.MET2data.Mat = [ EchoTime ];
%%   
%%       b- load experimental data 
%          |- mwf object needs 2 data input(s) to be assigned:
%          |-   MET2data
%          |-   Mask

data = struct();
 
% MET2data.mat contains [64  64   1  32] data.
 load('mwf_data\MET2data.mat');
% Mask.mat contains [64  64] data.
 load('mwf_data\Mask.mat');
 data.MET2data= double(MET2data);
 data.Mask= double(Mask);

%%      b- fit dataset 
%             |- This section will fit data. 

FitResults = FitData(data,Model,0);

%%       c- show fitting results 
%           |- Output map will be displayed.
%           |- If available, a graph will be displayed to show fitting in a voxel.

qMRshowOutput(FitResults,data,Model);

%%       d- Save results
%           |-  qMR maps are saved in NIFTI and in a structure FitResults.mat
%                that can be loaded in qMRLab graphical user interface
%           |-  Model object stores all the options and protocol.
%                It can be easily shared with collaborators to fit their 
%                own data or can be used for simulation.

FitResultsSave_mat(FitResults);
Model.saveObj('mwf_Demo.qmrlab.mat');

%% V- SIMULATIONS
%     |- This section can be executed to run simulations for mwf.
%%       a- Single Voxel Curve
%           |- Simulates Single Voxel curves:
%                (1) use equation to generate synthetic MRI data
%                (2) add rician noise
%                (3) fit and plot curve

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

%%       b- Sensitivity Analysis 
%           |-    Simulates sensitivity to fitted parameters:
%                  (1) vary fitting parameters from lower (lb) to upper (ub) bound.
%                  (2) run Sim_Single_Voxel_Curve Nofruns times
%                  (3) Compute mean and std across runs

      %              MWF           T2MW          T2IEW         
      OptTable.st = [50            20            1.2e+02]; % nominal values
      OptTable.fx = [0             1             1]; %vary MWF...
      OptTable.lb = [0.0001        0.0001        40]; %...from 0.0001
      OptTable.ub = [1e+02         40            2e+02]; %...to 100
      % Set simulation options
      Opt.SNR = 200;
      Opt.T2Spectrumvariance_Myelin = 5;
      Opt.T2Spectrumvariance_IEIntraExtracellularWater = 20;
      Opt.Nofrun = 5;
      % run simulation
      SimResults = Model.Sim_Sensitivity_Analysis(OptTable,Opt);
      figure('Name','Sensitivity Analysis');
      SimVaryPlot(SimResults, 'MWF' ,'MWF' );

%% VI- NOTES
%% 5.a.1 BIDS
% <html>
% <img src="https://github.com/qMRLab/doc_images/blob/main/usr/BIDS_Logo.png?raw=true" style="height:100px!important;">
% </html>
%% 
% 
%   |== sub-01/
%   |~~~~~~ anat/
%   |---------- sub-01_echo-1_MESE.json
%   |---------- sub-01_echo-1_MESE.nii.gz
%   |---------- sub-01_echo-2_MESE.json
%   |---------- sub-01_echo-2_MESE.nii.gz
%   |---------- .
%   |---------- .
%   |---------- sub-01_echo-N_MESE.json
%   |---------- sub-01_echo-N_MESE.nii.gz
%   |
%   |== derivatives/
%   |~~~~~~ qMRLab/
%   |---------- dataset_description.json
%   |~~~~~~~~~~ sub-01/anat/
%   |-------------- sub-01_MWFmap.nii.gz
%   |-------------- sub-01_MWFmap.json
%   |-------------- sub-01_T2MW.nii.gz (Not defined in BIDS yet)
%   |-------------- sub-01_T2MW.json
%   |-------------- sub-01_T2IEW.nii.gz (Not defined in BIDS yet)
%   |-------------- sub-01_T2IEW.json
% 
% For further information, please visit <https://bids-specification.readthedocs.io/en/stable/99-appendices/11-qmri.html BIDS qMRI Appendix>.

% More information is available at https://qmrlab.readthedocs.io/en/master/mwf_batch.html

% MacKay, M., et al. (1994). In vivo visualization of myeling water in brain by magnetic resonance. Magnetic Resonance in Medicine, 31(6), 673-677. 10.1002/mrm.1910310614
