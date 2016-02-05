function [c, ceq] = constraint(x,components,component_names)
 

    c = [];
    ceq = [];

    for i = 1:length(component_names)
        obj = components.(char(component_names(i)));
        [c,ceq] = obj.makeFuelCellMatrix(x,c,ceq);
    end
    
%     c = [...
%         x(2)-95;...
%         60-x(2);...
%         x(3)-95;...
%         60-x(3);...
%         x(4)-95;...
%         60-x(4)]
%    
%     ceq = [...
%         x(5) - 1/(((0.70-0.55)/(95-60))*(x(2)-60)+0.55)*x(8),...
%         x(5) - 1/(((0.25-0.20)/(95-60))*(x(2)-60)+0.20)*x(11),...
%         x(5) - 1/(((0.05-0.25)/(95-60))*(x(2)-60)+0.25)*x(14),...
%         ...
%         x(6) - 1/(((0.70-0.55)/(95-60))*(x(3)-60)+0.55)*x(9),...
%         x(6) - 1/(((0.25-0.20)/(95-60))*(x(3)-60)+0.20)*x(12),...
%         x(6) - 1/(((0.05-0.25)/(95-60))*(x(3)-60)+0.25)*x(15),...
%         ...
%         x(7) - 1/(((0.70-0.55)/(95-60))*(x(4)-60)+0.55)*x(10),...
%         x(7) - 1/(((0.25-0.20)/(95-60))*(x(4)-60)+0.20)*x(13),...
%         x(7) - 1/(((0.05-0.25)/(95-60))*(x(4)-60)+0.25)*x(16)...
%         ];