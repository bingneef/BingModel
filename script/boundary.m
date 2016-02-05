%% setup
random = rand(timesteps,1);
zero = zeros(timesteps,1);
one = ones(timesteps,1);

%% set CFs
CF_ZERO = zeros(timesteps,1);
CF_FULL = ones(timesteps,1);
[CF_W,CF_S] = deal(zero);
[demand_ac,demand_dc,demand_heat_25,demand_heat_800,demand_CH4,demand_H2,demand_C,demand_W,demand_dung,demand_ac_beta,demand_dc_beta,demand_h2_beta,demand_W_beta] = deal(zero);

%% Check if exist and average
if(exist(strcat(cat,'/CF_WIND.txt'),'file'))
    CF_W = average_from_large(importdata(strcat(cat,'/CF_WIND.txt')),timesteps);
end
if(exist(strcat(cat,'/CF_SOLAR.txt'),'file'))
    CF_S = average_from_large(importdata(strcat(cat,'/CF_SOLAR.txt')),timesteps);
end

CF_MARKET = zero; %no extra values from market!

if(exist(strcat(cat,'/DEMAND_AC.txt'),'file'))
    demand_ac = average_from_large(importdata(strcat(cat,'/DEMAND_AC.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_DC.txt'),'file'))
    demand_dc = average_from_large(importdata(strcat(cat,'/DEMAND_DC.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_HEAT_25.txt'),'file'))
    demand_heat_25 = average_from_large(importdata(strcat(cat,'/DEMAND_HEAT_25.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_HEAT_800.txt'),'file'))
    demand_heat_800 = average_from_large(importdata(strcat(cat,'/DEMAND_HEAT_800.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_CH4.txt'),'file'))
    demand_CH4 = average_from_large(importdata(strcat(cat,'/DEMAND_CH4.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_H2.txt'),'file'))
    demand_H2 = average_from_large(importdata(strcat(cat,'/DEMAND_H2.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_C.txt'),'file'))
    demand_C = average_from_large(importdata(strcat(cat,'/DEMAND_C.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_W.txt'),'file'))
    demand_W = average_from_large(importdata(strcat(cat,'/DEMAND_W.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_DUNG.txt'),'file'))
    demand_dung = average_from_large(importdata(strcat(cat,'/DEMAND_DUNG.txt')),timesteps);
end

if(exist(strcat(cat,'/DEMAND_AC_BETA.txt'),'file'))
    demand_ac_beta = average_from_large(importdata(strcat(cat,'/DEMAND_AC_BETA.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_DC_BETA.txt'),'file'))
    demand_dc_beta = average_from_large(importdata(strcat(cat,'/DEMAND_DC_BETA.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_H2_BETA.txt'),'file'))
    demand_h2_beta = average_from_large(importdata(strcat(cat,'/DEMAND_H2_BETA.txt')),timesteps);
end
if(exist(strcat(cat,'/DEMAND_W_BETA.txt'),'file'))
    demand_W_beta = average_from_large(importdata(strcat(cat,'/DEMAND_W_BETA.txt')),timesteps);
end