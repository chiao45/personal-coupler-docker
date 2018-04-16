function make_plot(study, varargin)

if nargin < 1
    error('Not enough input arguments');
end
if nargin >= 2
    Re = varargin{1};
else
    Re = 500;
end

if nargin >= 3
    Pr = varargin{2};
else
    Pr = 0.01;
end

k = int32([1 5 20]);

study_copy = strcat('k',study);
study_copy = strcat(study_copy, '%d.mat');

xx = linspace(0.05,0.95,20);

for i =1:3
    fn = sprintf(study_copy, k(i));
    load(fn, 'theta');
    theta_num{i} = theta;
    theta_ext{i} = theta_exact(Re, Pr, k(i), xx);
end

i_ = int32(0);
for i = 1:length(study)
    if study(i) == '_'
        i_ = int32(i);
    end
end

if i_
    % assume somewhere in between
    study = strcat(strcat(study(1:i_-1),'\_'),study(i_+1:end));
end

x = linspace(0,1,length(theta_num{1}));

plot(x, theta_num{1}, ...
    xx, theta_ext{1}, 'ko', ...
    x, theta_num{2}, ...
    xx, theta_ext{2}, 'k^', ...
    x, theta_num{3}, ...
    xx, theta_ext{3}, 'kv', ...
    'LineWidth', 1);
axis([0 1 0 1]);
title(strcat(study, ' Interface Results'), 'Interpreter', 'latex');
xlabel('plate length', 'Interpreter', 'latex');
ylabel('$$\theta=\frac{T_i-T_{\infty}}{T_b-T_{\infty}}$$', ...
    'Interpreter', 'latex');
legend('k=1, numerical results', 'k=1, analytical solution', ...
    'k=5, numerical results', 'k=5, analytical solution', ...
    'k=20, numerical results', 'k=20, analytical solution', ...
    'Location', 'northeast');
