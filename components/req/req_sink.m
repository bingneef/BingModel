classdef req_sink < comp_blueprint
    properties
        nvars = 13;
        flow_names = {'AC IN','DC IN','HEAT 25 IN','HEAT 800 IN','CH4 IN','H2 IN','C IN','WASTE','DUNG IN','AC_BETA IN','DC_BETA IN','H2_BETA IN','WASTE_BETA IN'};        
        capex = 0;
        opex = 0;   
        response_time = 0;
        %factor = [0,0,0,0,0,1,1,0];
        factor = [0,0,0,1,1,0,0,5,0,0,0,0,5];
        %factor = 0.01*[1,1,1,1,1,1,1,1,1,1,1,1,1];
        
        class = 'sink';
    end
    
    methods
        function obj = req_sink(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 1;
            
            obj.in = [obj.ac,obj.dc,obj.heat_25,obj.heat_800,obj.ch4,obj.h2,obj.C,obj.W,obj.dung,obj.ac_beta,obj.dc_beta,obj.h2_beta,obj.W_beta];
            obj.out = [];
            obj.response_factor = obj.responseFactor();
        end
        
        function c = costs(obj,x)
            matrix_kron = ones(1,obj.timesteps);
            %matrix_kron = zeros(1,obj.timesteps);
            matrix_kron(end) = 1;
            
            matrix_c = kron(obj.factor,matrix_kron);
            vars = x(end-length(matrix_c)+1:end)';
            c = matrix_c * vars;
        end
    end
end