
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
  [result(K)]=speechAnalysis_f(f,fs,nb);
  fprintf('frequency: %d \n', fs);
  fprintf('result: %5.3f \n', result(K) );

  if(result(K) > max)
      max = result(K);
  end
  if(result(K) < min)
      min = result(K);
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

fprintf('min fx: %5.3f\n', min );
fprintf('max fx: %5.3f\n', max );

% fprintf('males: %d\n', males );
% fprintf('females: %d\n', females );
% fprintf('ambiguous: %d\n', amb );
% fprintf('errors: %d\n', errors );