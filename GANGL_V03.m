function GANGL_V03(x,y,GRAF,per,centro)
    addpath('funtions_V01/');
    addpath('funtions_V03/');
    %% Determinacion del centro del grupo:
    if length (x) == 2 %Si son dos personas CM
        xcm = sum(x) / length(x);
        ycm = sum(y) / length(y);
    else %Mas de 2 personas CH
        if (centro == 1)
            xcm = sum(x) / length(x);
            ycm = sum(y) / length(y);
        elseif (centro == 2)
            xcm = (max(x) + min(x)) / 2; 
            ycm = (max(y) + min(y)) / 2;
        elseif (centro == 3)
            k = convhull(x, y);
            xcm = mean(x(k));
            ycm = mean(y(k));
        end
    end
    %% Ordenamiento de los puntos en sentido horario.
    [x_ord, y_ord] = ordenar_puntos(xcm,ycm,x,y);
    %% Determinacion de las distancias y sus angulos con respecto al eje x, de cada punto al centro del grupo
    [dis, ang] = dis_ang (x_ord,y_ord,xcm,ycm);
    
    %% DETERMINACION DE LA ORIENTACION
    ang_vec = orientacion_vec(x_ord,y_ord,xcm,ycm,1);
    % Determinar el valor mas cercano a la orientacion
    orientacion = 1000;
    for i=1:length(ang)
        if ang_vec < ang(i)
            orientacion = ang(i); %Primer angulo, para rotar todo
            break;
        end
        %En el caso de que no hay angulos mayores a la direccion veectorial
        %escogera el primer angulo desde 0°
        if orientacion == 1000
            orientacion = ang(1);
        end
    end
    %% EL ANGULO QUE SE TIENE QUE ROTAR SERA "ORIENTACION"
    rotacion = -orientacion;
    %% DETERMINANOS LA NUEVA DISTRIBUCION DE VECTORES
    % disp('direccion');
    % disp(ang_vec);disp(orientacion);
    % disp('distribucion normal');
    % disp(ang);disp(x_ord);disp(y_ord);
    [ang_new ang x_new y_new] = ordenamiento(ang, orientacion, x_ord, y_ord); %la nueva entrada sera: 
    %ang, x_new y y_new.
    % disp('distribucion con direccion');
    % disp(ang_new);disp(ang_ord);disp(x_new);disp(y_new);
    %% Determinacion de las distancias y sus angulos con respecto al eje x, de cada punto al centro del grupo
    [dis, ang_sum] = dis_ang (x_new,y_new,xcm,ycm);
    %% Determinacion de las varianzas Madre
        min_sig = 0.5; %minimo valor de las varianzas
        for i=1:length(dis)  
            sigma_y(i) = abs(dis(i))+min_sig;
            sigma_x(i) = abs(dis(i))+min_sig;
            % if sigma_y(i) < min_sig
            %     sigma_y(i) = min_sig;
            % else
            %     sigma_y(i) = sigma_y(i);
            % end
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
    %% Determinar los sigma hijos, con un recorrido de 0 a 360°, con saltos de delta_ang
        delta_ang=1;
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
            % parte nueva - promedio
            sigma_AX = ((t1/distancias(j))*sigma_x(k)) + ((t2/distancias(j))*sigma_x(k+1));
            sigma_AY = ((t1/distancias(j))*sigma_y(k)) + ((t2/distancias(j))*sigma_y(k+1));
            % sigma_BX = -((t1/distancias(j))*sigma_x(k)) + ((t2/distancias(j))*sigma_x(k+1));
            % sigma_BY = -((t1/distancias(j))*sigma_y(k)) + ((t2/distancias(j))*sigma_y(k+1));
            sigma_xx(i) = sigma_AX;
            sigma_yy(i) = sigma_AY;
            % sigma_xx(i) = ((t1/distancias(j))*sigma_x(k)) + ((t2/distancias(j))*sigma_x(k+1));
            % sigma_yy(i) = ((t1/distancias(j))*sigma_y(k)) + ((t2/distancias(j))*sigma_y(k+1));
        end
    %% GENERACION DE LA MALLA PARA LA GAUSSIANA
        lado = 4; %maximo valor de cada lado de la grafica
        paso = 0.1; %Paso de la malla, entre punto a punto
        xpos = abs(max(x))+lado;
        xneg = abs(min(x))-lado;
        ypos = abs(max(y))+lado;
        yneg = abs(min(y))-lado;
        %Se genera la malla en la que se determianra cada punto de la
        %gaussiana.
        [xx, yy] = meshgrid((xneg):paso:(xpos), (yneg):paso:(ypos));
    %% Creacion de las matrices de varianzas
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
    %% Se crea cada punto zz de la funcion gaussiana
        zz = exp(-(xx - xcm).^2 ./ (2 .* varianzax.^2) - (yy - ycm).^2 ./ (2 .* varianzay.^2));
       
    %% Se rota el desfase de la gaussiana
        [xrot,yrot,zrot] = rotar_gaussiana (xx,yy,zz,rotacion,xcm,ycm);
    %% Se grafica el contorno
        if GRAF==1 && per == 1
            mesh(xrot, yrot,zrot);
            hold on;
            graficar_personas3d(x,y);
        elseif GRAF==1 && per == 0
            mesh(xrot, yrot,zrot);
        elseif GRAF == 0 && per == 1
            graficar_personas(x,y);
            hold on;
            graficar_lineas_nivel(xrot,yrot,zrot,xcm,ycm);
        else
            graficar_lineas_nivel(xrot,yrot,zrot,xcm,ycm);
        end
        grid on;
end
