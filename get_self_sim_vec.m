%% ���ڽ�������ת��Ϊ��������������
%����patch��region�������Ծ������������ת����ȡbin�������������������������
function self_similarities_vec = get_self_sim_vec(ssd_region, bin, vec_size)

self_similarities_vec = zeros(1, vec_size);%��ʼ�����ص㴦��������
num = 0;
for m = 0:14
    for n = 0:2
        temp = bin{m+1, n+1};
        max_value = 0;
        %�ҵ�����ͬһ��bin�е����ֵ
        temp_size = size(temp);
        for loc = 1:temp_size(2)
            row = temp(1, loc);
            col = temp(2, loc);
            max_value = max(max_value, ssd_region(row, col));
        end
        num = num + 1;
        self_similarities_vec(num)=max_value;
    end
end
