%Donde [x y] son las posiciones de todos los individuos que conforman el
%grupo de personas, vf: varianza frontal, vri: varianza rigth, vl:varianza
%left y vre: varianza rear.
function [xrot, yrot, zrot] = gaussiana_asimetrica_n_gdl3d(x,y,vf, vri, vl, vre)
    %Ordenar los puntos
    %rotacion = -20;
    % xcm = sum(x) / length(x);
    % ycm = sum(y) / length(y);
% ---------------> hallar el centro del grupo CG <-----------------------------
    if length (x) == 2
        xcm = sum(x) / length(x);
        ycm = sum(y) / length(y);
    else 
        k = convhull(x, y);
        xcm = mean(x(k));
        ycm = mean(y(k));
    end
% ---------------------------> end <------------------------------------------
% ---------> Ordenamiendo de los puntos en sentido horario <------------------
    ang_ordenar = rad2deg(atan2(y - ycm, x - xcm));
    angulos_ajustados = mod(ang_ordenar, 360);
    [~, indice_orden] = sort(angulos_ajustados); % Ordenar los puntos según los ángulos ajustados
    x_ord = x(indice_orden); % Generar los nuevos vectores x e y ordenados
    y_ord = y(indice_orden);
%----------------------------> end <------------------------------------------
    %Se halla las distancias del centro de masa a cada pesona, ademas del
    %angulo formado con respecto al eje x
    [dis, ang] = dis_ang (x_ord,y_ord,xcm,ycm);
    %Se determina los sigmas principales
%----------------------------ROTACION DE LA GAUSSIANA ----------------------

    % if ang(1)<180 && ang(1)>90
    %     rotacion = -(ang(1)-90);
    % elseif ang(1)>180 && ang(1)<270
    %     rotacion = -(ang(1)-180);
    % elseif ang(1)>270 && ang(1)<360  
    %     rotacion = -(ang(1)-270);
    % else 
    %     rotacion = -ang(1);
    % end
    rotacion = -ang(1);
    % rotacion = 0;
    % rotacion = -25;
 
%-----------------------------------END------------------------------------
    for i=1:length(dis)
        if ang(i)>=0 && ang(i)<=180
            sigma_y(i) = abs((dis(i))*sin(deg2rad (ang(i))))+vf;
            sigma_x(i) = abs((dis(i))*cos(deg2rad (ang(i))))+vf;
        else
            sigma_y(i) = abs((dis(i))*sin(deg2rad (ang(i))))+vre;
            sigma_x(i) = abs((dis(i))*cos(deg2rad (ang(i))))+vre;
        end
        if ang(i)>=90 && ang(i)<=270
            sigma_y(i) = abs((dis(i))*sin(deg2rad (ang(i))))+vl;
            sigma_x(i) = abs((dis(i))*cos(deg2rad (ang(i))))+vl;
        else
            sigma_y(i) = abs((dis(i))*sin(deg2rad(ang(i))))+vri;
            sigma_x(i) = abs((dis(i))*cos(deg2rad(ang(i))))+vri;
        end
    end
%Se añade el sigma inicial, al final de todos los sigmas.
    sigma_x(length(sigma_x)+1)=sigma_x(1);
    sigma_y(length(sigma_y)+1)=sigma_y(1);
%Se determinan las distancias para hallar los sigmas intermedios.
    for i=1:length(ang)
        if i==length(ang)
            distan(i)=360-ang(i)+ang(1);
        else
            distan(i)=ang(i+1)-ang(i);
        end
    end
%se genera un valor de cero al comienzo del arreglo para manerar mejor los
%indices:
    j=1;
    for i=1:length(distan)+1
        if i==1
            distancias(j)=0;
            j=j+1;
        else
            distancias(j)=distan(i-1);
            j=j+1;
        end
    end
%Generacion de el vector de sigmas, para esto se hara un recorrido de 360
%grados con saltos de delta_ang, se comenzara desde el punto mas cercano al
%eje x y ademas contando el angulo desplazado positivamente en sentido
%antihorario.
    delta_ang=1;%----------------------------------------------------------------------------------------------
    j=2;
    k=1;
    cont=0;
    angulo=0;
    for i=1:360
        if i>distancias(j)+angulo
            angulo=distancias(j)+angulo;
            j=j+1;
            k=k+1;
            cont=0;
        end
        t1=distancias(j)-cont;
        t2=cont;
        cont=cont+delta_ang;
        sigma_xx(i) = ((t1/distancias(j))*sigma_x(k)) + ((t2/distancias(j))*sigma_x(k+1));
        sigma_yy(i) = ((t1/distancias(j))*sigma_y(k)) + ((t2/distancias(j))*sigma_y(k+1));
    end

% ---------------> Se crea la malla con la cual se hallara la gaussiana <--------------
    xpos = abs(max(x))+3;
    xneg = abs(min(x))-3;
    ypos = abs(max(y))+3;
    yneg = abs(min(y))-3;

    [xx, yy] = meshgrid((xneg):0.01:(xpos), (yneg):0.01:(ypos));
% ----------------------------------> end malla <--------------------------------------
    tam=size(yy);
    for i=1:1:tam(1)
        for j=1:1:tam(2)
            theta = atan2(yy(i,j) - ycm, xx(i,j) - xcm); 
            theta = mod(rad2deg (theta), 360);
            alpha = round( theta ); %redondeando se asigna un valor al angulo OJO
            if alpha>=360
                alpha=360;
            end
            if alpha<=1
                alpha=1;
            end
            varianzax(i,j) = sigma_xx(alpha);
            varianzay(i,j) = sigma_yy(alpha);
        end
    end
%Se crea la gaussiana:
    zz = exp(-(xx - xcm).^2 ./ (2 .* varianzax.^2) - (yy - ycm).^2 ./ (2 .* varianzay.^2));

    for i = 1:101
        for j = 1:101
            % Accede al elemento en la posición (i, j)
            %fprintf('%f',zz(i, j));
        end
        %fprintf('\n');
    end    
%Se rota el desfase de la gaussiana
    [xrot,yrot,zrot] = rotar_gaussiana (xx,yy,zz,rotacion,xcm,ycm);
%Se grafica el contorno
    % contour(xrot,yrot,zrot,[0.1,0.1],'LineColor', 'g');
    % hold on;
    % contour(xrot,yrot,zrot,[0.3,0.3],'LineColor', 'y');
    % hold on;
    % contour(xrot,yrot,zrot,[0.6,0.6],'LineColor', 'r')
    % hold on;
    % plot(xcm, ycm, 'bo', 'MarkerSize', 15); % Marcar centro de masa en rojo
    % hold on;
    % plot(xcm, ycm, 'bo', 'MarkerSize', 10); % Marcar centro de masa en rojo
    % hold on;
    % plot(xcm, ycm, 'bo', 'MarkerSize', 5); % Marcar centro de masa en rojo

    mesh(xx, yy,zz);
end