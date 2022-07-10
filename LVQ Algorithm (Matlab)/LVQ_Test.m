close all;
clear;
x_test_data = xlsread('C:\Users\user\Desktop\SEM 8\Project Sarjana Muda (PSM)\THESIS PROGRESS\Control Chart Pattern Recognition (CCPR) Project\Test and Train Data\x_test.csv');
y_test_data = xlsread('C:\Users\user\Desktop\SEM 8\Project Sarjana Muda (PSM)\THESIS PROGRESS\Control Chart Pattern Recognition (CCPR) Project\Test and Train Data\y_test.csv');

%% Test Data
x_test = x_test_data(:,2:end)';
y_test = y_test_data(:,2)';

%% Testing Process
load net
test_result = round(sim(net,x_test));
test_target_vector = vec2ind(test_result);
result = [test_target_vector;y_test];

%% Percentage of Accuracy
true_result=0;
for i=1:length(test_target_vector)
    if result(2,i)==result(1,i)
        true_result = true_result + 1;
    end
end
wrong_result = length(test_target_vector) - true_result;
percentage = (true_result/length(test_target_vector))*100;
perf = mse(net,y_test,x_test);

fprintf('The Percentage of True Classification Rate for testing process: %.2f \n',percentage);
fprintf('The Mean Squared Error: %.3f \n',perf);