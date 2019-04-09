function final_I = WholeImageMask( currentimage)

x = edge(currentimage);
se1 = strel('diamond',20);
thrsh_GaussianImage = imfill(imdilate(x,se1),'holes');
thrsh_GaussianImage2 = thrsh_GaussianImage;

% connected component labelling (8-connected neighbourhood) algorithm
CC = bwconncomp(thrsh_GaussianImage,8);
numPixels = cellfun(@numel,CC.PixelIdxList);
[~,idx] = max(numPixels);
thrsh_GaussianImage2(CC.PixelIdxList{idx}) = 0;
Cln_thrsh_GaussianImage = abs(thrsh_GaussianImage -thrsh_GaussianImage2);

% isolate the frame and smooth the remaining region using a Gaussian filtersigma = 5;hsize = [1 1];
sigma = 5;
hsize = [10,10];
NewGaussianImage = imgaussfilt(Cln_thrsh_GaussianImage,hsize,sigma);

%dilation
se1= strel('square',5);
dilated_I = imfill(imdilate(NewGaussianImage,se1), 'holes');
x = dilated_I;
x(find(dilated_I~=0)) = 1;
final_I = x;
% %smooth the image 
% se2 = strel('diamond',5);
% se3 = strel('diamond',5);
% final_I = imdilate(imerode(imerode(dilated_I,se2),se2),se3);
% h = figure;
% figure(h);imshow(final_I);title('whole image mask')

end
