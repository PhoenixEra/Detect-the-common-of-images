%% ����ÿ��ͼƬ���������������ӱ�ʾ

n_img=5;% ����ͼƬ����
n_test = 2;
region_size = [45, 37];
patch_size = [5, 5];
[radius, angle] = cart2polar(region_size);%���ڽ�ֱ������ת��Ϊ����������Ϊԭ��ļ�����ϵ
bin = get_bin(radius, angle, region_size);%���ڽ�������ϵ����Ϊ80��bin

for m=1:n_img
    src_img = (imread(['Input\',num2str(m),'.jpg']));
    imgRgb = imresize(src_img,1/3);
    self_similarities = com_Self_Similarities(imgRgb,region_size,patch_size, bin);
    savePath = sprintf('self_similarities0%d.mat', m);
    save(savePath,'self_similarities');  % ����ÿ��ͼ�����������������mat
end

%%
%���������Ե÷�
width = 1;height = 1;%������ͼ���СΪ100*100
center_sub = [floor(width/2), floor(height/2)];
p = 1;%�����������2����
self_similarities=cell(1,n_img);
for m = 1:n_img
    Path = sprintf('self_similarities0%d.mat', m);
    temp = load(Path);%����ͼ�����������������
    self_similarities1 = temp.self_similarities;
    img_size1 = size(self_similarities1);
    src_img = (imread(['Input\',num2str(m),'.jpg']));
    imgRgb = imresize(src_img,1/3);
    sig_score_img = zeros(img_size1(1),img_size1(2));
    for row1 = center_sub(1)+1:img_size1(1)-center_sub(1)-1
        for col1 = center_sub(2)+1:img_size1(2)-center_sub(2)-1                 
            sub1 = self_similarities1(row1-center_sub(1):row1+center_sub(1),col1-center_sub(2):col1+center_sub(2),:);%��һ��ͼ�����ͼ��
            max_match = zeros(1, n_img-1);%��¼����������ͼ��Ŀ�����ƥ��÷�
            num_img=1;
            match_score = cell(n_img);%��¼����������ͼ��Ŀ��ƥ��÷�
            %����������ͼ���������
            for n = 1:n_img               
                if n~=m
                    Path = sprintf('self_similarities0%d.mat', n);
                    temp = load(Path);
                    self_similarities2 = temp.self_similarities;                   
                    temp1 = repmat(sub1,[size(self_similarities2,1),size(self_similarities2,2)]);
                    temp2 =-1.*(sum((self_similarities2 - temp1).^2,3));
                    max_match(1,num_img) = max(max(temp2));%��¼��ÿ��ͼ������ƥ��÷�
                    match_score{num_img} = reshape(temp2,[],1);           
                    num_img=num_img+1;
                end
            end
            %���������Ե÷�
            temp3 = [match_score{1};match_score{2};match_score{3};match_score{4};match_score{5}];
            avgMatch = mean(temp3);%�����ص㴦�ľ��ο�����������ͼ���е�ƽ��ƥ��÷�
            stdMatch = std(temp3);%ƥ��÷ֱ�׼��
            sig_score_img(row1,col1) = sum((max_match(:)-avgMatch(:))./stdMatch(:));
        end
    end

    savePath = sprintf('sig_img11%d.mat', m);
	save(savePath,'sig_score_img');  % ����ÿ��ͼ�������Ե÷�mat
	
	Path = sprintf('sig_img11%d.mat', m);
    temp = load(Path);
    sig_score_img = temp.sig_score_img;
    src_img = (imread(['Input\',num2str(m),'.jpg']));
    draw_result(src_img, sig_score_img./4, [45, 37],3);%���ÿ��ͼƬ��⵽�Ĺ�ͬĿ��
     
end