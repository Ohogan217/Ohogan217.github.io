clear
clc
close all

nFeatures = 15;
nSamps = 30;
nTrain = 20;
featurenames = {'Age', 'Speed', 'Weight', 'Height', 'TUAG',...
    'Average Stance Duration Assymetry', 'Average Stride Time','Average Force Assymetry', ...
    'Stride Time Standard Deviation', 'Average Force in Stronger Leg', 'Average Force in Weaker Leg', ...
    'Stride Time Variation', 'Longest Stance Duration', 'Average Stance Duration in Stronger Leg', 'Average Stance Duration in Weaker Leg'};
% %% File read-in
% Files = readtable("StudentNumber_Datasets.xlsx", "ReadRowNames",true);
% DemoData = readtable("demographics.html", "ReadRowNames",true);
% 
% files = table2array(Files(StuNumber, :));%File read in
% 
% demoNames = strings(1,30);%get String array for demographic data
% for i = 1:length(files)
%     demoNames(i) = erase([char(files(i))], "_01.txt");
% end
% demodata = DemoData(demoNames, :);%Get specified Demographic data
% %% Feature extraction
% %Select features from demographic data
% features = array2table(zeros(30, nFeatures), 'VariableNames',featurenames,'RowNames', (files));
% features(:,"Age") = demodata(:, "Age");
% features(:,"Speed") = demodata(:, "Speed_01 (m/sec)");
% features(:,"Weight") = demodata(:,"Weight (kg)");
% features(:,"Height") = demodata(:,"Height (meters)");
% features(:,"TUAG") = demodata(:,"TUAG");
% 
% for i  = 1:5%% Set the average value of a feature to any NaN values
%     avg = nanmean(features(:,i));
%     for j = 1:height(features)
%         if(isnan(table2array(features(j, i))))
%             features(j,i) = avg;
%         end
%     end
% end
% 
% %get average stance time assymetry,average stride time, average force asymetry, stride variation and
% %the average force in the stronger leg
% for i = 1:30
%     file = load([char(files(i))]);
%     [mStrideL, sdStrideL] = StrideTime(file(:,18));
%     [mStrideR, sdStrideR] = StrideTime(file(:,19));
%     [avgstancedurL, maxstancedurL] = FindStanceDuration(file(:, 18));
%     [avgstancedurR, maxstancedurR] = FindStanceDuration(file(:, 19));
%     features(files(i), 'Average Stance Duration Assymetry') = num2cell(abs(avgstancedurR - avgstancedurL));
%     features(files(i), 'Longest Stance Duration') = num2cell(max(maxstancedurR, maxstancedurL));
%     features(files(i), 'Average Stride Time') = num2cell((mStrideL+mStrideR)/2);
%     features(files(i), 'Average Force Assymetry') = num2cell(abs(mean((file(:, 18))-mean(file(:,19)))));
%     features(files(i), 'Stride Time Standard Deviation') = num2cell((sdStrideR+sdStrideL)/2);
%     features(files(i), 'Average Force in Stronger Leg') = num2cell(max([mean(file(:, 18));mean(file(:,19))]));
%     features(files(i), 'Average Force in Weaker Leg') = num2cell(min([mean(file(:, 18));mean(file(:,19))]));
%     features(files(i), 'Average Stance Duration in Stronger Leg') = num2cell(max(avgstancedurL,avgstancedurR));
%     features(files(i), 'Average Stance Duration in Weaker Leg') = num2cell(min(avgstancedurL,avgstancedurR));
% end
% 
% features(:,"Stride Time Variation") = num2cell(features{:,"Stride Time Standard Deviation"}./features{:, "Average Stride Time"});

%% Load files -  
% Ensures no different split of data each run and saves time reading in and calculating the feature set again
load('Features.mat')
%% Scale features
ScaledFeatures = features;

for i = 1:nFeatures
    feature = features(:, i);
    maxfeat = max(feature);
    minfeat = min(feature);
    feature = (feature - minfeat)./(maxfeat-minfeat);
    ScaledFeatures(:,i) = feature;
end
%% SplitData
X =  table2array(ScaledFeatures(:, 1:15));% 

y = [zeros(1,15), ones(1, 15)]'; % y is the label vector


%% filter Method
disp(" 2a - Filter Method ")
[idx,weights] = relieff(X,y,3); 
[w,i] = sort(weights,'descend');

