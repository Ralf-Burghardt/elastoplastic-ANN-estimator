function example_planetary_gear_carrier()

addpath(genpath('../src'))

inputs = xlsread("AST_planetary_gear_carrier.xlsx");

sigma_ANN = zeros(size(inputs,1),1);
for i = 1:size(inputs,1)
    [sigma_ANN(i), ~] = perform_stress_prediction(inputs(i,6), inputs(i,7), inputs(i,8), ...
                                                  inputs(i,3), inputs(i,4), ...
                                                  inputs(i,2), inputs(i,9) );
end

figure()
scatter(inputs(:,10),sigma_ANN(:))
grid on
xlabel('Real elastic plastic stress in MPa')
ylabel('Predicted elastic plastic stress in MPa')
hold on
plot([0,2000],[0,2000],'-','Color','k')
xlim([0,max([sigma_ANN;inputs(:,10)])]);
ylim([0,max([sigma_ANN;inputs(:,10)])]);
end