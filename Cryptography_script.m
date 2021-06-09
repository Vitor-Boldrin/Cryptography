E = imread('universo.jpeg'); %imagem de entrada
[m,n,d] = size(E);
C = zeros(m,n,d);
D = zeros(m,n,d);

key = 10;
%Forma alternativa de calcular phi:
A = fliplr(vander(1:key));
A = A(:,1:key);

%Decomposição QR
[Q,R] = qr(A);

%Encriptografando

for dim = 1:3
    for i = 1:m
        for j = 1:(fix(n/key))
            
            y = E(i,(1+key*(j-1)):(j*key),dim)';
            b = (R)\(Q'*double(y));
            C(i,(1+key*(j-1)):(j*key),dim) = b';
            
            
        end
    end
end


%Descriptografando

for dim = 1:3
    for i = 1:m
        for j = 1:(fix(n/key))
            
            D(i,(1+key*(j-1)):(j*key),dim) = uint8(Q'\(R*C(i,(1+key*(j-1)):(j*key),dim)'));
            
        end
    end
end
D = uint8(D);
figure(1)
image(E)
set(gca, 'Visible', 'off')
%saveas(gcf,'imecc_E.png')
figure(2)
image(C)
set(gca, 'Visible', 'off')
%saveas(gcf,'imecc_C.png')
figure(3)
image(D)
set(gca, 'Visible', 'off')
%saveas(gcf,'imecc_D.png')
