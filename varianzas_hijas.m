clc; clear all; close all;
x2=2;
y2=2;

x1=10;
y1=2;

dx = x2 - x1;
dy = y2 - y1;
distancia = sqrt(dx * dx + dy * dy);

% Crear vector t2 que va de 0 a distancia
t2 = linspace(0, distancia, 10);
% Crear vector t1 que va de distancia a 0
t1 = linspace(distancia, 0, 10);

sigma_xx = ((t1/distancia)*x1) - ((t2/distancia)*x2);
sigma_yy = ((t1/distancia)*y1) - ((t2/distancia)*y2);

plot(sigma_xx,sigma_yy);