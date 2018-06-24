function [c, ceq] = confun(obj_vars, p_1, p_2, c_1, c_2, xi_1_d, xi_1_n, xi_2_d, ...
    xi_2_n, alpha, beta, budget, eta_1, eta_2)

% 
x = obj_vars(1:2);
p_d = obj_vars(3);
p_n = obj_vars(4);

% Output function
output_d = @(x) xi_1_d.*x(1) + xi_2_d.*x(2);
output_n = @(x) xi_1_n.*x(1) + xi_2_n.*x(2);

% Input cost functions
cost_x = @(x) (p_1*(x(1)-c_1)^eta_1 + p_2*(x(2)-c_1)^eta_2) + 1; %(p_1 + log(x(1)))*x(1) + (p_2 + log(x(2)))*x(2);

% % Demand functions
demand_d = @(x) (alpha*budget)/p_d;
demand_n = @(x) (alpha*budget)/p_n;

inv_demand_d = @(x) (alpha*budget)/output_d(x);   %15 - log(output_d(x)+1);
inv_demand_n = @(x) (beta*budget)/output_n(x);   %15 - log(output_n(x)+1);

% Profit
revenue_d = @(x) min([output_d(x), demand_d(x)])*p_d;
revenue_n = @(x) min([output_n(x), demand_n(x)])*p_n;
profit = @(x) revenue_d(x) + revenue_n(x) - (cost_x(x));


%% Nonlinear inequality constraints

% %budget constraint
con_budget_cons = p_d*output_d(x) + p_n*output_n(x) - budget;

% firms making profit
profit_cons = -profit(x);
 
c = [profit_cons, con_budget_cons];  

%% Nonlinear equality constraints

ceq = [];


end