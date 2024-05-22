function [nuevo_ang nuevo x_nuv y_nuv] = ordenamiento(ang, referencia, x, y)    
    indice = find(ang == referencia);%Encuentra el indice de la referencia
    nuevo_ang = [ang(indice:end), ang(1:indice-1)];%Reordenamiento segun el indice
    x_nuv = [x(indice:end), x(1:indice-1)];%Reordenamiento segun el indice
    y_nuv = [y(indice:end), y(1:indice-1)];%Reordenamiento segun el indice
    % disp(nuevo_ang);
    %Se reordena considerando la referencia como cero grados
    for i=1:length(ang)
        if nuevo_ang(i)-nuevo_ang(1)>=0
            nuevo(i)=nuevo_ang(i)- nuevo_ang(1);
        else
            if nuevo_ang(i)+ nuevo_ang(1) >= 0
                nuevo(i)=(360-nuevo_ang(1))+nuevo_ang(i);
            else
                nuevo(i)=nuevo_ang(i)+ nuevo_ang(1);
        
            end
        end
    end
end
