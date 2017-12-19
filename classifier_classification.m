
clear all; close all; clc;
workspace;
% load the saved feature vectors
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_01\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_01\features_temp.mat');
B_Mov1_spt(:,:)     = features_spt(:,:);
B_Mov1_temp(:,:)    = features_temp(:,:);
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_02\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_02\features_temp.mat');
B_Mov2_spt(:,:)          = features_spt(:,:);
B_Mov2_temp(:,:)         = features_temp(:,:);
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_03\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_03\features_temp.mat');
B_Mov3_spt(:,:)          = features_spt(:,:);
B_Mov3_temp(:,:)         = features_temp(:,:);
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_04\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_04\features_temp.mat');
B_Mov4_spt(:,:)          = features_spt(:,:);
B_Mov4_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_05\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_05\features_temp.mat');
B_Mov5_spt(:,:)          = features_spt(:,:);
B_Mov5_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_06\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_06\features_temp.mat');
B_Mov6_spt(:,:)          = features_spt(:,:);
B_Mov6_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_07\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_07\features_temp.mat');
B_Mov7_spt(:,:)          = features_spt(:,:);
B_Mov7_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_08\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Bikent_08\features_temp.mat');
B_Mov8_spt(:,:)          = features_spt(:,:);
B_Mov8_temp(:,:)         = features_temp(:,:); 

load('D:\Backup\Project 1\Output - Feature Vectors\Visor_01\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_01\features_temp.mat');
V_Mov1_spt(:,:)          = features_spt(:,:);
V_Mov1_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_02\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_02\features_temp.mat');
V_Mov2_spt(:,:)          = features_spt(:,:);
V_Mov2_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_03\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_03\features_temp.mat');
V_Mov3_spt(:,:)          = features_spt(:,:);
V_Mov3_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_04\features_spt.mat');
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_04\features_temp.mat');
V_Mov4_spt(:,:)          = features_spt(:,:);
V_Mov4_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_05\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_05\features_temp.mat');
V_Mov5_spt(:,:)          = features_spt(:,:);
V_Mov5_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_06\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_06\features_temp.mat');
V_Mov6_spt(:,:)          = features_spt(:,:);
V_Mov6_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_07\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_07\features_temp.mat');
V_Mov7_spt(:,:)          = features_spt(:,:);
V_Mov7_temp(:,:)         = features_temp(:,:); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_08\features_spt.mat'); 
load('D:\Backup\Project 1\Output - Feature Vectors\Visor_08\features_temp.mat');
V_Mov8_spt(:,:)          = features_spt(:,:);
V_Mov8_temp(:,:)         = features_temp(:,:); 

% load the SVM Structs
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_SVMstruct_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_SVMstruct_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_SVMstruct_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_SVMstruct_temp.mat');

% load class information.
[~,data,~] = xlsread('D:\Backup\Project 1\Output - Feature Vectors\Classes_input_for_the_Classifier.xlsx');
[maxrow,maxcol] = size(data);
classinfor =zeros(maxrow,maxcol);
for j = 1:maxcol
    for i = 1:maxrow
        if (strcmpi(data{i,j},'Yes') == 1)
            classinfor(i,j) = 1;
        elseif (strcmpi(data{i,j},'No') == 1)
            classinfor(i,j) = 2;
        end
    end
end

GroupB01_spt = svmclassify(B_SVMstruct_spt,B_Mov1_spt);
GroupB02_spt = svmclassify(B_SVMstruct_spt,B_Mov2_spt);
GroupB03_spt = svmclassify(B_SVMstruct_spt,B_Mov3_spt);
GroupB04_spt = svmclassify(B_SVMstruct_spt,B_Mov4_spt);
GroupB05_spt = svmclassify(B_SVMstruct_spt,B_Mov5_spt);
GroupB06_spt = svmclassify(B_SVMstruct_spt,B_Mov6_spt);
GroupB07_spt = svmclassify(B_SVMstruct_spt,B_Mov7_spt);
GroupB08_spt = svmclassify(B_SVMstruct_spt,B_Mov8_spt);

GroupV01_spt = svmclassify(V_SVMstruct_spt,V_Mov1_spt);
GroupV02_spt = svmclassify(V_SVMstruct_spt,V_Mov2_spt);
GroupV03_spt = svmclassify(V_SVMstruct_spt,V_Mov3_spt);
GroupV04_spt = svmclassify(V_SVMstruct_spt,V_Mov4_spt);
GroupV05_spt = svmclassify(V_SVMstruct_spt,V_Mov5_spt);
GroupV06_spt = svmclassify(V_SVMstruct_spt,V_Mov6_spt);
GroupV07_spt = svmclassify(V_SVMstruct_spt,V_Mov7_spt);
GroupV08_spt = svmclassify(V_SVMstruct_spt,V_Mov8_spt);

