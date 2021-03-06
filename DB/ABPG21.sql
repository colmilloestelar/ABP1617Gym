-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 29, 2016 at 10:51 AM
-- Server version: 5.7.16-0ubuntu0.16.04.1
-- PHP Version: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ABPG21`
--
CREATE DATABASE IF NOT EXISTS `ABPG21` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ABPG21`;

-- --------------------------------------------------------

--
-- Table structure for table `Actividad`
--

CREATE TABLE `Actividad` (
  `idActividad` int(11) NOT NULL,
  `nomActividad` varchar(20) NOT NULL,
  `tipoAct` varchar(10) NOT NULL,
  `numPlazas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Ejercicio`
--

CREATE TABLE `Ejercicio` (
  `idEjercicio` int(11) NOT NULL,
  `nomEjercicio` varchar(20) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `categoria` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Estadísticas`
--

CREATE TABLE `Estadísticas` (
  `TablaEjercicio_Ejercicio_idEjercicio` int(11) NOT NULL,
  `TablaEjercicio_Tabla_idTabla` int(11) NOT NULL,
  `Usuario_idUsuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `comentario` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Notificacion`
--

CREATE TABLE `Notificacion` (
  `idNotificacion` int(11) NOT NULL,
  `contenido` varchar(45) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `Usuario_idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Reserva`
--

CREATE TABLE `Reserva` (
  `Usuario_idUsuario` int(11) NOT NULL,
  `Sesion_idSesion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Sesion`
--

CREATE TABLE `Sesion` (
  `idSesion` int(11) NOT NULL,
  `numPlazasOcupadas` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `Actividad_idActividad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Sigue`
--

CREATE TABLE `Sigue` (
  `Tabla_idTabla` int(11) NOT NULL,
  `Usuario_idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Tabla`
--

CREATE TABLE `Tabla` (
  `idTabla` int(11) NOT NULL,
  `nomTabla` varchar(10) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `TablaEjercicio`
--

CREATE TABLE `TablaEjercicio` (
  `Ejercicio_idEjercicio` int(11) NOT NULL,
  `Tabla_idTabla` int(11) NOT NULL,
  `nRepeticiones` int(11) DEFAULT NULL,
  `carga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Usuario`
--

CREATE TABLE `Usuario` (
  `idUsuario` int(11) NOT NULL,
  `nomUsuario` varchar(20) NOT NULL,
  `direccion` varchar(30) DEFAULT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `tipoTarjeta` varchar(10) NOT NULL,
  `dni` varchar(10) NOT NULL,
  `fechaNac` date DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `pass` varchar(16) NOT NULL,
  `tipoUsuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Actividad`
--
ALTER TABLE `Actividad`
  ADD PRIMARY KEY (`idActividad`);

--
-- Indexes for table `Ejercicio`
--
ALTER TABLE `Ejercicio`
  ADD PRIMARY KEY (`idEjercicio`);

--
-- Indexes for table `Estadísticas`
--
ALTER TABLE `Estadísticas`
  ADD PRIMARY KEY (`TablaEjercicio_Ejercicio_idEjercicio`,`TablaEjercicio_Tabla_idTabla`,`Usuario_idUsuario`,`fecha`),
  ADD KEY `fk_TablaEjercicio_has_Usuario_Usuario1_idx` (`Usuario_idUsuario`),
  ADD KEY `fk_TablaEjercicio_has_Usuario_TablaEjercicio1_idx` (`TablaEjercicio_Ejercicio_idEjercicio`,`TablaEjercicio_Tabla_idTabla`);

--
-- Indexes for table `Notificacion`
--
ALTER TABLE `Notificacion`
  ADD PRIMARY KEY (`idNotificacion`,`Usuario_idUsuario`),
  ADD KEY `fk_Notificacion_Usuario1_idx` (`Usuario_idUsuario`);

--
-- Indexes for table `Reserva`
--
ALTER TABLE `Reserva`
  ADD PRIMARY KEY (`Usuario_idUsuario`,`Sesion_idSesion`),
  ADD KEY `fk_Deportista_has_Sesion_Usuario1_idx` (`Usuario_idUsuario`),
  ADD KEY `fk_Reserva_Sesion1_idx` (`Sesion_idSesion`);

--
-- Indexes for table `Sesion`
--
ALTER TABLE `Sesion`
  ADD PRIMARY KEY (`idSesion`,`Actividad_idActividad`),
  ADD KEY `fk_Sesion_Actividad1_idx` (`Actividad_idActividad`);

--
-- Indexes for table `Sigue`
--
ALTER TABLE `Sigue`
  ADD PRIMARY KEY (`Tabla_idTabla`,`Usuario_idUsuario`),
  ADD KEY `fk_Deportista_has_Tabla_Tabla1_idx` (`Tabla_idTabla`),
  ADD KEY `fk_Sigue_Usuario1_idx` (`Usuario_idUsuario`);

--
-- Indexes for table `Tabla`
--
ALTER TABLE `Tabla`
  ADD PRIMARY KEY (`idTabla`);

--
-- Indexes for table `TablaEjercicio`
--
ALTER TABLE `TablaEjercicio`
  ADD PRIMARY KEY (`Ejercicio_idEjercicio`,`Tabla_idTabla`),
  ADD KEY `fk_Ejercicio_has_Tabla_Tabla1_idx` (`Tabla_idTabla`),
  ADD KEY `fk_Ejercicio_has_Tabla_Ejercicio1_idx` (`Ejercicio_idEjercicio`);

--
-- Indexes for table `Usuario`
--
ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `pass_UNIQUE` (`pass`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Actividad`
--
ALTER TABLE `Actividad`
  MODIFY `idActividad` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Ejercicio`
--
ALTER TABLE `Ejercicio`
  MODIFY `idEjercicio` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Notificacion`
--
ALTER TABLE `Notificacion`
  MODIFY `idNotificacion` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Sesion`
--
ALTER TABLE `Sesion`
  MODIFY `idSesion` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Tabla`
--
ALTER TABLE `Tabla`
  MODIFY `idTabla` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Usuario`
--
ALTER TABLE `Usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Estadísticas`
--
ALTER TABLE `Estadísticas`
  ADD CONSTRAINT `fk_TablaEjercicio_has_Usuario_TablaEjercicio1` FOREIGN KEY (`TablaEjercicio_Ejercicio_idEjercicio`,`TablaEjercicio_Tabla_idTabla`) REFERENCES `TablaEjercicio` (`Ejercicio_idEjercicio`, `Tabla_idTabla`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TablaEjercicio_has_Usuario_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Notificacion`
--
ALTER TABLE `Notificacion`
  ADD CONSTRAINT `fk_Notificacion_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Reserva`
--
ALTER TABLE `Reserva`
  ADD CONSTRAINT `fk_Deportista_has_Sesion_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Reserva_Sesion1` FOREIGN KEY (`Sesion_idSesion`) REFERENCES `Sesion` (`idSesion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Sesion`
--
ALTER TABLE `Sesion`
  ADD CONSTRAINT `fk_Sesion_Actividad1` FOREIGN KEY (`Actividad_idActividad`) REFERENCES `Actividad` (`idActividad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Sigue`
--
ALTER TABLE `Sigue`
  ADD CONSTRAINT `fk_Deportista_has_Tabla_Tabla1` FOREIGN KEY (`Tabla_idTabla`) REFERENCES `Tabla` (`idTabla`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Sigue_Usuario1` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `TablaEjercicio`
--
ALTER TABLE `TablaEjercicio`
  ADD CONSTRAINT `fk_Ejercicio_has_Tabla_Ejercicio1` FOREIGN KEY (`Ejercicio_idEjercicio`) REFERENCES `Ejercicio` (`idEjercicio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Ejercicio_has_Tabla_Tabla1` FOREIGN KEY (`Tabla_idTabla`) REFERENCES `Tabla` (`idTabla`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
