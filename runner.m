%% initiate
clear all; close all; clc;
addpath(genpath('script'));
addpath(genpath('components'));
addpath(genpath('load'));

warning('off','all')
%% Off
for timesteps = 480:48:960
    fprintf('\n\n%i\n',timesteps)
    script;
end

%% let me know!
%sendMail;