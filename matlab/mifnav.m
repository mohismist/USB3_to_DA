function mifnav(infile,outfile)

%% mif Navigation Message Generate
% Copyright (c) 2017-3-10 Mohismist ��ΰ��
%   All rights reserved.
%   Email: mohismist@yahoo.com
%
% Reference:
%
% Introductions:
%   ˵��������.mif��ʽ��NAV����
%   @param infile: input binary file containing navigation message
%   @param outfile: output file: outfile.mif
%

%% ***** Read Navigation Message *****
    num = 2048;
    if(nargin ~= 2)
        error('Please check the input parameters.');
    elseif(floor(num/4) ~= num/4)
        error('Please check the parameter.');
    end
    
    fid=fopen(infile,'r');
    data_nav(1:num) = fread(fid,num,'ubit4');
    fclose(fid); 
    data_nav = reshape(data_nav,4,num/4);
    data_nav = [data_nav(2,1:end);data_nav(1,1:end);data_nav(4,1:end);data_nav(3,1:end)];
    data_nav = num2str(reshape(data_nav,1,num)');

%% ***** Generate .mif File *****    fid=fopen(strcat(outfile,'.mif'),'w');
    fid=fopen(strcat(outfile,'.mif'),'w');
    fprintf(fid,'WIDTH=1;\n'); %ָ��ÿ����ֵ���ֿ�
    fprintf(fid,'DEPTH=%d;\n',num); %ָ����ֵ�ĸ�������ROM�����
    fprintf(fid,'ADDRESS_RADIX=UNS;\n'); %ָ����ַ�����ƣ�UNS���޷�������
    fprintf(fid,'DATA_RADIX=HEX;\n'); %ָ�����ݻ���
    fprintf(fid,'CONTENT BEGIN\n'); %�̶���ʽ
    for k=1:num %���ݶ�����
        fprintf(fid,'%3d',k-1);
        fprintf(fid,' : ');
        fprintf(fid,'%s',data_nav(k));
        fprintf(fid,';\n');
    end
    fprintf(fid,'END;\n'); %�̶���ʽ
    fclose(fid); 
end