GroupB01_temp = svmclassify(B_SVMstruct_temp,B_Mov1_temp);
GroupB02_temp = svmclassify(B_SVMstruct_temp,B_Mov2_temp);
GroupB03_temp = svmclassify(B_SVMstruct_temp,B_Mov3_temp);
GroupB04_temp = svmclassify(B_SVMstruct_temp,B_Mov4_temp);
GroupB05_temp = svmclassify(B_SVMstruct_temp,B_Mov5_temp);
GroupB06_temp = svmclassify(B_SVMstruct_temp,B_Mov6_temp);
GroupB07_temp = svmclassify(B_SVMstruct_temp,B_Mov7_temp);
GroupB08_temp = svmclassify(B_SVMstruct_temp,B_Mov8_temp);

GroupV01_temp = svmclassify(V_SVMstruct_temp,V_Mov1_temp);
GroupV02_temp = svmclassify(V_SVMstruct_temp,V_Mov2_temp);
GroupV03_temp = svmclassify(V_SVMstruct_temp,V_Mov3_temp);
GroupV04_temp = svmclassify(V_SVMstruct_temp,V_Mov4_temp);
GroupV05_temp = svmclassify(V_SVMstruct_temp,V_Mov5_temp);
GroupV06_temp = svmclassify(V_SVMstruct_temp,V_Mov6_temp);
GroupV07_temp = svmclassify(V_SVMstruct_temp,V_Mov7_temp);
GroupV08_temp = svmclassify(V_SVMstruct_temp,V_Mov8_temp);

[sel,~] = size(GroupB01_spt);
confmat_B01_spt = confusionmat(classinfor(1:sel,1),GroupB01_spt);
Accuracy.B01_spt = (confmat_B01_spt(1)+confmat_B01_spt(4))/(confmat_B01_spt(1)+confmat_B01_spt(2)+confmat_B01_spt(3)+confmat_B01_spt(4));
[sel,~] = size(GroupB02_spt);
confmat_B02_spt = confusionmat(classinfor(1:sel,2),GroupB02_spt);
Accuracy.B02_spt = (confmat_B02_spt(1)+confmat_B02_spt(4))/(confmat_B02_spt(1)+confmat_B02_spt(2)+confmat_B02_spt(3)+confmat_B02_spt(4));
[sel,~] = size(GroupB03_spt);
confmat_B03_spt = confusionmat(classinfor(1:sel,3),GroupB03_spt);
Accuracy.B03_spt = (confmat_B03_spt(1)+confmat_B03_spt(4))/(confmat_B03_spt(1)+confmat_B03_spt(2)+confmat_B03_spt(3)+confmat_B03_spt(4));
[sel,~] = size(GroupB04_spt);
confmat_B04_spt = confusionmat(classinfor(1:sel,4),GroupB04_spt);
Accuracy.B04_spt = (confmat_B04_spt(1)+confmat_B04_spt(4))/(confmat_B04_spt(1)+confmat_B04_spt(2)+confmat_B04_spt(3)+confmat_B04_spt(4));
[sel,~] = size(GroupB05_spt);
confmat_B05_spt = confusionmat(classinfor(1:sel,5),GroupB05_spt);
Accuracy.B05_spt = (confmat_B05_spt(1)+confmat_B05_spt(4))/(confmat_B05_spt(1)+confmat_B05_spt(2)+confmat_B05_spt(3)+confmat_B05_spt(4));
[sel,~] = size(GroupB06_spt);
confmat_B06_spt = confusionmat(classinfor(1:sel,6),GroupB06_spt);
Accuracy.B06_spt = (confmat_B06_spt(1)+confmat_B06_spt(4))/(confmat_B06_spt(1)+confmat_B06_spt(2)+confmat_B06_spt(3)+confmat_B06_spt(4));
[sel,~] = size(GroupB07_spt);
confmat_B07_spt = confusionmat(classinfor(1:sel,7),GroupB07_spt);
Accuracy.B07_spt = (confmat_B07_spt(1)+confmat_B07_spt(4))/(confmat_B07_spt(1)+confmat_B07_spt(2)+confmat_B07_spt(3)+confmat_B07_spt(4));
[sel,~] = size(GroupB08_spt);
confmat_B08_spt = confusionmat(classinfor(1:sel,8),GroupB08_spt);
%Accuracy.B08_spt = (confmat_B08_spt(1)+confmat_B08_spt(4))/(confmat_B08_spt(1)+confmat_B08_spt(2)+confmat_B08_spt(3)+confmat_B08_spt(4));

