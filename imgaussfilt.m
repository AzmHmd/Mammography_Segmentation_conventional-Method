
function I = imgaussfilt(input, hsize, sigma)


%# Create the gaussian filter with hsize and sigma 
G = fspecial('gaussian',hsize,sigma);
%# Filter it
I = imfilter(input,G,'same');
