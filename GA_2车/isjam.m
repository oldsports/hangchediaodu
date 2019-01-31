function [ a1,b1,c1,d1,e1,p1 ] = isjam( j,k,t,a,b,c,d,e,p,dis,v,car_update_flag )
%UNTITLED 此处显示有关此函数的摘要
%预测路线，从p到d
if p(j,t)-d(j,t+1)==0
    delta_j=v;
else
    delta_j=-1*v*abs(p(j,t)-d(j,t+1))/(p(j,t)-d(j,t+1));
end
if p(k,t)-d(k,t+1)==0
    delta_k=v;
else
    delta_k=-1*v*abs(p(k,t)-d(k,t+1))/(p(k,t)-d(k,t+1));
end
route_car{j}=p(j,t):delta_j:d(j,t+1);
route_car{k}=p(k,t):delta_k:d(k,t+1);
route_new=ones(abs(length(route_car{j})-length(route_car{k})),1)';
%补全短的路线
if length(route_car{j})>length(route_car{k})
    route_new=route_new*route_car{k}(length(route_car{k}));
    route_car{k}=[route_car{k},route_new];
else
    route_new=route_new*route_car{j}(length(route_car{j}));
    route_car{j}=[route_car{j},route_new];
end
%判断是否有交集
%                     if ~isempty(intersect(route_car{j},route_car{k}))
if ~isempty(find(abs(route_car{k}-route_car{j})<dis,1))
    %低优先级和b~=0，更新冲突状态  2.6  2.7
    if e(k,t+1)>e(j,t+1)%&&b(j,t)==0%更新j
        [a1,b1,c1,d1,e1,p1]=update_b(j,t,k,a,b,c,d,e,p,dis,v,car_update_flag);
        %         car_update_flag(j)=1;
    else
        if e(j,t+1)>e(k,t+1)%&&b(k,t)==0%更新k
            [a1,b1,c1,d1,e1,p1]=update_b(k,t,j,a,b,c,d,e,p,dis,v,car_update_flag);
            %             car_update_flag(k)=1;
            
        else
            a1=a;
            b1=b;
            c1=c;
            d1=d;
            e1=e;
            p1=p;
        end
    end
else
    a1=a;
    b1=b;
    c1=c;
    d1=d;
    e1=e;
    p1=p;
end

end

