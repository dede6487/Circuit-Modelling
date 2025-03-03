clc; clear; close all;

% Define a grid in the complex plane
[x, y] = meshgrid(linspace(-5, 5, 400), linspace(-5, 5, 400));
z = x + 1i*y;

% BDF1 Stability Region
xi1 = 1 ./ (1 - z);
stab1 = abs(xi1) <= 1;

% Initialize stability matrices
 stab2 = false(size(z));
 stab3 = false(size(z));
 
% Compute BDF2 Stability Region using roots
for i = 1:numel(z)
    coeffs = [1, -4, 3 - 2*z(i)]; % Characteristic equation coefficients
    roots_xi = roots(coeffs); % Solve for xi
    for n = 1:size(roots_xi, 1)
        temp = true;
        if (1 < abs(roots_xi(n)))
            temp = false;
        end
        if temp == true
            stab2(i) = true;
        end
    end
end

% Compute BDF3 Stability Region using roots
for i = 1:numel(z)
    coeffs = [-2, 9, -18, 11-6*z(i)]; % Characteristic equation coefficients
    roots_xi = roots(coeffs); % Solve for xi
    for n = 1:size(roots_xi, 1)
        temp = true;
        if (1 < abs(roots_xi(n)))
            temp = false;
        end
        if temp == true
            stab3(i) = true;
        end
    end
end

% Plot stability regions
figure;
subplot(1,3,1);
contourf(x, y, stab1, [0.5 0.5], 'b', 'LineWidth', 1.5);
hold on; grid on;
xline(0, '--k'); yline(0, '--k');
title('BDF1 Stability Region');
xlabel('Re(z)'); ylabel('Im(z)');

subplot(1,3,2);
contourf(x, y, stab2, [0.5 0.5], 'r', 'LineWidth', 1.5);
hold on; grid on;
xline(0, '--k'); yline(0, '--k');
title('BDF2 Stability Region');
xlabel('Re(z)'); ylabel('Im(z)');

all(stab2,'all')

subplot(1,3,3);
contourf(x, y, stab3, [0.5 0.5], 'g', 'LineWidth', 1.5);
hold on; grid on;
xline(0, '--k'); yline(0, '--k');
title('BDF3 Stability Region');
xlabel('Re(z)'); ylabel('Im(z)');

sgtitle('Stability Regions of BDF1, BDF2, and BDF3');
