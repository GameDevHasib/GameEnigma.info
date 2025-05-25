-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2025 at 02:58 PM
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
-- Database: `game enigma database`
--

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
(2, 4, 6, 34, 39);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
