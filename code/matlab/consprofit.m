function [c, ceq] = confun(vars)

% 
x = obj_vars(1:2);
p_1 = obj_vars(3);
p_2 = obj_vars(4);
p_d = obj_vars(5);
p_n = obj_vars(6);

% Output function
output_d = @(x) xi_1_d.*x(1) + xi_2_d.*x(2);
output_n = @(x) xi_1_n.*x(1) + xi_2_n.*x(2);

% Input cost functions
cost_x = @(x) (p_1*x(1) + p_2*x(2)); %(p_1 + log(x(1)))*x(1) + (p_2 + log(x(2)))*x(2);

% Demand functions
inv_demand_d = @(x) (alpha*budget)/output_d(x);   %15 - log(output_d(x)+1);
inv_demand_n = @(x) (beta*budget)/output_n(x);   %15 - log(output_n(x)+1);

% Profit
profit = @(x) max([output_d(x)*inv_demand_d(x) ...
    + output_n(x)*inv_demand_n(x) - (cost_x(x)), 0]);


%% Nonlinear inequality constraints

% production >= consumption
prod_d_cons = (alpha*budget)/p_d - output_d(x);
prod_n_cons = (beta*budget)/p_n  - output_n(x);

% budget constraint
con_budget_cons = p_d*output_d(x) + p_n*output_n(x) - budget;
prod_budget_cons =  cost_x(x) - (p_d*output_d(x) + p_n*output_n(x));

% firms making profit
profit_cons = -profit(x);
 
c = [prod_d_cons; prod_n_cons; con_budget_cons; prod_budget_cons; profit_cons];  

%% Nonlinear equality constraints

ceq = [];


end