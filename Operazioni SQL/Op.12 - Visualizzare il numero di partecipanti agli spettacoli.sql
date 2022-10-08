SELECT `spettacolo`.`Nome`, COUNT(`partecipante`.`FK_Persona`) AS 'N_Partecipanti' 
FROM `partecipante` RIGHT JOIN `spettacolo` ON `spettacolo`.`Nome` = `partecipante`.`FK_Spettacolo`  
GROUP BY `spettacolo`.`Nome` 
ORDER BY `N_Partecipanti` DESC;