%%% Model %%%
% Linear cost
% CES Utility
% Two Periods


%% Parameters

alpha = [1, 2];
xi_1  = [1, 1];
xi_2  = [0.5, 1.5];

sigma = 0.5;
phi   = (sigma - 1)/sigma;
budget = 1;

x_1_cost_param = 1;
x_2_cost_param = 1;

%% Solution

% Prices
xi_mat   = [xi_1; xi_2];
cost_mat = [x_1_cost_param; x_2_cost_param];
prices   = xi_mat\cost_mat;

% Price Index
P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

% Quantities
Y = ((alpha'./prices).^(sigma)) * (budget/P);
X = (xi_mat')\Y;

X