clc;
close all;
clear all;

%% Casos de uso
% %caso de uso 01
% x1 = [2 4 4];
% y1 = [3 2 3];
% theta1 = [0 90 180];
% % Caso de uso 02
% x2 = [2 2 4];
% y2 = [3 2 2.5];
% theta2 = [0 0 180];
%% Casos aleatorios
li=5;%limite de coordenadas, maximo 5.
limvec=10; %limite del numero de personas.
n = randi([2, limvec]);% Generar un número aleatorio de elementos para el vector (n)
x1 = li * rand(1, n); % Valores aleatorios
y1 = li * rand(1, n); % Valores aleatorios
theta1 = 360 * rand(1, n);  
x2 = li * rand(1, n); % Valores aleatorios
y2 = li * rand(1, n); % Valores aleatorios
theta2 = 360 * rand(1, n); 
%% Determinar Centros de Grupo
% Metodo del centro de masa
cmxm_1=mean(x1);
cmym_1=mean(y1);
cmxm_2=mean(x2);
cmym_2=mean(y2);
% Metodo de maximos
mmxm_1 = (max(x1) + min(x1)) / 2; 
mmym_1 = (max(y1) + min(y1)) / 2;

mmxm_2 = (max(x2) + min(x2)) / 2; 
mmym_2 = (max(y2) + min(y2)) / 2;

% Casco Convexo
k1 = convhull(x1, y1);
chxm_1 = mean(x1(k1));
chym_1 = mean(y1(k1));

k2 = convhull(x2, y2);
chxm_2 = mean(x2(k2));
chym_2 = mean(y2(k2));


%% Graficas
figure(1)
graf_personas(x1,y1,theta1);
hold on;
h1 = plot (cmxm_1,cmym_1,'o','LineWidth', 2,'color','yellow');
hold on;
h2 = plot (mmxm_1,mmym_1,'o','LineWidth', 2,'color','red');
hold on;
h3 = plot (chxm_1,chym_1,'o','LineWidth', 2,'color','black');
legend([h1, h2, h3], {'Centro de masa', 'Maximos y minimos', 'Casco convexo'});
figure(2)
graf_personas(x2,y2,theta2);
hold on;
h1 = plot (cmxm_2,cmym_2,'o','LineWidth', 2,'color','yellow');
hold on;
h2 = plot (mmxm_2,mmym_2,'o','LineWidth', 2,'color','red');
hold on;
h3 = plot (chxm_2,chym_2,'o','LineWidth', 2,'color','black');
legend([h1, h2, h3], {'Centro de masa', 'Maximos y minimos', 'Casco convexo'});