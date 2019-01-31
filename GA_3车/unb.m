function [ a,b,c,d,e,p,car_update_flag ] = unb( j,t,a,b,c,d,e,p,D,v,car_update_flag )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
b_list=find(b(:,t)==j);
ds=D(:,1);
dl=D(:,2);
for k=1:length(b_list)
    if a(b_list(k),t)==0
        [a,b,c,d,e,p]=update_mode(b_list(k),t,a(b_list(k),t),0,a,b,c,d,e,p,ds,dl,v);
        car_update_flag(b_list(k))=1;
    else
        [a,b,c,d,e,p,car_update_flag]=update_unb( b_list(k),t,a,b,c,d,e,p,D,v,car_update_flag);
    end
end
end

