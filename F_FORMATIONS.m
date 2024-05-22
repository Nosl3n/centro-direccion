clc; clear all;
close all;
%% Distribución "A" de personas según las F-formations.
x1=2; x2=2.6;
y1=1; y2=0;
% theta1=0;
% theta2=90;
x=[x1, x2];
y=[y1, y2];
% theta=[theta1,theta2];
figure (1)
GANGL_V03(x,y,0,1,2);
grid on;
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo A de las f-formations');
%% Distribución "B" de personas según las F-formations.
x1=6; x2=5;
y1=4; y2=4;
% theta1=180;
% theta2=0;
x=[x1, x2];
y=[y1, y2];
% theta=[theta1,theta2];
figure (2)
GANGL_V03(x,y,0,1,2);
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo B de las f-formations');
%% Distribución "C" de personas según las F-formations.
x1=6; x2=5;
y1=4; y2=4;
% theta1=90;
% theta2=90;
x=[x1, x2];
y=[y1, y2];
% theta=[theta1,theta2];
figure (3)
GANGL_V03(x,y,0,1,2);
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo C de las f-formations');

%% Distribución de D personas según las F-formations.
x1=1; x2=2; x3=3;
y1=3; y2=2; y3=3;
% theta1=30;
% theta2=90;
% theta3=150;
x=[x1, x2, x3];
y=[y1, y2, y3];
% theta=[theta1,theta2,theta3];
figure (4)
GANGL_V03(x,y,0,1,2);
grid on;
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo D de las f-formations');

%% Distribución de E personas según las F-formations.
x1=1; x2=2; x3=3;
y1=3; y2=4; y3=3;
% theta1=30;
% theta2=270;
% theta3=150;
x=[x1, x2, x3];
y=[y1, y2, y3];
% theta=[theta1,theta2,theta3];
figure (5)
graficar_personas(x,y);
GANGL_V03(x,y,0,1,2);
grid on;
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo E de las f-formations');

%% Distribución de F personas según las F-formations.
x1=1; x2=1; x3=4;
y1=3; y2=5; y3=4;
% theta1=30;
% theta2=300;
% theta3=180;
x=[x1, x2, x3];
y=[y1, y2, y3];
% theta=[theta1,theta2,theta3];
figure (6)
GANGL_V03(x,y,0,1,2);
grid on;
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo F de las f-formations');

%% Distribución de F personas según las F-formations.
x1=1; x2=1.2; x3=4;
y1=3; y2=5; y3=4.5;
% theta1=30;
% theta2=300;
% theta3=180;
x=[x1, x2, x3];
y=[y1, y2, y3];
% theta=[theta1,theta2,theta3];
figure (7)
GANGL_V03(x,y,0,1,2);
grid on;
xlabel('Coordenada X');
ylabel('Coordenada Y');
title('Distribución del tipo F de las f-formations');
