%% ���ڽ�ֱ������ת��Ϊ����������Ϊԭ��ļ�����ϵ
%����region�����������ϵ�뾶�ͽǶȾ���
function [radius, angle] = cart2polar(region_size)
radius = zeros(region_size(1), region_size(2));%������뾶
angle = zeros(region_size(1), region_size(2));%������Ƕ�
center = [ceil(region_size(1)/2), ceil(region_size(2)/2)];
for row = 1:region_size(1)
    for col = 1:region_size(2)
        [theta,rho]=cart2pol(row-center(1),col-center(2));%ֱ������ת������
        radius(row,col) = log(rho);
        angle(row,col) = theta*180/pi + 180;
    end
end