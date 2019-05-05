%% Elasticity of Substitution Sim with error bars on sigma estimate

close all; clear; clc;

% Simulation params
n = 500;
cost_multiplier = linspace(0.5,2,n);
sigma_range = [0.8847 + 2*0.044, 0.8847, 0.8847 - 2*0.044];
m = length(sigma_range);

% Exogenous params
c_1 = 104.3;
c_2 = 50;
alpha = [0.6, 0.4];
xi_1  = [1,   1];
xi_2  = [1, 0.1];
budget = 1;


figure('Renderer', 'painters', 'Position', [100 100 900 600])
hold on;

for j = 1:m
    
    sigma = sigma_range(j);
    results = zeros(n,2); 

    for i = 1:n


        phi   = (sigma - 1)/sigma;
        x_1_cost_param = c_1*cost_multiplier(i);
        x_2_cost_param = c_2;

        % Prices
        xi_mat   = [xi_1; xi_2];
        cost_mat = [x_1_cost_param; x_2_cost_param];
        prices   = xi_mat\cost_mat;

        if any(prices<0)
            continue
        end

        % Price Index
        P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));
        if sigma == 1
            P = 1;
        end
        
        % Quantities
        Y = ((alpha'./prices).^(sigma)) * (budget/P);
           
        X = (xi_mat')\Y;

        results(i,:) = X';

    end    

    output = [];
    output(1,:) = c_1*cost_multiplier'./c_2;
    output(2,:) = results(:,1)./results(:,2);

    % subset to positive quantities
    ind = ~any(output <= 0);
    output = output(:,ind);

    % relationship between log prices and quantities
    subplot(2,1,1);
    hold on;
    
    if sigma == 0.8847
        plot(-log(output(1,:)), log(output(2,:)), ...
            'LineWidth', 1, 'Color', 'k');
    elseif sigma < 0.8846
        plot(-log(output(1,:)), log(output(2,:)), ...
            'LineWidth', 1, 'LineStyle', '--', 'Color', [0 0 1]*0.8);
    else
        plot(-log(output(1,:)), log(output(2,:)), ...
            'LineWidth', 1, 'LineStyle', '--', 'Color', [1 0 0]*0.8);
    end
    
    
    % relationship between log prices and quantities
    subplot(2,1,2);
    hold on;
    
    if sigma == 0.8847
        plot(-log(output(1,2:end)), ...
            diff(log(output(2,:)))./diff(-log(output(1,:))), ...
            'LineWidth', 1, 'Color', 'k');
    elseif sigma < 0.8846
        plot(-log(output(1,2:end)), ...
            diff(log(output(2,:)))./diff(-log(output(1,:))), ...
            'LineWidth', 1, 'LineStyle', '--', 'Color', [0 0 1]*0.8);
    else
        plot(-log(output(1,2:end)), ...
            diff(log(output(2,:)))./diff(-log(output(1,:))), ...
            'LineWidth', 1, 'LineStyle', '--', 'Color', [1 0 0]*0.8);
    end
    
end

%% Plot formatting

% Format subplot 1
subplot(2,1,1);
legend('0.9727 (Upper 95% Confidence Limit)', '0.8847', ...
    '0.7967 (Lower 95% Confidence Limit)')
xlabel({'Negative Log Difference in Costs', 'log(c_2/c_1)'})
ylabel({'Log Difference in Quantities', 'log(X_1/X_2)'})
xlim([-1.5, -0.4])
grid('on')

% Format legend
[hleg,att] = legend('show');
legend('Location', 'northwest')
title(hleg, {'\sigma', '(Intertemporal Elasticity of Substitution', ...
    'for Electricity Consumption)'})

% Format subplot 2
subplot(2,1,2);
xlabel({'Negative Log Difference in Costs', 'log(c_2/c_1)'})
ylabel({'Elasticity of Substitution', ...
    'between Technologies', 'e_{1, 2}',})
xlim([-1.5, -0.4])
ylim([0 15])
grid('on')

% Save figure
print(gcf,'fig_elasticity.png','-dpng','-r300')

