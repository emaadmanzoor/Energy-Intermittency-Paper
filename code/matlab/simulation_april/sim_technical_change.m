%% Price (Cost) Elasticity Sim

n = 500;
results = zeros(n,2); 
cost_multiplier = linspace(0.5,2,n);
sigma_range = [0.1, 0.5, 1.0, 1.5, 2];
m = length(sigma_range);


figure;
hold on;

for j = 1:m
    
    sigma = sigma_range(j);

    for i = 1:n

        alpha = [0.6, 0.4];
        xi_1  = [1,   1];
        xi_2  = [1, 0.1];
        
        phi   = (sigma - 1)/sigma;
        budget = 1;

        x_1_cost_param = 104.3*cost_multiplier(i);
        x_2_cost_param = 50;

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
        if sigma ~= 1
            Y = ((alpha'./prices).^(sigma)) * (budget/P);
        else 
            Y = (alpha'./prices);
        end 
           
        X = (xi_mat')\Y;

        results(i,:) = X';

    end    

    output = [];
    output(1,:) = 95*cost_multiplier'./50;
    output(2,:) = results(:,1)./results(:,2);

    % subset to positive quantities
    ind = ~any(output <= 0);
    output = output(:,ind);

    % relationship between log prices and quantities
    subplot(2,1,1);
    hold on;
    plot(-log(output(1,:)), log(output(2,:)))
    
    
    % relationship between log prices and quantities
    subplot(2,1,2);
    hold on;
    plot(-log(output(1,2:end)), diff(log(output(2,:)))./diff(-log(output(1,:))))
    
end

subplot(2,1,1);
legend('0.1', '0.5', '1.0', '1.5', '2.0')
xlabel('Negative Log Difference in Prices')
ylabel('Log Difference in Quantities')

[hleg,att] = legend('show');
title(hleg, '\sigma')

subplot(2,1,2);
xlabel('Negative Log Difference in Prices')
ylabel({'Elasticity of Substitution', 'between Technologies'})
ylim([0 15])