[sel,~] = size(GroupB01_temp);
confmat_B01_temp = confusionmat(classinfor(1:sel,1),GroupB01_temp);
Accuracy.B01_temp = (confmat_B01_temp(1)+confmat_B01_temp(4))/(confmat_B01_temp(1)+confmat_B01_temp(2)+confmat_B01_temp(3)+confmat_B01_temp(4));
[sel,~] = size(GroupB02_temp);
confmat_B02_temp = confusionmat(classinfor(1:sel,2),GroupB02_temp);
Accuracy.B02_temp = (confmat_B02_temp(1)+confmat_B02_temp(4))/(confmat_B02_temp(1)+confmat_B02_temp(2)+confmat_B02_temp(3)+confmat_B02_temp(4));
[sel,~] = size(GroupB03_temp);
confmat_B03_temp = confusionmat(classinfor(1:sel,3),GroupB03_temp);
Accuracy.B03_temp = (confmat_B03_temp(1)+confmat_B03_temp(4))/(confmat_B03_temp(1)+confmat_B03_temp(2)+confmat_B03_temp(3)+confmat_B03_temp(4));
[sel,~] = size(GroupB04_temp);
confmat_B04_temp = confusionmat(classinfor(1:sel,4),GroupB04_temp);
Accuracy.B04_temp = (confmat_B04_temp(1)+confmat_B04_temp(4))/(confmat_B04_temp(1)+confmat_B04_temp(2)+confmat_B04_temp(3)+confmat_B04_temp(4));
[sel,~] = size(GroupB05_temp);
confmat_B05_temp = confusionmat(classinfor(1:sel,5),GroupB05_temp);
Accuracy.B05_temp = (confmat_B05_temp(1)+confmat_B05_temp(4))/(confmat_B05_temp(1)+confmat_B05_temp(2)+confmat_B05_temp(3)+confmat_B05_temp(4));
[sel,~] = size(GroupB06_temp);
confmat_B06_temp = confusionmat(classinfor(1:sel,6),GroupB06_temp);
Accuracy.B06_temp = (confmat_B06_temp(1)+confmat_B06_temp(4))/(confmat_B06_temp(1)+confmat_B06_temp(2)+confmat_B06_temp(3)+confmat_B06_temp(4));
[sel,~] = size(GroupB07_temp);
confmat_B07_temp = confusionmat(classinfor(1:sel,7),GroupB07_temp);
Accuracy.B07_temp = (confmat_B07_temp(1)+confmat_B07_temp(4))/(confmat_B07_temp(1)+confmat_B07_temp(2)+confmat_B07_temp(3)+confmat_B07_temp(4));
[sel,~] = size(GroupB08_temp);
confmat_B08_temp = confusionmat(classinfor(1:sel,8),GroupB08_temp);
Accuracy.B08_temp = (confmat_B08_temp(1)+confmat_B08_temp(4))/(confmat_B08_temp(1)+confmat_B08_temp(2)+confmat_B08_temp(3)+confmat_B08_temp(4));


