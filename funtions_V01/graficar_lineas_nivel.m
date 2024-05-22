function graficar_lineas_nivel(xrot,yrot,zrot,xcm,ycm)
    contour(xrot,yrot,zrot,[0.1,0.1],'LineColor', 'g');
    hold on;
    contour(xrot,yrot,zrot,[0.3,0.3],'LineColor', 'y');
    hold on;
    contour(xrot,yrot,zrot,[0.6,0.6],'LineColor', 'r')
    hold on;
    plot(xcm, ycm, 'bo', 'MarkerSize', 15); % Marcar centro de masa en rojo
    hold on;
    plot(xcm, ycm, 'bo', 'MarkerSize', 10); % Marcar centro de masa en rojo
    hold on;
    plot(xcm, ycm, 'bo', 'MarkerSize', 5); % Marcar centro de masa en rojo
end