[filenames, pathname, filterindex] = uigetfile( ...
{  '*.wav','WAV-files (*.wav)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
males = 0;
females = 0;
min = 99999;
max = 0;
for K = 1 : length(filenames)
  thisfullname = fullfile(pathname, filenames{K});
  [f,fs]=wavread(thisfullname);
  result=gender(f,fs);
  disp('--------------------------------------------------');
  disp(filenames{K});
  fprintf('frequency: %d \n', fs);
  fprintf('result: %16.f \n', result );
  if(result > max)
      max = result;
  end
  if(result < min)
      min = result;
  end
  if (result>195)
      disp('female')
      females = females + 1;
  else
      disp('male');
      males = males + 1;
  end
  
  disp('__________________________________________________');
  
end

fprintf('min: %5.f\n', min );
fprintf('max: %5.f\n', max );
fprintf('males: %d\n', males );
fprintf('females: %d\n', females );
