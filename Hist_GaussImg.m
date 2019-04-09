function [ NHist_GaussianImagef ] = Hist_GaussImg( GaussianImage )
Hist_GaussianImage = imhist(GaussianImage);
NHist_GaussianImage = Hist_GaussianImage(:) / max(Hist_GaussianImage(:));
% NHist_GaussianImagef = smooth(NHist_GaussianImage);
NHist_GaussianImagef=NHist_GaussianImage;
end

