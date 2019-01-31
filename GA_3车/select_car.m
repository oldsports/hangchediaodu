function [ car_result] = select_car( i,car_num,car_mlist,a,b,c,d,e,p,ds,dl,t,tfl ,v)
%select_car  选择执行任务的天车
%1.确定备选天车
car_list=zeros(car_num,3);%1:备选标记；2：匹配度；3：与起点距离
%R=zeros(mission_num,car_num);%任务与天车匹配度
ta=60;
for j=1:car_num
    if c(j,t)==0
        car_list(j,1)=1;
    else
        if car_mlist(find(car_mlist==a(j,t))+1)==0
            if c(j,t)==1
                if tfl(i)-t<4*ta+(abs(p(j,t)-ds(a(j,t)))+abs(ds(a(j,t))-dl(a(j,t)))+abs(ds(i)-dl(a(j,t)))+abs(dl(i)-ds(i)))/v
                    %将天车增加到备选天车
                    car_list(j,1)=1;
                end
            else
                if c(j,t)==2||c(j,t)==3||c(j,t)==4
                    if tfl(i)-t<4*ta+(abs(p(j,t)-dl(a(j,t)))+abs(ds(i)-dl(a(j,t)))+abs(dl(i)-ds(i)))/v
                        %将天车增加到备选天车
                        car_list(j,1)=1;
                    end
                end
            end
        end
    end
end

%2. 计算匹配度

for j=1:car_num
    %找到天车最后一个任务的目标位置，和新的任务对比
    if a(j,t)==0
        final_d=d(j,t);
    else
        zero_list=find(car_mlist(:,j)==0);
        final_d=dl(car_mlist(zero_list(1)-1,j));
    end
    if car_list(j,1)==1
        dists=abs(ds(i)-final_d);
        car_list(j,3)=dists;
        if ds(i)<final_d&&final_d<dl(i)
            car_list(j,2)=3;
        else
            
            distl=abs(dl(i)-final_d);
            if dists<distl
                car_list(j,2)=2;
            else
                car_list(j,2)=1;
            end
        end
       
    end
end
%3.选择天车
car_list2=find(car_list(:,2)==max(car_list(:,2)));
if length(car_list2)>1
    car3=find(car_list(:,3)==min(car_list(car_list2,3)));
    if length(car3)>1
        car_result=ceil(rand()*length(car3));
%         car_result=car3(1);
%在遗传算法里，这里加随机。

    else
        if length(car3)==1
            car_result=car3;
        end
    end
    
else
    if length(car_list2)==1
        car_result=car_list2;
    end
end

end

