clear;
[filenames, pathname, filterindex] = uigetfile( ...
{  '*.wav','WAV-files (*.wav)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
errors = 0;
males = 0;
females = 0;
amb = 0;
if iscell(filenames)
    nbfiles = length(filenames);
elseif filenames ~= 0
    nbfiles = 1;
else
    nbfiles = 0;
end
result=[];
mEnrgy = [];
fEnrgy = [];
ambEnrgy = [];
tEnrgy = [];
for K = 1 : nbfiles
  if(nbfiles > 1)
      filename = filenames{K};
  else
      filename = filenames;
  end
  thisfullname = fullfile(pathname, filename);
%   disp('--------------------------------------------------');
  fprintf('\n%20s\t',filename);
  [f,fs,nb]=wavread(thisfullname);
    l = length(f)/fs;
%   if(l<1)
%       continue
%   end
  [result(K,1),result(K,2), mEnrgy(K), fEnrgy(K),tEnrgy(K)]=speechAnalysis( f,fs);
%   
  
%   fprintf('sample rate: %d \n', fs);
%   fprintf('Length: %5.1f \n', length(f)/fs);
  fprintf('fx: %7.3f \t', result(K,1) );
  fprintf('fe: %10f \t', fEnrgy(K));
  fprintf('me: %10f \t', mEnrgy(K));
  fprintf('ae: %5f \t', tEnrgy(K));
% %   if((fc/mc)>2)
% %       disp('female')
% %       females = females + 1;
% % %       movefile(thisfullname, fullfile(pathname,'female_auto',filename),'f');
% %   elseif(mc/fc>2)
% %             disp('male')
% %       males = males + 1;
% % %       movefile(thisfullname, fullfile(pathname,'male_auto',filename),'f');
%   if(result(K,1) < 50 || result(K,1) > 500)
% %       disp('Error');
%       errors = errors + 1;
%   elseif(result(K,1)>180 && (fc/mc)>2 )
% %       disp('female')
%       females = females + 1;
% %       movefile(thisfullname, fullfile(pathname,'female_auto',filename),'f');
%   elseif (result(K,1)<165 && (mc/fc)>2)
% %       disp('male');
%       males = males + 1;
% %       movefile(thisfullname, fullfile(pathname,'male_auto',filename),'f');
%   else
%       amb = amb + 1;
% %       disp('ambiguous');
%   end
  
%   disp('__________________________________________________');
  
end

% 
% fprintf('\nmin fx: %5f\n', min(result(:,1)) );
% fprintf('max fx: %5f\n', max(result(:,1)) );
% fprintf('males: %d\n', males );
% fprintf('females: %d\n', females );
% fprintf('ambiguous: %d\n', amb );
% fprintf('errors: %d\n', errors );