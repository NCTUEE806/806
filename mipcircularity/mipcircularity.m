function c= mipcircularity(im)
p=[]
[row col]=size(im);
for i=1:row
    for j=1:col
        if im(i,j)==1
            p=[p;i j];
        end
    end
end
xmean=mean(p(:,1));
ymean=mean(p(:,2));
npoints=size(p,1);
for i=1:npoints
    d(i)=sqrt((p(i,1)-xmean)^2+(p(i,2)-ymean)^2);
    
end

mur=sum(d)/npoints;
sgmr=0;

for i=1:npoints
    sgmr=sgmr+(d(i)-mur)^2;
end

sgmr=sgmr/npoints;
c=mur/sqrt(sgmr);
end
