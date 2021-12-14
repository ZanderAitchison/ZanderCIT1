-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema EPL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EPL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EPL` DEFAULT CHARACTER SET utf8 ;
USE `EPL` ;

-- -----------------------------------------------------
-- Table `EPL`.`Managers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`Managers` ;

CREATE TABLE IF NOT EXISTS `EPL`.`Managers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `m_fname` VARCHAR(45) NOT NULL,
  `m_lname` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EPL`.`Stadiums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`Stadiums` ;

CREATE TABLE IF NOT EXISTS `EPL`.`Stadiums` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `s_name` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EPL`.`club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`club` ;

CREATE TABLE IF NOT EXISTS `EPL`.`club` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(45) NOT NULL,
  `PL_trophies` INT NOT NULL,
  `FA_cups` INT NOT NULL,
  `CL_trophies` INT NOT NULL,
  `Managers_id` INT,
  `Stadiums_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_club_Managers1_idx` (`Managers_id` ASC) VISIBLE,
  INDEX `fk_club_Stadiums1_idx` (`Stadiums_id` ASC) VISIBLE,
  CONSTRAINT `fk_club_Managers1`
    FOREIGN KEY (`Managers_id`)
    REFERENCES `EPL`.`Managers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_Stadiums1`
    FOREIGN KEY (`Stadiums_id`)
    REFERENCES `EPL`.`Stadiums` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EPL`.`Hall_of_Fame`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`Hall_of_Fame` ;

