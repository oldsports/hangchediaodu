function [ a,b,c,d,e,p,car_update_flag ] = update_unb( car,t,a,b,c,d,e,p,D,v,car_update_flag )
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
b(car,t+1)=0;
% a(car,t+1)=a(car,t);
% c(car,t+1)=c(car,t);
if c(car,t)==0
    a(car,t+1)=a(car,t);
    c(car,t+1)=c(car,t);
    d(car,t+1)=d(car,t);
else
    d(car,t+1)=D(a(car,t),ceil(c(car,t)/2));
end
if abs(p(car,t)-d(car,t+1))<v
    p(car,t+1)=d(car,t+1);
else
    p(car,t+1)=p(car,t)+v*abs(d(car,t+1)-p(car,t))/(d(car,t+1)-p(car,t));
end
if c(car,t+1)==0
%     e(car,t+1)=e(car,t);
    a(car,t+1)=a(car,t);
    c(car,t+1)=c(car,t);
end
if a(car,t+1)==0
    e(car,t+1)=0;
else
    e(car,t+1)=700-a(car,t+1);
end
car_update_flag(car)=1;

%�жϹ�������
if ~isempty(find(b(:,t)==car))
    [ a,b,c,d,e,p,car_update_flag ] = unb( car,t,a,b,c,d,e,p,D,v,car_update_flag );
end
end

