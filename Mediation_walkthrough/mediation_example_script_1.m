close all
clear all

% This script is explained in detail in the powerpoint titled
% Mediation_sample_data_walkthrough

% mediation_example_script1 and 2 do the same analysis.
% ...script1 is very terse, and includes the essential commands only.
% ...script2 is longer and includes more checking that files are available, etc.

%% Step 1 of walkthrough
% ---------------------------------
% Make a new analysis directory to save results, and go there
andir = 'Test_mediation';
mkdir(andir)
cd(andir)

%%Step 2
% ---------------------------------

dinf = what('Wager_et_al_2008_Neuron_EmotionReg');

%imgs = filenames(fullfile(dinf.path,'con_*img'), 'char', 'absolute');
imgs = fullfile(dinf.path, 'Wager_2008_emo_reg_vs_look_neg_contrast_images.nii.gz');

%%Step 3
% ---------------------------------

behav_dat = importdata(fullfile(dinf.path,'Wager_2008_emotionreg_behavioral_data.txt'))

%%Step 4
% ---------------------------------

mask = which('gray_matter_mask.img')
canlab_results_fmridisplay(mask, 'compact2');

%% Step 5
% ---------------------------------

andir='Test_mediation_2018';
mkdir(andir)
cd(andir)

%% Step 6
% ---------------------------------

ls

%% Step 7 
% Run mediation without bootstrapping (fast)
% Test that things are working
% ---------------------------------

x=behav_dat.data(:,1);
y=behav_dat.data(:,2);
names={'X:RVLPFC' 'Y:Reappraisal_Success' 'M:BrainMediator'};

results = mediation_brain(x,y,imgs,'names',names,'mask', mask);

% "Legacy" version: reslice mask to same space first:
% scn_map_image(mask,deblank(imgs(1,:)), 'write', 'resliced_mask.img');
% results = mediation_brain(x,y,imgs,'names',names,'mask', 'resliced_mask.img'); 

%% Step 8
% ---------------------------------
% Uncomment the lines below to run with bootstrapping

% Make yourself a cup of tea while the results are compiled as this is going to take a while
% pre-compiled results are also available in
% 'mediation_Example_Data_Wager2008_Msearch_R_XisRIFGstim_norobust'

results = mediation_brain(x,y,imgs,'names',names,'mask', mask,'boot','pvals',5);

%% Step 9
% ---------------------------------

% change to the mediation analysis directory, if you haven't done, yet.
% compute result images and figures

% Get results and publish an HTML report:

publish_mediation_report;

%% Step 10
% ---------------------------------------------------------------------
% Get and save results (older format but nore complete):

mediation_brain_results_all_script;


% see mediation_brain_results for more options.

