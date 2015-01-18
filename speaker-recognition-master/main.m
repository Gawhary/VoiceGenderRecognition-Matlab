%% read testing files
[filenames, pathname, filterindex] = uigetfile( ...
{  '*.wav','WAV-files (*.wav)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Test training files', ...
   'MultiSelect', 'on');
if iscell(filenames)
    nbfiles = length(filenames);
elseif filenames ~= 0
    nbfiles = 1;
else
    nbfiles = 0;
end
for K = 1 : nbfiles
  if(nbfiles > 1)
      filename = filenames{K};
  else
      filename = filenames;
  end
  thisfullname = fullfile(pathname, filename);
%   disp('--------------------------------------------------');
  fprintf('\n%20s\t',filename);
  
    [f,fs] = audioread(thisfullname);
    f=f(:,1);



%% Feature Extraction (MFCCs)

testing_features  = melcepst(f, fs);

%% Feature Matching (Minimum-Distance Classifier)
% 
delta = 0.85; % threshold for identification

mean_testing_feature = mean(testing_features);

d1 = mean((mean_training_feature1 - mean_testing_feature).^2);
d2 = mean((mean_training_feature2 - mean_testing_feature).^2);
 
check_identified(d1, delta, 'd1'); 
check_identified(d2, delta, 'd2'); 

%% Feature Matching (Gaussian Mixture Model)

[pc1, idx1] = Cluster_Probability(testing_features', training_mu1);
[pc2, idx2] = Cluster_Probability(testing_features', training_mu2);
PC = [PC; [pc1 pc2]];
IDX=[IDX;[mean(idx1) mean(idx2)]];
end

