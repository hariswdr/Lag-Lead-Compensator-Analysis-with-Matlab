%%UAS PTK (Lag-Lead)
%Nama : Gede Haris Widiarta
%NIM  : 1102174038

clear all;
clc;

%%Inisialisasi Sistem
s  = tf('s');
La = 1/((s)*(s+2)*(s+10));
Kv = 100;                %Pre-define
Wmax  = 5;               %Pre-define
Pimax = 60;              %180-Phase(5 rad = 185) -> 180-185=-5 ->PM(55)+5=60
K  = Kv*20;              %20 -> hasil lim s*La
% bode(La)  

%%Fasa Maju (Lead)
Kd  = 13.92              %Kd = (1+sind(Pimax))/(1-sind(Pimax))
a   = Wmax/sqrt(Kd);
b   = Kd*a;
GDs = Kd*(s+a)/(s+b);
Gs  = 1/((s)*(s+2)*(s+10));
Ls  = K*Gs               %Loop-gain sesudah ditambah K
Ls1 = Ls*GDs             %Loop-gain sistem dengan phase 125, karena PM=55
% bode(Ls)
% hold on             
% bode(Ls1)

%%Fasa Mundur (Lag)
Km  = 0.04;              %20 log K = Magnitude (5 rad = -27.8) -> 10^-27.8/20
am  = 0.05;              %Wmax per 2 dekade
bm  = Km*am;
Gls = Km*(s+am)/(s+bm) 
Ls2 = Ls1*Gls;
% bode(Ls2)

%Respon Step Lag-Lead
ha = K*GDs*Gls*La;
hb = ha/(1+ha);
step(hb)