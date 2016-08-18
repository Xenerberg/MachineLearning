%Script_02: Script to execute the 2nd Exercise 
clc; clear all;close all;

%Read the relevant files into Matlab variables (Markov model parameters)
A = dlmread('A.txt');
B = dlmread('B.txt');
pi = dlmread('pi.txt');

%Read the train and test data
TestData = dlmread('A_Test_Binned.txt');
TrainData = dlmread('A_Train_Binned.txt');

%To compute likelihood, we make use of Forward Algorithm
fprintf('Number of state-labels:%d\n', size(A,1));
fprintf('Number of observation-labels:%d\n', size(B,1));

loglik = zeros(size(TrainData,2),1);

%Evaluation procedure on Training data
for iCount = 1:size(TrainData,2)
    loglik(iCount) = log(fn_ForwardAlgorithm(A,B,pi,TrainData(:,iCount)));
    %test(iCount) = log(pr_hmm(TrainData(:,iCount),A,B',pi));
    %https://github.com/IraKorshunova/HMM/blob/master/HiddenMarkovModel.cpp
    %(For reference)    
end

%Evaluation Procedure on Test data
classification_labels = cell(size(TestData,2),1);
for iCount = 1:size(TestData,2)
   loglik_test(iCount) = log(fn_ForwardAlgorithm(A,B,pi,TestData(:,iCount)));
   %test(iCount) = log(pr_hmm(TestData(:,iCount),A,B',pi));
   %Classification of results on Test data only
   if loglik_test(iCount) > -120
       classification_labels{iCount} = 'train';       
   else
       classification_labels{iCount} = 'test';
   end
   
end


