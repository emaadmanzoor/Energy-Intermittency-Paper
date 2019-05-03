%% Optimal capacity of Coal with respect to solar price

close all; clear; clc;

% Simulation params
n = 5000;
research_multiplier = linspace(1,5,n);
sigma_range = [0.5];
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
        x_2_cost_param = c_2;

        % Prices
        xi_mat   = [xi_1; xi_2*(research_multiplier(i))];
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
    output(3,:) = research_multiplier-1;
    
    % subset to positive quantities
    ind = ~any(output(1:2,:) <= 0);
    output = output(:,ind);

    % quantity of solar
    subplot(2,1,1);
    hold on;
    plot(output(3,:)*100, ...
         output(1,:), ...
        'LineWidth', 1);
    
end

%% Plot formatting

% Add horizontal line at 1

% Format subplot 1
xlabel('Percent Change in the Efficiency of Solar (MWh)')
ylabel('Coal Capacity (MWh)')
xtickformat('percentage')
xlim([0, 350])
grid('on')


%% Optimal capacity of Coal with respect to own price

% Simulation params
n = 5000;
cost_multiplier = linspace(1,5,n);
sigma_range = [0.5];
m = length(sigma_range);

% Exogenous params
c_1 = 104.3;
c_2 = 50;
alpha = [0.6, 0.4];
xi_1  = [1,   1];
xi_2  = [1, 0.1];
budget = 1;


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

    % quantity of solar
    subplot(2,1,2);
    hold on;
    plot(output(3,:)*100, ...
         output(1,:), ...
        'LineWidth', 1);
    
end

%% Plot formatting

% Format subplot 2
subplot(2,1,2)
xlabel('Percent Increase in the Cost of Coal')
ylabel('Coal Capacity (MWh)')
xtickformat('percentage')
xlim([0, 350])
grid('on')

% Save figure
print(gcf,'fig_tax_subsidy.png','-dpng','-r300')


