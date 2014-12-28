
[filenames, pathname, filterindex] = uigetfile( ...
{  '*.wav','WAV-files (*.wav)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
errors = 0;
males = 0;
females = 0;
amb = 0;
min = [99999,99999];
max = [0,0];
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
  disp('--------------------------------------------------');
  disp(filename);
  [f,fs,nb]=wavread(thisfullname);
  [result(1,K), result(2,K)]=speechAnalysis(f,fs,nb);
  fprintf('frequency: %d \n', fs);
  fprintf('result: %5.3f \n', result(K) );

  if(result(1,K) > max(1))
      max(1) = result(1, K);
  end
  if(result(1,K) < min(1))
      min(1) = result(1,K);
  end
  if(result(2,K) > max(2))
      max(2) = result(2, K);
  end
  if(result(2,K) < min(2))
      min(2) = result(2,K);
  end
%   
%   if(result(K) < 50 || result(K) > 500)
%       disp('Error');
%       errors = errors + 1;
% else
%   if (result(K)>250)
%       disp('female')
%       females = females + 1;
%   elseif (result(K)<230)
%       disp('male');
%       males = males + 1;
%   else
%       amb = amb + 1;
%       disp('ambiguous');
%   end
  
  disp('__________________________________________________');
  
end

fprintf('min fx: %5.3f\n', min(1) );
fprintf('max fx: %5.3f\n', max(1) );

fprintf('min std: %5.3f\n', min(2) );
fprintf('max std: %5.3f\n', max(2) );

% fprintf('males: %d\n', males );
% fprintf('females: %d\n', females );
% fprintf('ambiguous: %d\n', amb );
% fprintf('errors: %d\n', errors );