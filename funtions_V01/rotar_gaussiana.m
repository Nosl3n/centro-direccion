function [xrot,yrot,zrot] = rotar_gaussiana (x,y,z,angulo,cmx,cmy)
    %DETERMINAMOS LA TRASLACION EN LOS EJES, sign -> determina el signo
    if cmx - cmx == 0
        xmove = -cmx;
    else
        xmove = cmx;
    end

    if cmy - cmy == 0
        ymove = -cmy;
    else
        ymove = cmy;
    end

    % Ángulo de rotación en radianes
    angulo = deg2rad(angulo);
    % Crear la matriz de transformación homogénea para la rotación alrededor del eje Z
    matriz_rotacion = [cos(angulo) -sin(angulo) 0 ;
                       sin(angulo)  cos(angulo) 0 ;
                       0            0           1 ];

    % Convertir las matrices x, y, z en vectores
    xx = x(:);
    yy = y(:);
    zz = z(:);
    % Traslaación de la gaussiana al origen de coordendas
    xx=xx + xmove;
    yy=yy + ymove;
    % Combinar los vectores en una matriz de puntos
    puntos = horzcat(xx, yy, zz);
    % Aplicar la matriz de transformación homogénea (Rotacion en Z) a los puntos en 3D
    puntos_rot = puntos * matriz_rotacion;
    % Separar los puntos rotados en vectores x, y, z
    Xrot = puntos_rot(:, 1);
    Yrot = puntos_rot(:, 2);
    Zrot = puntos_rot(:, 3);
    % Regresar la gaussiana a su posición original
    Xrot = Xrot - xmove;
    Yrot = Yrot - ymove;
    % Reshape para obtener matrices 2D
    xrot = reshape(Xrot, size(x));
    yrot = reshape(Yrot, size(y));
    zrot = reshape(Zrot, size(z));
end