filtfeatures = featurenames(idx(1:5));
% 
% figure
% bar(1:15, weights)
% xlabel('Feature number','FontSize',20,'FontName','calibri')
% ylabel('Weight','FontSize',20,'FontName','calibri')
% title('Ranking features for filter feature selection')
% set(gca,'fontsize',20,'fontname','calibri')

%% Wrapper - KNN
disp(" 2b - KNN Wrapper ")

k = 3;

functKNN = @(XTrain,yTrain,XTest,yTest)size(XTest,1)*loss(fitcknn(XTrain,yTrain, 'NumNeighbors',k),XTest,yTest);

opts = statset("Display","final");  
ho = cvpartition(y,"holdout", 10); 

tfknn = sequentialfs(functKNN,X,y,"CV",ho,"Options",opts, "nfeatures", 5);  

wrapk1features(1:length(find(tfknn==1))) = featurenames((tfknn==1));

%% Wrapper SVM
disp(" 2b - SVM Wrapper ")

c = 1;

functSVM = @(XTrain,yTrain,XTest,yTest)size(XTest,1)*loss(fitcsvm(XTrain,yTrain, 'BoxConstraint', c),XTest,yTest);  

tfsvm = sequentialfs(functSVM,X,y,"CV",ho,"Options",opts, "nfeatures", 5); 
wrapsvmfeatures(1:length(find(tfsvm==1))) = featurenames(tfsvm==1);

%% Wrapper Random Forest 
disp(" 2b - Random Forest Wrapper ")
Ntrees = 100;
Nsplits = 10;
functRandFor = @(XTrain,yTrain,XTest,yTest)size(XTest,1)*loss(fitcensemble(XTrain,yTrain, 'Method','Bag', 'NumLearningCycles',Ntrees,'Learners',templateTree('MaxNumSplits',Nsplits) ),XTest,yTest);  

tfrf = sequentialfs(functRandFor,X,y,"CV",ho,"Options",opts, "nfeatures", 5);  % perform sequential feature selection within CV
wraprffeatures(1:length(find(tfrf==1))) = featurenames((tfrf==1));

%% Wrapper based feature selection with cross validation - KNN
disp(" 3 - KNN CV wrappper ")

kTruepos = zeros(1,3);
kFalsepos = zeros(1,3);
kTrueneg = zeros(1,3);
kFalseneg = zeros(1,3);
kresults = zeros(30, 15, 3);

ks = [1, 5, 9];

for i = 1:3
    k = ks(i);
    disp("k = " + k)
    
    for fold = 1:nSamps
        disp("Fold " + fold)

        temptrain = X(setdiff(1:nSamps,fold), :);
        tempidtrain = y(setdiff(1:nSamps,fold));
    
        cv = cvpartition(tempidtrain,"KFold",5);
    
        tfknn = sequentialfs(functKNN,temptrain,tempidtrain,"CV",cv,"Options",opts);
        kresults(fold, :, i) = tfknn;
        kfeatures = find(tfknn==1);

        kData = X(:, kfeatures);
        
        temptest = kData(fold, :);
        temptrain = kData(setdiff(1:nSamps,fold), :);
        
        kPrediciton = predict(fitcknn(temptrain, tempidtrain, 'NumNeighbors', k), temptest);
        
        kTruepos(i)= kTruepos(i) + (1 == y(fold) && kPrediciton == 1);
        kFalsepos(i) = kFalsepos(i)+ (0 == y(fold) && kPrediciton == 1);
        kTrueneg(i) = kTrueneg(i) + (0 == y(fold) && kPrediciton == 0);
        kFalseneg(i) = kFalseneg(i)+ (1 == y(fold) && kPrediciton == 0);
    end
end
%% Evaluation
ksensiticity = kTruepos./(kTruepos + kFalseneg);
kspecificity = kTrueneg./(kTrueneg + kFalsepos);
kprecision = kTruepos./(kTruepos + kFalsepos);
kaccuracy = (kTruepos + kTrueneg)/30;
kf1 = kTruepos./(kTruepos+(kFalsepos + kFalseneg)/2);

%% Wrapper based feature selection with cross validation - SVM
disp(" 4 - SVM CV wrappper ")

svmTruepos = zeros(1,3);
svmFalsepos = zeros(1,3);
svmTrueneg = zeros(1,3);
svmFalseneg = zeros(1,3);
svmresults = zeros(30, 15, 3);

