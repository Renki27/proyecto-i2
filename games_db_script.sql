-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-07-2020 a las 05:38:27
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `games_db`
--
CREATE DATABASE IF NOT EXISTS `games_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `games_db`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `CREATE_ACCOUNT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_ACCOUNT` (IN `p_username` VARCHAR(25), IN `p_account_type` VARCHAR(25), IN `p_password` VARCHAR(255), IN `p_email` VARCHAR(25))  BEGIN
    DECLARE emailExists INT;
    DECLARE userExists INT;
    
	SELECT COUNT(*) INTO emailExists FROM ACCOUNT WHERE ACCOUNT.EMAIL = p_EMAIL;
    SELECT COUNT(*) INTO userExists FROM ACCOUNT WHERE ACCOUNT.USERNAME = p_username;
    IF emailExists = 0 AND userExists = 0 THEN
     INSERT INTO account (username, account_type, account.password, EMAIL) 
     VALUES (p_username, p_account_type, p_password, p_email);
    END IF;
END$$

DROP PROCEDURE IF EXISTS `DELETE_GAME`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETE_GAME` (IN `p_ID_GAME` INT(5))  BEGIN
    DECLARE gameExists INT;
    
	SELECT COUNT(*) INTO gameExists FROM GAME WHERE GAME.ID_GAME = p_ID_GAME;
    IF gameExists = 1 THEN
    DELETE FROM GAME WHERE GAME.ID_GAME = p_ID_GAME;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `INSERT_GAME`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_GAME` (IN `p_USERNAME` VARCHAR(25), IN `p_TITLE` VARCHAR(50), IN `p_GENRE` VARCHAR(50), IN `p_PUBLISHER` VARCHAR(50), IN `p_DEVELOPER` VARCHAR(50), IN `p_PLATFORM` VARCHAR(50), IN `p_RELEASED_ON` INT(4), IN `p_MULTIPLAYER` VARCHAR(25), IN `p_DESCRIPTION` VARCHAR(1000), IN `p_IMAGE` VARCHAR(100), IN `p_VIDEO_LINK` VARCHAR(50))  INSERT INTO GAME (USERNAME, TITLE, GENRE, PUBLISHER, DEVELOPER, PLATFORM, RELEASED_ON, MULTIPLAYER, DESCRIPTION, IMAGE, VIDEO_LINK)
VALUES (p_USERNAME, p_TITLE, p_GENRE, p_PUBLISHER, p_DEVELOPER, p_PLATFORM, p_RELEASED_ON, p_MULTIPLAYER, p_DESCRIPTION, p_IMAGE, p_VIDEO_LINK)$$

DROP PROCEDURE IF EXISTS `SELECT_ALL_GAMES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_ALL_GAMES` ()  BEGIN
	SELECT * from game ORDER BY id_game DESC;
END$$

DROP PROCEDURE IF EXISTS `SELECT_USER_BY_EMAIL`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_USER_BY_EMAIL` (IN `p_email` VARCHAR(25))  BEGIN
DECLARE emailExists VARCHAR(25);


SELECT COUNT(*) INTO emailExists FROM ACCOUNT WHERE ACCOUNT.EMAIL = p_email;

IF emailExists = 1 THEN

SELECT * FROM account WHERE email = p_email;

END IF;
END$$

DROP PROCEDURE IF EXISTS `SELECT_USER_BY_USERNAME`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_USER_BY_USERNAME` (IN `p_username` VARCHAR(25))  BEGIN
    DECLARE userExists VARCHAR(25);

    
	SELECT COUNT(*) INTO userExists FROM ACCOUNT WHERE ACCOUNT.USERNAME = p_username;

    IF userExists = 1 THEN

	SELECT * FROM account WHERE username = p_username;

    END IF;
END$$

DROP PROCEDURE IF EXISTS `UPDATE_GAME`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_GAME` (IN `p_ID_GAME` INT(5), IN `p_USERNAME` VARCHAR(25), IN `p_TITLE` VARCHAR(50), IN `p_GENRE` VARCHAR(50), IN `p_PUBLISHER` VARCHAR(50), IN `p_DEVELOPER` VARCHAR(50), IN `p_PLATFORM` VARCHAR(50), IN `p_RELEASED_ON` INT(4), IN `p_MULTIPLAYER` VARCHAR(25), IN `p_DESCRIPTION` VARCHAR(1000), IN `p_IMAGE` VARCHAR(100), IN `p_VIDEO_LINK` VARCHAR(50))  UPDATE GAME SET USERNAME = p_USERNAME, TITLE = p_TITLE, GENRE = p_GENRE, PUBLISHER = p_PUBLISHER, DEVELOPER = p_DEVELOPER, PLATFORM = p_PLATFORM, RELEASED_ON = p_RELEASED_ON, MULTIPLAYER = p_MULTIPLAYER, DESCRIPTION = p_DESCRIPTION, IMAGE = p_IMAGE, VIDEO_LINK = p_VIDEO_LINK WHERE p_ID_GAME = GAME.ID_GAME$$

