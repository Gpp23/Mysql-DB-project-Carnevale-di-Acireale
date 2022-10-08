-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Gen 02, 2022 alle 12:54
-- Versione del server: 10.4.22-MariaDB
-- Versione PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carnevale di acireale`
--
CREATE DATABASE IF NOT EXISTS `carnevale di acireale` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `carnevale di acireale`;

-- --------------------------------------------------------

--
-- Struttura della tabella `account`
--

CREATE TABLE IF NOT EXISTS `account` (
  `ID` int(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Email` varchar(254) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Data_Creazione` date NOT NULL DEFAULT current_timestamp(),
  `Importo` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `account`
--

INSERT INTO `account` (`ID`, `Email`, `Password`, `Data_Creazione`, `Importo`) VALUES
(1, 'rossi@live.it', '1wejqeonasdjhqwioej', '2021-12-28', 300),
(2, 'verdi@hotmail.com', 'afiojeorjioqjekjqwklejio', '2021-12-28', 10),
(3, 'marrone@hotmail.it', 'jiheiowioeuqiouuiehqw', '2021-12-28', 125),
(4, 'azzurro@gmail.com', '3ohjdjojpoeiwpoeimd', '2021-12-28', 300),
(5, 'nero@yahoo.com', 'fji3jij32kkdklakflofijwjeok', '2021-12-28', 12),
(6, 'aci@live.it', '2huh2io3jeioj2onckjwe', '2021-12-28', 100);

-- --------------------------------------------------------

--
-- Struttura della tabella `area`
--

CREATE TABLE IF NOT EXISTS `area` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Indirizzo` varchar(40) NOT NULL,
  `N_Civico` int(3) NOT NULL,
  `N_Persone` int(6) NOT NULL,
  `Limite_Persone` int(6) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `area`
--

INSERT INTO `area` (`ID`, `Indirizzo`, `N_Civico`, `N_Persone`, `Limite_Persone`) VALUES
(0, 'Fuori Circuito', 0, 4, 50000),
(1, 'Corso Umbero', 1, 0, 1),
(2, 'Corso Umberto', 150, 0, 10),
(3, 'Corso Italia', 1, 0, 10),
(4, 'Corso Italia', 150, 0, 10),
(5, 'Corso Savoia', 1, 0, 15),
(6, 'Corso Savoia', 150, 0, 20);

-- --------------------------------------------------------

--
-- Struttura della tabella `biglietto`
--