cs = [0.1, 1, 10];

for i = 1:3
    c = cs(i);
    disp("c = " + c)
    
    for fold = 1:nSamps
        disp("Fold " + fold)
    
        temptrain = X(setdiff(1:nSamps,fold), :);
        tempidtrain = y(setdiff(1:nSamps,fold));

        cv = cvpartition(tempidtrain,"KFold",5);
    
        tfsvm = sequentialfs(functSVM,temptrain,tempidtrain,"CV",cv,"Options",opts);
        svmresults(fold, :, i) = tfsvm;
        svmfeatures = find(tfsvm ==1);

        svmData = X(:, svmfeatures);
        
        temptest = svmData(fold, :);
        temptrain = svmData(setdiff(1:nSamps,fold), :);
        tempidtrain = y(setdiff(1:nSamps,fold));
        
        svmPrediciton = predict(fitcsvm(temptrain, tempidtrain, 'BoxConstraint', c ), temptest);
        
        svmTruepos(i)= svmTruepos(i) + (1 == y(fold) && svmPrediciton == 1);
        svmFalsepos(i) = svmFalsepos(i)+ (0 == y(fold) && svmPrediciton == 1);
        svmTrueneg(i) = svmTrueneg(i) + (0 == y(fold) && svmPrediciton == 0);
        svmFalseneg(i) = svmFalseneg(i)+ (1 == y(fold) && svmPrediciton == 0);
    end
end
%% Evaluation
svmsensiticity = svmTruepos./(svmTruepos + svmFalseneg);
svmspecificity = svmTrueneg./(svmTrueneg + svmFalsepos);
svmprecision = svmTruepos./(svmTruepos + svmFalsepos);
svmaccuracy = (svmTruepos + svmTrueneg)/30;
svmf1 = svmTruepos./(svmTruepos+(svmFalsepos + svmFalseneg)/2);

%% Wrapper based feature selection with cross validation - Random Forest
load("Workspace.mat");
disp(" 5 - RF CV wrappper ")

rfTruepos = zeros(1,2);
rfFalsepos = zeros(1,2);
rfTrueneg = zeros(1,2);
rfFalseneg = zeros(1,2);
rfresults = zeros(30, 15, 2);

ns = [20, 100];
opts = statset("Display","iter");  

for i = 1:2
    Ntrees = ns(i);
    disp("Ntrees = " + Ntrees)
    
    for fold = 1:nSamps
        disp("Fold " + fold + " -  Trees " + Ntrees)
        
        temptrain = X(setdiff(1:nSamps,fold), :);
        tempidtrain = y(setdiff(1:nSamps,fold));
    
        cv = cvpartition(tempidtrain,"KFold",2);
    
        tfrf = sequentialfs(functRandFor,temptrain,tempidtrain,"CV",cv,"Options",opts);
        rfresults(fold, :, i) = tfrf;
        rffeatures = find(tfrf ==1);
        rfData = X(:, rffeatures);
        
        temptest = rfData(fold, :);
        temptrain = rfData(setdiff(1:nSamps,fold), :);
        tempidtrain = y(setdiff(1:nSamps,fold));
        
        rfPrediciton = predict(fitcensemble(temptrain, tempidtrain, 'Method','Bag', 'NumLearningCycles',Ntrees,'Learners',templateTree('MaxNumSplits',Nsplits)), temptest);
        
        rfTruepos(i)= rfTruepos(i) + (1 == y(fold) && rfPrediciton == 1);
        rfFalsepos(i) = rfFalsepos(i)+ (0 == y(fold) && rfPrediciton == 1);
        rfTrueneg(i) = rfTrueneg(i) + (0 == y(fold) && rfPrediciton == 0);
        rfFalseneg(i) = rfFalseneg(i)+ (1 == y(fold) && rfPrediciton == 0);
    end
end
%% Evaluation
rfsensiticity = rfTruepos./(rfTruepos + rfFalseneg);
rfspecificity = rfTrueneg./(rfTrueneg + rfFalsepos);
rfprecision = rfTruepos./(rfTruepos + rfFalsepos);
rfaccuracy = (rfTruepos + rfTrueneg)/30;
rff1 = rfTruepos./(rfTruepos+(rfFalsepos + rfFalseneg)/2);
