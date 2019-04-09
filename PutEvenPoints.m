function [ pix_loc_col, pix_loc_row] = PutEvenPoints( contourtraced ,...
    points,space,start )
x=start;
pix_selected(1,:) = contourtraced(x,:);
k = x+1;
for i = 2: points
    while any(pdist2(contourtraced(k,:),[pix_selected(1:i-1,:)],...
            'euclidean')< space)
        k = k+1;
    end
    pix_selected(i,:) = contourtraced(k,:);
end
pix_loc_col = pix_selected(:,1);
pix_loc_row = pix_selected(:,2);

end