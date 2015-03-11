function compensate=edgeCompensate(img1)

minPointNum=10
copyPointNum=10
slopeNum=5
cutHeight=20
cutWidth=30

% SE = strel('square',3)
% img= imclose(img1,SE)


img=bwmorph(img1,'skel',Inf); %thinning
figure
imshow(img)
title('thinningResult')

[row col]=size(img);
seed = zeros(size(img))       %用來存放端點的位置 並用來做顯示
compensate = zeros(size(img)) %用來存放最後的結果
seedTemp=[];                  %用來存放端點的位置

%the following is selecting the end points
for i=2:row-1
    for j=2:col-1
        if img(i,j)==1
            mask=img(i-1:i+1,j-1:j+1)
            if(sum(sum(mask==1))<3)
                seed(i,j)=1;
                seedTemp=[seedTemp; i j];
            end
        end
    end
end
% figure
% imshow(seed)
% title('seed')
seedSize=size(seedTemp);
imgCopy=img;

for num=1:seedSize(1)
    
    pointNum=0;        %用來計算是不是每個connected component 有30個一組
    positionTemp=[];   %設定一組位置暫存器的初始值
%     imgCopy=img;       
    x=seedTemp(num,1);
    y=seedTemp(num,2);
    positionTemp=[x y];   %start point
    %img(x,y)=0
    imgCopy(x,y)=0;     %避免下次又拜訪相同的位置
    pointNum=pointNum+1;
       
    outEdge=0;    %flag 用來判斷是不是有超過邊界
    flagOut=0;    %flag 用來判斷是不是已經找到了
    
    while(1)       %開始找尋那一個connect component
        whiteNum=0 %用來看個window是否有其他的白色pixel 也就是用來判斷是不是終點
        for i=x-1:x+1
            for j=y-1:y+1
                if i<1 ||i >row || j<1 ||j>col   %代表這個connected component碰到邊邊了
                    outEdge=1;
                    break;
                end
                %if img(i,j)==1
                if imgCopy(i,j)==1           %代表找到下一個白點了
                    x=i;
                    y=j;
                    positionTemp=[positionTemp;x y]; %將找到的position放入queue中
                    imgCopy(x,y)=0;      %避免下一個循環又找到這個點
                    %img(x,y)=0;
                    pointNum=pointNum+1; %用來計算這個connected component 有幾個元素
                    whiteNum=1;
                    flagOut=1;
                    break;
                end
            end
            if flagOut==1 || outEdge==1   %用來跳出第二個迴圈
                flagOut=0;
                outEdge=0;
                break;
            end
        end
        
        if whiteNum==0 || pointNum==minPointNum %代表已經找到了一個端點了
            break;
        end
    end
    
    if pointNum<minPointNum  %如果大小小於30 pixel，就不算入一整組
        continue
    end
    
    positionTemp=positionTemp(1:copyPointNum,:)   
    
    m1=(positionTemp(1,2)-positionTemp(slopeNum,2))/(positionTemp(1,1)-positionTemp(slopeNum,1));  %計算前幾個點的斜率
    if m1>100
        m1=100
    elseif m1<-100
        m1=-100
    end
    
    m2=(positionTemp(1,2)-positionTemp(copyPointNum,2))/(positionTemp(1,1)-positionTemp(copyPointNum,1)); %計算整體的斜率
    if m2>100
        m2=100
    elseif m2<-100
        m2=-100
    end
    angle=atan((m1-m2)/(1+m1*m2))
    
    xShiftToOroginal=-1*positionTemp(1,1);
    yShiftToOroginal=-1*positionTemp(1,2);
    
    positionTemp(:,1)=positionTemp(:,1)+xShiftToOroginal;
    positionTemp(:,2)=positionTemp(:,2)+yShiftToOroginal;

    positionTemp= positionTemp' %開始做旋轉
    rotate=[cos(angle) -sin(angle); sin(angle) cos(angle)]
    positionTemp=rotate*positionTemp;
    positionTemp=positionTemp'
    
    positionTemp(:,1)=positionTemp(:,1)-xShiftToOroginal;    %平移回去
    positionTemp(:,2)=positionTemp(:,2)-yShiftToOroginal;
    
    xShift=positionTemp(1,1)-positionTemp(copyPointNum,1);
    yShift=positionTemp(1,2)-positionTemp(copyPointNum,2);
    
    positionTemp(:,1)=positionTemp(:,1)+xShift;    %將第30個點平移到第一個點的位置
    positionTemp(:,2)=positionTemp(:,2)+yShift;
    
    
%     slope=[slope;m];        
%     
%     xShift=positionTemp(1,1)-positionTemp(end,1);
%     yShift=positionTemp(1,2)-positionTemp(end,2);
%     sumSlope=yShift/xShift;
%     xAxis=[0:9]'
%     yAxis=slope;
%     p=polyfit(xAxis,yAxis,2);
%     finalSlope=polyval(p,10,2);
%     angle=atan((finalSlope-sumSlope)/(1+finalSlope*sumSlope))
%     
%     for i=1:30
%         xTemp=positionTemp(i,1)
%         yTemp=positionTemp(i,2)
%         positionTemp(i,1)=xTemp*cos(angle)-yTemp*sin(angle)+xShift;
%         positionTemp(i,2)=xTemp*sin(angle)+yTemp*cos(angle)+yShift;
%     end
%     
    for i=1:copyPointNum
        if round(positionTemp(i,1))>0 && round(positionTemp(i,1))<row && round(positionTemp(i,2))>0 && round(positionTemp(i,2))<col
            compensate(round(positionTemp(i,1)),round(positionTemp(i,2)))=1;
        end
    end
end
figure
imshow(compensate)
title('compensate');
tempCompensate=compensate|img;
compensate=zeros(size(img));
compensate(cutHeight:end-cutHeight,cutWidth:end-cutWidth)=tempCompensate(cutHeight:end-cutHeight,cutWidth:end-cutWidth);

end




