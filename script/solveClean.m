%% set limits
nvars = length(A(1,:));    % Number of variables
 
ObjectiveFunction = @(x) fitness(x,components,component_names);
ConstraintFunction = @(x) constraint(x,components,component_names);
LB = zeros(1,nvars);    % Lower bound
UB = 10000*ones(1,nvars); % Upper bound
 
x0 = zeros(1,nvars);
%x0 = importdata('test.mat')';

%% create f
f = zeros(1,nvars);
% for i = 1:length(component_names)
%     obj = components.(char(component_names(i)));
%     f(obj.c:obj.c+obj.cols-1) = obj.makeCostArray();
% end

obj = components.('SINK');
f(obj.c:obj.c+obj.cols-1) = obj.makeCostArray();


 
%% solve

options = optimoptions('fmincon','Algorithm','active-set');
%options = optimoptions(options,'Display','iter');
options = optimoptions(options,'MaxFunEvals',5000000);
options = optimoptions(options,'MaxIter',10000);
% options = optimoptions('fmincon','Algorithm','sqp');
options = optimoptions(options,'Display','none'); %really don't want the output telling me how awesome this is

options = optimoptions('linprog','Display','none'); %really don't want the output telling me how awesome this is

%[x,~,exitflag] = fmincon(ObjectiveFunction,x0,A,b,Aeq,beq,LB,UB,ConstraintFunction,options);
[x,~,exitflag] = linprog(f,A,b,Aeq,beq,LB,UB,x0,options);
x(x<1e-3) = 0;

if(exitflag < 0)
    display(exitflag)
end