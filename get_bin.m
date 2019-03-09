%% ���ڽ�������ϵ����Ϊ15*3=45��bin�������в���80bin�����Ǵ���̫���������ͼ����������ţ������Ӧ������bin�Ļ��֣�
%���뼫�����ʾ�İ뾶�ͽǶȾ���������ֺõ�bin
function bin = get_bin(radius, angle, region_size)
max_radius = max(max(radius));%���뾶
bin = cell(15, 3)
for m = 0:14
    theta_low = m*24;theta_up = (m+1)*24;
    for n = 0:2
        rho_low = max_radius*n/3;rho_up = max_radius*(n+1)/3;
        %ѭ������region���ҵ�����ͬһ��bin��ͼ��λ�ã����浽cell��
        temp = [];num = 0;
        for row = 1:region_size(1)
            for col = 1:region_size(2)
                if (radius(row, col)>=rho_low) & (radius(row, col)<=rho_up) & (angle(row, col)>=theta_low) & (angle(row, col)<=theta_up)
                    num = num + 1;
                    temp(1,num) = row;temp(2,num) = col;
                end
            end
        end
        bin{m+1, n+1}=temp;
    end
end