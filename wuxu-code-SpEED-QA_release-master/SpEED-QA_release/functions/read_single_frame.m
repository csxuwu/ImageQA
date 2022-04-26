function y1 = read_single_frame(vidfilename, framenum, height, width)

fid =  fopen(vidfilename);

fseek(fid,(framenum-1)*width*height*1.5,'bof');

y1 = fread(fid,width*height, 'uchar')';
y1 = reshape(y1,[width height]);
y1  = y1';

fclose(fid);