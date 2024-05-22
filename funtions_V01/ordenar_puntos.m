function [x_ord, y_ord] = ordenar_puntos(xcm, ycm, x, y)
    ang_ordenar = rad2deg(atan2(y - ycm, x - xcm));
    angulos_ajustados = mod(ang_ordenar, 360);
    [~, indice_orden] = sort(angulos_ajustados); % Ordenar los puntos según los ángulos ajustados
    x_ord = x(indice_orden); % Generar los nuevos vectores x e y ordenados
    y_ord = y(indice_orden);
end