function [ c, ceq ] = constraints( x_1, x_2, parameters )

xi_1   = parameters.xi_1; 
xi_2_t = parameters.xi_2_t;
xi_2_s = parameters.xi_2_s;
alpha  = parameters.alpha;
beta   = parameters.beta;
budget = parameters.budget;
p_1    = parameters.p_1;
p_2    = parameters.p_2;

% profit first-order max
p_t = -(p_2*xi_1 - p_1*xi_2_s)/(xi_1*(xi_2_s - xi_2_t));
p_s = (p_2*xi_1 - p_1*xi_2_t)/(xi_1*(xi_2_s - xi_2_t));

% demand
y_t_demand = alpha*budget/p_t;
y_s_demand = beta*budget/p_s;

% supply
y_t_supply = xi_1*x_1 + xi_2_t*x_2;
y_s_supply = xi_1*x_1 + xi_2_s*x_2;

% output used
y_t = min(y_t_supply, y_t_demand);
y_s = min(y_s_supply, y_s_demand);

cost_f = @(x_1, x_2) p_1*x_1 + p_2*x_2;


%% <= constraints
positive_output_y_t = -y_t;
positive_output_y_s = -y_s;
positive_profit = y_t*p_t + y_s*p_s - cost_f(x_1, x_2);
c = [positive_output_y_t, positive_output_y_s, -positive_profit];


%% == constraints
budget_constraint = ((y_t*p_t + y_s*p_s) - budget).^2;

ceq = [budget_constraint];


end

