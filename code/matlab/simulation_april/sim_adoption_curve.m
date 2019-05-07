%% Adoption with Respect to Price of Solar Sim

close all; clear; clc;

% Simulation params
n = 5000;
cost_multiplier = linspace(0.01,2,n);
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
        x_1_cost_param = c_1;
        x_2_cost_param = c_2*cost_multiplier(i);

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
    output(1,:) = results(:,1);
    output(2,:) = results(:,2);
    output(3,:) = cost_multiplier-1;
    
    % subset to positive quantities
    ind = ~any(output(1:2,:) <= 0);
    output = output(:,ind);

    % adoption curve for solar
    hold on;
    subplot(2,1,1);
    plot(output(3,:)*100, ...
         100*output(2,:)./(output(1,:) + output(2,:)), ...
        'LineWidth', 1);
    
end

%% Plot formatting

% Format plot 1
legend('0.9727 (Upper 95% Confidence Limit)', '0.8847', ...
    '0.7967 (Lower 95% Confidence Limit)')
xlabel('Percent Change in the Cost of Solar')
ylabel({'Solar Capacity', 'as a Fraction of All Capacity'})
xtickformat('percentage')
ytickformat('percentage')
xlim([-80, 40])
ylim([0 100])
grid('on')

% Format legend
[hleg,att] = legend('show');
legend('Location', 'southwest')
title(hleg, '\sigma')

% Save figure
%print(gcf,'fig_adoption_c2.png','-dpng','-r300')


%% Adoption with Respect to Price of Solar Sim

% Simulation params
n = 5000;
cost_multiplier = linspace(0.50,3,n);
sigma_range = [0.8847 + 2*0.044, 0.8847, 0.8847 - 2*0.044];
m = length(sigma_range);

% Exogenous params
c_1 = 104.3;
c_2 = 50;
alpha = [0.6, 0.4];
xi_1  = [1,   1];
xi_2  = [1, 0.1];
budget = 1;


%figure('Renderer', 'painters', 'Position', [100 100 900 600])
%hold on;

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
    output(1,:) = results(:,1);
    output(2,:) = results(:,2);
    output(3,:) = cost_multiplier-1;
    
    % subset to positive quantities
    ind = ~any(output(1:2,:) <= 0);
    output = output(:,ind);

    % adoption curve for solar
    hold on;
    subplot(2,1,2);
    plot(output(3,:)*100, ...
         100*output(2,:)./(output(1,:) + output(2,:)), ...
        'LineWidth', 1);
    
end

%% Plot formatting

% Format plot 2
xlabel('Percent Change in the Cost of Coal')
ylabel({'Solar Capacity', 'as a Fraction of All Capacity'})
xtickformat('percentage')
ytickformat('percentage')
xlim([-30, 200])
ylim([0 100])
grid('on')

% Save figure
print(gcf,'fig_adoption_c1.png','-dpng','-r300')

