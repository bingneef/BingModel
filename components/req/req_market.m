classdef req_market < comp_blueprint
    properties
        nvars = 9;
        flow_names = {'AC OUT','DC OUT','HEAT 25 OUT','HEAT 800 OUT','CH4 OUT','H2 OUT','C OUT','WASTE','DUNG OUT'};        
        capex = 0;
        opex = 5;   
        response_time = 0;
        factor = [10000,10000,100,100,100,10,100,100,100];
        
        class = 'market';
    end
    
    methods
        function obj = req_market(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 1;
            
            obj.in = [];
            obj.out = [obj.ac,obj.dc,obj.heat_25,obj.heat_800,obj.ch4,obj.h2,obj.C,obj.W,obj.dung];
            obj.response_factor = obj.responseFactor();
        end
        
        function c = costs(obj,x)
            matrix_c = kron(obj.factor,ones(1,obj.timesteps));
            vars = x(obj.c+1:obj.c+length(matrix_c))';
            %vars = x(end-length(matrix_c)+1:end)';
            c = matrix_c * vars;
        end
    end
end