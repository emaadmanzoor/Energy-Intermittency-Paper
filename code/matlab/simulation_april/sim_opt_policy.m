%% Optimal policy with just tax

beta = 0;
n = 10000;
tau_range = linspace(0,140,n);
results = zeros(n,1);


for i = 1:n

    tau = tau_range(i);
    output = sim_function([1+beta, tau]);
    welfare = output(3) + output(4) + output(5);
    results(i) = welfare;

end

plot(tau_range, results)
[M, I] = max(results);
tau_range(I)


%% Optimal policy with just subsidy

tau = 0;
n = 1000;
beta_range = linspace(0,4,n);
results = zeros(n,1);


for j = 1:n

    beta = beta_range(j);
    output = sim_function([1+beta, tau]);
    welfare = output(3) + output(4) + output(5);
    results(j) = welfare;

    if (output(1) < 0) || (output(2) < 0)
        results(j) = nan;
    end
    
end

plot(beta_range, results)
[M, I] = max(results);
beta_range(I)


%% Optimal policy with both

n = 500;
[tau_range, beta_range] = meshgrid(linspace(60,80,n), linspace(0,1,n));
results = zeros(n,n);


for i = 1:n      % tau
    for j = 1:n  % beta
           
        tau = tau_range(i,j);
        beta = beta_range(i,j);
        output = sim_function([1+beta, tau]);
        welfare = output(3) + output(4) + output(5);
        results(i,j) = welfare;

        if ((output(1) < 0) || (output(2) < 0) ||  ~isreal(welfare))
            results(i,j) = nan;
        end

    end
end

disp('Done')

mesh(tau_range, beta_range, results)

%%

% beta = 0 case
[M, I] = max(results(1,:));
tau_range(I)

% general case
[M, I] = max(results(:));
[beta_range(I) tau_range(I)]




