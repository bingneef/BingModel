
% get sizes
rows = 0;
cols = 0;

for i = 1:length(component_names)
   rows = rows + components.(char(component_names(i))).rows;
   cols = cols + components.(char(component_names(i))).cols;
end

% local - smaller
matrix_local_max = zeros(rows,cols);
r = 1;
c = 1;

for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    matrix_local_max(r:r+obj.rows-1,c:c+obj.cols-1) = obj.makeMaxMatrix();
    
    r = r + obj.rows;
    c = c + obj.cols;
end

% local - storage
matrix_local_stor = zeros(0,cols);
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    if(strcmp(obj.class,'stor'))
        m = zeros(1,cols);
        m(obj.c:obj.c+obj.cols-1-obj.timesteps) = obj.makeStorMatrix();
        matrix_local_stor = [matrix_local_stor;m];
    end
end

% % local - storage - capacity
% matrix_local_stor_capacity = zeros(0,cols);
% for i = 1:length(component_names)
%     obj = components.(char(component_names(i)));
%     if(strcmp(obj.class,'stor'))
%         m = zeros(obj.timesteps * (obj.timesteps-1),cols);
%         m(:,obj.c+1:obj.c+obj.cols-1) = obj.makeCapacityMatrix();
%         matrix_local_stor_capacity = [matrix_local_stor_capacity;m];
%     end
% end

% local - storage - capacity to power
matrix_local_stor_capacity_to_power = zeros(0,cols);
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    if(strcmp(obj.class,'stor'))
        m = zeros(1,cols);
        m(:,obj.c:obj.c+1) = obj.makeCapacityToPowerMatrix();
        matrix_local_stor_capacity_to_power = [matrix_local_stor_capacity_to_power;m];
    end
end

% local - IC
matrix_local_ic = zeros(0,cols);
sol_local_ic = zeros(0,1);
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    if(obj.IC > 0)
        m = zeros(1,cols);
        [m(obj.c:obj.c+obj.cols-1),ic] = obj.makeICMatrix();
        matrix_local_ic = [matrix_local_ic;m];
        sol_local_ic = [sol_local_ic;ic];
    end
end

%%
clear m;
% local - response time
matrix_local_response = zeros(0,cols);
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    m = obj.makeResponseMatrix();
    M = zeros(1*timesteps,cols);
    M(:,obj.c:obj.c+obj.cols-1) = m;
    %if(sum(sum(M)) == 0)
    %    continue;
    %end

    matrix_local_response = [matrix_local_response;M];
end

%%

%combine
A = [...
    matrix_local_max;...
    matrix_local_response;...
    ...%matrix_local_stor_capacity;...
    ];

b = [...
    zeros(length(matrix_local_max(:,1)),1);...
    zeros(length(matrix_local_response(:,1)),1);...
    ...%zeros(length(matrix_local_stor_capacity(:,1)),1);...
    ];

% global - demand
matrix_global_demand = zeros(timesteps,cols);
for i = 1:16    
    for j = 1:length(component_names)
        obj = components.(char(component_names(j)));
        matrix_global_demand = obj.makeDemandMatrix(matrix_global_demand,i);
    end
end

% local - ratio
matrix_local_ratio = zeros(0,cols);
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    m = zeros(obj.timesteps*(length(obj.ratio_in)+length(obj.ratio_out)-1),cols);
    
    if(~isempty(obj.makeRatioMatrix()) && ~strcmp(obj.class,'stor'))
        m(:,obj.c:obj.c+obj.cols-1) = obj.makeRatioMatrix();
        matrix_local_ratio = [matrix_local_ratio;m];
    end
end

%%
% local - ratio_stor
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    m = zeros(obj.timesteps,cols);
    
    if(strcmp(obj.class,'stor'))
        m_t = obj.makeRatioMatrix();
        m(:,obj.c+obj.cols-length(m_t):obj.c+obj.cols-1) = m_t;
        matrix_local_ratio = [matrix_local_ratio;m];
    end
end
%%
%%

% sorting

Aeq = [...
    matrix_global_demand;...    
    matrix_local_ratio;...
    matrix_local_stor;...
    matrix_local_ic;...
    matrix_local_stor_capacity_to_power;...
    ];
beq = [...
    demand_ac;...
    demand_dc;...
    demand_heat_25;...
    demand_heat_800;...
    demand_CH4;...
    demand_H2;...
    demand_C;...
    demand_W;...
    demand_dung;...
    demand_ac_beta;...
    demand_dc_beta;...
    demand_h2_beta;...
    demand_W_beta;...
    zeros(length(matrix_local_ratio(:,1)),1);...
    zeros(length(matrix_local_stor(:,1)),1);...
    sol_local_ic;...
    zeros(length(matrix_local_stor_capacity_to_power(:,1)),1);...
    ];