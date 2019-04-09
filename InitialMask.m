function initial_mask = InitialMask(currentimage)
%% get the input data and change the format if necessary
OriginalImage = currentimage;   % get the a gray-scale image
% OriginalImage = imnoise(OriginalImage,'gaussian');
%OriginalImage = (rgb2gray(OriginalImage));
[O_row, O_column] = size(OriginalImage);

%% Originall image and histogram
subplot(221);imshow(10*currentimage);title('OriginalImage');axis off
Hist_OriginalImage= imhist(OriginalImage);
NHist_OriginalImage = Hist_OriginalImage(:) / max(Hist_OriginalImage(:));

%% Guassian filter to make further processing effective
sigma = 5;hsize = [10 10];
GaussianImage = imgaussfilt(OriginalImage,hsize,sigma);
% figure();imshow(GaussianImage),title('GaussianImage');
NHist_GaussianImagef = Hist_GaussImg( GaussianImage );
[ymax,imax,ymin,imin] = extrema(NHist_GaussianImagef);
x = find(imin == min(imin));
TH = .1*ymin(imin(x));
subplot(222);plot(NHist_GaussianImagef,'LineWidth',2);title('GaussianImage Histogram');xlim([0 255])
hold on
plot(imin(x),NHist_GaussianImagef(imin(x)),'r*');hold on
xlim([0 255])

%% Global Threshold to get the initial mask of the image
subplot(223)
thrsh_GaussianImage = Globalthreshold(GaussianImage,TH);
% imshow(10*thrsh_GaussianImage);
% title('Global thresholded image');
thrsh_GaussianImage2 = thrsh_GaussianImage();
% axis off

%% connected component labelling (8-connected neighbourhood) algorithm to remove the annotation and labels on image
CC = bwconncomp(thrsh_GaussianImage,8);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
thrsh_GaussianImage2(CC.PixelIdxList{idx}) = 0;
Cln_thrsh_GaussianImage = abs(thrsh_GaussianImage -thrsh_GaussianImage2);
NewGaussianImage = imgaussfilt(Cln_thrsh_GaussianImage,hsize,sigma);
% subplot(122);imshow(NewGaussianImage);
% title('8-connected neighbourhood image');
%% fill in the holes by dilation, imfill and erosion
se1= strel('square',5);
I_dilated = imdilate(NewGaussianImage,se1);
I_dilated= imfill(I_dilated, 'holes');
%smooth the image more
se2 = strel('diamond',5);
I_erod = imerode(I_dilated,se2);
I_erod = imerode(I_erod,se2);

se1= strel('square',5);
I = imdilate(I_erod,se1);
I= imfill(I, 'holes');
%smooth the image more
se2 = strel('diamond',5);
I = imerode(I,se2);
I_final = imerode(I,se2);

I_perim = bwperim(I_final);%Find perimeter of breast in binary image
% fill inside the resulted contour
initial_mask = imgaussfilt(imfill(I_perim, 'holes'),hsize,sigma);
subplot(223);imshow(initial_mask);title('initial mask');axis off
end