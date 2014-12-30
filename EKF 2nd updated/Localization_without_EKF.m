% First run the file named Run_this_first.m and then execute this program

clear all; close all; clc;
% load lasandodo_data_corridor; % File containing las_dat, odo_dat
load lasandodo_data_maze1; % File containing las_dat, odo_dat
[r_las,c_las]=size(las_dat);
[r_odo,c_odo]=size(odo_dat);

dum=1;
delTh=0; ACdelTh=0;
% Xnow = [0 0 pi/2]; % Start position (x, y, theta) for Corridor
Xnow = [0.5 1.28 pi/2]; % Start position (x, y, theta) for maze
[po_now,re_now,re_x,re_y] = GetObservation(las_dat(1,2:c_las),Xnow(3));
po_past=po_now; re_past=re_now;
Xpast=Xnow;
for k=2:1500
    k
    Xpast
    [Xnow, ACdelTh,delX,delY,delTh] = GetOdometry(odo_dat(k-1:k,:),Xpast);
    ACdelTh
    [po_now,re_now,re_x,re_y] = GetObservation(las_dat(k,2:c_las),Xnow(3));
    Xnow
    Xpast=Xnow;
    
    dum=dum+1;
    if ~isempty(re_now)
        if dum>5            
            figure(1);
            hold on;
            plot(re_x+Xnow(1),re_y+Xnow(2),'.k',re_now(1,:)+Xnow(1),re_now(2,:)+Xnow(2),'ob');
            pause(0.01);
            dum=1;
        end
    end
end