function [ c, ceq ] = constraints( opt_coeffs, parameters )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Unpack

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


%% Condition

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
q_diff = (20.*(Y - Y_demand)./Y).^4;
q_diff_total = sum(q_diff)/24;



%% <= constraints

budget_constraint = I - budget;
budget_constraint2 = (x_1_cost_param*X_1 + x_2_cost_param*X_2) - budget;
% storage
energy_con = sum(Z); % use less energy than input

c = [budget_constraint, budget_constraint2, energy_con, q_diff_total - 0.5];


%% == constraints

% storage
slack = 0.01;

stored_energy = zeros(1,24);
stored_energy(1) = -Z(1); % initial z should be negative to add charge

energy_avail = zeros(1,24); % 1 if available else 0
energy_avail(1) = Z(1) < 0;

for i = 2:24
    stored_energy(i) = stored_energy(i-1)*(1-parameters.storage_decay) - Z(i);
    energy_avail(i) = Z(i) < G(i) + stored_energy(i) + slack;
end

ceq = [1 - price_coeffs_positive, 1 - energy_avail];


end

