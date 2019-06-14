-- MySQL Script generated by MySQL Workbench
-- Thu Sep  6 16:22:19 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema smc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `smc` ;

-- -----------------------------------------------------
-- Schema smc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smc` DEFAULT CHARACTER SET utf8 ;
USE `smc` ;

-- -----------------------------------------------------
-- Table `smc`.`patientUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patientUser` ;

CREATE TABLE IF NOT EXISTS `smc`.`patientUser` (
  `patientUserId` INT NOT NULL,
  `patientUserName` VARCHAR(150) NOT NULL,
  `patientUserPassword` VARCHAR(150) NOT NULL,
  `patientUserSessionId` VARCHAR(150) NULL,
  PRIMARY KEY (`patientUserId`),
  UNIQUE INDEX `patientUserName_UNIQUE` (`patientUserName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patient` ;

CREATE TABLE IF NOT EXISTS `smc`.`patient` (
  `patientUser_fk` INT NOT NULL,
  `patientName` VARCHAR(150) NOT NULL,
  `patientCpf` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`patientUser_fk`),
  UNIQUE INDEX `patientCpf_UNIQUE` (`patientCpf` ASC) VISIBLE,
  CONSTRAINT `fk_patient_patientUser1`
    FOREIGN KEY (`patientUser_fk`)
    REFERENCES `smc`.`patientUser` (`patientUserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicUser` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicUser` (
  `medicUserId` INT NOT NULL,
  `medicUserName` VARCHAR(150) NOT NULL,
  `medicUserPassword` VARCHAR(150) NOT NULL,
  `medicUserSessionId` VARCHAR(150) NULL,
  PRIMARY KEY (`medicUserId`),
  UNIQUE INDEX `medicUserName_UNIQUE` (`medicUserName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medic` ;

CREATE TABLE IF NOT EXISTS `smc`.`medic` (
  `medicUser_fk` INT NOT NULL,
  `medicName` VARCHAR(150) NOT NULL,
  `medicCrm` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`medicUser_fk`),
  UNIQUE INDEX `medicCrm_UNIQUE` (`medicCrm` ASC) VISIBLE,
  CONSTRAINT `fk_medic_medicUser`
    FOREIGN KEY (`medicUser_fk`)
    REFERENCES `smc`.`medicUser` (`medicUserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `smc`.`managerUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`managerUser` ;

CREATE TABLE IF NOT EXISTS `smc`.`managerUser` (
  `managerUserId` INT NOT NULL,
  `managerUserName` VARCHAR(150) NOT NULL,
  `managerUserPassword` VARCHAR(150) NOT NULL,
  `managerUserSessionId` VARCHAR(150) NULL,
  PRIMARY KEY (`managerUserId`),
  UNIQUE INDEX `managerUserName_UNIQUE` (`managerUserName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`patientProfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patientProfile` ;

CREATE TABLE IF NOT EXISTS `smc`.`patientProfile` (
  `patient_fk` INT NOT NULL,
  `patientProfileEmail` VARCHAR(150) NULL,
  `patientProfileGenre` VARCHAR(10) NULL,
  `patientProfileBirthDate` DATE NOT NULL,
  `patientProfileHeight` FLOAT NULL,
  `patientProfileBloodType` VARCHAR(5) NULL,
  `patientProfileTelephone` VARCHAR(12) NULL,
  `patientProfileWeight` FLOAT NULL,
  PRIMARY KEY (`patient_fk`),
  CONSTRAINT `fk_patientProfile_patient1`
    FOREIGN KEY (`patient_fk`)
    REFERENCES `smc`.`patient` (`patientUser_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicProfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicProfile` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicProfile` (
  `medic_fk` INT NOT NULL,
  `medicProfileBio` VARCHAR(300) NULL,
  `medicProfileExpAge` INT NULL,
  `medicProfileInfoCompl` VARCHAR(50) NULL,
  PRIMARY KEY (`medic_fk`),
  CONSTRAINT `fk_medicProfile_medic1`
    FOREIGN KEY (`medic_fk`)
    REFERENCES `smc`.`medic` (`medicUser_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`patientAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patientAccount` ;

CREATE TABLE IF NOT EXISTS `smc`.`patientAccount` (
  `patientProfile_fk` INT NOT NULL,
  `patientAccountCreationDate` DATE NULL,
  PRIMARY KEY (`patientProfile_fk`),
  CONSTRAINT `fk_account_patientProfile1`
    FOREIGN KEY (`patientProfile_fk`)
    REFERENCES `smc`.`patientProfile` (`patient_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`speciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`speciality` ;

CREATE TABLE IF NOT EXISTS `smc`.`speciality` (
  `specialityId` INT NOT NULL,
  `specialityName` VARCHAR(100) NOT NULL,
  `specialityPriv` TINYINT NOT NULL,
  PRIMARY KEY (`specialityId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`accountSpeciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`accountSpeciality` ;

CREATE TABLE IF NOT EXISTS `smc`.`accountSpeciality` (
  `accountSpecialityId` INT NOT NULL,
  `patientAccount_fk` INT NOT NULL,
  `patientAccountSpecialityCreationDate` DATETIME NOT NULL,
  `patientAccountSpecialityUseDate` DATETIME NULL,
  `patientAccountSpecialityUsed` TINYINT NOT NULL,
  `speciality_fk` INT NOT NULL,
  `medicProfile_fk` INT NOT NULL,
  PRIMARY KEY (`accountSpecialityId`),
  INDEX `fk_accountSpeciality_speciality1_idx` (`speciality_fk` ASC) VISIBLE,
  INDEX `fk_accountSpeciality_medicProfile1_idx` (`medicProfile_fk` ASC) VISIBLE,
  CONSTRAINT `fk_accountSpeciality_account1`
    FOREIGN KEY (`patientAccount_fk`)
    REFERENCES `smc`.`patientAccount` (`patientProfile_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accountSpeciality_speciality1`
    FOREIGN KEY (`speciality_fk`)
    REFERENCES `smc`.`speciality` (`specialityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accountSpeciality_medicProfile1`
    FOREIGN KEY (`medicProfile_fk`)
    REFERENCES `smc`.`medicProfile` (`medic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`file` ;

CREATE TABLE IF NOT EXISTS `smc`.`file` (
  `fileId` INT NOT NULL,
  `fileName` VARCHAR(45) NOT NULL,
  `filePath` VARCHAR(350) NOT NULL,
  `fileUploadDate` DATETIME NOT NULL,
  `fileLength` INT NOT NULL,
  PRIMARY KEY (`fileId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`patientAccountFile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patientAccountFile` ;

CREATE TABLE IF NOT EXISTS `smc`.`patientAccountFile` (
  `patientAccount_fk` INT NOT NULL,
  `file_fk` INT NOT NULL,
  `patientAccountFileType` INT(2) NOT NULL,
  INDEX `fk_filesAccount_account1_idx` (`patientAccount_fk` ASC) VISIBLE,
  INDEX `fk_patientAccountFile_file1_idx` (`file_fk` ASC) VISIBLE,
  CONSTRAINT `fk_filesAccount_account1`
    FOREIGN KEY (`patientAccount_fk`)
    REFERENCES `smc`.`patientAccount` (`patientProfile_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patientAccountFile_file1`
    FOREIGN KEY (`file_fk`)
    REFERENCES `smc`.`file` (`fileId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`patientProfileFile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patientProfileFile` ;

CREATE TABLE IF NOT EXISTS `smc`.`patientProfileFile` (
  `file_fk` INT NOT NULL,
  `patientProfile_fk` INT NOT NULL,
  INDEX `fk_patientProfileFile_file1_idx` (`file_fk` ASC) VISIBLE,
  PRIMARY KEY (`patientProfile_fk`),
  CONSTRAINT `fk_patientProfileFile_file1`
    FOREIGN KEY (`file_fk`)
    REFERENCES `smc`.`file` (`fileId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patientProfileFile_patientProfile1`
    FOREIGN KEY (`patientProfile_fk`)
    REFERENCES `smc`.`patientProfile` (`patient_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicEvaluation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicEvaluation` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicEvaluation` (
  `medicProfile_fk` INT NOT NULL,
  `medicEvaluationAvg` FLOAT NULL,
  `medicEvaluationCount` INT NULL,
  PRIMARY KEY (`medicProfile_fk`),
  CONSTRAINT `fk_medicEvaluation_medicProfile1`
    FOREIGN KEY (`medicProfile_fk`)
    REFERENCES `smc`.`medicProfile` (`medic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`evaluation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`evaluation` ;

CREATE TABLE IF NOT EXISTS `smc`.`evaluation` (
  `evaluationId` INT NOT NULL,
  `patientProfile_fk` INT NOT NULL,
  `medicEvaluation_fk` INT NOT NULL,
  `evaluationDescName` VARCHAR(20) NOT NULL,
  `evaluationDescInfo` VARCHAR(200) NOT NULL,
  `evaluationScore` INT NOT NULL,
  PRIMARY KEY (`evaluationId`),
  INDEX `fk_patientEvaluation_patientProfile1_idx` (`patientProfile_fk` ASC) VISIBLE,
  INDEX `fk_evaluation_medicEvaluation1_idx` (`medicEvaluation_fk` ASC) VISIBLE,
  CONSTRAINT `fk_patientEvaluation_patientProfile1`
    FOREIGN KEY (`patientProfile_fk`)
    REFERENCES `smc`.`patientProfile` (`patient_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluation_medicEvaluation1`
    FOREIGN KEY (`medicEvaluation_fk`)
    REFERENCES `smc`.`medicEvaluation` (`medicProfile_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`clinic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`clinic` ;

CREATE TABLE IF NOT EXISTS `smc`.`clinic` (
  `clinicId` INT NOT NULL,
  `clinicName` VARCHAR(150) NOT NULL,
  `clinicCnpj` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`clinicId`),
  UNIQUE INDEX `clinicCnpj_UNIQUE` (`clinicCnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`clinicProfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`clinicProfile` ;

CREATE TABLE IF NOT EXISTS `smc`.`clinicProfile` (
  `clinic_fk` INT NOT NULL,
  `clinicProfileBio` VARCHAR(500) NULL,
  `clinicProfileAddress` VARCHAR(50) NULL,
  PRIMARY KEY (`clinic_fk`),
  CONSTRAINT `fk_clinicProfile_clinic1`
    FOREIGN KEY (`clinic_fk`)
    REFERENCES `smc`.`clinic` (`clinicId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicSpeciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicSpeciality` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicSpeciality` (
  `medicProfile_fk` INT NOT NULL,
  `speciality_fk` INT NOT NULL,
  INDEX `fk_medicSpeciality_medicProfile1_idx` (`medicProfile_fk` ASC) VISIBLE,
  INDEX `fk_medicSpeciality_speciality1_idx` (`speciality_fk` ASC) VISIBLE,
  PRIMARY KEY (`speciality_fk`, `medicProfile_fk`),
  CONSTRAINT `fk_medicSpeciality_medicProfile1`
    FOREIGN KEY (`medicProfile_fk`)
    REFERENCES `smc`.`medicProfile` (`medic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicSpeciality_speciality1`
    FOREIGN KEY (`speciality_fk`)
    REFERENCES `smc`.`speciality` (`specialityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicProfileFile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicProfileFile` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicProfileFile` (
  `medicProfile_fk` INT NOT NULL,
  `file_fk` INT NOT NULL,
  INDEX `fk_medicProfileFiles_medicProfile1_idx` (`medicProfile_fk` ASC) VISIBLE,
  INDEX `fk_medicProfileFile_file1_idx` (`file_fk` ASC) VISIBLE,
  CONSTRAINT `fk_medicProfileFiles_medicProfile1`
    FOREIGN KEY (`medicProfile_fk`)
    REFERENCES `smc`.`medicProfile` (`medic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicProfileFile_file1`
    FOREIGN KEY (`file_fk`)
    REFERENCES `smc`.`file` (`fileId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicWorkAddress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicWorkAddress` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicWorkAddress` (
  `medicWorkAddressId` INT NOT NULL,
  `clinicProfile_fk` INT NOT NULL,
  `medicWorkAddressComplement` VARCHAR(50) NULL,
  `medicSpeciality_speciality_fk` INT NOT NULL,
  `medicSpeciality_medicProfile_fk` INT NOT NULL,
  INDEX `fk_medicWorkAddress_clinicProfile1_idx` (`clinicProfile_fk` ASC) VISIBLE,
  PRIMARY KEY (`medicWorkAddressId`),
  INDEX `fk_medicWorkAddress_medicSpeciality1_idx` (`medicSpeciality_speciality_fk` ASC, `medicSpeciality_medicProfile_fk` ASC) VISIBLE,
  CONSTRAINT `fk_medicWorkAddress_clinicProfile1`
    FOREIGN KEY (`clinicProfile_fk`)
    REFERENCES `smc`.`clinicProfile` (`clinic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicWorkAddress_medicSpeciality1`
    FOREIGN KEY (`medicSpeciality_speciality_fk` , `medicSpeciality_medicProfile_fk`)
    REFERENCES `smc`.`medicSpeciality` (`speciality_fk` , `medicProfile_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`consult`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`consult` ;

CREATE TABLE IF NOT EXISTS `smc`.`consult` (
  `consultId` INT NOT NULL,
  `consultCreationDate` DATETIME NOT NULL,
  `consultForDate` DATETIME NOT NULL,
  `consultConsulted` TINYINT NOT NULL,
  `medicSpeciality_speciality_fk` INT NOT NULL,
  `medicSpeciality_medicProfile_fk` INT NOT NULL,
  `medicWorkAddress_fk` INT NOT NULL,
  `patientProfile_fk` INT NOT NULL,
  PRIMARY KEY (`consultId`),
  INDEX `fk_patientConsult_medicSpeciality1_idx` (`medicSpeciality_speciality_fk` ASC, `medicSpeciality_medicProfile_fk` ASC) VISIBLE,
  INDEX `fk_consult_medicWorkAddress1_idx` (`medicWorkAddress_fk` ASC) VISIBLE,
  INDEX `fk_consult_patientProfile1_idx` (`patientProfile_fk` ASC) VISIBLE,
  CONSTRAINT `fk_patientConsult_medicSpeciality1`
    FOREIGN KEY (`medicSpeciality_speciality_fk` , `medicSpeciality_medicProfile_fk`)
    REFERENCES `smc`.`medicSpeciality` (`speciality_fk` , `medicProfile_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consult_medicWorkAddress1`
    FOREIGN KEY (`medicWorkAddress_fk`)
    REFERENCES `smc`.`medicWorkAddress` (`medicWorkAddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consult_patientProfile1`
    FOREIGN KEY (`patientProfile_fk`)
    REFERENCES `smc`.`patientProfile` (`patient_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`patientConsult`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`patientConsult` ;

CREATE TABLE IF NOT EXISTS `smc`.`patientConsult` (
  `consult_fk` INT NOT NULL,
  `patientProfile_fk` INT NOT NULL,
  INDEX `fk_patientAgenda_patientProfile1_idx` (`patientProfile_fk` ASC) VISIBLE,
  PRIMARY KEY (`consult_fk`),
  CONSTRAINT `fk_patientAgenda_patientProfile1`
    FOREIGN KEY (`patientProfile_fk`)
    REFERENCES `smc`.`patientProfile` (`patient_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patientConsult_consult1`
    FOREIGN KEY (`consult_fk`)
    REFERENCES `smc`.`consult` (`consultId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicConsult`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicConsult` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicConsult` (
  `consult_fk` INT NOT NULL,
  `medicProfile_fk` INT NOT NULL,
  INDEX `fk_medicAgenda_medicProfile1_idx` (`medicProfile_fk` ASC) VISIBLE,
  PRIMARY KEY (`consult_fk`),
  CONSTRAINT `fk_medicAgenda_medicProfile1`
    FOREIGN KEY (`medicProfile_fk`)
    REFERENCES `smc`.`medicProfile` (`medic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicConsult_consult1`
    FOREIGN KEY (`consult_fk`)
    REFERENCES `smc`.`consult` (`consultId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`clinicTelephone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`clinicTelephone` ;

CREATE TABLE IF NOT EXISTS `smc`.`clinicTelephone` (
  `clinicProfile_fk` INT NOT NULL,
  `clinicTelephoneNumber` VARCHAR(11) NULL,
  INDEX `fk_clinicTelephone_clinicProfile1_idx` (`clinicProfile_fk` ASC) VISIBLE,
  CONSTRAINT `fk_clinicTelephone_clinicProfile1`
    FOREIGN KEY (`clinicProfile_fk`)
    REFERENCES `smc`.`clinicProfile` (`clinic_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`userType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`userType` ;

CREATE TABLE IF NOT EXISTS `smc`.`userType` (
  `userTypeName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`userTypeName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`logError`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`logError` ;

CREATE TABLE IF NOT EXISTS `smc`.`logError` (
  `logErrorId` INT NOT NULL,
  `userType_fk` VARCHAR(20) NOT NULL,
  `logErrorName` VARCHAR(60) NULL,
  `logErrorDesc` VARCHAR(300) NULL,
  PRIMARY KEY (`logErrorId`),
  INDEX `fk_logError_userType1_idx` (`userType_fk` ASC) VISIBLE,
  CONSTRAINT `fk_logError_userType1`
    FOREIGN KEY (`userType_fk`)
    REFERENCES `smc`.`userType` (`userTypeName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`logConsult`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`logConsult` ;

CREATE TABLE IF NOT EXISTS `smc`.`logConsult` (
  `logConsultId` INT NOT NULL,
  PRIMARY KEY (`logConsultId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`idManager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`idManager` ;

CREATE TABLE IF NOT EXISTS `smc`.`idManager` (
  `id` INT NOT NULL,
  `rowSize` INT NULL,
  `managerUser` INT NULL,
  `managerUserLast` INT NULL,
  `medicUser` INT NULL,
  `medicUserLast` INT NULL,
  `medicSchedule` INT NULL,
  `medicScheduleLast` INT NULL,
  `clinic` INT NULL,
  `clinicLast` INT NULL,
  `speciality` INT NULL,
  `specialityLast` INT NULL,
  `medicWorkAddress` INT NULL,
  `medicWorkAddressLast` INT NULL,
  `evaluation` INT NULL,
  `evaluationLast` INT NULL,
  `consult` INT NULL,
  `consultLast` INT NULL,
  `accountSpeciality` INT NULL,
  `accountSpecialityLast` INT NULL,
  `file` INT NULL,
  `fileLast` INT NULL,
  `patientUser` INT NULL,
  `patientUserLast` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smc`.`medicWorkScheduling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smc`.`medicWorkScheduling` ;

CREATE TABLE IF NOT EXISTS `smc`.`medicWorkScheduling` (
  `medicWorkAddress_fk` INT NOT NULL,
  `medicWorkSchedulingPerDay` INT NOT NULL,
  `medicWorkSchedulingDateLast` DATE NOT NULL,
  `medicWorkSchedulingCounterOfDay` INT NOT NULL,
  `medicWorkSchedulingInfo` VARCHAR(20) NULL,
  `medicWorkSchedulingDaysOfWeek` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`medicWorkAddress_fk`),
  CONSTRAINT `fk_medicWorkSpace_medicWorkAddress1`
    FOREIGN KEY (`medicWorkAddress_fk`)
    REFERENCES `smc`.`medicWorkAddress` (`medicWorkAddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS patient;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'patient';

GRANT SELECT ON TABLE `smc`.`clinic` TO 'patient';
GRANT SELECT ON TABLE `smc`.`clinicProfile` TO 'patient';
GRANT SELECT ON TABLE `smc`.`patient` TO 'patient';
GRANT SELECT ON TABLE `smc`.`medic` TO 'patient';
GRANT SELECT, UPDATE ON TABLE `smc`.`patientProfile` TO 'patient';
GRANT SELECT ON TABLE `smc`.`medicProfile` TO 'patient';
GRANT SELECT ON TABLE `smc`.`patientAccount` TO 'patient';
GRANT SELECT ON TABLE `smc`.`accountSpeciality` TO 'patient';
GRANT SELECT ON TABLE `smc`.`file` TO 'patient';
GRANT SELECT, UPDATE, INSERT ON TABLE `smc`.`patientAccountFile` TO 'patient';
GRANT SELECT, INSERT, UPDATE ON TABLE `smc`.`patientProfileFile` TO 'patient';
GRANT SELECT, UPDATE, INSERT ON TABLE `smc`.`evaluation` TO 'patient';
GRANT SELECT ON TABLE `smc`.`speciality` TO 'patient';
GRANT SELECT ON TABLE `smc`.`medicSpeciality` TO 'patient';
GRANT SELECT ON TABLE `smc`.`medicProfileFile` TO 'patient';
GRANT SELECT, INSERT, UPDATE ON TABLE `smc`.`consult` TO 'patient';
GRANT SELECT ON TABLE `smc`.`medicWorkAddress` TO 'patient';
GRANT SELECT, INSERT, UPDATE ON TABLE `smc`.`patientConsult` TO 'patient';
GRANT SELECT ON TABLE `smc`.`medicConsult` TO 'patient';
GRANT SELECT ON TABLE `smc`.`clinicTelephone` TO 'patient';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO idManager VALUES (0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0);