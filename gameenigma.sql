-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2025 at 04:36 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gameenigma`
--

-- --------------------------------------------------------

--
-- Table structure for table `cpuinfo`
--

CREATE TABLE `cpuinfo` (
  `CpuID` int(11) NOT NULL,
  `CpuName` varchar(100) DEFAULT NULL,
  `CpuScore` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cpuinfo`
--

INSERT INTO `cpuinfo` (`CpuID`, `CpuName`, `CpuScore`) VALUES
(1, '2.0 GHz Pentium 4', 33),
(2, 'Core 2 Duo 2GHz', 33.3),
(3, 'AMD Ryzen 5 1500X', 66.4),
(4, 'Intel Core i7-4770K', 73.6),
(5, 'AMD Ryzen 5 3600X', 84.1),
(6, 'Intel Core i7-8700', 87),
(7, 'AMD Quad core @ 2.5 GHz', 29.6),
(8, 'Intel Quad core @ 2.0 GHz', 41.6),
(9, 'AMD Six core @ 3.2 GHz', 55.2),
(10, 'intel Quad core @ 3.0 GHz', 63.1),
(11, 'Intel CPU Core i5-2500K ', 65.9),
(12, 'AMD A10-5800K APU', 59.7),
(13, 'Intel Core i5-7400', 63.5),
(14, 'Ryzen 5 1600', 83.1),
(15, 'Amd Phenom X3 8650', 41),
(16, 'Intel Core i3-3220', 52.1),
(17, ' AMD Phenom II X3 720', 48.1),
(18, 'Intel Core i5-3470', 63.1),
(19, 'AMD FX-8350 @ 4.0 GHz', 56.5),
(20, 'Intel Core i7-3770 ', 69),
(21, ' AMD Ryzen 3 1200', 57),
(22, 'Intel i5-6600k', 72.4),
(23, 'AMD Ryzen 5 2400 G', 62.5),
(24, 'Intel Core i3-2100 ', 50.9),
(25, 'AMD FX-6300', 55.2),
(26, ' AMD Ryzen 5 1400', 61),
(27, 'AMD Phenom 9850 ', 45.9),
(28, 'Intel Core2 Quad Q6600', 41.6),
(29, 'Intel Core i5 3470', 63.1),
(30, 'Intel Core i5-2400', 60.6),
(31, 'Intel Core i7-4770 ', 70.5),
(32, ' AMD Ryzen 5 1600', 70.2),
(33, 'AMD Ryzen 7 7700', 109),
(34, 'AMD Ryzen 5 5600g', 94.7),
(35, 'Intel Core i3-10100', 79.9),
(36, ' Intel Core i5-4460 ', 62.1),
(37, 'Intel Core i7-4790 ', 71.4),
(38, 'Intel Core i3-8100 ', 70.6),
(39, 'AMD Ryzen 3 3100', 74.6),
(40, 'Intel Core i5-11400', 94.2),
(41, 'Ryzen 5 5600', 93),
(42, 'Intel i5-4670K', 68),
(43, 'Intel i5-11600K ', 99.3),
(44, 'Ryzen 7 3700X', 85.9),
(45, 'Core i7-9700', 92),
(46, 'Core i9-12900', 111),
(47, 'Ryzen 9 7900X', 118),
(48, 'Core i5-4430', 65.2),
(49, 'Core i5-6600K', 72.4);

-- --------------------------------------------------------

--
-- Table structure for table `gameinfo`
--

