function [X,Y] = Prependic_Lines(currentimage,I)
%% trace the boundry of the whole tissue
pad = 400;
clean_image = im2double(currentimage).*im2double(I);
C=padarray(clean_image,[pad pad],'both');

mask_line = edge(I);
[m,~] = size(I);
P = find(mask_line(fix(m/2),:)~= 0);
P = [fix(m/2),P(1)];

contour = bwtraceboundary(mask_line,P,'S');
[B,Ind] = sort(contour(:,1));
contour2(:,1) = B+pad;
contour2(:,2) = contour(Ind,2)+pad;
subplot(224)
imshow(10*C);hold on
plot(contour2(:,2),contour2(:,1),'b','LineWidth',2)

%% put even points of the boundary line
points = 40;% pre-defined
% ax = gcf;
% [~,start_y] = getpts(ax);
% [~,end_y] = getpts(ax);
% indexstart = find(contour2(:,1)==fix(start_y))
% start = indexstart(1);
% indexend = find(contour2(:,1)==fix(end_y))
% endd = indexend(1);

space = (length(contour2(:,2))--start)/points;
space = space - space/2;
start = 5;

% distribute points evenly on the breast boundry
[ pix_loc_col, pix_loc_row] = PutEvenPoints( contour2 ,points,space, start);
plot(pix_loc_row,pix_loc_col,'ro');

%% Drawing an orthogonal line for each point
num = 500;
in = 100; out = 400;
[X,Y] = DrawPrepenLines( pix_loc_row,pix_loc_col,in,out,num );

%% Draw the respective pixels
plot(X(1:points,:),Y(1:points,:),'g.');

end


