SELECT sum(`tipo biglietto`.`Prezzo`) as 'Incasso Totale' 
FROM `biglietto`,`tipo biglietto`
WHERE `biglietto`.`FK_Tipo`=`tipo biglietto`.`Nome`;