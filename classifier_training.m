
clear all; close all; clc;

load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov1_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov2_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov3_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov4_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov5_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov6_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov7_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov8_spt.mat');

load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov1_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov2_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov3_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov4_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov5_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov6_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov7_spt.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov8_spt.mat');

load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov1_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov2_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov3_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov4_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov5_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov6_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov7_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_Mov8_temp.mat');

load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov1_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov2_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov3_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov4_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov5_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov6_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov7_temp.mat');
load('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_Mov8_temp.mat');

B_smokefeature_spt      = [B_Mov1_spt(1:20,:);B_Mov3_spt(21:40,:);B_Mov7_spt(21:50,:);B_Mov8_spt(21:50,:)];
B_nonsmokefeature_spt   = [B_Mov1_spt(1:20,:);B_Mov3_spt(21:40,:);B_Mov6_spt(21:50,:);B_Mov7_spt(871:900,:)];
V_smokefeature_spt      = [V_Mov1_spt(61:65,:);V_Mov2_spt(71:80,:);V_Mov3_spt(426:450,:);V_Mov5_spt(1341:1370,:);V_Mov8_spt(1341:1370,:)];
V_nonsmokefeature_spt   = [V_Mov1_spt(1:20,:);V_Mov2_spt(1:20,:);V_Mov5_spt(351:380,:);V_Mov8_spt(1:30,:)];

B_trainFeatures_spt    = [B_smokefeature_spt;B_nonsmokefeature_spt]; 
V_trainFeatures_spt     = [V_smokefeature_spt;V_nonsmokefeature_spt]; 

[n_samples,~] = size(B_smokefeature_spt);
B_trainclasses=[ones(n_samples,1);ones(n_samples,1)+1];
B_SVMstruct_spt = svmtrain(B_trainFeatures_spt,B_trainclasses);

[n_samples,~] = size(V_smokefeature_spt);
V_trainclasses=[ones(n_samples,1);ones(n_samples,1)+1];
V_SVMstruct_spt = svmtrain(V_trainFeatures_spt,V_trainclasses);

save('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_SVMstruct_spt.mat','B_SVMstruct_spt');
save('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_SVMstruct_spt.mat','V_SVMstruct_spt');

B_smokefeature_temp      = [B_Mov1_temp(1:20,:);B_Mov3_temp(21:40,:);B_Mov7_temp(21:50,:);B_Mov8_temp(21:50,:)];
B_nonsmokefeature_temp   = [B_Mov1_temp(1:20,:);B_Mov3_temp(21:40,:);B_Mov6_temp(21:50,:);B_Mov7_temp(871:900,:)];
V_smokefeature_temp      = [V_Mov1_temp(61:65,:);V_Mov2_temp(71:80,:);V_Mov3_temp(426:450,:);V_Mov5_temp(1341:1370,:);V_Mov8_temp(1341:1370,:)];
V_nonsmokefeature_temp   = [V_Mov1_temp(1:20,:);V_Mov2_temp(1:20,:);V_Mov5_temp(351:380,:);V_Mov8_temp(1:30,:)];

B_trainFeatures_temp    = [B_smokefeature_temp;B_nonsmokefeature_temp]; 
V_trainFeatures_temp     = [V_smokefeature_temp;V_nonsmokefeature_temp]; 

[n_samples,~] = size(B_smokefeature_temp);
B_trainclasses=[ones(n_samples,1);ones(n_samples,1)+1];
B_SVMstruct_temp = svmtrain(B_trainFeatures_temp,B_trainclasses);

[n_samples,~] = size(V_smokefeature_temp);
V_trainclasses=[ones(n_samples,1);ones(n_samples,1)+1];
V_SVMstruct_temp = svmtrain(V_trainFeatures_temp,V_trainclasses);

save('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\B_SVMstruct_temp.mat','B_SVMstruct_temp');
save('D:\Backup\Project 1\Lab Project Files\V_3\Featurevector\V_SVMstruct_temp.mat','V_SVMstruct_temp');
