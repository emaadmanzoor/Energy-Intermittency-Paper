function [ c, ceq ] = constraints( price_coeffs, parameters )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Unpack

% funcs
alpha = parameters.alpha;
xi_1  = parameters.xi_1;
xi_2  = parameters.xi_2;

% prices
x_1_cost_param = parameters.x_1_cost_param;
x_2_cost_param = parameters.x_2_cost_param;

% constants
phi   = parameters.phi;
sigma = 1/(1-phi);
budget = parameters.budget;


%% Condition

% price
price_coeffs_positive = sum(price_coeffs > 0) == length(price_coeffs);

% 
X_1 = (1/x_1_cost_param)*xi_1(linspace(0,1,24))*price_coeffs'/24;
X_2 = (1/x_2_cost_param)*xi_2(linspace(0,1,24))*price_coeffs'/24;

Y = (1/24)*(xi_1(linspace(0,1,24))*X_1 + xi_2(linspace(0,1,24))*X_1);
I = price_coeffs*Y'/24;

% price index
P = ((1/24)*(price_coeffs.^(1-sigma))*(alpha(linspace(0,1,24))'.^sigma)).^(1/(1-sigma));
Y_demand = ((price_coeffs./(alpha(linspace(0,1,24)))).^(-sigma)) .* (P.^(1-sigma));



%% <= constraints

budget_constraint = I - budget;

c = [budget_constraint];


%% == constraints

ceq = [1 - price_coeffs_positive];


end

