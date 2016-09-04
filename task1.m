im=(imread('try2.jpg'));

for u=1:size(im,1)
    for v=1:size(im,2)
        if im(u,v)>=124
            im(u,v)=255;
        end
    end
end

wBracket=126;
bBracket=126;

rowChecks=4;
step=round(size(im,1)/rowChecks);
row=zeros(1,rowChecks);

for i=1:rowChecks
    row(i)=step*i-10;
end

flag=0;

for r=1:rowChecks
    k=1;
    while k < size(im,2)
        if im(row(r),k) <= wBracket % condition for blackish pixel
            p1=k;
            
            while k<size(im,2) && im(row(r),k) <= wBracket
                k=k+1;
            end
            if k==size(im,2)
                break;
            end
            if im(row(r),k) > 255-bBracket
                p2=k;
                
                while k<size(im,2) && im(row(r),k) > 255-bBracket
                    k=k+1;
                end
                if k==size(im,2)
                    break;
                end
                if im(row(r),k) <= wBracket
                    p3=k;
                    
                    while k<size(im,2) && im(row(r),k) <= wBracket
                        k=k+1;
                    end
                    if k==size(im,2)
                        break;
                    end
                    p4=k;
       
                    w1=p2-p1;
                    w2=p3-p2;
                    w3=p4-p3;
                    if abs(w1-w3)<=2 && abs(w2-w1)<5
                        [res,m,num,close,temp,num1]=barCode(im,k,row(r),wBracket,bBracket,size(im,2),p1);
                        if res==1
                            flag=1;
                        end
                    else
                        k=p3-2;
                    end
                end
            end
        end
        
        if flag==1
            break;
        end
        k=k+1;
    end
    if flag==1
        break;
    end
end
q='barcode not detected';
if flag==0
    q
end
    

