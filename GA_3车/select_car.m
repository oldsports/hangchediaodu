function [ car_result] = select_car( i,car_num,car_mlist,a,b,c,d,e,p,ds,dl,t,tfl ,v)
%select_car  ѡ��ִ��������쳵
%1.ȷ����ѡ�쳵
car_list=zeros(car_num,3);%1:��ѡ��ǣ�2��ƥ��ȣ�3����������
%R=zeros(mission_num,car_num);%�������쳵ƥ���
ta=60;
for j=1:car_num
    if c(j,t)==0
        car_list(j,1)=1;
    else
        if car_mlist(find(car_mlist==a(j,t))+1)==0
            if c(j,t)==1
                if tfl(i)-t<4*ta+(abs(p(j,t)-ds(a(j,t)))+abs(ds(a(j,t))-dl(a(j,t)))+abs(ds(i)-dl(a(j,t)))+abs(dl(i)-ds(i)))/v
                    %���쳵���ӵ���ѡ�쳵
                    car_list(j,1)=1;
                end
            else
                if c(j,t)==2||c(j,t)==3||c(j,t)==4
                    if tfl(i)-t<4*ta+(abs(p(j,t)-dl(a(j,t)))+abs(ds(i)-dl(a(j,t)))+abs(dl(i)-ds(i)))/v
                        %���쳵���ӵ���ѡ�쳵
                        car_list(j,1)=1;
                    end
                end
            end
        end
    end
end

%2. ����ƥ���

for j=1:car_num
    %�ҵ��쳵���һ�������Ŀ��λ�ã����µ�����Ա�
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
%3.ѡ���쳵
car_list2=find(car_list(:,2)==max(car_list(:,2)));
if length(car_list2)>1
    car3=find(car_list(:,3)==min(car_list(car_list2,3)));
    if length(car3)>1
        car_result=ceil(rand()*length(car3));
%         car_result=car3(1);
%���Ŵ��㷨�����������

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

