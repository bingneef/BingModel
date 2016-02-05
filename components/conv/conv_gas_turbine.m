classdef conv_gas_turbine < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'CH4 IN','AC OUT','WASTE'};        
        capex = 16.04;
        opex = 0;   
        response_time = 0;
        class = 'conv';
    end
    
    methods
        function obj = conv_gas_turbine(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*obj.nvars + 1;
            
            obj.in = [obj.ch4];
            obj.out = [obj.ac,obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.25;0.75];
            obj.response_factor = obj.responseFactor();
        end
    end
end