%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%ucitati nis_cata.csv u matlab, pokrenuti domacip2.m pa onda%%%
%%%               finalnaskriptapredvidjanje.m                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%blizanac mladen ra76/2020

velicina = size(bitkojn, 1);
velicina = velicina - 1;
inputNIS = zeros(7, velicina-1);
targetNIS = zeros(2, velicina-1);

datum = table2array(bitkojn(1:end, 1));
cena = table2array(bitkojn(1:end, 2));
open = table2array(bitkojn(1:end, 3));
low = table2array(bitkojn(1:end, 4));
high = table2array(bitkojn(1:end, 5));





for i = 1:velicina-26
    targetNIS(1, i) = high(i);
    targetNIS(2, i) = low(i);
    
    pomocna = i + 1;
    iterator = 0;
    suma = 0;
   
    while iterator ~= 10
        suma = suma + cena(pomocna);
        iterator = iterator + 1;
        pomocna = pomocna + 1;
    end
   
    inputNIS(1, i) = suma / 10;
     
    suma1 = 10 * cena(i + 1) + 9 * cena(i + 2) + 8 * cena(i + 3) + 7 * cena(i + 4) + 6 * cena(i + 5) + 5 * cena(i + 6) + 4 * cena(i + 7) + 3 * cena(i + 8) + 2 * cena(i + 9) + cena(i + 10);
    inputNIS(2, i) = suma1 / 55;
    
    last10L = low(i+1:i+10);  %zadnjih 10 najmanje
    last10H = high(i+1:i+10); %10 dana najvise
    
   l = last10L(1);
   h = last10H(1);
   for j = 2:numel(last10L)
        if last10L(j) < l
            l = last10L(j);  
        end
        if last10H(j) > h
            h = last10H(j);
        end
   end
   %momentum last 10 days
   inputNIS(3, i) = cena(i + 1) - cena(i + 10);
   %stohastic k% 
   inputNIS(4, i) = (h - cena(i + 1)) / ((h-l))*100;
   % Stochastic D%
   inputNIS(5, i) = mean(inputNIS(4, i:i+9));  % Calculate the mean of the last 10 values of Stochastic K%
   %cci
   mt = (high(i+1) + low(i+1) + cena(i+1)) / 3;  % Typical Price
   smt = mean(inputNIS(1, i:i+9));  % Simple Moving Average of Typical Price (10-period)
   dt = std(inputNIS(1, i:i+9));  % Standard Deviation of Typical Price (10-period)
    
   cci = (mt - smt) / (0.015 * dt);  % Commodity Channel Index (CCI)
    
   inputNIS(6, i) = cci;   
   
   
   
   
    rsiPeriod = 14;  % RSI 2 nedelje, rsi index
    delta = diff(cena(i:i+rsiPeriod));  % promena cena
    gain = sum(delta(delta > 0));  % Sum of gains
    loss = -sum(delta(delta < 0));  % Sum of losses
    avgGain = gain / rsiPeriod;  % Average gain
    avgLoss = loss / rsiPeriod;  % Average loss
    rs = avgGain / avgLoss;  % Relative strength
    rsi = 100 - (100 / (1 + rs));  % Relative Strength Index (RSI)

    inputNIS(7, i) = rsi;
   
    
  
end

