function [ a,b,c,d,e,p ,car_update_flag,car_update_time] = update_car( j,a,b,c,d,e,p ,car_update_flag,car_update_time,car_mlist)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if car_update_flag(j)~=1
    
    car_update_flag(j)=1;
    if b(j,t)==0
        switch c(j,t)
            case 1
                if abs(p(j,t)-d(j,t))<v
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),2,a,b,c,d,e,p,ds,dl,v);
                    car_update_time(j)=t;
                else
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),1,a,b,c,d,e,p,ds,dl,v);
                end
            case 2
                ta2=T(a(j,t),1);%floor(c(j,t)/2)+1);
                if t-car_update_time(j)>=ta2
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),3,a,b,c,d,e,p,ds,dl,v);
                else
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),2,a,b,c,d,e,p,ds,dl,v);
                end
            case 3
                if abs(p(j,t)-d(j,t))<v
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),4,a,b,c,d,e,p,ds,dl,v);
                    car_update_time(j)=t;
                else
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),3,a,b,c,d,e,p,ds,dl,v);
                end
            case 4
                ta2=T(a(j,t),2);%floor((c(j,t)+1)/2));
                if t-car_update_time(j)>=ta2
                    if car_mlist(find(car_mlist(:,j)==a(j,t))+1,j)==0
                        [a,b,c,d,e,p]=update_mode(j,t,a(j,t),0,a,b,c,d,e,p,ds,dl,v);
                    else
                        [a,b,c,d,e,p]=update_mode(j,t,car_mlist(find(car_mlist(:,j)==a(j,t))+1,j),1,a,b,c,d,e,p,ds,dl,v);
                    end
                else
                    [a,b,c,d,e,p]=update_mode(j,t,a(j,t),4,a,b,c,d,e,p,ds,dl,v);
                end
            case 0
                [a,b,c,d,e,p]=update_mode(j,t,a(j,t),0,a,b,c,d,e,p,ds,dl,v);
        end
        %             else
        %                 [a,b,c,d,e,p]=update_b(j,t,b(j,t),a,b,c,d,e,p,dis,v);
    end
end
%4或者2结束，如果有占用，解除占用
if t~=1
    if c(j,t)==4||c(j,t)==2
        if c(j,t+1)~=c(j,t)
            if ~isempty(find(b(:,t),j))
                b_list=find(b(:,t)==j);
                for k=1:length(b_list)
                    if a(b_list(k),t)==0
                        [a,b,c,d,e,p]=update_mode(b_list(k),t,a(b_list(k),t),0,a,b,c,d,e,p,ds,dl,v);
                        car_update_flag(b_list(k))=1;
                    else
                        [a,b,c,d,e,p]=update_unb( b_list(k),t,a,b,c,d,e,p,D,v);
                        car_update_flag(b_list(k))=1;
                    end
                end
            end
        end
    end
end

end

