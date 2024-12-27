function [gx,gy]=sobel(matrix)
z1=matrix(1,1);
z2=matrix(1,2);
z3=matrix(1,3);
z4=matrix(2,1);
z6=matrix(2,3);
z7=matrix(3,1);
z8=matrix(3,2);
z9=matrix(3,3);

gx=z7+2*z8+z9-z1-2*z2-z3;
gy=z3+2*z6+z9-z1-2*z4-z7;
