% less than 100 even number
for k= 1:1 % Possible number : 1~125
    kk= 2*k+38; %  offset 38 because before 39 are all liquid
    mkdir(sprintf('P:\\Insung\\segmentation files\\%d_segmentation\\', kk)); %make directory
    for i = 1: 370 %number of images
            imNo = i+414;   % Read the images, note offset of 414
            fprintf('%d, %d\n', kk, imNo); %counter
        if kk < 100 %kk 39~99
           if mod(kk,2)==1 % when kk is odd number, the first one is 39.
               QC = imread(sprintf('P:\\recon_proj_0480\\%03d\\recon_proj_0480__%05d.tiff', kk, imNo)); %load QC data
               L = imread(sprintf('P:\\recon_proj_0480\\035\\recon_proj_0480__%05d.tiff', imNo)); %load Liquid data, always 35
               subtract = QC-L; %This part is needed! to remove center noise! because the noise position is fixed,(not rotate!)
               subtract2 = imrotate(subtract, (20*(kk-35)*0.00813235)); %rotation, reference : 35 liquid 
               a=size(subtract2,1); b=size(subtract2,2); %size of rotated image
               if mod(a,2)==0 %if size is even number, just divide it by two.
                  subtract4 = subtract2(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
               else %if size is odd number, make it even and divide it by two.
                  a=a-1;
                  b=a;
                  subtract4 = subtract2(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
               end

               %QC(1076:1544, 1128:1440) = subtract(1076:1544, 1128:1440);

               QC2 = imrotate(QC, (20*(kk-35)*0.00813235)); %rotate QC, reference : 35 liquid 
               a=size(QC2,1); b=size(QC2,2); %size of rotated image
               if mod(a,2)==0 %if size is even number, just divide it by two.
                  QC3 = QC2(((a/2)-1279):((a/2)+1280),((b/2)-1279):((b/2)+1280),1);
               else %if size is odd number, make it even and divide it by two.
                  a=a-1;
                  b=a;
                  QC3 = QC2(((a/2)-1279):((a/2)+1280),((b/2)-1279):((b/2)+1280),1);
               end
               subtr = QC3-L;      %get QC3-L (QC(rotated)-L)  
               
            else %mod(mod(kk,2)==0)
                QC = imread(sprintf('P:\\recon_proj_0480\\%03d\\recon_proj_0480__%05d.tiff', kk, imNo));
                L = imread(sprintf('P:\\recon_proj_0480\\036\\recon_proj_0480__%05d.tiff', imNo));
                subtract = QC-L; %to remove center noise
                subtract2 = imrotate(subtract, 180 +(20*(kk-35)*0.00813235)); %rotate 180 and align reference point 35
                a=size(subtract2,1); b=size(subtract2,2); %size of rotated image
                if mod(a,2)==0 %if size is even number, just divide it by two.
                   subtract4 = subtract2(((a/2)-1279):((a/2)+1280),((b/2)-1279):((b/2)+1280),1);
                else %if size is odd number, make it even and divide it by two.
                   a=a-1;
                   b=a;
                   subtract4 = subtract2(((a/2)-1279):((a/2)+1280),((b/2)-1279):((b/2)+1280),1);
                end
                QC2 = imrotate(QC, 180 +(20*(kk-35)*0.00813235)); %rotate 180. reference 35
                L2 =imrotate(L, 180 + 0.00813235); %align with Liq 35
                a=size(QC2,1); b=size(QC2,2); %size of rotated image
                c=size(L2,1); d=size(L2,2);
                if mod(a,2)==0 %if size is even number, just divide it by two.
                   QC3 = QC2(((a/2)-1279):((a/2)+1280),((b/2)-1279):((b/2)+1280),1);
                else %if size is odd number, make it even and divide it by two.
                   a=a-1;
                   b=a;
                   QC3 = QC2(((a/2)-1279):((a/2)+1280),((b/2)-1279):((b/2)+1280),1);
                end
                if mod(c,2)==0
                    L3 = L2(((c/2)-1279):((c/2)+1280),((d/2)-1279):((d/2)+1280),1);
                else
                    c=c-1;
                    d=c;
                    L3 = L2(((c/2)-1279):((c/2)+1280),((d/2)-1279):((d/2)+1280),1);
                end   
               
                subtr = QC3-L3; %get QC3-L (QC(rotated)-L)
           end
            
        elseif kk > 100 %when kk is greater than 100, we need to flip the data.
%            
               if mod(kk,2)==1 % when kk is odd number, the first one is 101.
                   imNo = i+414;   % Read the images, note offset of 414
                   QC = imread(sprintf('E:\\recon_proj_0480\\%03d\\recon_proj_0480__%05d.tiff', kk, imNo));
                   L = imread(sprintf('E:\\recon_proj_0480\\035\\recon_proj_0480__%05d.tiff', imNo));
                   subtract = QC-L; %This part is needed! to remove center noise! because the noise position is fixed,(not rotate!)
                   subtract2 = flipdim(subtract,2); %flip the image
                   subtract3 = imrotate(subtract2, 180-46.23 -(20*(kk-100)*0.00813235)); %rotate, the reference is 35
                   a=size(subtract3,1); b=size(subtract3,2);
                   if mod(a,2)==0 %if size is even number, just divide it by two.
                        subtract4 = subtract3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   else %if size is odd number, make it even and divide it by two.
                        a=a-1;
                        b=a;
                        subtract4 = subtract3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   end
                   
                   QC2=flipdim(QC,2); %flip the image
                   QC3 = imrotate(QC2, 180-46.23 -(20*(kk-100)*0.00813235)); %rotate 180 deg, difference between 99 and 100, correction
                   a=size(QC3,1); b=size(QC3,2); %size of rotated image
                   if mod(a,2)==0
                       QC4 = QC3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   else
                       a=a-1;
                       b=a;
                       QC4 = QC3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   end 
                   subtr = QC4-L; %get QC4-L (QC(rotated)-L)
               else
                   QC = imread(sprintf('E:\\recon_proj_0480\\%03d\\recon_proj_0480__%05d.tiff', kk, imNo));
                   L = imread(sprintf('E:\\recon_proj_0480\\035\\recon_proj_0480__%05d.tiff', imNo));
                   subtract = QC-L; %This part is needed! to remove center noise! because the noise position is fixed,(not rotate!)
                   subtract2 = flipdim(subtract,2); %flip the image
                   subtract3 = imrotate(subtract2, -46.23 -(20*(kk-100)*0.00813235));%rotate 180 deg, difference between 99 and 100, correction
                   if mod(a,2)==0 %if size is even number, just divide it by two.
                        subtract4 = subtract3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   else %if size is odd number, make it even and divide it by two.
                        a=a-1;
                        b=a;
                        subtract4 = subtract3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   end
                                                         
                   QC2= flipdim(QC,2); %flip the image
                   QC3 = imrotate(QC2, -46.23 -(20*(kk-100)*0.00813235));%rotate 180 deg, and align, reference 35
                   
                   a=size(QC3,1); b=size(QC3,2);
                   
                   if mod(a,2)==0
                       QC4 = QC3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   else
                       a=a-1;
                       b=a;
                       QC4 = QC3(((a/2)-1280):((a/2)+1279),((b/2)-1279):((b/2)+1280),1);
                   end
                   
                   subtr = QC4-L; %get QC4-L (QC(rotated)-L)
               end       
        else
        end   
               
subtr(1000:1600, 1000:1500)= subtract4(1000:1600, 1000:1500); %change the center of rotated image. the noise was removed from subtract4 
subtr = (subtr + 0.0019)/(0.0038); %normalize
thresh = (subtr > 0.54); %find threshold

thresh1 = (subtr >0.555); %will be used as inside threshold %normal
thresh(1000:1560,1000:1560) = thresh1(1000:1560,1000:1560); 
%             thresedge = edge(subtr, 'canny', 0.1, 3);
%             thresedge2 =imdilate(thresedge, strel('disk',2));
%             combo = thresedge2 | thresh;
%             combo = thresh;


fillim = ~bwareaopen(~thresh, 100000); %fill black
fillim = bwareaopen(fillim, 200, 4); %remove white
totim = imerode(fillim, strel('disk',2)); %uncomment this part 3/18 Insung
                    
    A=totim;
    A = bwareaopen(A, 6000, 4);
    AA = edge(A, 'canny', 0.1,3);       %apply edge 'canny'
    B = A(1000:1500, 1000:2000);        %crop the original image
    
    C = AA(1000:1500, 1000:2000);       %crop the edge image
    
    ind = find(C);                      %find white pixels, linear indices
    [row, col] = ind2sub(size(C), ind); %convert linear indices to subscripts, [row, col]
    store1 = zeros([size(C,1),2]); % make zeros matrix, number of row --> number of row in C, number of column -->2 
    store2 = zeros([size(C,1),2]); % make zeros matrix, number of row --> number of row in C, number of column -->2
        for m = 1:size(C,1)         % from 1 to the number of row in C
            t = find(row ==m);      % return the indices of white belong to row i in C
            
            mincol = min(col(t));   %Find minimum column. e.g 1, 2, 3...
            maxcol = max(col(t));   %Find maximum column.
            
            store1(m,:) = [m, mincol]; %store minimum column in each row
            store2(m,:) = [m, maxcol]; %store maximum column in each row
            
        end
    rowtop = 1;                 %first row
    rowbottom = size(B,1);      %last row
    coltop1 = store1(rowtop,2); %the value belongs to the column in store1(rowtop, mincol)
    colbottom1 = store1(rowbottom,2); %the value belongs to the column in store1 (rowbottom, mincol)
    coltop2 = store2(rowtop,2); %the value belongs to the column in store2(rowtop, maxcol)
    colbottom2 = store2(rowbottom,2); %the value belongs to the column in store1(rowtop, maxcol)
    
      
    minslope = ((rowtop -rowbottom)/(coltop1 - colbottom1)); %slope : left line
    x1 = (store1(:,1)-rowbottom)/minslope + colbottom1; %y(store) = slope(x1-colbottom) + rowbottom
    x1 = round(x1); %roundup
    
    maxslope = ((rowtop - rowbottom)/(coltop2 - colbottom2)); %slope : right line
    x2 = (store2(:,1)-rowbottom)/maxslope + colbottom2; %y(store) = slope(x1-colbottom) + rowbottom
    x2 = round(x2);
    
    xdist2 = abs(x2 - store2(:,2)); %diffrence between max value and x2
    outlie2 = (xdist2 > 1); %if greater than 3 --> 1
    outlie2 = imdilate(outlie2, strel('disk',10));
    store2(outlie2,2) = x2(outlie2); %if maximum value in store2 has outlie2  --> column value --> x2 value on outlie2
    linind22 = sub2ind(size(C), store2(:,1),store2(:,2)); %linear indices with the values in store2 subcripts 
    C(linind22) = 1; %white line on outlie2
    
    BB = (B | C); %
    BB = ~bwareaopen(~BB, 40000, 4); % fill in small black part
%     BB = imerode(BB, strel('disk',2));
    
    xdist1 = abs(x1 - store1(:,2)); %diffrence between min value and x1
    outlie1 = (xdist1 > 0); %if greater than 2 --> 1
    outlie1 = imdilate(outlie1, strel('disk',10)); %imdilate
    store1(outlie1,2) = x1(outlie1); %if minimum value in store1 has outlie1  --> column value --> x1 value on outlie1
    linind1 = sub2ind(size(BB), store1(:,1), store1(:,2)); %linear indices with the values in store1 subcripts
    BB(linind1) = 0;   %black line on outlie1
    A = A./255;
    
         if isempty(find(row==rowtop)) == 1 && isempty(find(row==rowbottom))==1 %if there are ones on the both lines.
            A(1000:1500, 1000:2000) = BB;
            A2 = bwareaopen(A(1000:1500, 1000:2000), 500, 4); %remove small white area
            A(1000:1500, 1000:2000) = A2;
       
         else % 1 or 0 one on the lines
            BB2 = imclearborder(BB); %remove white part connected to the borders
            BB3 = BB-BB2; %remove the parts without contact
            A(1000:1500, 1000:2000) = BB3;
        end
        %A(1100:1480, 1080:1580) = A2;
         A3 = bwareaopen(A, 300, 4); %remove very small white area % 800 for normal 300 for 40
          imwrite(A3, sprintf('P:\\Insung\\segmentation files\\%d_segmentation\\%d.tiff', kk, imNo), ...
          'compression', 'none');
    end
end


