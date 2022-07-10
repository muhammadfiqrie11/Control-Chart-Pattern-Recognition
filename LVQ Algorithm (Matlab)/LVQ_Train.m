clear;

data = xlsread('C:\Users\user\Desktop\SEM 8\Project Sarjana Muda (PSM)\THESIS PROGRESS\Control Chart Pattern Recognition (CCPR) Project\pattern_data\SecondStageData\Input_Data.csv');

x_train_data = xlsread('C:\Users\user\Desktop\SEM 8\Project Sarjana Muda (PSM)\THESIS PROGRESS\Control Chart Pattern Recognition (CCPR) Project\Test and Train Data\x_train.csv');
y_train_data = xlsread('C:\Users\user\Desktop\SEM 8\Project Sarjana Muda (PSM)\THESIS PROGRESS\Control Chart Pattern Recognition (CCPR) Project\Test and Train Data\y_train.csv');

%% Train Data
x_train = x_train_data(:,2:end)';
y_train = y_train_data(:,2)';
y_train_vector = ind2vec(y_train);

%% Plot Train Data
colormap(hsv);
plotvec(x_train,y_train)
title('Input Vectors');
xlabel('x(1)');
ylabel('x(2)');

%% Learning Vector Quantization Network
net = lvqnet(72,0.02,'learnlv1');
net.trainParam.epochs = 7;


net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%Network Training Process
net = train(net, x_train, y_train_vector);
view(net)
save net
%% Percentage of Accuracy
test = net(x_train);
test_vector = vec2ind(test);
result = [test_vector;y_train];

true_result=0;
for i=1:length(test_vector)
    if result(2,i)==result(1,i)
        true_result = true_result + 1;
    end
end
wrong_result = length(test_vector) - true_result;
percentage = (true_result/length(test_vector))*100;
perf = mse(net,y_train,x_train);

fprintf('The Percentage of True Classification Rate for training process: %.2f \n',percentage);
fprintf('The Mean Squared Error: %.3f \n',perf);