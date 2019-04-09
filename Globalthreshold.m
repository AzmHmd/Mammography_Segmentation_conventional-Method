function thrsh_GaussianImage = Gthreshold(currentimage,TH)
% GaussianImage = imgaussfilt(currentimage);
% imhist(GaussianImage)
thrsh_GaussianImage = currentimage;
thrsh_GaussianImage(find(currentimage<TH)) = 0;
thrsh_GaussianImage(find(currentimage>=TH)) = 1;
imshow(thrsh_GaussianImage)
end

