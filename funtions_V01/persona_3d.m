function personas3d(posicion_x, posicion_y)   
    % Definir las dimensiones de la persona
    altura_maxima = 0.8; % Altura máxima en el eje z
    radio_cuerpo = 0.18; % Radio del cuerpo
    radio_cabeza = 0.2; % Radio de la cabeza
    
    % Número de puntos para dibujar el cilindro
    num_puntos = 50;
    
    % Calcular los ángulos para los puntos del cilindro
    theta = linspace(0, 2*pi, num_puntos);
    z = linspace(0, altura_maxima, num_puntos);
    
    % Coordenadas x e y del cilindro
    x_cilindro = radio_cuerpo * cos(theta) + posicion_x;
    y_cilindro = radio_cuerpo * sin(theta) + posicion_y;
    
    % Coordenadas para las caras laterales del cilindro
    X = repmat(x_cilindro, num_puntos, 1);
    Y = repmat(y_cilindro, num_puntos, 1);
    Z = repmat(z', 1, num_puntos);
    
    % Coordenadas para la esfera de la cabeza
    [X_cabeza, Y_cabeza, Z_cabeza] = sphere(num_puntos);
    X_cabeza = X_cabeza * radio_cabeza + posicion_x;
    Y_cabeza = Y_cabeza * radio_cabeza + posicion_y;
    Z_cabeza = Z_cabeza * radio_cabeza + altura_maxima;
    
    % Dibujar el cilindro y la cabeza
    figure;
    hold on;
    surf(X, Y, Z, 'FaceColor', 'blue', 'EdgeColor', 'none');
    surf(X_cabeza, Y_cabeza, Z_cabeza, 'FaceColor', 'red', 'EdgeColor', 'none');
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    view(3);
end
