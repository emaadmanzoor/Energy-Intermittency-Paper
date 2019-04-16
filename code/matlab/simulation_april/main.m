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


%% Price Elasticity Sim

n = 100;
results = zeros(n,2); 
cost_range = linspace(0.5,1.5,n);

for i = 1:n
    
    x_1_cost_param = cost_range(i);

    alpha = [1, 2];
    xi_1  = [1, 1];
    xi_2  = [0.5, 1.5];

    sigma = 0.5;
    phi   = (sigma - 1)/sigma;
    budget = 1;

    x_2_cost_param = 1;

    % Prices
    xi_mat   = [xi_1; xi_2];
    cost_mat = [x_1_cost_param; x_2_cost_param];
    prices   = xi_mat\cost_mat;
    
    if any(prices<0)
        continue
    end
    
    % Price Index
    P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

    % Quantities
    Y = ((alpha'./prices).^(sigma)) * (budget/P);
    X = (xi_mat')\Y;
    
    results(i,:) = X';
    
end    
    
output = [];
output(1,:) = cost_range'./1;
output(2,:) = results(:,1)./results(:,2);

% subset to positive quantities
ind = ~any(output <= 0);
output = output(:,ind);

% relationship between log prices and quantities
plot(log(output(1,:)), log(output(2,:)))
xlabel('Log Difference in Prices')
ylabel('Log Difference in Quantities')

    
    
    
    
    
    
    