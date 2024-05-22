clear all; close all; clc;
%% Casos aleatorios
li=5;%limite de coordenadas, maximo 5.
limvec=10; %limite del numero de personas.
n = randi([2, limvec]);% Generar un número aleatorio de elementos para el vector (n)
x = li * rand(1, n); % Valores aleatorios
y= li * rand(1, n); % Valores aleatorios

%% CASO CON CENTROS DE MASA
figure
GANGL_V03(x,y,0,1,1);
title('Centro de masa');
xlabel('X');
ylabel('Y');
%% CASO CON MAXIMOS Y MINIMOS
figure
GANGL_V03(x,y,0,1,2);
title('Maximos y minimos');
xlabel('X');
ylabel('Y');
%% CASO CON CASCO CONVEXO
figure
GANGL_V03(x,y,0,1,3);
title('Casco convexo');
xlabel('X');
ylabel('Y');