CREATE TABLE IF NOT EXISTS `biglietto` (
  `Cod` varchar(32) NOT NULL,
  `Data_Acquisto` datetime NOT NULL DEFAULT current_timestamp(),
  `Data_Validità` date NOT NULL,
  `FK_Tipo` varchar(16) NOT NULL,
  `FK_Persona` varchar(16) NOT NULL,
  PRIMARY KEY (`Cod`),
  KEY `FK_Tipo` (`FK_Tipo`),
  KEY `FK_Persona` (`FK_Persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `biglietto`
--

INSERT INTO `biglietto` (`Cod`, `Data_Acquisto`, `Data_Validità`, `FK_Tipo`, `FK_Persona`) VALUES
('DMKOEK20KLWELWEPWE', '2021-12-30 21:55:37', '2021-12-31', 'Settimanale', 'CCZCCN42R43G324P'),
('EKWO2EKOEK2', '2021-12-31 12:45:11', '2022-01-01', 'Giornaliero', 'CCZCCN42R43G324P'),
('KEKWPEPSD23', '2022-01-02 11:52:34', '2021-12-29', 'Giornaliero', 'DWLSST51C62F597A');

--
-- Trigger `biglietto`
--
DELIMITER $$
CREATE TRIGGER `Acquisto del biglietto` BEFORE INSERT ON `biglietto` FOR EACH ROW BEGIN
DECLARE prezzo_biglietto integer;
DECLARE ID_ACCOUNT integer;
SELECT `tipo biglietto`.`Prezzo` INTO `prezzo_biglietto` FROM `tipo biglietto` WHERE `tipo biglietto`.`Nome` = NEW.`FK_Tipo`;
SELECT `account`.`ID` INTO `ID_ACCOUNT` FROM `account` JOIN `persona` ON `account`.`ID`=`persona`.`FK_Account` WHERE `persona`.`CDF` = NEW.`FK_Persona`;
	IF((SELECT `account`.`Importo` FROM `account` WHERE `account`.`ID`=ID_ACCOUNT) > prezzo_biglietto) THEN
    UPDATE `account` SET `account`.`Importo` = `account`.`Importo` - prezzo_biglietto WHERE `account`.`ID`=ID_ACCOUNT;
    ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Soldi non sufficienti';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `carro allegorico`
--

CREATE TABLE IF NOT EXISTS `carro allegorico` (
  `Nome` varchar(30) NOT NULL,
  `Descrizione` varchar(255) NOT NULL,
  `Altezza` int(3) NOT NULL,
  `URL_IMG` varchar(45) DEFAULT NULL,
  `FK_Area` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  KEY `FK_Area` (`FK_Area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `carro allegorico`
--

INSERT INTO `carro allegorico` (`Nome`, `Descrizione`, `Altezza`, `URL_IMG`, `FK_Area`) VALUES
('A', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam nec purus sit amet lacus porttitor pulvinar at a sem. Morbi pretium justo nunc, nec finibus turpis gravida in. Maecenas iaculis pulvinar augue nec pulvinar. Quisque at justo at sapien conseq', 100, NULL, 6),
('B', 'Cras facilisis mauris sit amet nibh tristique lobortis. Ut commodo justo sed scelerisque commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed eget ex eget elit hendrerit mattis. Aenean mauris arcu, maximus sed dui nec, porta lacinia ', 140, NULL, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `debug`
--

CREATE TABLE IF NOT EXISTS `debug` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `debug`
--

INSERT INTO `debug` (`id`, `message`, `time`) VALUES
(49, 'inizio validità: 2021-12-29 00:00:00 giorni validità: 1 giorno spettacolo: 2021-12-29 01:50:13 differenza giorni con lo spettacolo: 0 trovato: 0 risultato dell if 0', '2022-01-02 10:55:18'),
(50, 'inizio validità: 2021-12-29 00:00:00 giorni validità: 1 giorno spettacolo: 2021-12-29 01:50:13 differenza giorni con lo spettacolo: 0 trovato: 1 risultato dell if 1', '2022-01-02 10:57:24');

-- --------------------------------------------------------

--
-- Struttura della tabella `partecipante`
--

CREATE TABLE IF NOT EXISTS `partecipante` (
  `FK_Persona` varchar(16) NOT NULL,
  `FK_Spettacolo` varchar(30) NOT NULL,
  PRIMARY KEY (`FK_Persona`,`FK_Spettacolo`),
  KEY `FK_Persona` (`FK_Persona`),
  KEY `FK_Spettacolo` (`FK_Spettacolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `partecipante`
--

INSERT INTO `partecipante` (`FK_Persona`, `FK_Spettacolo`) VALUES
('CCZCCN42R43G324P', 'Concerto Giorgio Vanni'),
('CCZCCN42R43G324P', 'Techno Party');

--
-- Trigger `partecipante`
--
DELIMITER $$
CREATE TRIGGER `Controllo prenotazione` BEFORE INSERT ON `partecipante` FOR EACH ROW BEGIN
Declare giorno_spettacolo datetime;
Declare giorno_attuale datetime;
DECLARE posti_occupati integer;
SELECT COUNT(`partecipante`.`FK_Persona`) INTO `posti_occupati` FROM `partecipante` RIGHT JOIN `spettacolo` ON `spettacolo`.`Nome` = NEW.`FK_Spettacolo`;
SELECT `spettacolo`.`Data` INTO `giorno_spettacolo` FROM `spettacolo` WHERE `spettacolo`.`Nome` = NEW.`FK_Spettacolo`;
SET giorno_attuale = NOW();

IF(posti_occupati > 1000) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Posti finiti';
ELSE
	IF(SELECT COUNT(*) FROM `partecipante` WHERE `partecipante`.`FK_Persona` = NEW.`FK_Persona` > 0 AND (TIMESTAMPDIFF(HOUR, giorno_attuale, giorno_spettacolo) > 1 OR TIMESTAMPDIFF(MONTH, giorno_attuale, giorno_spettacolo) > 1 OR TIMESTAMPDIFF(YEAR, giorno_attuale, giorno_spettacolo) > 1)) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La persona è già prenotata ad uno spettacolo';
	END IF;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Prenotazione - Controllo biglietto` BEFORE INSERT ON `partecipante` FOR EACH ROW BEGIN
DECLARE giorni_validità integer;
DECLARE inizio_validità datetime;
DECLARE giorno_spettacolo datetime;
DECLARE `done` BOOL DEFAULT FALSE;
DECLARE `trovato` BOOL DEFAULT FALSE;
DECLARE `cur` CURSOR FOR
SELECT `biglietto`.`Data_Validità`, `tipo biglietto`.`Giorni_Validità` FROM `biglietto` JOIN `tipo biglietto` ON `biglietto`.`FK_Tipo` = `tipo biglietto`.`Nome` WHERE `biglietto`.`FK_Persona` = NEW.`FK_Persona`;  
DECLARE CONTINUE HANDLER FOR NOT FOUND SET `done` := TRUE;
SET `trovato` = false;
SELECT `spettacolo`.`Data` INTO `giorno_spettacolo` FROM `spettacolo` WHERE `spettacolo`.`Nome`=NEW.`FK_Spettacolo`;
OPEN `cur`;
	`read_loop`:LOOP
     FETCH `cur` INTO `inizio_validità`, `giorni_validità`;
    IF `done` or `trovato` THEN
    	 CLOSE `cur`;
   		 LEAVE `read_loop`;
    END IF;
    IF ((TIMESTAMPDIFF(DAY,inizio_validità,giorno_spettacolo) < giorni_validità) AND TIMESTAMPDIFF(MONTH,inizio_validità,giorno_spettacolo) = 0 AND inizio_validità < giorno_spettacolo) THEN 
    	SET `trovato` = true;
	END IF;
  /* insert into `debug`(message) VALUES (concat('inizio validità: ',inizio_validità,' giorni validità: ',giorni_validità,' giorno spettacolo: ',giorno_spettacolo,' differenza giorni con lo spettacolo: ',TIMESTAMPDIFF(DAY,inizio_validità,giorno_spettacolo), ' trovato: ',trovato,' risultato dell if ', (TIMESTAMPDIFF(DAY,inizio_validità,giorno_spettacolo) < giorni_validità))); */ /*DEBUGGING*/
    END LOOP;
IF (!`trovato`) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Biglietto valido non trovato per lo spettacolo';
    END IF; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `CDF` varchar(16) NOT NULL,
  `Cellulare` int(9) UNSIGNED DEFAULT NULL,
  `Nome` varchar(30) NOT NULL,
  `Cognome` varchar(30) NOT NULL,
  `Data_Nascita` date NOT NULL,
  `FK_Area` int(10) UNSIGNED DEFAULT 0,
  `FK_Account` int(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`CDF`),
  KEY `FK_Area` (`FK_Area`),
  KEY `FK_Account` (`FK_Account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `persona`
--

INSERT INTO `persona` (`CDF`, `Cellulare`, `Nome`, `Cognome`, `Data_Nascita`, `FK_Area`, `FK_Account`) VALUES
('CCZCCN42R43G324P', 3338912133, 'Filippo', 'Stanco', '1991-12-18', 0, 5),
('CCZCCN42R43G993T', NULL, 'Mario', 'Rossi', '1998-02-21', 0, 1),
('CPRTCN22R45E324P', NULL, 'Christian', 'Lento', '2001-12-14', 0, 3),
('DWLSST51C62F597A', NULL, 'Giuseppe', 'Condorelli', '2000-03-23', 0, 5);

--
-- Trigger `persona`
--
DELIMITER $$
CREATE TRIGGER ` Entrare in un'area - Controllo biglietto` BEFORE UPDATE ON `persona` FOR EACH ROW BEGIN
DECLARE giorni_validità integer;
DECLARE inizio_validità datetime;
DECLARE `done` BOOL DEFAULT FALSE;
DECLARE `trovato` BOOL DEFAULT FALSE;
DECLARE `cur` CURSOR FOR
SELECT `biglietto`.`Data_Validità`, `tipo biglietto`.`Giorni_Validità` FROM `biglietto` JOIN `tipo biglietto` ON `biglietto`.`FK_Tipo` = `tipo biglietto`.`Nome` WHERE `biglietto`.`FK_Persona` = NEW.`CDF`;  
DECLARE CONTINUE HANDLER FOR NOT FOUND SET `done` := TRUE;
SET `trovato` = false;
OPEN `cur`;
	`read_loop`:LOOP
     FETCH `cur` INTO `inizio_validità`, `giorni_validità`;
    IF `done` or `trovato` THEN
    	 CLOSE `cur`;
   		 LEAVE `read_loop`;
    END IF;
    IF (TIMESTAMPDIFF(DAY,NOW(),inizio_validità) < (giorni_validità - 1) AND TIMESTAMPDIFF(MONTH,NOW(),inizio_validità) = 0 AND inizio_validità < NOW()) THEN 
    	SET `trovato` = true;
	END IF;
    /*insert into `debug`(message) VALUES (concat('inizio validità: ',inizio_validità,' giorni validità: ',giorni_validità,' differenza giorni: ',TIMESTAMPDIFF(DAY,inizio_validità,NOW()), ' trovato: ',trovato));*/ /*DEBUGGING*/
    END LOOP;
IF (!`trovato`) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Biglietto valido non trovato';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Entrata in un'area - Controllo limite` BEFORE UPDATE ON `persona` FOR EACH ROW BEGIN
    IF ((SELECT `area`.`N_Persone` FROM `area` WHERE `area`.`ID` = NEW.`FK_Area`) + 1 <= (SELECT `area`.`Limite_Persone` FROM `area` WHERE `area`.`ID` = NEW.`FK_Area`)) THEN UPDATE `area` SET `area`.`N_Persone` = `area`.`N_Persone`+1 WHERE `area`.`ID` = NEW.`FK_Area`;
    UPDATE `area` SET `area`.`N_Persone` = `area`.`N_Persone`-1 WHERE `area`.`ID` = OLD.`FK_Area`;
    ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Limite persone raggiunto';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Nuova Persona` BEFORE INSERT ON `persona` FOR EACH ROW BEGIN
    IF ((SELECT `area`.`N_Persone` FROM `area` WHERE `area`.`ID` = '0') + 1 <= (SELECT `area`.`Limite_Persone` FROM `area` WHERE `area`.`ID` = '0')) THEN UPDATE `area` SET `area`.`N_Persone` = `area`.`N_Persone`+1 WHERE `area`.`ID` = '0';
    ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Limite persone raggiunto';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `spettacolo`
--

CREATE TABLE IF NOT EXISTS `spettacolo` (
  `Nome` varchar(30) NOT NULL,
  `Descrizione` text NOT NULL,
  `Durata` int(3) NOT NULL,
  `Data` datetime NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `spettacolo`
--

INSERT INTO `spettacolo` (`Nome`, `Descrizione`, `Durata`, `Data`) VALUES
('Concerto Giorgio Vanni', 'In questo concerto verranno cantate tutte le sigle dei cartoni animati che vi hanno accompagnato durante la vostra infanzia!', 120, '2022-01-03 01:50:13'),
('Techno Party', 'Musica a più non posso, divertimento assicurato!', 100, '2022-01-02 12:50:13');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo biglietto`
--

CREATE TABLE IF NOT EXISTS `tipo biglietto` (
  `Nome` varchar(16) NOT NULL,
  `Descrizione` text NOT NULL,
  `Prezzo` double NOT NULL,
  `Giorni_Validità` int(2) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `tipo biglietto`
--

INSERT INTO `tipo biglietto` (`Nome`, `Descrizione`, `Prezzo`, `Giorni_Validità`) VALUES
('Giornaliero', 'Biglietto giornaliero valido solo per una giornata', 6, 1),
('Settimanale', 'Biglietto settimanale valido per un\'intera settimana', 25, 7);

-- --------------------------------------------------------

--
-- Struttura della tabella `votazione`
--

CREATE TABLE IF NOT EXISTS `votazione` (
  `FK_Account` int(4) UNSIGNED NOT NULL,
  `FK_Carro` varchar(30) NOT NULL,
  `Commento` text NOT NULL,
  `Voto` int(1) NOT NULL,
  PRIMARY KEY (`FK_Account`,`FK_Carro`),
  KEY `FK_Account` (`FK_Account`),
  KEY `FK_Carro` (`FK_Carro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `votazione`
--

INSERT INTO `votazione` (`FK_Account`, `FK_Carro`, `Commento`, `Voto`) VALUES
(1, 'A', 'Il carro A è davvero brutto, il peggiore!', 2),
(4, 'A', 'Io e la mia famiglia siamo rimasti davvero meravigliati quando abbiamo visto il carro A, bellissimo!', 10),
(6, 'B', 'Il carro B non ha rivali, il migliore in assoluto', 10);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `biglietto`
--
ALTER TABLE `biglietto`
  ADD CONSTRAINT `biglietto_ibfk_1` FOREIGN KEY (`FK_Tipo`) REFERENCES `tipo biglietto` (`Nome`),
  ADD CONSTRAINT `biglietto_ibfk_2` FOREIGN KEY (`FK_Persona`) REFERENCES `persona` (`CDF`);

--
-- Limiti per la tabella `carro allegorico`
--
ALTER TABLE `carro allegorico`
  ADD CONSTRAINT `carro allegorico_ibfk_1` FOREIGN KEY (`FK_Area`) REFERENCES `area` (`ID`);

--
-- Limiti per la tabella `partecipante`
--
ALTER TABLE `partecipante`
  ADD CONSTRAINT `partecipante_ibfk_1` FOREIGN KEY (`FK_Persona`) REFERENCES `persona` (`CDF`),
  ADD CONSTRAINT `partecipante_ibfk_2` FOREIGN KEY (`FK_Spettacolo`) REFERENCES `spettacolo` (`Nome`);

--
-- Limiti per la tabella `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`FK_Area`) REFERENCES `area` (`ID`),
  ADD CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`FK_Account`) REFERENCES `account` (`ID`);

--
-- Limiti per la tabella `votazione`
--
ALTER TABLE `votazione`
  ADD CONSTRAINT `votazione_ibfk_2` FOREIGN KEY (`FK_Carro`) REFERENCES `carro allegorico` (`Nome`),
  ADD CONSTRAINT `votazione_ibfk_3` FOREIGN KEY (`FK_Account`) REFERENCES `account` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
