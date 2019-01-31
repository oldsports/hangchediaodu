function [ a,b,c,d,e,p ] = update_b( car,t,car2,a,b,c,d,e,p,dis,v,car_update_flag )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
b(car,t+1)=car2;

% if car2>car
%     d(car,t+1)=d(car2,t+1)+dis*abs(car-car2)/(car-car2);
%     e(car,t+1)=e(car2,t);
% else
    d(car,t+1)=d(car2,t+1)+dis*abs(car-car2)/(car-car2);
    e(car,t+1)=e(car2,t+1);
% end
% if d(car,t+1)<0
%     d(car,t+1)=d(car,t);
% end
if abs(p(car,t)-d(car,t+1))<v
    p(car,t+1)=d(car,t+1);
else
    p(car,t+1)=p(car,t)+v*abs(d(car,t+1)-p(car,t))/(d(car,t+1)-p(car,t));
end
if car_update_flag(car)==0
    
    a(car,t+1)=a(car,t);
    c(car,t+1)=c(car,t);
end

end

