function [ geti] = Copy_of_select_car( car_num,mission_num,D,ta,population_size)
load TD_100
%改名字
%生成种群
%select_car  选择执行任务的天车
%1.确定备选天车
place=[550001,640000,720000];
% car_mlist=zeros(mission_num,car_num);
car_dlist=zeros(mission_num,car_num);
car_dlist(1,:)=place;
ds=D(:,1);
dl=D(:,2);
geti=zeros(population_size,mission_num);
car_list=zeros(car_num,3);%1:备选标记；2：匹配度；3：与起点距离
%2. 计算匹配度
for population_num=1:population_size
    for t=1:14000%改时间
        for i=1:mission_num
            if t==ta(2*i)
                if i==1
                    car_result=ceil(rand()*car_num);
                    car_dlist(1,car_result)=dl(1);
                else
                    
                    for j=1:car_num
                        %找到天车最后一个任务的目标位置，和新的任务对比
                        zero_list=find(car_dlist(:,j)==0);
                        final_d=car_dlist(zero_list(1)-1,j);
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
                    
                    %3.选择天车
                    car_list2=find(car_list(:,2)==max(car_list(:,2)));
                    if length(car_list2)>1
                        
                        car_result=ceil(rand()*length(car_list2));
                        %         car_result=car3(1);
                        %在遗传算法里，这里加随机。
                        
                        
                        
                    else
                        if length(car_list2)==1
                            car_result=car_list2;
                        end
                    end
                end
                geti(population_num,i)=car_result;
            end
        end
    end
end

