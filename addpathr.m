function addpathr(varargin)
% ADDPATHR  Recursively add folders to search path.
%   ADDPATHR will add the user provided directories and all of their
%   subdirectories to the MATLAB search path. Hidden folders and MATLAB
%   special folders are being ignored.
%
% (c) 2016 Florian Rau

for d = varargin
    if isdir(d{:})
        
        % add current directory
        addpath(d{:})
        
        % process subdirectories
        tmp = dir(d{:});
        tmp = tmp([tmp.isdir]);
        tmp = tmp(~cellfun('isempty',{tmp.date})); 
        tmp = {tmp(cellfun('isempty',regexpi({tmp.name},'^[.+@]'))).name};
        tmp = fullfile(d{:},tmp);
        addpathr(tmp{:})

    else
        return
    end    
end
    