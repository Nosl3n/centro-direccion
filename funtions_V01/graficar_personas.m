function graficar_personas(x, y)
    % Detalles estéticos de los círculos
    r=0.4;
    edgeColor = [0.1 0.4 0.2];  % Color de borde personalizado
    lineWidth = 2;              % Grosor de línea personalizado
    faceColor = 'none';         % Sin relleno (transparente)

    % Graficar círculos para representar a cada persona
    for i = 1:length(x)
        rectangle('Position', [x(i) - r, y(i) - r, 2 * r, 2 * r], ...
                  'Curvature', [1, 1], ...
                  'EdgeColor', edgeColor, ...
                  'LineWidth', lineWidth, ...
                  'FaceColor', faceColor);
    end
end