function [ geti] = Copy_of_select_car( car_num,mission_num,D,ta,population_size)
load TD_100
%������
%������Ⱥ
%select_car  ѡ��ִ��������쳵
%1.ȷ����ѡ�쳵
place=[550001,640000,720000];
% car_mlist=zeros(mission_num,car_num);
car_dlist=zeros(mission_num,car_num);
car_dlist(1,:)=place;
ds=D(:,1);
dl=D(:,2);
geti=zeros(population_size,mission_num);
car_list=zeros(car_num,3);%1:��ѡ��ǣ�2��ƥ��ȣ�3����������
%2. ����ƥ���
for population_num=1:population_size
    for t=1:14000%��ʱ��
        for i=1:mission_num
            if t==ta(2*i)
                if i==1
                    car_result=ceil(rand()*car_num);
                    car_dlist(1,car_result)=dl(1);
                else
                    
                    for j=1:car_num
                        %�ҵ��쳵���һ�������Ŀ��λ�ã����µ�����Ա�
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
                    
                    %3.ѡ���쳵
                    car_list2=find(car_list(:,2)==max(car_list(:,2)));
                    if length(car_list2)>1
                        
                        car_result=ceil(rand()*length(car_list2));
                        %         car_result=car3(1);
                        %���Ŵ��㷨�����������
                        
                        
                        
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

