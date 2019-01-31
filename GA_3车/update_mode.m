function [a,b,c,d,e,p  ] = update_mode( j,t ,i,mode,a,b,c,d,e,p,ds,dl,v,ta)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

if mode==1

    a(j,t+1)=i;
    b(j,t+1)=0;
    c(j,t+1)=1;
    
    e(j,t+1)=700-i;

        d(j,t+1)=ds(i);
        if abs(p(j,t)-d(j,t+1))<v
            p(j,t+1)=d(j,t+1);
        else
            p(j,t+1)=p(j,t)+v*abs(d(j,t+1)-p(j,t))/(d(j,t+1)-p(j,t));
        end

else
    if mode==2
        p(j,t+1)=ds(i);
        a(j,t+1)=i;
        b(j,t+1)=0;
        c(j,t+1)=2;
        d(j,t+1)=ds(i);
        e(j,t+1)=inf;
    else
        if mode==3
%             p(j,t+1)=p(j,t)+v*abs(dl(i)-p(j,t))/(dl(i)-p(j,t));
            a(j,t+1)=i;
            b(j,t+1)=0;
            c(j,t+1)=3;
            d(j,t+1)=dl(i);
            e(j,t+1)=700-i;
            if abs(p(j,t)-d(j,t+1))<v
                p(j,t+1)=d(j,t+1);
            else
                p(j,t+1)=p(j,t)+v*abs(d(j,t+1)-p(j,t))/(d(j,t+1)-p(j,t));
            end
        else
            if mode==4
                p(j,t+1)=dl(i);
                a(j,t+1)=i;
                b(j,t+1)=0;
                c(j,t+1)=4;
                d(j,t+1)=dl(i);
                e(j,t+1)=inf;
            else
                if mode==0
                    if i~=0
                        a(j,t+1)=i;
                    else
                    
                    a(j,t+1)=0;
                    end
                    p(j,t+1)=p(j,t);
                    b(j,t+1)=0;
                    c(j,t+1)=0;
                    d(j,t+1)=p(j,t);
                    e(j,t+1)=0;
                end
            end
        end
    end
    
    
end

end

