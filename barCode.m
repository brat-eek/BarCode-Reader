function [ res,m,num,close,temp,num1 ] = barCode( im,k,r,wBracket,bBracket,ylen,p1 )
res=1;
m=zeros(12,4); % for storing the white black starting points for each of 12 blocks of barcode 
j=k;
num=m;
temp=im;
for i=1:6
    if im(r,j) > 255-bBracket
        m(i,1)=j;
    else
        res=0;
        return;
    end
    while j<ylen && im(r,j) > 255-bBracket 
        j=j+1;
    end
    
    if im(r,j) <= wBracket
        m(i,2)=j;
    else
        res=0;
        return;
    end
    while j<ylen && im(r,j) <= wBracket
        j=j+1;
    end
    
    if im(r,j) > 255-bBracket
        m(i,3)=j;
    else
        res=0;
        return;
    end
    while j<ylen && im(r,j) > 255-bBracket
        j=j+1;
    end
    
    if im(r,j) <= wBracket
        m(i,4)=j;
    else
        res=0;
        return;
    end
    while j<ylen && im(r,j) <= wBracket
        j=j+1;
    end
    if j==ylen
        res=0;
        return;
    end
    
end

% if res = 0 then return from function 'google it' else continue
p=j;
cnt=0;
while cnt<3
    if j<ylen && im(r,j) > 255-bBracket && im(r,j+1) <= wBracket
        cnt=cnt+1;
    end
    j=j+1;
end

% now j is at first black pixel
% now dont have to check

for i=7:12
    m(i,1)=j;
    while j<ylen && im(r,j) <= wBracket
        j=j+1;
    end
    
    m(i,2)=j;
    while j<ylen && im(r,j) > 255-bBracket
        j=j+1;
    end
    
    m(i,3)=j;
    while j<ylen && im(r,j) <= wBracket
        j=j+1;
    end
        
    m(i,4)=j;
    while j<ylen && im(r,j) > 255-bBracket
        j=j+1;
    end
    if j==ylen
        res=0;
        return;
    end
end
s=j;
cnt=0;
while cnt<2
    if j<ylen && im(r,j+1) > 255-bBracket && im(r,j) <= wBracket
        cnt=cnt+1;
    end
    j=j+1;
end
close=j-1;
%temp=imcrop(im,[p1 r close-p1 2]);
%temp=imresize(temp,95/size(im,2));
temp=imcrop(im,[p1 r close-p1 1]);
temp=imresize(temp,95/size(temp,2));

count=4;

num1=zeros(12,7);
for i=1:6
    for j=1:7
        if temp(count) > 255-bBracket
            num1(i,j)=0;
        else
            num1(i,j)=1;
        end
        count=count+1;
    end
end
count=51;
for i=7:12
    for j=1:7
        if temp(count) > 255-bBracket
            num1(i,j)=0;
        else
            num1(i,j)=1;
        end
        count=count+1;
    end
end


for i=1:11
    for j=1:3
        num(i,j)=m(i,j+1)-m(i,j);
    end
    num(i,4)=m(i+1,1)-m(i,4);
end

num(6,4)=p-m(6,4);

%i = 12 
num(12,1)=m(12,2)-m(12,1);
num(12,2)=m(12,3)-m(12,2);
num(12,3)=m(12,4)-m(12,3);
num(12,4)=s-m(12,4);

for i=1:12
    num(i,:)=floor(num(i,:)/min(num(i,:)));
end



    
    