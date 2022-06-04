close all;
clear all;
clc;
addpath('./bin/');
me=meshQ4Rect([0 1],[0 1],15,15);
% Q4Plotter(me,me.nodes,1);
gDat=gaussData(2);
mat.nu   = 0.3;
mat.E    = 200e5;
mat.D = (mat.E/((1+mat.nu)*(1-2*mat.nu)))*[1-mat.nu mat.nu 0 ; mat.nu 1-mat.nu 0; 0 0 (1-2*mat.nu)/2];
botNodes=find(me.nodes(:,2)<0.0001);
deadDof=[botNodes(:);me.noNd+botNodes(:)];
actDof=setdiff(1:(2*me.noNd),deadDof);
topNodes=find(me.nodes(:,2)>0.999999);

k=zeros(2*me.noNd);
fe=zeros(2*me.noNd,1);
for itEl=1:me.noEl
    elConnect=me.elements(itEl,1:4);
    elNodes=me.nodes(elConnect,:);
    elDof=[elConnect elConnect+me.noNd];
    ke=Q4LinearElasticStiffness(elNodes,gDat,mat);
    k(elDof,elDof)=k(elDof,elDof)+ke;
end
fe(me.noNd+topNodes(:))=1000000;
sol=zeros(2*me.noNd,1);
sol(actDof)=k(actDof,actDof)\fe(actDof);
deformation=me.nodes+reshape(sol,[me.noNd 2]);
Q4Plotter(me,deformation,1);