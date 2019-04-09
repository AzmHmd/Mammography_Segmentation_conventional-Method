
function PlotInOneWindow(currentimage,Mask)
currentimage = im2double(currentimage);
    imshow([10*currentimage;ones(11,size(currentimage,2));Mask])
    title({['original image'];['segmented imge']}); axis off;
     
end