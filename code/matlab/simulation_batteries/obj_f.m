function [ obj_value ] = obj_f ( opt_coeffs, parameters )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Unpack parameters

% funcs
alpha = parameters.alpha;
xi_1  = parameters.xi_1;
xi_2  = parameters.xi_2;

% prices
price_coeffs = opt_coeffs(1:24);
x_1_cost_param = parameters.x_1_cost_param;
x_2_cost_param = parameters.x_2_cost_param;

% constants
phi   = parameters.phi;
sigma = 1/(1-phi);
budget = parameters.budget;

% storage
storage_coeffs = opt_coeffs(27:50);

%% Find utility

% price
price_coeffs_positive = sum(price_coeffs > 0) == length(price_coeffs);

% Input
X_1 = opt_coeffs(25);%(1/x_1_cost_param)*xi_1(linspace(0,1,24))*price_coeffs'/24;
X_2 = opt_coeffs(26);%(1/x_2_cost_param)*xi_2(linspace(0,1,24))*price_coeffs'/24;

% Output
G = (1/24)*(xi_1(linspace(0,1,24))*X_1 + xi_2(linspace(0,1,24))*X_2);
Z = storage_coeffs;

Y = G + Z;
I = price_coeffs*Y'/24;

% price index
P = ((1/24)*(price_coeffs.^(1-sigma))*(alpha(linspace(0,1,24))'.^sigma)).^(1/(1-sigma));
Y_demand = ((price_coeffs./(alpha(linspace(0,1,24)))).^(-sigma)) .* (P.^(1-sigma));
U = (1/24)*(alpha(linspace(0,1,24))*(Y.^phi)').^(1/phi);

% quantity mismatch
q_diff = (30.*(Y - Y_demand)).^4;
q_diff_total = sum(q_diff)/24;

obj_value = -U;%20*q_diff_total;


end
