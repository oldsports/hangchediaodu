function [ result] = hangche(population)


%���ɵ��������������㡢�յ㡢�������ʱ�䡢����ж��ʱ��
%������ʼ��
% global mission_num





load TD_20
%������
mission_num=20;%��������
mission_time=zeros(mission_num,2);
% global car_num
car_num=3;
% global time_num
time_num=50000;%��ʱ��
place=[550001,640000,720000];
tb=zeros(mission_num,2);

ts=zeros(mission_num,1);
tf=zeros(mission_num,1);
% global tse
tse=T(:,1);
tsl=zeros(mission_num,1);
% global tfl
tfl=T(:,2);
ds=D(:,1);
dl=D(:,2);
v=10000;
L=800000;
dis=15000;
%�쳵״̬
p=zeros(car_num,time_num);%�쳵λ��
a=zeros(car_num,time_num);%�������񣺸���ʱΪ�����ţ�����ʱΪ0
b=zeros(car_num,time_num);%�����ƶ�������ͻΪ0����ͻʱ���ȼ��ϸ�Ϊ0���ϵ�Ϊ���ȼ��ϸߵ��쳵���
c=zeros(car_num,time_num);%�����׶Σ�1�����������2�������3�������ƶ���4��ж�أ�0�����أ�
d=zeros(car_num,time_num);%Ŀ��λ�ã�����������cΪ0����ǰλ�ã�1�����λ�ã�2�����λ�ã�3��ж��λ�ã�4��ж��λ�ã�
%������������ȼ����쳵��Ŀ��λ�þ���dis
e=zeros(car_num,time_num);%�쳵���ȼ�

car_mlist=zeros(mission_num,car_num);
route_car=cell(car_num,1);

update_map=[0,10,30,200,230,202,12,2];
update_list=[1,1,2,3,2,3,1,3];
update_order=[1,2,3;
    3,2,1;
    2,1,3;];
% b_list=zeros(car_num,1);
t=1;
c1_time=0;
b_x=0;



%population2car_mlist
for j=1:car_num
    car_slist=find(population(1,:)==j);
    car_mlist(1:length(car_slist),j)=car_slist';
end
%��ʼ��
for j=1:car_num
    p(j,1)=place(j);
    %     p(j,1)=(car_num-j)*dis;
%     c(j,1)=4;
    a(j,t)=car_mlist(1,j);

end
car_update_time=zeros(car_num,1);
while t<time_num

    car_update_flag=zeros(car_num,1);
    
    order=100*b(1,t)+10*b(2,t)+b(3,t);
    order2=find(update_map==order);
    order_list=update_order(update_list(order2),:);
    for l=1:car_num
        j=order_list(l);
        if car_update_flag(j)~=1
            
            
            if b(j,t)==0
                switch c(j,t)
                    case 1
                        if abs(p(j,t)-d(j,t))<v
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),2,a,b,c,d,e,p,ds,dl,v,ta);
                            car_update_time(j)=t;
                        else
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),1,a,b,c,d,e,p,ds,dl,v,ta);
                        end
                    case 2
                        ta2=T(a(j,t),1);%floor(c(j,t)/2)+1);
                        if t-car_update_time(j)>=ta2
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),3,a,b,c,d,e,p,ds,dl,v,ta);
                        else
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),2,a,b,c,d,e,p,ds,dl,v,ta);
                        end
                    case 3
                        if abs(p(j,t)-d(j,t))<v
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),4,a,b,c,d,e,p,ds,dl,v,ta);
                            car_update_time(j)=t;
                        else
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),3,a,b,c,d,e,p,ds,dl,v,ta);
                        end
                    case 4
                        ta2=T(a(j,t),2);%floor((c(j,t)+1)/2));
                        if t-car_update_time(j)>=ta2
                            if car_mlist(find(car_mlist(:,j)==a(j,t))+1,j)==0
                                [a,b,c,d,e,p]=update_mode(j,t,0,0,a,b,c,d,e,p,ds,dl,v,ta);
                            else
                                if t>=ta(2*car_mlist(find(car_mlist(:,j)==a(j,t))+1,j))
                                [a,b,c,d,e,p]=update_mode(j,t,car_mlist(find(car_mlist(:,j)==a(j,t))+1,j),1,a,b,c,d,e,p,ds,dl,v,ta);
                                else
                                    [a,b,c,d,e,p]=update_mode(j,t,car_mlist(find(car_mlist(:,j)==a(j,t))+1,j),0,a,b,c,d,e,p,ds,dl,v,ta);
                                end
                            end
                        else
                            [a,b,c,d,e,p]=update_mode(j,t,a(j,t),4,a,b,c,d,e,p,ds,dl,v,ta);
                        end
                    case 0
                        if a(j,t)~=0
                            if t>=ta(a(j,t)*2)
                                [a,b,c,d,e,p]=update_mode(j,t,a(j,t),1,a,b,c,d,e,p,ds,dl,v,ta);
                            else
                                [a,b,c,d,e,p]=update_mode(j,t,a(j,t),0,a,b,c,d,e,p,ds,dl,v,ta);
                            end
                        else
%                         if car_mlist(find(car_mlist(:,j)==a(j,t))+1,j)~=0
%                             if t>=ta(2*car_mlist(find(car_mlist(:,j)==a(j,t))+1,j))
%                                 [a,b,c,d,e,p]=update_mode(j,t,car_mlist(find(car_mlist(:,j)==a(j,t))+1,j),1,a,b,c,d,e,p,ds,dl,v,ta);
%                             else
%                                 [a,b,c,d,e,p]=update_mode(j,t,car_mlist(find(car_mlist(:,j)==a(j,t))+1,j),0,a,b,c,d,e,p,ds,dl,v,ta);
%                             end
%                         else
                            [a,b,c,d,e,p]=update_mode(j,t,0,0,a,b,c,d,e,p,ds,dl,v,ta);