DROP PROCEDURE IF EXISTS `UPDATE_GAME_NO_IMAGE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_GAME_NO_IMAGE` (IN `p_ID_GAME` INT(5), IN `p_USERNAME` VARCHAR(25), IN `p_TITLE` VARCHAR(50), IN `p_GENRE` VARCHAR(50), IN `p_PUBLISHER` VARCHAR(50), IN `p_DEVELOPER` VARCHAR(50), IN `p_PLATFORM` VARCHAR(50), IN `p_RELEASED_ON` INT(4), IN `p_MULTIPLAYER` VARCHAR(25), IN `p_DESCRIPTION` VARCHAR(1000), IN `p_VIDEO_LINK` VARCHAR(50))  UPDATE GAME SET USERNAME = p_USERNAME, TITLE = p_TITLE, GENRE = p_GENRE, PUBLISHER = p_PUBLISHER, DEVELOPER = p_DEVELOPER, PLATFORM = p_PLATFORM, RELEASED_ON = p_RELEASED_ON, MULTIPLAYER = p_MULTIPLAYER, DESCRIPTION = p_DESCRIPTION, VIDEO_LINK = p_VIDEO_LINK WHERE p_ID_GAME = GAME.ID_GAME$$

DROP PROCEDURE IF EXISTS `VERIFY_USER_EXISTS_EMAIL`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `VERIFY_USER_EXISTS_EMAIL` (IN `p_email` VARCHAR(25))  BEGIN


SELECT COUNT(*) FROM ACCOUNT WHERE ACCOUNT.EMAIL = p_email;


END$$

DROP PROCEDURE IF EXISTS `VERIFY_USER_EXISTS_USERNAME`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `VERIFY_USER_EXISTS_USERNAME` (IN `p_username` VARCHAR(25))  BEGIN
    
	SELECT COUNT(*) FROM ACCOUNT WHERE ACCOUNT.USERNAME = p_username;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `USERNAME` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `ACCOUNT_TYPE` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `EMAIL` varchar(25) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `account`
--

