function [ X,Y ] = DrawPrepenLines( pix_loc_row,pix_loc_col,in,out,...
    num)
px = pix_loc_row;
py = pix_loc_col;

for i = 3: length(px)

        pt1(1) = px(i-2);
        pt1(2) = py(i-2);
        pt2(1) = px(i-1);
        pt2(2) = py(i-1);
        pt3(1) = px(i);
        pt3(2) = py(i);
        v = pt3 - pt1;
 
    % n = 1;
    % t = linspace(0,1,n+2);  % evenly spaced parameters
    % t = t(2:(end-1));       % we don't need the start and end points
    x = pt2(1);    % p(t) = p1 + t*(p2-p1)
    y = pt2(2);
    % h = line(x,y);
    % h.LineStyle = 'none';
    % h.Marker = 'o';
    %     v1 = out*v / norm(v);
    %     v2 = in*v / norm(v);
    v1 = in*v / norm(v);
    v2 = out*v / norm(v);
    % for ii=1:n
    line([x+v2(2), x-v1(2)],[y-v2(1), y+v1(1)]);
    axis equal
    X(i,:) = linspace(round(x+v2(2)),round(x-v1(2)),num);
    Y(i,:) = linspace(round(y-v2(1)),round(y+v1(1)),num);
    % end
    %     pause(.25)
end
end