%% Adoption Curve with Respect to Both Prices Sim

close all; clear; clc;

% Simulation params
[c_1_range, c_2_range] = meshgrid(0.5:0.05:2, 0.5:0.05:2);

% Exogenous params
c_1 = 104.3;
c_2 = 50;
alpha = [0.6, 0.4];
xi_1  = [1,   1];
xi_2  = [1, 0.1];
budget = 1;
sigma = 0.5;


figure('Renderer', 'painters', 'Position', [100 100 900 600])
hold on;

results = ones(length(c_1_range), length(c_1_range)); 

for i = 1:length(results)
    for j = 1:length(results)

        phi   = (sigma - 1)/sigma;
        x_1_cost_param = c_1*c_1_range(i,j);
        x_2_cost_param = c_2*c_2_range(i,j);

        % Prices
        xi_mat   = [xi_1; xi_2];
        cost_mat = [x_1_cost_param; x_2_cost_param];
        prices   = xi_mat\cost_mat;

        % Price Index
        P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

        % Quantities
        if sigma ~= 1
            Y = ((alpha'./prices).^(sigma)) * (budget/P);
        else 
            Y = (alpha'./prices);
        end 

        X = (xi_mat')\Y;

        if all(X > 0)
            results(i,j) = X(2)/(X(1) + X(2));
        else
            results(i,j) = nan;
        end

    end    
end

surf(100*(c_1_range-1), 100*(c_2_range-1), results)

%% Plot formatting

xlabel('Percent Change in the Cost of Coal')
ylabel('Percent Change in the Cost of Solar')
zlabel('Solar Capacity as a Fraction of All Capacity')
xtickformat('percentage')
ytickformat('percentage')