INSERT INTO `account` (`USERNAME`, `ACCOUNT_TYPE`, `PASSWORD`, `EMAIL`) VALUES
('admin', 'ADMIN', '$2y$10$9hYR0Eiztgv2dnThNAPPluypqt7lKItzmHz3MWraHrN7P1Qv.0pIW', 'admin@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game`
--

DROP TABLE IF EXISTS `game`;
CREATE TABLE `game` (
  `ID_GAME` int(5) NOT NULL,
  `USERNAME` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `TITLE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `GENRE` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NONE',
  `PUBLISHER` varchar(2550) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NONE',
  `DEVELOPER` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NONE',
  `PLATFORM` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NONE',
  `RELEASED_ON` int(4) NOT NULL DEFAULT 0,
  `MULTIPLAYER` varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No',
  `DESCRIPTION` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `IMAGE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `VIDEO_LINK` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `game`
--

INSERT INTO `game` (`ID_GAME`, `USERNAME`, `TITLE`, `GENRE`, `PUBLISHER`, `DEVELOPER`, `PLATFORM`, `RELEASED_ON`, `MULTIPLAYER`, `DESCRIPTION`, `IMAGE`, `VIDEO_LINK`) VALUES
(1, 'admin', 'Monster Hunter: World', 'Action role-playing', 'Capcom', 'Capcom', 'PlayStation 4, Xbox One, PC, Nintendo Switch', 2018, 'YES', 'In an unnamed high fantasy setting, humans and other sentient races have set their eyes on the New World, a separate continent from the populated Old World. The New World is an untamed wilderness where many powerful monsters roam, and where researchers have been drawn to uncover new mysteries. Several ocean-bound Fleets have been sent already to establish working bases, safe from monsters, and operations are led by the Research Commission.', '../uploads/MHW_thumbnail.png', 'https://www.youtube.com/embed/SE_FnuD9zJc?rel=0'),
(2, 'admin', 'VALORANT', 'FPS (First Person Shooter)', 'Riot Games', 'Riot Games', 'PC', 2020, 'YES', 'Valorant is a team-based tactical shooter and first-person shooter set in the near-future. Players assume the control of agents, characters who come from a plethora of countries and cultures around the world. In the main game mode, players join either the attacking or defending team with each team having five players on it. Agents have unique abilities and use an economic system to purchase their abilities and weapons.\n\nRequirements: \nWindows 7/8/10 de 64-bit.\n4 GB of RAM.\n1 GB of VRAM.\nCPU: Intel i3-370M.\nGPU: Intel HD 300.', '../uploads/valorant_art_20200707052940.jpg', 'https://www.youtube.com/embed/e_E9W2vsRbQ?rel=0'),
(3, 'admin', 'Resident Evil 2: REMAKE', 'Survival horror', 'Capcom', 'Capcom', 'PlayStation 4, Microsoft Windows, Xbox One', 2019, 'NO', 'The game is set in Raccoon City in September 1998, two months after the events of Resident Evil. Most of the citizens have been turned into mindless zombies, due to an outbreak of a viral bioweapon known as the T-Virus, manufactured by Umbrella Corporation. The game begins at a gas station outside of the city, where rookie police officer Leon S. Kennedy meets college student Claire Redfield, who is looking for her brother Chris Redfield.', '../uploads/RE_2_Remake.png', 'https://www.youtube.com/embed/u3wS-Q2KBpk?rel=0'),
(4, 'admin', 'Horizon Zero Dawn', 'Action role-playing', 'Sony Interactive Entertainment', 'Guerrilla Games', 'PlayStation 4', 2017, 'NO', 'The story is set in the 31st century, in a world where humans live in scattered tribal-like populations with limited access to technology. Their technologically advanced predecessors are remembered as the \"Old Ones\". Large robotic creatures, known as \"machines\", dominate the Earth. For the most part, they peacefully coexist with humans, who occasionally hunt them for parts. ', '../uploads/Horizon_ps4.jpg', 'https://www.youtube.com/embed/wzx96gYA8ek?rel=0'),
(5, 'admin', 'Horizon Zero Dawn (Complete Edition)', 'Action role-playing', 'Sony Interactive Entertainment', 'Guerrilla Games', 'Microsoft Windows', 2020, 'NO', 'The story is set in the 31st century, in a world where humans live in scattered tribal-like populations with limited access to technology. Their technologically advanced predecessors are remembered as the \"Old Ones\". Large robotic creatures, known as \"machines\", dominate the Earth. For the most part, they peacefully coexist with humans, who occasionally hunt them for parts. However, a phenomenon known as the \"Derangement\" has caused machines to become more aggressive towards humans, and larger and deadlier machines have begun to appear.', '../uploads/Horizon_pc.jpg', 'https://www.youtube.com/embed/AyzG5V5qc-g?rel=0'),
(6, 'admin', 'Detroit: Become Human', 'Adventure', 'Sony Interactive Entertainment', 'Quantic Dream', 'PlayStation 4, Microsoft Windows', 2018, 'NO', 'The plot follows three androids: Kara, who escapes the owner she was serving to explore her newfound sentience and protect a young girl; Connor, whose job is to hunt down sentient androids; and Markus, who devotes himself to releasing other androids from servitude.', '../uploads/detroit_become_human.jpg', 'https://www.youtube.com/embed/ldNsaU4eGFU?rel=0'),
(7, 'admin', 'Devil May Cry 5', 'Hack and slash, Third-person Shooter', 'Capcom', 'Capcom', 'Microsoft Windows, PlayStation 4, Xbox One', 2019, 'YES', 'The gameplay features the return of Dante and Nero as playable characters, along with a new character, named \\\"V\\\". The gameplay is similar to that of the other titles in the Devil May Cry series, focusing on fast-paced \\\"stylish action\\\"; The player fights off hordes of demons with a variety of attacks and weapons. They receive a style-rating for combat based on a number of factors, such as move variety, the length of a combo and dodging attacks.', '../uploads/DMC5_20200707020817.jpg', 'https://www.youtube.com/embed/p2lWUQHUapM?rel=0'),
(8, 'admin', 'The Legend of Zelda: Breath of the Wild', 'Action-adventure', 'Nintendo', 'Nintendo EPD', 'Nintendo Switch, Wii U', 2017, 'NO', 'Breath of the Wild is an action-adventure game set in an open world where players are tasked with exploring the kingdom of Hyrule while controlling Link. In terms of structure, Breath of the Wild encourages nonlinear gameplay, which is illustrated by the game\\\'s lack of defined entrances or exits to areas, scant instruction given to the player, and encouragement to explore freely.', '../uploads/BOTW-thumb_20200707021425.jpg', 'https://www.youtube.com/embed/ofH5ptn5w-A?rel=0'),
(9, 'admin', 'Nier: Automata', 'Action role-playing', 'Square Enix', 'PlatinumGames', 'PlayStation 4, Windows, Xbox One', 2017, 'NO', 'Nier: Automata is an action role-playing game in which players take the role of combat androids from the YoRHa units across an open world environment. In addition to standard navigation on foot, using a special item allows the player to summon a wild animal to ride, and in some scenarios pilot a flying mech to fight enemies.', '../uploads/nier_20200707051423.jpg', 'https://www.youtube.com/embed/wJxNhJ8fjFk?rel=0'),
(10, 'admin', 'Kirby Star Allies', 'Platformer', 'Nintendo', 'HAL Laboratory', 'Nintendo Switch', 2018, 'YES', 'On the Jambandra space station far away from Kirby\'s home planet, a dark crystal heart explodes due to an imperfection in a mysterious ritual, sending its numerous fragments, Jamba Hearts, hurtling into deep space. Many characters, including King Dedede and Meta Knight, are possessed while investigating the hearts that land on Popstar. A heart hits Kirby, but it instead gives him the ability to befriend enemies by throwing hearts.', '../uploads/KirbyStarAllies_20200707051643.jpg', 'https://www.youtube.com/embed/FNPf9KkL-ik?rel=0');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`USERNAME`);

--
-- Indices de la tabla `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`ID_GAME`),
  ADD KEY `FK_ACCOUNT_HAS_GAME` (`USERNAME`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `game`
--
ALTER TABLE `game`
  MODIFY `ID_GAME` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
