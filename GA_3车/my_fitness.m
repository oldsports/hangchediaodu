function y = my_fitness(population)
% % population是随机数[0,1]矩阵，下面的操作改变范围为[-1,1]
% population = 2 * (population - 0.5); 
% y = sum(population.^2, 2); % 行的平方和
[x,~]=size(population);
y=zeros(x,7);
%1.y:适应度
%2.c1_time:总等待被运输时间
%3.总运输时间
%4.f1
%5.f2
%6.f3:天车负载时间差异
%7.b_x:天车被动距离
for i=1:x
    a=hangche(population(i,:));
    y(i,:)=a;
end
