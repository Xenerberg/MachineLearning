clc;clear all;
Data = load('Data.mat');
Input = Data.Input;
Output = Data.Output;
size_Data = floor(size(Input,2));
subsampleSize = floor(size_Data/5);
last_SubsampleSize = subsampleSize + mod(size_Data,5);

k = 5;%K-Fold validation value
SubSampledInput = cell(1,k);
SubSampledOutput = cell(1,k);
for iCount = 1:k
   SubSampledInput{1,iCount} = Input(:,1 + (iCount-1)*subsampleSize:iCount*subsampleSize);
   SubSampledOutput{1,iCount} = Output(:,1+ (iCount-1)*subsampleSize:iCount*subsampleSize);
end

p1_max = 6;
p2_max = 6;
p1_range = 1:p1_max;
p2_range = 1:p2_max;
range_k = 1:5;
for iCount_k = range_k
   ValidationSampleInput = cell2mat(SubSampledInput(iCount_k));
   ValidationSampleOutput = cell2mat(SubSampledOutput(iCount_k));
   trainingIndexes = range_k(range_k~=iCount_k);
   TrainingSampleInput = cell2mat(SubSampledInput(trainingIndexes));
   TrainingSampleOuput = cell2mat(SubSampledOutput(trainingIndexes));  
   for iCount_p1 = p1_range                        
          A_x = fn_CreateSystemMatrix_x_y(TrainingSampleInput,iCount_p1,[1,length(TrainingSampleInput)]);
          Param_x{iCount_k, iCount_p1} = (A_x'*A_x)\A_x'*TrainingSampleOuput(1,:)';
          A_y = fn_CreateSystemMatrix_x_y(TrainingSampleInput,iCount_p1,[1,length(TrainingSampleInput)]);
          Param_y{iCount_k, iCount_p1} = (A_y'*A_y)\A_y'*TrainingSampleOuput(2,:)';
          A_x_est = fn_CreateSystemMatrix_x_y(ValidationSampleInput,iCount_p1,[1,length(ValidationSampleInput)]);          
          Estimated_x = A_x_est*Param_x{iCount_k,iCount_p1};
          error_vector_x = ValidationSampleOutput(1,:)' - Estimated_x;
          
          A_y_est = fn_CreateSystemMatrix_x_y(ValidationSampleInput,iCount_p1,[1,length(ValidationSampleInput)]);          
          Estimated_y = A_y_est*Param_y{iCount_k,iCount_p1};
          error_vector_y = ValidationSampleOutput(2,:)' - Estimated_y;
          sse_position = 0;
          for iCount = 1:size(Estimated_x)
             error_x = error_vector_x(iCount);
             error_y = error_vector_y(iCount);
             error_position = [error_x;error_y];
             se_position = sqrt(error_position'*error_position);
             sse_position = sse_position + se_position;
          end
          error_p1(iCount_k, iCount_p1) = sse_position/iCount;
   end
   for iCount_p2 = p2_range
          A_theta = fn_CreateSystemMatrix_theta(TrainingSampleInput,iCount_p2,[1,length(TrainingSampleInput)]);
          Param_theta{iCount_k, iCount_p2} = (A_theta'*A_theta)\A_theta'*TrainingSampleOuput(3,:)';
          
          A_theta_est = fn_CreateSystemMatrix_theta(ValidationSampleInput,iCount_p2,[1,length(ValidationSampleInput)]);          
          Estimated_theta = A_theta_est*Param_theta{iCount_k,iCount_p2};
          error_vector_theta = ValidationSampleOutput(3,:)' - Estimated_theta;
          error_p2(iCount_k,iCount_p2) = sqrt(error_vector_theta'*error_vector_theta)/iCount;     
 
   end

    
end

[min_p1, i_p1] = min(sum(error_p1));
[min_p2, i_p2] = min(sum(error_p2));

A_x = fn_CreateSystemMatrix_x_y(Input,i_p1,[1,length(Input)]);
par_x = (A_x'*A_x)\A_x'*Output(1,:)';
A_y = fn_CreateSystemMatrix_x_y(Input,i_p1,[1,length(Input)]);
par_y = (A_y'*A_y)\A_y'*Output(2,:)';
A_theta = fn_CreateSystemMatrix_theta(Input,i_p2,[1,length(Input)]);
par_theta = (A_theta'*A_theta)\A_theta'*Output(3,:)';

par{1} = par_x;
par{2} = par_y;
par{3} = par_theta;

save('params','par');
Simulate_robot(0.15,-0.03);


