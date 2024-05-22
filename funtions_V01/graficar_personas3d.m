function graficar_personas3d(posicion_x, posicion_y)
    for i=1:length(posicion_x)
        personas3d(posicion_x(i),posicion_y(i));
        hold on;
    end
end
