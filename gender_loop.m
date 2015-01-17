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
aAmp = [];
fAmp = [];
mAmp = [];
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
  [result(K),mAmp(K),fAmp(K),aAmp(K)]=speechFrequency(f,fs);
%   fprintf('frequency: %d \n', fs);
%   fprintf('Length: %5.3f \n', length(f)/fs);
  fprintf('fx: %7.3f \t', result(K) );
  fprintf('m: %5f \t', mAmp(K) );
  fprintf('f: %5f \t', fAmp(K) );
  fprintf('a: %5f \t', aAmp(K) );
%   
%   if(result(K) < 50 || result(K) > 500)
%       disp('Error');
%       errors = errors + 1;
% else
%   if((fc/mc)>3)
%       disp('female')
%       females = females + 1;
% %       movefile(thisfullname, pathname+'female_auto');
%   elseif((mc/fc)>3)
%       disp('male');
%       males = males + 1;
% %       movefile(thisfullname, pathname+'male_auto');
%   else
%       if (result(K)>185)
%           disp('female')
%           females = females + 1;
% %       movefile(thisfullname, pathname+'female_auto');
%       elseif (result(K)<160)
%           disp('male');
%           males = males + 1;
% %       movefile(thisfullname, pathname+'male_auto');
%       else
%           amb = amb + 1;
%           disp('ambiguous');
%       end
%   end
%   
%   disp('__________________________________________________');
  

end

fprintf('\nmin: %5.3f\n', min(result) );
fprintf('max: %5.3f\n', max(result) );
% fprintf('males: %d\n', males );
% fprintf('females: %d\n', females );
% fprintf('ambiguous: %d\n', amb );
% fprintf('errors: %d\n', errors );