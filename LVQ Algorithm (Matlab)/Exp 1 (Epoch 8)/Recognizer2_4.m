clear;

data = xlsread('C:\Users\user\Desktop\SEM 8\Project Sarjana Muda (PSM)\THESIS PROGRESS\Control Chart Pattern Recognition (CCPR) Project\LVQ Algorithm (Matlab)\Exp 1 (Epoch 8)\Input_Data_4.csv');

%% Train Data
input = data(:,1:32)';
target = data(:,end)';
input_vector = ind2vec(target);

%% Plot Train Data
colormap(hsv);
plotvec(input,target)
title('Input Vectors');
xlabel('x(1)');
ylabel('x(2)');

%% Learning Vector Quantization Network
net = lvqnet(72,0.02,'learnlv1');
net.trainParam.epochs = 8;
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 10/100;

%Network Training Process
net = train(net, input, input_vector);
view(net)
save net
%% Percentage of Accuracy
test = net(input);
test_vector = vec2ind(test);
result = [test_vector;target];

true_result=0;
for i=1:length(test_vector)
    if result(2,i)==result(1,i)
        true_result = true_result + 1;
    end
end
wrong_result = length(test_vector) - true_result;
percentage = (true_result/length(test_vector))*100;
perf = mse(net,target,input);

fprintf('The Percentage of True Classification Rate for training process: %.2f \n',percentage);
fprintf('The Mean Squared Error: %.3f \n',perf);