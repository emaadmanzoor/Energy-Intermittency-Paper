function [ output ] = sim_function(v)
% ========================================================================
% SIM_FUNCTION finds the optimal X_1 given a multiplier 
% for the output efficiency of solar and a tax rate on coal
% ========================================================================
% INPUT ARGUMENTS:
%   v             (matrx)  the first entry is the multiplier on the output
%                          efficiency of solar and the second entry is the 
%                          tax rate
% ========================================================================

alpha = [0.6, 0.4];
xi_1  = [1, 1];
xi_2  = [1, 0.1]*v(1);

sigma = 1;
phi   = (sigma - 1)/sigma;
budget = 1;
gamma = 70;

c_1 = 104.3;
c_2 = 50;
c_b = 0.75;

x_1_cost_param = c_1+v(2);
x_2_cost_param = c_2;

% Prices
xi_mat   = [xi_1; xi_2];
cost_mat = [x_1_cost_param; x_2_cost_param];
prices   = xi_mat\cost_mat;

% Price Index
P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

if sigma == 1
    P = 1;
end
        

% Quantities
Y = ((alpha'./prices).^(sigma)) * (budget/P);
X = (xi_mat')\Y;

% Tax revenue + Pollution costs 
tax_revenue    = v(2) * X(1);
pollution_dmg  = gamma*X(1);

% Beta costs
beta_cost = c_b*v(1);

% Consumer surplus trim
cons_surplus_trim = -alpha(1)*budget*log(prices(1)) + ...
                    -alpha(2)*budget*log(prices(2));

output = [X(1), X(2), ...
    tax_revenue - pollution_dmg, cons_surplus_trim, -beta_cost];

end