[sel,~] = size(GroupV01_spt);
confmat_V01_spt = confusionmat(classinfor(1:sel,9),GroupV01_spt);
Accuracy.V01_spt = (confmat_V01_spt(1)+confmat_V01_spt(4))/(confmat_V01_spt(1)+confmat_V01_spt(2)+confmat_V01_spt(3)+confmat_V01_spt(4));
[sel,~] = size(GroupV02_spt);
confmat_V02_spt = confusionmat(classinfor(1:sel,10),GroupV02_spt);
Accuracy.V02_spt = (confmat_V02_spt(1)+confmat_V02_spt(4))/(confmat_V02_spt(1)+confmat_V02_spt(2)+confmat_V02_spt(3)+confmat_V02_spt(4));
[sel,~] = size(GroupV03_spt);
confmat_V03_spt = confusionmat(classinfor(1:sel,11),GroupV03_spt);
Accuracy.V03_spt = (confmat_V03_spt(1)+confmat_V03_spt(4))/(confmat_V03_spt(1)+confmat_V03_spt(2)+confmat_V03_spt(3)+confmat_V03_spt(4));
[sel,~] = size(GroupV04_spt);
confmat_V04_spt = confusionmat(classinfor(1:sel,12),GroupV04_spt);
Accuracy.V04_spt = (confmat_V04_spt(1)+confmat_V04_spt(4))/(confmat_V04_spt(1)+confmat_V04_spt(2)+confmat_V04_spt(3)+confmat_V04_spt(4));
[sel,~] = size(GroupV05_spt);
confmat_V05_spt = confusionmat(classinfor(1:sel,13),GroupV05_spt);
Accuracy.V05_spt = (confmat_V05_spt(1)+confmat_V05_spt(4))/(confmat_V05_spt(1)+confmat_V05_spt(2)+confmat_V05_spt(3)+confmat_V05_spt(4));
[sel,~] = size(GroupV06_spt);
confmat_V06_spt = confusionmat(classinfor(1:sel,14),GroupV06_spt);
Accuracy.V06_spt = (confmat_V06_spt(1)+confmat_V06_spt(4))/(confmat_V06_spt(1)+confmat_V06_spt(2)+confmat_V06_spt(3)+confmat_V06_spt(4));
[sel,~] = size(GroupV07_spt);
confmat_V07_spt = confusionmat(classinfor(1:sel,15),GroupV07_spt);
Accuracy.V07_spt = (confmat_V07_spt(1)+confmat_V07_spt(4))/(confmat_V07_spt(1)+confmat_V07_spt(2)+confmat_V07_spt(3)+confmat_V07_spt(4));
[sel,~] = size(GroupV08_spt);
confmat_V08_spt = confusionmat(classinfor(1:sel,16),GroupV08_spt);
Accuracy.V08_spt = (confmat_V08_spt(1)+confmat_V08_spt(4))/(confmat_V08_spt(1)+confmat_V08_spt(2)+confmat_V08_spt(3)+confmat_V08_spt(4));

[sel,~] = size(GroupV01_temp);
confmat_V01_temp = confusionmat(classinfor(1:sel,9),GroupV01_temp);
Accuracy.V01_temp = (confmat_V01_temp(1)+confmat_V01_temp(4))/(confmat_V01_temp(1)+confmat_V01_temp(2)+confmat_V01_temp(3)+confmat_V01_temp(4));
[sel,~] = size(GroupV02_temp);
confmat_V02_temp = confusionmat(classinfor(1:sel,10),GroupV02_temp);
Accuracy.V02_temp = (confmat_V02_temp(1)+confmat_V02_temp(4))/(confmat_V02_temp(1)+confmat_V02_temp(2)+confmat_V02_temp(3)+confmat_V02_temp(4));
[sel,~] = size(GroupV03_temp);
confmat_V03_temp = confusionmat(classinfor(1:sel,11),GroupV03_temp);
Accuracy.V03_temp = (confmat_V03_temp(1)+confmat_V03_temp(4))/(confmat_V03_temp(1)+confmat_V03_temp(2)+confmat_V03_temp(3)+confmat_V03_temp(4));
[sel,~] = size(GroupV04_temp);
confmat_V04_temp = confusionmat(classinfor(1:sel,12),GroupV04_temp);
Accuracy.V04_temp = (confmat_V04_temp(1)+confmat_V04_temp(4))/(confmat_V04_temp(1)+confmat_V04_temp(2)+confmat_V04_temp(3)+confmat_V04_temp(4));
[sel,~] = size(GroupV05_temp);
confmat_V05_temp = confusionmat(classinfor(1:sel,13),GroupV05_temp);
Accuracy.V05_temp = (confmat_V05_temp(1)+confmat_V05_temp(4))/(confmat_V05_temp(1)+confmat_V05_temp(2)+confmat_V05_temp(3)+confmat_V05_temp(4));
[sel,~] = size(GroupV06_temp);
confmat_V06_temp = confusionmat(classinfor(1:sel,14),GroupV06_temp);
Accuracy.V06_temp = (confmat_V06_temp(1)+confmat_V06_temp(4))/(confmat_V06_temp(1)+confmat_V06_temp(2)+confmat_V06_temp(3)+confmat_V06_temp(4));
[sel,~] = size(GroupV07_temp);
confmat_V07_temp = confusionmat(classinfor(1:sel,15),GroupV07_temp);
Accuracy.V07_temp = (confmat_V07_temp(1)+confmat_V07_temp(4))/(confmat_V07_temp(1)+confmat_V07_temp(2)+confmat_V07_temp(3)+confmat_V07_temp(4));
[sel,~] = size(GroupV08_temp);
confmat_V08_temp = confusionmat(classinfor(1:sel,16),GroupV08_temp);
Accuracy.V08_temp = (confmat_V08_temp(1)+confmat_V08_temp(4))/(confmat_V08_temp(1)+confmat_V08_temp(2)+confmat_V08_temp(3)+confmat_V08_temp(4));