CREATE TABLE `gameinfo` (
  `GID` int(11) NOT NULL,
  `GameName` varchar(255) DEFAULT NULL,
  `ReleaseDate` varchar(50) DEFAULT NULL,
  `Platform` varchar(100) DEFAULT NULL,
  `Genres` varchar(255) DEFAULT NULL,
  `GameDetail` varchar(1000) DEFAULT NULL,
  `CompanyName` varchar(255) DEFAULT NULL,
  `CompanyLink` varchar(255) DEFAULT NULL,
  `CompanyInfo` varchar(1000) DEFAULT NULL,
  `IGNRating` varchar(10) DEFAULT NULL,
  `StoreLink` varchar(255) DEFAULT NULL,
  `TrailerLink` varchar(255) DEFAULT NULL,
  `GameplayLink` varchar(255) DEFAULT NULL,
  `Mincpu` varchar(500) NOT NULL,
  `Maxcpu` varchar(500) NOT NULL,
  `MinRAM` int(11) DEFAULT NULL,
  `MaxRAM` int(11) DEFAULT NULL,
  `Mingpu` varchar(500) NOT NULL,
  `Maxgpu` varchar(500) NOT NULL,
  `GameSize` float DEFAULT NULL,
  `GamePictureLink` varchar(500) DEFAULT NULL,
  `InGameImageLink1` varchar(300) DEFAULT NULL,
  `InGameImageLink2` varchar(300) DEFAULT NULL,
  `InGameImageLink3` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gameinfo`
--

INSERT INTO `gameinfo` (`GID`, `GameName`, `ReleaseDate`, `Platform`, `Genres`, `GameDetail`, `CompanyName`, `CompanyLink`, `CompanyInfo`, `IGNRating`, `StoreLink`, `TrailerLink`, `GameplayLink`, `Mincpu`, `Maxcpu`, `MinRAM`, `MaxRAM`, `Mingpu`, `Maxgpu`, `GameSize`, `GamePictureLink`, `InGameImageLink1`, `InGameImageLink2`, `InGameImageLink3`) VALUES
(1, 'The walking dead the game', '2012. April 24.', 'PlayStation 4, PlayStation 3, Xbox One, Xbox 360, Nintendo Switch, Android, Microsoft Windows, Plays', 'Interactive film, Graphic adventure game, Adventure.', 'The Walking Dead is a 2012 episodic graphic adventure video game developed and published by Telltale Games. Set in the same universe as the comic book series of the same name by Robert Kirkman, it is the first installment in Telltale\'s The Walking Dead video game series. The game follows Lee Everett, a convicted criminal who becomes the guardian of a young girl named Clementine amidst the onset of a zombie apocalypse in Georgia. Player decisions, such as dialogue choices and actions, influence the story\'s direction, with the consequences of these choices carrying over across the game\'s episodes.', 'Telltale Games', 'https://telltale.com/', 'Telltale Incorporated (trade name: Telltale Games) was an American video game developer based in San Rafael, California. The company was founded in July 2004 by former LucasArts developers Kevin Bruner, Dan Connors and Troy Molander, following LucasArts\' decision to leave the adventure game genre. Telltale established itself to focus on adventure games using a novel episodic release schedule over digital distribution, creating its own game engine, the Telltale Tool, to support this. It closed in October 2018 after filing for bankruptcy protection.', '9.3', 'https://store.steampowered.com/app/207610/The_Walking_Dead/', 'https://www.youtube.com/watch?v=N40uY51s5Z0', 'https://www.youtube.com/watch?v=-1reJEP_gsI', '2.0 GHz Pentium 4', 'Core 2 Duo 2GHz', 3, 3, 'AMD ATI Radeon HD 5450 ', 'Nvidia GT 210', 2, 'Img/The walking dead the game Cover.jpg', 'Img/The walking dead the game gameplay1.jpg', 'Img/The walking dead the game gameplay2.jpg', 'Img/The walking dead the game gameplay3.jpg'),
(2, 'The Last of Us Part I', ' September 2, 2022', ' PlayStation 5, Microsoft Windows', 'Action-adventure game, Shooter Video Game Adventure\r\n', 'The Last of Us Part I is a 2022 action-adventure game developed by Naughty Dog and published by Sony Interactive Entertainment. A remake of the 2013 game The Last of Us, it features revised gameplay, including enhanced combat and exploration, and expanded accessibility options. Players control Joel, who is tasked with escorting the young Ellie across a post-apocalyptic United States and defend her against cannibalistic creatures infected by a mutated strain of the Cordyceps fungus. The game includes a remake of the 2014 expansion pack The Last of Us: Left Behind, which follows Ellie and her best friend Riley.', 'Sony Interactive Entertainment', 'https://sonyinteractive.com/en/', 'Sony Interactive Entertainment LLC (SIE) is an American video game and digital entertainment company that is a major subsidiary of Sony Group Corporation. It primarily operates the PlayStation brand of video game consoles and products. It is also the world\'s largest company in the video game industry based on its equity investments.\r\n\r\nIn 1993, Sony and Sony Music Entertainment Japan jointly established Sony Computer Entertainment Inc. (SCE) in Tokyo, which released the video game console PlayStation in Japan the following year and subsequently in the United States and Europe the year after. In 2010, Sony underwent a corporate split and established Sony Network Entertainment International (SNEI) in California, which provided gaming-related services through the PlayStation Network as well as other media through Sony Entertainment Network, including the sale of game titles and content on the PlayStation Store, as well as offering PlayStation Plus and Media Go. In 2016, SCE and SNEI joint', '9', 'https://store.steampowered.com/app/1888930/The_Last_of_Us_Part_I/', 'https://www.youtube.com/watch?v=WxjeV10H1F0', 'https://www.youtube.com/watch?v=y99DqGw-jG4', 'AMD Ryzen 5 1500X, Intel Core i7-4770K', 'AMD Ryzen 5 3600X, Intel Core i7-8700', 16, 16, 'AMD Radeon RX 470 (4 GB), AMD Radeon RX 6500 XT (4 GB), NVIDIA GeForce GTX 970 (4 GB), NVIDIA GeForce GTX 1050 Ti (4 GB)', ' AMD Radeon RX 5700 XT (8 GB), AMD Radeon RX 6600 XT (8 GB), NVIDIA GeForce RTX 2070 SUPER (8 GB), NVIDIA GeForce RTX 3060 (8 GB)', 100, 'Img/The Last of Us Part I Cover.png', 'Img/The Last of Us Part I gameplay1.jpg', 'Img/The Last of Us Part I gameplay2.jpg', 'Img/The Last of Us Part I gameplay3.jpg'),
(3, 'Destiny dragon age inquisition', ' 18 Nov, 2014', 'PlayStation 3 PlayStation4 Windows Xbox 360 Xbox One', 'Action role-playing', 'Dragon Age: Inquisition is a 2014 action role-playing video game developed by BioWare and published by Electronic Arts. The third major game in the Dragon Age franchise, Inquisition is the sequel to Dragon Age II (2011). The story follows a player character known as the Inquisitor on a journey to settle the civil unrest in the continent of Thedas and close a mysterious tear in the sky called the \"Breach\", which is unleashing dangerous demons upon the world. Dragon Age: Inquisition\'s gameplay is similar to its predecessors, although it consists of several semi-open worlds for players to explore. Players control the Inquisitor or their companions mainly from a third-person perspective, although a traditional role-playing game top-down camera angle is also available.', 'Electronic Arts', 'https://www.ea.com/', 'Electronic Arts Inc. (EA) is an American video game company headquartered in Redwood City, California. Founded in May 1982 by former Apple employee Trip Hawkins, the company was a pioneer of the early home computer game industry and promoted the designers and programmers responsible for its games as \"software artists\". EA published numerous games and some productivity software for personal computers, all of which were developed by external individuals or groups until 1987\'s Skate or Die! The company shifted toward internal game studios, often through acquisitions, such as Distinctive Software becoming EA Canada in 1991.', '6.3', 'https://store.steampowered.com/app/1222690/Dragon_Age_Inquisition/', 'https://www.youtube.com/watch?v=jlACgYHtWCI', 'https://www.youtube.com/watch?v=X0G9Np6TqVo', 'Intel Quad core @ 2.0 GHz,AMD Quad core @ 2.5 GHz\r\n', 'AMD Six core @ 3.2 GHz,intel Quad core @ 3.0 GHz', 4, 8, ' AMD Radeon HD 4870,Nvidia GeForce 8800 GT', 'Nvidia GPU GeForce GTX 660,AMD GPU Radeon HD 7870', 26, 'Img/Destiny dragon age inquisition Cover.jpg', 'Img/Destiny dragon age inquisition gameplay 1.jpeg', 'Img/Destiny dragon age inquisition gameplay 2.jpeg', 'Img/Destiny dragon age inquisition gameplay 3.jpeg'),
(4, 'The witcher 3 wild hunt', ' 18 May, 2015', 'PlayStation 5, Nintendo Switch, PlayStation 4, Xbox One, Xbox Series X and Series S, GeForce Now, Mi', 'Open world, Fighting game, Action role-playing game, Action-adventure game, Nonlinear gameplay', 'The Witcher 3: Wild Hunt is a 2015 action role-playing game developed and published by CD Projekt. It is the sequel to the 2011 game The Witcher 2: Assassins of Kings and the third game in The Witcher video game series, played in an open world with a third-person perspective. The games follow the Witcher series of fantasy novels by Polish author Andrzej Sapkowski.', 'CD PROJEKT RED', 'https://www.cdprojektred.com/en', 'CD Projekt was founded in May 1994 by Marcin Iwiński and Michał Kiciński.According to Iwiński, although he enjoyed playing video games as a child they were scarce in the Polish People\'s Republic (which experienced political unrest, martial law, and goods shortages during the 1980s). Marcin Iwiński, in high school, was selling cracked copies of Western video games at a Warsaw marketplace (stalls on the streets with many such products were popular in the newly established and aggressively privatised Third Polish Republic of the 1990s).In high school, Iwiński met Kiciński, who became his business partner; at that time, Kiciński was also selling video games.', '9.3', 'https://store.steampowered.com/app/292030/The_Witcher_3_Wild_Hunt/', 'https://www.youtube.com/watch?v=1-l29HlKkXU', 'https://www.youtube.com/watch?v=cn_taKva-AQ', 'Intel CPU Core i5-2500K,AMD A10-5800K APU', 'Intel Core i5-7400,Ryzen 5 1600', 6, 8, 'Nvidia GPU GeForce GTX 660,AMD Radeon HD 7870\r\n', 'Nvidia GTX 1070,AMD Radeon RX 480', 50, 'Img/The witcher 3 wild hunt Cover.jpg', 'Img/The witcher 3 wild hunt gameplay1.jpg', 'Img/The witcher 3 wild hunt gameplay2.jpg', 'Img/The witcher 3 wild hunt gameplay3.jpg'),
(5, 'Assassin\'s Creed Valhalla', ' 6 Dec, 2022', 'PlayStation 5, PlayStation 4, Xbox Series X and Series S, Xbox One, Microsoft Windows, Google Stadia', 'PlayStation 5, PlayStation 4, Xbox Series X and Series S, Xbox One, Microsoft Windows, Google Stadia, Amazon Luna', 'Assassin\'s Creed Valhalla is a 2020 action role-playing game developed by Ubisoft Montreal and published by Ubisoft. It is the twelfth major installment in the Assassin\'s Creed series, and the successor to 2018\'s Assassin\'s Creed Odyssey. Principally set in the years 872–878 AD, the game recounts a Viking fantasy story during their expansions into the British Isles. Players control Eivor Varinsdottir, a Viking raider who, while attempting to establish a new Viking clan in England, becomes embroiled in the centuries-old conflict between the Assassin Brotherhood, who fight for peace and liberty, and the Templar Order, who desire peace through control.[c] The game also includes a framing story, set in the 21st century, which follows Layla Hassan, an Assassin who relives Eivor\'s memories so as to find a way to save the Earth from destruction.', 'Ubisoft Montreal', 'https://montreal.ubisoft.com/en/', 'Following Ubisoft\'s initial public offering in 1996, the Montreuil, France-based publisher began looking to expand into more global markets.[4] Establishing a studio in Quebec was of strong interest to the company; according to Ubisoft\'s CEO Yannis Mallat, a Quebec studio would allow them to bring in French-speaking employees and help with communication with the Montreuil headquarters, and was in close proximity to the United States, one of the largest markets for video games.', '8', 'https://store.steampowered.com/app/2208920/Assassins_Creed_Valhalla/', 'https://www.youtube.com/watch?v=rKjUAWlbTJk', 'https://www.youtube.com/watch?v=4DII3yLCL4A', 'AMD Ryzen 3 1200, Intel Core i5-4460 \r\n', 'AMD Ryzen 5 1600,Intel Core i7-4790 ', 8, 16, 'AMD R9 380,GeForce GTX 960', 'AMD RX 5700XT,GeForce RTX 2080', 160, 'Img/Assassin\'s Creed Valhalla Cover.jpg', 'Img/Assassin\'s Creed Valhalla gameplay1.jpg', 'Img/Assassin\'s Creed Valhalla gameplay2.jpg', 'Img/Assassin\'s Creed Valhalla gameplay3.jpg'),
(6, 'Marvel\'s Spider-Man 2', 'January 30, 2025', 'PlayStation 5, PlayStation 4,Windows', 'Action-adventure game, Fighting game, Platform game, Adventure', 'The incredible power of the symbiote forces Peter Parker and Miles Morales into a desperate fight as they balance their lives, friendships, and their duty to protect in an exciting chapter of the acclaimed Spider-Man franchise.\r\n', 'Playstation', 'https://www.playstation.com/en-us/', 'PlayStation is a video gaming brand owned and produced by Sony Interactive Entertainment , a division of Japanese conglomerate Sony. Its flagship products consists of a series of home video game consoles produced under the brand; it also consists of handhelds, online services, magazines, and other forms of media.\r\n\r\nThe brand began with the first PlayStation home console released in Japan in 1994 and worldwide the following year, which became the first console of any type to ship over 100 million units, which made PlayStation a globally recognized brand. Since then there have been numerous newer consoles—the most recent being the PlayStation 5 released in 2020—while there have also been a series of handheld consoles and a number of other electronics such as a media center and a smartphone. The main series of controllers utilized by the PlayStation series is the DualShock, a line of vibration-feedback gamepads. SIE also operate numerous online services like PlayStation Network, the Play', '8', 'https://www.playstation.com/en-us/games/marvels-spider-man-2/marvels-spider-man-2-pc/', 'https://www.youtube.com/watch?v=HdzlOQoG8TE', 'https://www.youtube.com/watch?v=SLBT1BPsDWM', 'Intel Core i3-8100,Ryzen 3 3100', 'Intel Core i5-11400,Ryzen 5 5600', 16, 16, 'GeForce GTX 1650,Radeon RX 5500 XT', 'GeForce RTX 3070,AMD Radeon RX 6800', 140, 'Img/Marvel\'s Spider-Man 2 Cover.jpg', 'Img/Marvel\'s Spider-Man 2 gameplay1.jpg', 'Img/Marvel\'s Spider-Man 2 gameplay2.jpg', 'Img/Marvel\'s Spider-Man 2 gameplay3.jpg'),
(7, 'God of War RagnaroK', 'November 9, 2022', 'PlayStation 5, PlayStation 4, Microsoft Windows', 'Action-adventure game', 'God of War Ragnarök is a 2022 action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. It was released worldwide on November 9, 2022, for both the PlayStation 4 and PlayStation 5, marking the first cross-generation release in the God of War series, and was released for Windows on September 19, 2024. It is the ninth installment in the series, the ninth chronologically, and the sequel to 2018\'s God of War. Loosely based on Norse mythology, the game is set in ancient Scandinavia and features series protagonist, Kratos, and his now teenage son, Atreus. Concluding the Norse era of the series, the story follows Kratos and Atreus\' efforts to prevent the nine realms from being destroyed by Ragnarök, the eschatological event which is central to Norse mythology and was foretold to happen in the previous game after Kratos killed the Aesir god Baldur.', 'Sony Interactive Entertainment', 'https://sonyinteractive.com/en/', 'Sony Interactive Entertainment LLC is an American video game and digital entertainment company that is a major subsidiary of Japanese conglomerate Sony Group Corporation. It primarily operates the PlayStation brand of video game consoles and products. It is also the world\'s largest company in the video game industry based on its equity investments.', '10', 'https://www.playstation.com/en-us/games/god-of-war-ragnarok/', 'https://www.youtube.com/watch?v=4mVaKztSoJM', 'https://www.youtube.com/watch?v=OHy6Zz6YXOU', 'Intel i5-4670K,AMD Ryzen 3 1200', 'Intel i5-11600K,AMD Ryzen 7 3700X', 16, 16, 'GTX 1060,RX 5500 XT', 'RTX 4070,RX 7900 XT', 190, 'Img/God of War Ragnarok Cover.jpg', 'Img/God of War Ragnarok gameplay1.jpg', 'Img/God of War Ragnarok gameplay2.jpg', 'Img/God of War Ragnarok gameplay3.jpg'),
(8, 'Cyberpunk 2077: Phantom Liberty', 'September 25, 2023', 'PlayStation 5, Xbox Series X and Series S, Microsoft Windows, Mac operating systems', 'Role-playing Video Game, Adventure game, Shooter Video Game, Fighting game', 'Cyberpunk 2077: Phantom Liberty is a 2023 expansion pack for the 2020 video game Cyberpunk 2077 developed by CD Projekt RED. The expansion introduces a new district to the game\'s open world, as well as a new quest line. Set in a dystopian cyberpunk universe, the player assumes the role of V, a mercenary who must rescue the President of the New United States whose aircraft has crashed in the lawless district of Dogtown. It was released for PlayStation 5, Xbox Series X/S, and Windows in September 2023. A Nintendo Switch 2 version will release alongside the base game in June 2025, with a MacOS version scheduled for later that year. The expansion received critical acclaim and is credited with renewing interest in Cyberpunk 2077. It has sold more than 8 million copies since release.', 'CD PROJEKT RED', 'https://www.cdprojektred.com/en', 'CD Projekt S.A. is a Polish video game company based in Warsaw, founded in May 1994 by Marcin Iwiński and Michał Kiciński. Iwiński and Kiciński were video game retailers before they founded the company, which initially acted as a distributor of foreign video games for the domestic market. The department responsible for developing original games, CD Projekt Red (stylised as CD PROJEKT RED), best known for The Witcher series and Cyberpunk 2077, was formed in 2002. In 2008, CD Projekt launched the digital distribution service Good Old Games, now known as GOG.com.', '9', 'https://store.steampowered.com/app/2138330/Cyberpunk_2077_Phantom_Liberty/', 'https://www.youtube.com/watch?v=sJbexcm4Trk', 'https://www.youtube.com/watch?v=DV_ekMpWNb0', 'Ryzen 5 5600,Core i7-9700', 'Core i9-12900,Ryzen 9 7900X', 16, 24, 'RTX 2060,RX 6800-XT', 'RTX 4080,RX 7900-XTX\r\n	\r\n\r\n', 70, 'Img/Cyberpunk 2077 Phantom Liberty Cover.jpg', 'Img/Cyberpunk 2077 Phantom Liberty gameplay1.jpg', 'Img/Cyberpunk 2077 Phantom Liberty gameplay2.jpg', 'Img/Cyberpunk 2077 Phantom Liberty gameplay3.jpg'),
(9, 'PUBG: BATTLEGROUNDS', 'December 21, 2017.', 'Android, PlayStation 4, Microsoft Windows, Xbox One, Xbox Series X and Series S, Google Stadia', 'Battle royale game, Shooter Video Game, Massively multiplayer online game, Action-adventure game, Free To Play', 'PUBG: Battlegrounds is a 2017 battle royale video game published by Krafton, and developed by Krafton\'s PUBG Studios. The game, which was inspired by the Japanese film Battle Royale (2000), is based on previous mods created by Brendan \"PlayerUnknown\" Greene for other games, and expanded into a standalone game under Greene\'s creative direction. Played from either a third-person or first-person perspective, up to one hundred players parachute onto an island where they are tasked to scavenge for weapons and equipment to kill other players while avoiding getting killed themselves. The available safe area of the game\'s map decreases in size over time, directing surviving players into an ever-tightening space to force encounters.', 'Krafton', 'https://krafton.com/en/games/', 'Krafton Inc is a South Korean video game publisher and holding company based in Bundang District, Seongnam. It was created in November 2018 to serve as the parent company for Bluehole, founded by Chang Byung-gyu in Seoul in March 2007, and its subsidiaries. The company has published several notable video game titles including TERA, PUBG: Battlegrounds, New State Mobile, The Callisto Protocol and InZOI.', '9.5', 'https://store.steampowered.com/app/578080/PUBG_BATTLEGROUNDS/', 'https://www.youtube.com/watch?v=fDLAFIhfFy4', 'https://www.youtube.com/watch?v=WjJ0MSF2Dgo', 'Core i5-4430,AMD FX-6300', 'Core i5-6600K,AMD Ryzen 5 1600', 8, 16, 'GeForce GTX 960,R7 370 ', 'GeForce GTX 1060,RX 580 ', 50, 'Img/PUBG BATTLEGROUNDS Cover.jpg', 'Img/PUBG BATTLEGROUNDS gameplay1.jpg', 'Img/PUBG BATTLEGROUNDS gameplay2.jpg', 'Img/PUBG BATTLEGROUNDS gameplay3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `gpuinfo`
--

CREATE TABLE `gpuinfo` (
  `GpuID` int(11) NOT NULL,
  `GpuName` varchar(100) DEFAULT NULL,
  `GpuScore` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gpuinfo`
--

INSERT INTO `gpuinfo` (`GpuID`, `GpuName`, `GpuScore`) VALUES
(1, 'AMD ATI Radeon HD 5450 ', 1.11),
(2, 'Nvidia GT 210', 0.69),
(3, 'Nvidia GeForce GTX 970', 49),
(4, 'AMD RX 470', 39.5),
(5, 'Nvidia GeForce GTX 1050 Ti', 23.1),
(6, 'AMD Radeon RX 5600 XT', 85.8),
(7, 'AMD Radeon HD 4870', 9.24),
(8, ' NVIDIA GeForce 8800 GT', 5.98),
(9, ' Nvidia GPU GeForce GTX 660', 19.9),
(10, 'AMD Radeon HD 7870', 26),
(11, 'Nvidia GTX 1070 ', 79.9),
(12, 'AMD Radeon RX 480', 45.6),
(13, 'AMD ATI Radeon HD 4850 ', 11.1),
(14, ' NVIDIA GeForce GTX 460 ', 12.1),
(15, 'Intel HD Graphics 4400', 2.6),
(16, 'NVIDIA GeForce GTX 680', 31.6),
(17, 'AMD Radeon HD 7970 ', 36),
(18, 'NVIDIA GeForce GTX 780', 44.9),
(19, 'AMD Radeon R9 290X ', 51),
(20, 'GeForce GTX 960', 32.9),
(21, 'NVIDIA GTX 1060-6GB', 56.1),
(22, 'AMD Radeon RX 570', 44.7),
(23, 'NVIDIA GeForce GTX 760', 26),
(24, 'AMD Radeon HD 7950', 28.6),
(25, 'NVIDIA 9800 GT ', 5.44),
(26, 'AMD HD 4870 ', 9.24),
(27, ' NVIDIA GTX 660 ', 19.9),
(28, ' AMD HD 7870', 26),
(29, 'Sapphire Radeon HD 2900XT', 7),
(30, 'NVIDIA GeForce 8800 GT', 5.98),
(31, 'AMD HD 5770', 10.4),
(32, ' NVIDIA GeForce 480', 19.6),
(33, 'AMD RX 5500-XT', 51),
(34, 'AMD RX 6500-XT', 50),
(35, 'AMD Radeon RX Vega 11 Graphics', 15.8),
(36, 'AMD Radeon RX 5700 XT', 99.9),
(37, 'AMD RX 6600-XT', 108.6),
(38, 'NVIDIA RTX 2070 SUPER', 115),
(39, 'NVIDIA RTX 3060', 101.2),
(40, 'AMD R9 380', 14),
(41, 'AMD RX 5700XT ', 41.6),
(42, 'GeForce RTX 2080', 51.4),
(43, 'GeForce GTX 1650 ', 18.1),
(44, 'GeForce RTX 3070', 61.7),
(45, 'Radeon RX 6800', 60.5),
(46, 'RTX 4070 Ti', 150),
(47, 'RX 7900 XT', 141),
(48, 'RTX 2060', 80),
(49, 'RX 6800-XT', 128),
(50, 'RTX 4080', 171),
(51, 'RX 7900-XTX', 158),
(52, 'R7 370 2GB', 9.1),
(53, 'RX 580', 88);

-- --------------------------------------------------------

--
-- Table structure for table `systemrequirement`
--

CREATE TABLE `systemrequirement` (
  `GID` int(11) DEFAULT NULL,
  `Mincpu` int(11) DEFAULT NULL,
  `Maxcpu` int(11) DEFAULT NULL,
  `Mingpu` int(11) DEFAULT NULL,
  `Maxgpu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `systemrequirement`
--

INSERT INTO `systemrequirement` (`GID`, `Mincpu`, `Maxcpu`, `Mingpu`, `Maxgpu`) VALUES
(1, 1, 2, 1, 2),
(2, 3, 5, 4, 36),
(2, 4, 6, 5, 37),
(2, 3, 5, 3, 38),
(2, 4, 6, 34, 39),
(3, 7, 9, 7, 9),
(3, 8, 10, 8, 10),
(4, 11, 13, 9, 11),
(4, 12, 14, 10, 12),
(5, 21, 14, 40, 41),
(5, 36, 37, 27, 42),
(6, 38, 40, 43, 45),
(6, 39, 41, 33, 44),
(7, 42, 43, 33, 46),
(7, 21, 44, 43, 47),
(8, 45, 47, 48, 51),
(8, 41, 46, 49, 50),
(9, 48, 49, 20, 53),
(9, 25, 32, 52, 21);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cpuinfo`
--
ALTER TABLE `cpuinfo`
  ADD PRIMARY KEY (`CpuID`);

--
-- Indexes for table `gameinfo`
--
ALTER TABLE `gameinfo`
  ADD PRIMARY KEY (`GID`);

--
-- Indexes for table `gpuinfo`
--
ALTER TABLE `gpuinfo`
  ADD PRIMARY KEY (`GpuID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
