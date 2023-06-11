%zadnjih 10 dana
%posto je input radjen sa podacima zakljucenim sa 2.6.2023 podaci predvidjane cene su za naredni dan berze 
input = inputNIS(:, 1:10);
%%maks za 5 dana
[maxY, ~, ~] = bitkijnmatlabfun(input, [], []);
maxcena = max(maxY(1:5));

% min za 5 dana
[minY, ~, ~] = bitkijnmatlabfun(input, [], []);
mincena = min(minY(1:5));

disp(['maksimalna cena u periodu od 5 dana: ', num2str(maxcena)]);
disp(['minimalna cena: ', num2str(mincena)]);