%                         end
                        end
                end
            else
                [a,b,c,d,e,p]=update_b(j,t,b(j,t),a,b,c,d,e,p,dis,v,car_update_flag);
            end
        end
        %4����2�����������ռ�ã����ռ��
        if t~=1
            if c(j,t)==4||c(j,t)==2
                if c(j,t+1)~=c(j,t)
                   
                    b_list=find(b(:,t)==j);
                  

                    for k=1:length(b_list)
                        %                             if b(b_list(k),t)==0
                        %                                 continue
                        %                             else
%                         if a(b_list(k),t)==0
%                             [a,b,c,d,e,p]=update_mode(b_list(k),t,a(b_list(k),t),0,a,b,c,d,e,p,ds,dl,v,ta);
%                             car_update_flag(b_list(k))=1;
%                         else
                            [a,b,c,d,e,p,car_update_flag]=update_unb( b_list(k),t,a,b,c,d,e,p,D,v,car_update_flag);
                            
                            %                             end
%                         end
                    end
                end
            end

        end
        car_update_flag(j)=1;
    end
% end
% for j=1:car_num
%     if b(j,t)~=0&&car_update_flag(j)~=1
%         [a,b,c,d,e,p]=update_b(j,t,b(j,t),a,b,c,d,e,p,dis,v);
%     end
% end

jam2=b(2,t+1);
for j=1:car_num
    %�������
    %         if ~isempty(find(b(:,t),j))
    %             b_list=find(b(:,t)==j);
    %             for k=1:length(b_list)
    %                 [a,b,c,d,e,p]=update_b(b_list(k),t,b(b_list(k),t),a,b,c,d,e,p,dis,v);
    %             end
    %         end
    %�жϳ�ͻ
    if t~=1
        %             if j==2&&b(j,t)~=0&&b(j,t+1)~=b(j,t)
        %                 [a,b,c,d,e,p]=isjam(j,4-b(j,t),t,a,b,c,d,e,p,dis,v);
        %             else
        if c(j,t)==4||c(j,t)==2||c(j,t)==0
            %�ж��Ƿ�Ϊ��ʼʱ��,��ʼʱ��Ԥ�⵱ǰ�׶κ���һ�׶εĳ�ͻ
            %��c=1ʱ���ж�c=1��2�ĳ�ͻ����c=3ʱ���ж�c=3��4�ĳ�ͻ
            if c(j,t)~=c(j,t+1)%||c(j,t)~=c(j,t-1)
                %�жϳ�ͻ
                %�����3����
                if j-1>=1
                    [a,b,c,d,e,p]=isjam(j,j-1,t,a,b,c,d,e,p,dis,v,car_update_flag);
                end
                if j+1<=car_num
                    [a,b,c,d,e,p]=isjam(j,j+1,t,a,b,c,d,e,p,dis,v,car_update_flag);
                end
                
                
            end
        end
    end
        %�жϳ�ͻ����
%     end
end
if (b(2,t)~=0&&b(2,t+1)~=b(2,t))||b(2,t+1)~=jam2
    while(1)
    [a,b,c,d,e,p]=isjam(2,1,t,a,b,c,d,e,p,dis,v,car_update_flag);
    jam_num=b(2,t+1);
    [a,b,c,d,e,p]=isjam(2,3,t,a,b,c,d,e,p,dis,v,car_update_flag);
    if jam_num==b(2,t+1)
        break
    end
    end

end
for j=1:car_num
    
    if t~=1
        %ͳ������
        if c(j,t)==1&&c(j,t-1)~=1
            mission_time(a(j,t),1)=t;
        end
        if c(j,t)==4&&c(j,t+1)~=4
            mission_time(a(j,t),2)=t;
        end
        if c(j,t)==1;
            c1_time=c1_time+1;
        end
        if b(j,t)~=0&&p(j,t+1)~=p(j,t)
            b_x=b_x+v;
        end
        if ~isempty(find(car_mlist(1,:)==a(j,t)))
            if a(j,t)~=0
                
            tb(a(j,t),1)=ta(2*a(j,t));
            end
        end
        if c(j,t)==1&&c(j,t-1)~=c(j,t)
            if t<ta(a(j,t)*2)
                tb(a(j,t),1)=ta(a(j,t)*2);
            else
                tb(a(j,t),1)=t;
            end
        end
        if c(j,t)==4&&c(j,t+1)~=c(j,t)
            tb(a(j,t),2)=t;
        end
    end
end

t=t+1;
end
%%������Ӧ��
f=zeros(mission_num,3);
delta_t=zeros(car_num,2);
for i=1:mission_num
    f(i,1)=tb(i,1)-ta(2*i);
    f(i,2)=tb(i,2)-tb(i,1);
    f(i,3)=tb(i,2)-ta(2*i);
end
for j=1:car_num
    for i=1:length(find(car_mlist(:,j)~=0))
        delta_t(j,1)=delta_t(j,1)+f(i,3);
    end
    delta_t(j,2)=(delta_t(j,1)-sum(f(:,3))/car_num)^2;
end
f1=sum(f(:,1));
f2=sum(f(:,2));
f3=sqrt(sum(delta_t(:,2)));
y=f1+f2+f3;
for t=time_num:-1:1
    if length(find(c(:,t)==zeros(car_num,1)))~=car_num
        end_time=t;
        break
    end
        
end
% plot(p(1,:))
% hold on
% plot(p(2,:),'r')
% plot(p(3,:),'g')
result=[y,c1_time,end_time,f1,f2,f3,b_x];
end