CREATE TABLE IF NOT EXISTS `EPL`.`Hall_of_Fame` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `appearances` INT NOT NULL,
  `goals` INT NOT NULL,
  `position` VARCHAR(15) NOT NULL,
  `assists` INT NOT NULL,
  `titles` INT NOT NULL,
  `season_awards` INT NOT NULL,
  `monthly_awards` INT NOT NULL,
  `club_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Hall_of_Fame_club1_idx` (`club_id` ASC) VISIBLE,
  CONSTRAINT `fk_Hall_of_Fame_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `EPL`.`club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EPL`.`players`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`players` ;

CREATE TABLE IF NOT EXISTS `EPL`.`players` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `position` VARCHAR(15) NOT NULL,
  `dob` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `height_cm` INT NOT NULL,
  `appearances` INT NOT NULL,
  `goals` INT NOT NULL,
  `assists` INT NOT NULL,
  `clean_sheets` INT NULL,
  `club_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_players_club1_idx` (`club_id` ASC) VISIBLE,
  CONSTRAINT `fk_players_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `EPL`.`club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EPL`.`season_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`season_table` ;

CREATE TABLE IF NOT EXISTS `EPL`.`season_table` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_year` YEAR(4) NOT NULL,
  `end_year` YEAR(4) NOT NULL,
  `position` INT NOT NULL,
  `club` VARCHAR(45) NOT NULL,
  `played` INT NOT NULL,
  `won` INT NOT NULL,
  `drawn` INT NOT NULL,
  `lost` INT NOT NULL,
  `GF` INT NOT NULL,
  `GA` INT NOT NULL,
  `GD` INT NOT NULL,
  `points` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EPL`.`season_table_has_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EPL`.`season_table_has_club` ;

CREATE TABLE IF NOT EXISTS `EPL`.`season_table_has_club` (
  `season_table_id` INT NOT NULL,
  `club_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`season_table_id`, `club_id`),
  INDEX `fk_season_table_has_club_club1_idx` (`club_id` ASC) VISIBLE,
  INDEX `fk_season_table_has_club_season_table1_idx` (`season_table_id` ASC) VISIBLE,
  CONSTRAINT `fk_season_table_has_club_season_table1`
    FOREIGN KEY (`season_table_id`)
    REFERENCES `EPL`.`season_table` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_season_table_has_club_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `EPL`.`club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Populate stadium table
INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Villa Park","42785","Birmingham");
SET @villa_park = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"The Amex","31800","Brighton");
SET @Amex = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Turf Moor","22619","Burnley");
SET @turk_moor = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Elland Road","39460","Leeds");
SET @elland_road = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"King Power Stadium","32312","Leicester");
SET @king_power = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Goodison Park","40157","Liverpool");
SET @goodison_park = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Anfield","54074","Liverpool");
SET @anfield = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Emirates Stadium","60361","London");
SET @emirates = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Brentford Community Stadium","17250","London");
SET @brentford = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Stamford Bridge","41837","London");
SET @stamford_bridge = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Selhurst Park","26225","London");
SET @selhurst_park = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Tottenham Hotspur Stadium","62303","London");
SET @tottenham_hotspur = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"London Stadium","60000","London");
SET @london_stadium = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Etihad Stadium","55000","Manchester");
SET @etihad = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Old Trafford","75811","Manchester");
SET @old_trafford = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"St James Park","52339","Newcastle upon Tyne");
SET @st_james_park = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Carrow Road","27010","Norwich");
SET @carrow_road = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"St Mary's Stadium","32689","Southampton");
SET @st_mary = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Vicarage Road","21500","Watford");
SET @vicarage = last_insert_id();

INSERT INTO `EPL`.`Stadiums`
(`id`,`s_name`,`capacity`,`city`)
VALUES(DEFAULT,"Molineux Stadium","31700","Wolverhampton");
SET @molineux = last_insert_id();

-- Populate Managers table
INSERT INTO `EPL`.`Managers`
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"Mikel", "Arteta","1982/03/26","Spain");
SET @MikelArteta = last_insert_id();

INSERT INTO `EPL`.`Managers`
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"Jurgen", "Klopp","1967/06/16","Germany");
SET @JurgenKlopp = last_insert_id();

INSERT INTO `EPL`.`Managers`
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"Josep", "Guardiola","1971/01/18","Spain");
SET @JosepGuardiola = last_insert_id();

INSERT INTO `EPL`.`Managers`
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"Thomas", "Tuchel","1973/08/29","Germany");
SET @ThomasTuchel = last_insert_id();

INSERT INTO `EPL`.`Managers` 
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"Ralf", "Rangnick","1958/06/29","Germany");
SET @RalfRangnick = last_insert_id();

INSERT INTO `EPL`.`Managers` 
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"Eddie", "Howe","1977/11/29","England");
SET @EddieHowe = last_insert_id();

INSERT INTO `EPL`.`Managers` 
(`id`,`m_fname`,`m_lname`,`dob`,`nationality`)
VALUES(DEFAULT,"David", "Moyes","1963/04/25","Scotland");
SET @DavidMoyes = last_insert_id();

-- Populate Club table
INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"Arsenal",13,14,0,@MikelArteta, @emirates);
SET @Arsenal = last_insert_id();

INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"Manchester United",20,12,3,@RalfRangnick, @old_trafford);
SET @ManU = last_insert_id();

INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"Liverpool",19,7,6,@JurgenKlopp,@anfield);
SET @Liverpool = last_insert_id();

INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"Chelsea",6,8,2,@ThomasTuchel,@stamford_bridge);
SET @Chelsea = last_insert_id();

INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"Manchester City",7,6,0,@JosepGuardiola,@etihad);
SET @ManCity = last_insert_id();

INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"Newcastle United",4,6,0,@EddieHowe,@st_james_park);
SET @Newcastle = last_insert_id();

INSERT INTO `EPL`.`club`
(`id`,`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
VALUES(DEFAULT,"West Ham United",0,3,0,@DavidMoyes,@london_stadium);
SET @West_Ham = last_insert_id();

-- Populate HallOfFame table
INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Thierry Henry","French","1977/08/17","258","175","forward","74","2","2","0",@Arsenal);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"David Beckham","England","1975/05/02","265","62","midfielder","80","6","0","1",@ManU);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Alan Shearer","England","1970/08/13","441","260","forward","64","1","0","0",@Newcastle);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Dennis Bergkamp","Netherlands","1969/05/10","315","87","forward","94","3","0","4",@Arsenal);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Frank Lampard","England","1978/06/20","609","177","midfielder","74","3","1","4",@Chelsea);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Steven Gerrard","England","1980/05/30","504","120","midfielder","92","0","0","6",@ManU);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Eric Cantona","France","1966/05/24","156","70","forward","56","4","0","1",@ManU);

INSERT INTO `EPL`.`Hall_of_Fame`
(`id`,`name`,`nationality`,`dob`,`appearances`,`goals`,`position`,`assists`,`titles`,`season_awards`,`monthly_awards`,`club_id`)
VALUES(DEFAULT,"Roy Keane","Ireland","1971/08/10","366","39","midfielder","33","7","0","2",@ManU);

