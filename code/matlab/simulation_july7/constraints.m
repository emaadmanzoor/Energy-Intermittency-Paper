function [ c, ceq ] = constraints( p_t, p_s, parameters )

xi_1   = parameters.xi_1; 
xi_2_t = parameters.xi_2_t;
xi_2_s = parameters.xi_2_s;
alpha  = parameters.alpha;
beta   = parameters.beta;
budget = parameters.budget;
p_1    = parameters.p_1;
p_2    = parameters.p_2;

% supply
x_1 = (2*p_1)^(-1)*(p_t*xi_1 + p_s*xi_1);
x_2 = (2*p_2)^(-1)*(p_t*xi_2_t + p_s*xi_2_s);
y_t_supply = xi_1*x_1 + xi_2_t*x_2;
y_s_supply = xi_1*x_1 + xi_2_s*x_2;

% demand
y_t_demand = alpha*budget/p_t;
y_s_demand = beta*budget/p_s;

% output used
y_t = min(y_t_supply, y_t_demand);
y_s = min(y_s_supply, y_s_demand);


%% <= constraints
positive_output_y_t = -y_t;
positive_output_y_s = -y_s;
positive_profit = y_t*p_t + y_s*p_s - (p_1*x_1^2 + p_2*x_2^2);
c = [positive_output_y_t, positive_output_y_s, -positive_profit];


%% == constraints
budget_constraint = ((y_t*p_t + y_s*p_s) - budget).^2;
sd_t = p_s*(xi_1^2 + xi_2_s*xi_2_t) + p_t*(xi_1^2 + xi_2_t^2) - alpha*budget/p_t;
sd_s = p_t*(xi_1^2 + xi_2_s*xi_2_t) + p_s*(xi_1^2 + xi_2_s^2) - beta*budget/p_s;

ceq = [budget_constraint, sd_t, sd_s];


end

