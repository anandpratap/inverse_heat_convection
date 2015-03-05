% Initialize the ADiMat runtime environment in MATLAB. Part of the
% ADiMat tool: Automatic Differentiation of Matlab programs.
%
% Copyright 2001-2008 Andre Vehreschild, Institute for Scientific Computing   
% Copyright 2009-2011 Johannes Willkomm, Fachgebiet Scientific Computing,
%                     TU Darmstadt
% Contact: willkomm@sc.rwth-aachen.de
%

adimathome = getenv('ADIMAT_HOME');
if isempty(adimathome)
  adimathome = '/usr/local';
end

if ispc
  adimat_prefix = adimathome;
else
  adimat_prefix = [ adimathome '/share/adimat'];
end

% files in the runtime directory are always needed
addpath([adimat_prefix '/runtime']);

% set type of derivatives
derivclassName = getenv('ADIMAT_DERIV_CLASSPATH');
if isempty(derivclassName)
  derivclassName = getenv('ADIMAT_DERIVCLASS');
  if isempty(derivclassName)
    derivclassName = 'opt_derivclass';
  end
end
addpath([ adimat_prefix  '/' derivclassName ]);

% set type of adjoints
adjointName = getenv('ADIMAT_ADJOINT');
if isempty(adjointName)
  adjointName = 'default';
end
adimat_adjoint(adjointName);

% set stack implementation. native-cell is not the fastest, but it
% works on all machines
stackName = getenv('ADIMAT_STACK');
if isempty(stackName) 
  stackName = 'native-cell';
end
adimat_stack(stackName);

stackName = getenv('ADIMAT_INFO_STACK');
if isempty(stackName) 
  stackName = 'log';
end
adimat_info_stack(stackName);

clear adimathome adimat_prefix admversion adjointName derivclassName ...
    stackName ans;

% Local Variables:
% mode: matlab
% End:

% $Id: ADiMat_startup.m.in 3360 2012-08-08 16:26:25Z willkomm $