-- Populate Season table
INSERT INTO `EPL`.`season_table`
(`id`,`start_year`,`end_year`,`position`,`club`,`played`,`won`,`drawn`,`lost`,`GF`,`GA`,`GD`,`points`)
VALUES(DEFAULT,"2021","2022","1","Manchester City","15","11","2","2","32","9","23","35");

INSERT INTO `EPL`.`season_table`
(`id`,`start_year`,`end_year`,`position`,`club`,`played`,`won`,`drawn`,`lost`,`GF`,`GA`,`GD`,`points`)
VALUES(DEFAULT,"2021","2022","2","Liverpool","15","10","4","1","44","12","32","34");

INSERT INTO `EPL`.`season_table`
(`id`,`start_year`,`end_year`,`position`,`club`,`played`,`won`,`drawn`,`lost`,`GF`,`GA`,`GD`,`points`)
VALUES(DEFAULT,"2021","2022","3","Chelsea","15","10","3","2","35","9","26","33");

INSERT INTO `EPL`.`season_table`
(`id`,`start_year`,`end_year`,`position`,`club`,`played`,`won`,`drawn`,`lost`,`GF`,`GA`,`GD`,`points`)
VALUES(DEFAULT,"2021","2022","4","West Ham United","15","8","3","4","28","19","9","27");

INSERT INTO `EPL`.`season_table`
(`id`,`start_year`,`end_year`,`position`,`club`,`played`,`won`,`drawn`,`lost`,`GF`,`GA`,`GD`,`points`)
VALUES(DEFAULT,"2021","2022","5","Arsenal","14","7","2","5","17","20","-3","23");

INSERT INTO `EPL`.`season_table`
(`id`,`start_year`,`end_year`,`position`,`club`,`played`,`won`,`drawn`,`lost`,`GF`,`GA`,`GD`,`points`)
VALUES(DEFAULT,"2021","2022","6","Manchester United","14","6","3","5","24","24","0","21");

-- Populate player table
INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Bukayo","Saka","Midfielder","2001/09/05","England","178","73","8","10",NULL,@Arsenal);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Pierre-Emerick","Aubameyang","Forward","1989/06/18","Gabon","187","127","68","16",NULL,@Arsenal);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Aaron","Ramsdale","Goalkeeper","1998/05/14","England","188","86","0","1","16",@Arsenal);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Alisson","Becker","Goalkeeper","1992/10/02","Brazil","191","114","1","1","52",@Liverpool);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Mohamed","Salah","Forward","1992/10/02","Egypt","175","173","110","43",NULL,@Liverpool);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Virgil","van Dijk","Defender","1991/07/08","Netherlands","193","177","15","4","70",@Liverpool);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Romelu","Lukaku","Forward","1993/05/13","Belgium","190","262","116","35",NULL,@Chelsea);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Edourd","Mendy","Goalkeeper","1992/03/01","Senegal","197","45","0","0","23",@Chelsea);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Christian","Pulisic","Midfielder","1998/09/18","United States","172","58","15","6",NULL,@Chelsea);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Cristiano","Ronaldo","Forward","1985/02/05","Portugal","187","207","90","36",NULL,@ManU);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Paul","Pogba","Midfielder","1993/03/15","France","191","146","28","36",NULL,@ManU);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Luke","Shaw","Defender","1995/07/12","England","185","200","2","13","55",@ManU);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"John","Stones","Defender","1994/05/28","England","188","188","5","0","60",@ManCity);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Kevin","De Bruyne","Midfielder","1991/06/28","Belgium","181","189","44","78",NULL,@ManCity);

INSERT INTO `EPL`.`players`
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"Phil","Foden","Midfielder","2000/05/28","England","171","78","18","10",NULL,@ManCity);

-- Populate seasonHasTable table
INSERT INTO `EPL`.`season_table_has_club`
(`season_table_id`,`club_id`)
VALUES(1,@ManCity);

INSERT INTO `EPL`.`season_table_has_club`
(`season_table_id`,`club_id`)
VALUES(2,@Liverpool);

INSERT INTO `EPL`.`season_table_has_club`
(`season_table_id`,`club_id`)
VALUES(3,@Chelsea);

INSERT INTO `EPL`.`season_table_has_club`
(`season_table_id`,`club_id`)
VALUES(4,@West_Ham);

INSERT INTO `EPL`.`season_table_has_club`
(`season_table_id`,`club_id`)
VALUES(5,@Arsenal);

INSERT INTO `EPL`.`season_table_has_club`
(`season_table_id`,`club_id`)
VALUES(6,@ManU);




