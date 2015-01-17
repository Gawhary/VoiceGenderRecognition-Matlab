[filenames, pathname, filterindex] = uigetfile( ...
{  '*.wav','WAV-files (*.wav)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
errors = 0;
males = 0;
females = 0;
amb = 0;
result = [];
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
  fprintf('\n%20s\t',filename);
  [f,fs]=wavread(thisfullname);
  l = length(f)/fs;
%   if(l<1)
%       continue
%   end
  [ma(K), fa(K), aa(K)] = maleFemalePower(f,fs);
  fprintf('Male: %11f\t\tFemale: %11f\tTotal: %9f', ma(K),fa(K), aa(K));

end
