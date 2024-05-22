function [distancias angulos_grados] = dis_ang(x,y,xc,yc)
    distancias = sqrt((x - xc).^2 + (y - yc).^2);
    angulos = atan2(y - yc, x - xc); 
    angulos_grados = mod(rad2deg(angulos), 360);
end