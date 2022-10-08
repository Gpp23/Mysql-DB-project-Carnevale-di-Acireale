SELECT `carro allegorico`.`Nome`, `carro allegorico`.`Descrizione`, `carro allegorico`.`Altezza`, AVG(`votazione`.`Voto`) AS 'Voto medio', `area`.`Indirizzo`, `area`.`N_Civico` 
FROM `carro allegorico`, `votazione`, `area` 
WHERE `votazione`.`FK_Carro` = `carro allegorico`.`Nome` AND `area`.`ID`=`carro allegorico`.`FK_Area` 
GROUP BY `carro allegorico`.`Nome` 
ORDER BY `Voto medio` DESC;