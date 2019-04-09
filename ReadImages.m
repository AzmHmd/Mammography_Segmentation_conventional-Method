%function [images, seg_images] = ReadImages()
clc;close all;clear all;
path = 'Your Path';
f1 = figure;

% read the image --------------------------------------------------
filename ='';
currentimage = (dicomread(fullfile(path,filename))); % read the image
% images{i} = currentimage;  % if you have several images and you want to
% save it.

% remove labels and find the initial mask  ------------------------
h = figure;
figure(h);
I = InitialMask(currentimage);

% segment the whole tissue ----------------------------------------
[X,Y] = Prependic_Lines(currentimage,I);

% plot the images in one window -----------------------------------
figure(f1);
PlotInOneWindow(currentimage,I)





