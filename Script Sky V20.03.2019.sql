-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema parking_sky
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema parking_sky
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parking_sky` DEFAULT CHARACTER SET utf8 ;
USE `parking_sky` ;

-- -----------------------------------------------------
-- Table `parking_sky`.`registro_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`registro_usuario` (
  `id_Registro_Usuario` INT(20) NOT NULL AUTO_INCREMENT,
  `Nombre_Usuario` VARCHAR(45) NOT NULL,
  `Apellido_Usuario` VARCHAR(45) NOT NULL,
  `Identificacion_Usuario` VARCHAR(45) NOT NULL,
  `Telefono_Usuario` INT(20) NOT NULL,
  `Correo_Usuario` VARCHAR(45) NOT NULL,
  `Contraseña_Usuario` VARCHAR(45) NOT NULL,
  `Rol_Usuario` VARCHAR(45) NOT NULL,
  `Fecha_Registro` DATETIME NOT NULL,
  `Numero_Apartamento` VARCHAR(45) NULL,
  `Torre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Registro_Usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parking_sky`.`registro_visitantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`registro_visitantes` (
  `id_Registro_Visitantes` INT(20) NOT NULL,
  `Nombre_Visitantes` VARCHAR(45) NOT NULL,
  `Apellido_Visitante` VARCHAR(45) NOT NULL,
  `Identificacion_Visitante` VARCHAR(45) NOT NULL,
  `Telefono_Visitante` INT(20) NOT NULL,
  `Numero_Torre` VARCHAR(45) NOT NULL,
  `Numero_Apartamento` VARCHAR(45) NOT NULL,
  `Fecha_Registro_Visitante` DATETIME NOT NULL,
  PRIMARY KEY (`id_Registro_Visitantes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parking_sky`.`registro_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`registro_vehiculo` (
  `id_Registro_Vehiculo` INT(20) NOT NULL,
  `Modelo_Vehiculo` VARCHAR(45) NOT NULL,
  `Color_Vehiculo` VARCHAR(45) NOT NULL,
  `Placa_Vehiculo` VARCHAR(45) NOT NULL,
  `Marca_Vehiculo` VARCHAR(45) NOT NULL,
  `Tipo_Vehiculo` VARCHAR(45) NOT NULL,
  `Estado_Vehiculo` VARCHAR(45) NOT NULL,
  `id_Registro_Usuario` INT(20) NOT NULL,
  `id_Registro_Visitantes` INT(20) NOT NULL,
  PRIMARY KEY (`id_Registro_Vehiculo`),
  INDEX `fk_id_Registro_Usuario_idx` (`id_Registro_Usuario` ASC) VISIBLE,
  INDEX `fk_id_Registro_Visitantes_idx` (`id_Registro_Visitantes` ASC) VISIBLE,
  CONSTRAINT `fk_id_Registro_Usuario`
    FOREIGN KEY (`id_Registro_Usuario`)
    REFERENCES `parking_sky`.`registro_usuario` (`id_Registro_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_Registro_Visitantes`
    FOREIGN KEY (`id_Registro_Visitantes`)
    REFERENCES `parking_sky`.`registro_visitantes` (`id_Registro_Visitantes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parking_sky`.`ingreso_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`ingreso_vehiculo` (
  `id_Ingreso_Vehiculo` INT(20) NOT NULL,
  `Fecha_Hora_Ingreso` DATETIME NOT NULL,
  `id_Registro_Vehiculo` INT(20) NOT NULL,
  PRIMARY KEY (`id_Ingreso_Vehiculo`),
  INDEX `fk_id_Registro_Vehiculo_idx` (`id_Registro_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `fk_id_Registro_Vehiculo`
    FOREIGN KEY (`id_Registro_Vehiculo`)
    REFERENCES `parking_sky`.`registro_vehiculo` (`id_Registro_Vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parking_sky`.`salida_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`salida_vehiculo` (
  `id_Salida_Vehiculo` INT(20) NOT NULL,
  `Fecha_Hora_Salida` DATETIME NOT NULL,
  `id_Ingreso_Vehiculo` INT(20) NOT NULL,
  PRIMARY KEY (`id_Salida_Vehiculo`),
  INDEX `fk_id_Ingreso_Vehiculo_idx` (`id_Ingreso_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `fk_id_Ingreso_Vehiculo`
    FOREIGN KEY (`id_Ingreso_Vehiculo`)
    REFERENCES `parking_sky`.`ingreso_vehiculo` (`id_Ingreso_Vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parking_sky`.`tipo_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`tipo_documento` (
  `id_Tipo_Documento` INT(20) NOT NULL,
  `Descripcion_Documento` VARCHAR(45) NOT NULL,
  `id_Registro_Usuario` INT(20) NOT NULL,
  `id_Registro_Visitantes` INT(20) NOT NULL,
  PRIMARY KEY (`id_Tipo_Documento`),
  INDEX `fk_id_Registro_Usuario_idx` (`id_Registro_Usuario` ASC) VISIBLE,
  INDEX `fk_id_Registro_Visitantes_idx` (`id_Registro_Visitantes` ASC) VISIBLE,
  CONSTRAINT `_id_Registro_Usuario`
    FOREIGN KEY (`id_Registro_Usuario`)
    REFERENCES `parking_sky`.`registro_usuario` (`id_Registro_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Registro_Visitantes_`
    FOREIGN KEY (`id_Registro_Visitantes`)
    REFERENCES `parking_sky`.`registro_visitantes` (`id_Registro_Visitantes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parking_sky`.`validar_ubicacion_vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parking_sky`.`validar_ubicacion_vehiculo` (
  `id_Validar_Ubicacion_Vehiculo` INT(20) NOT NULL,
  `Bahia_Numero` INT(20) NOT NULL,
  `Disponibilidad` VARCHAR(45) NOT NULL,
  `id_Ingreso_Vehiculo` INT(20) NOT NULL,
  PRIMARY KEY (`id_Validar_Ubicacion_Vehiculo`),
  INDEX `fk_id_Ingreso_Vehiculo_idx` (`id_Ingreso_Vehiculo` ASC) VISIBLE,
  CONSTRAINT `id_Ingreso_Vehiculo_fk`
    FOREIGN KEY (`id_Ingreso_Vehiculo`)
    REFERENCES `parking_sky`.`ingreso_vehiculo` (`id_Ingreso_Vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
