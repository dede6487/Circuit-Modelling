clc; clear; close all;

% Define a grid in the complex plane for each method (better scaling)
[x1, y1] = meshgrid(linspace(-2, 3, 400), linspace(-2, 2, 400));
z1 = x1 + 1i*y1;

[x2, y2] = meshgrid(linspace(-2, 5, 400), linspace(-3, 3, 400));
z2 = x2 + 1i*y2;

[x3, y3] = meshgrid(linspace(-4, 8, 400), linspace(-4.5, 4.5, 400));
z3 = x3 + 1i*y3;

% BDF1 Stability Region
xi1 = 1 ./ (1 - z1);
stab1 = abs(xi1) <= 1;

% Initialize stability matrices
 stab2 = true(size(z2));
 stab3 = true(size(z3));
 
% Compute BDF2 Stability Region using roots
for i = 1:numel(z2)
    coeffs = [1, -4, 3 - 2*z2(i)]; % Characteristic equation coefficients
    roots_xi = roots(coeffs); % Solve for xi
    for n = 1:size(roots_xi, 1)
        temp = true;
        if (1 < abs(roots_xi(n)))
            temp = false;
        end
        if temp == true
            stab2(i) = false;
        end
    end
end

% Compute BDF3 Stability Region using roots
for i = 1:numel(z3)
    coeffs = [-2, 9, -18, 11-6*z3(i)]; % Characteristic equation coefficients
    roots_xi = roots(coeffs); % Solve for xi
    for n = 1:size(roots_xi, 1)
        temp = true;
        if (1 < abs(roots_xi(n)))
            temp = false;
        end
        if temp == true
            stab3(i) = false;
        end
    end
end

% Plot stability regions
figure;
subplot(1,3,1);
contourf(x1, y2, stab1, [0.5 0.5], 's', 'LineWidth', 1.5);
axis tight;
hold on; grid on;
xline(0, '--k'); yline(0, '--k');
title('BDF1 Stability Region');
xlabel('Re(z)'); ylabel('Im(z)');

subplot(1,3,2);
contourf(x2, y2, stab2, [0.5 0.5], 's', 'LineWidth', 1.5);
axis tight;
hold on; grid on;
xline(0, '--k'); yline(0, '--k');
title('BDF2 Stability Region');
xlabel('Re(z)'); ylabel('Im(z)');

subplot(1,3,3);
contourf(x3, y3, stab3, [0.5 0.5], 's', 'LineWidth', 1.5);
axis tight;
hold on; grid on;
xline(0, '--k'); yline(0, '--k');
title('BDF3 Stability Region');
xlabel('Re(z)'); ylabel('Im(z)');

sgtitle('Stability Regions of BDF1, BDF2, and BDF3');

set(gcf, 'Color', 'w', 'Position', [0,0,1500,350]);
export_fig bdf_stability_regions.png;
