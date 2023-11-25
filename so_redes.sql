-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2023 at 03:38 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `so_redes`
--

-- --------------------------------------------------------

--
-- Table structure for table `solicitudes`
--

CREATE TABLE `solicitudes` (
  `ID` int(11) NOT NULL,
  `Motivo` varchar(255) DEFAULT NULL,
  `Fecha_Inicio` date DEFAULT NULL,
  `Fecha_Final` date DEFAULT NULL,
  `Motivo_Adicional` varchar(255) DEFAULT NULL,
  `Colaborador` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `solicitudes`
--

INSERT INTO `solicitudes` (`ID`, `Motivo`, `Fecha_Inicio`, `Fecha_Final`, `Motivo_Adicional`, `Colaborador`, `Status`) VALUES
(3, 'Me estoy muriendo', '2023-11-14', '2023-11-17', '', 3, 2),
(4, 'Me estoy muriendo', '2023-11-14', '2023-11-17', '', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `ID` int(11) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`ID`, `Descripcion`) VALUES
(0, 'rechazado'),
(1, 'en espera'),
(2, 'aceptado');

-- --------------------------------------------------------

--
-- Table structure for table `tipo`
--

CREATE TABLE `tipo` (
  `ID` int(11) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tipo`
--

INSERT INTO `tipo` (`ID`, `Descripcion`) VALUES
(1, 'Usuario'),
(2, 'Administrador');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Apellido` varchar(255) DEFAULT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Contraseña` varchar(255) DEFAULT NULL,
  `Tipo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`ID`, `Nombre`, `Apellido`, `Username`, `Contraseña`, `Tipo`) VALUES
(3, 'Daniel', 'Tovares', 'Dogleche', '$2y$10$HT7Ew.OeJhoYVigYCGVNXOFAczXh6p/t5y8iuyk6VQf2NxYOzUDVq', 1),
(4, 'Christopher', 'Diaz', 'Admin1', '$2y$10$XBtTfx4WZ9ayzY3CJmwt6OFnn8FOM85q4TAehPs5USR6G6NeGWwJq', 2),
(5, 'Luis', 'Rivera', 'Lerrgo', '$2y$10$vhzkHu7IQYqdnNv8dwxOUeAvRWuvLfAVe25MpFv4wFT/MtuwHlyAq', 1);

--
-- Triggers `usuario`
--
DELIMITER $$
CREATE TRIGGER `reorder_usuario_id` AFTER DELETE ON `usuario` FOR EACH ROW BEGIN
    DECLARE new_id INT;
    SET new_id := 1000;
    UPDATE usuario
    SET ID = (@new_id := @new_id + 1)
    WHERE ID > OLD.ID;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Colaborador` (`Colaborador`),
  ADD KEY `Status` (`Status`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Tipo` (`Tipo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipo`
--
ALTER TABLE `tipo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `solicitudes_ibfk_1` FOREIGN KEY (`Colaborador`) REFERENCES `usuario` (`ID`),
  ADD CONSTRAINT `solicitudes_ibfk_2` FOREIGN KEY (`Status`) REFERENCES `status` (`ID`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Tipo`) REFERENCES `tipo` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
