% [filenames, pathname, filterindex] = uigetfile( ...
% {  '*.wav','WAV-files (*.wav)'; ...
%    '*.*',  'All Files (*.*)'}, ...
%    'Pick a file', ...
%    'MultiSelect', 'on');
errors = 0;
males = 0;
females = 0;
amb = 0;
min = 99999;
max = 0;
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
  [f,fs]=wavread(thisfullname);
  [result(K),mc,fc,ac]=speechFrequency(f,fs);
  fprintf('frequency: %d \n', fs);
  fprintf('Length: %5.3f \n', length(f)/fs);
  fprintf('result: %5.3f \n', result(K) );
  fprintf('mc: %5.3f \n', mc );
  fprintf('fc: %5.3f \n', fc );
  fprintf('ac: %5.3f \n', ac );

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
  if((fc/mc)>3)
      disp('female')
      females = females + 1;
  elseif((mc/fc)>3)
      disp('male');
      males = males + 1;
  else
      if (result(K)>185)
          disp('female')
          females = females + 1;
      elseif (result(K)<160)
          disp('male');
          males = males + 1;
      else
          amb = amb + 1;
          disp('ambiguous');
      end
  end
  
  disp('__________________________________________________');
  

end

fprintf('min: %5.3f\n', min );
fprintf('max: %5.3f\n', max );
fprintf('males: %d\n', males );
fprintf('females: %d\n', females );
fprintf('ambiguous: %d\n', amb );
fprintf('errors: %d\n', errors );