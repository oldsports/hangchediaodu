function y = my_fitness(population)
% % population�������[0,1]��������Ĳ����ı䷶ΧΪ[-1,1]
% population = 2 * (population - 0.5); 
% y = sum(population.^2, 2); % �е�ƽ����
[x,~]=size(population);
y=zeros(x,7);
%1.y:��Ӧ��
%2.c1_time:�ܵȴ�������ʱ��
%3.������ʱ��
%4.f1
%5.f2
%6.f3:�쳵����ʱ�����
%7.b_x:�쳵��������
for i=1:x
    a=hangche(population(i,:));
    y(i,:)=a;
end
