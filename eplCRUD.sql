USE EPL;

-- This shows the 5 largest stadiums and the correlating club and league titles they have won.
SELECT club_name, s_name, capacity, PL_trophies AS "Premier_League_Trophies"
FROM Stadiums s
	JOIN club c
		ON s.id = c.Stadiums_id
ORDER BY capacity DESC
LIMIT 5;

-- Shows the forward and midfield players with the highest goals per game. (including legends) -- (this is cool)
DROP VIEW IF EXISTS v_HoF;
CREATE VIEW v_HoF
AS
SELECT *, SUBSTRING_INDEX(name," ",1) AS "fname", SUBSTRING_INDEX(name," ",-1) AS "lname"
FROM Hall_of_Fame;

SELECT *
FROM v_HoF;

SELECT "current_player" AS "status", fname, lname, club_name, position, goals, round(goals/appearances,3) AS "goals_per_game"
FROM players p
	JOIN club c
		ON	c.id = p.club_id
WHERE position IN ("Forward", "Midfielder")
UNION
SELECT "legend" AS "status", fname, lname, club_name, position, goals, round(goals/appearances,3) AS "goals_per_game"
FROM v_HoF v
	JOIN club c
		ON	c.id = v.club_id
WHERE position IN ("Forward", "Midfielder")
ORDER BY goals_per_game DESC;




-- create backup tables 
DROP TABLE IF EXISTS season_table_bak;
DROP TABLE IF EXISTS players_bak;

CREATE TABLE season_table_bak AS
SELECT * FROM season_table;
ALTER TABLE EPL.season_table_bak 
CHANGE COLUMN id id INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (id),
ADD UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE;


#create next backup table.
CREATE TABLE players_bak AS
SELECT * FROM players;
ALTER TABLE `EPL`.`players_bak` 
CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`id`),
ADD UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE;
;

## insert into managers

INSERT INTO EPL.Managers
(id,m_fname,m_lname,dob,nationality)
VALUES(DEFAULT,"Rafael", "Benitez", "1960-04-16","Spain");

# do update ,insert then delete the insert
DROP PROCEDURE IF EXISTS sp_club_insert
DELIMITER //

CREATE PROCEDURE sp_club_insert(
	IN club_name_param VARCHAR(35),
    IN pl_param INT,
    IN fa_param INT,
    IN cl_param INT,
	IN Manager_id_param INT,
    IN Stadium_id_param INT
)
	BEGIN 
    /*
		DECLARE sqlerror TINYINT DEFAULT FALSE;
        
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
			SET sqlerror = TRUE;
		
        START TRANSACTION;
        */
			INSERT INTO club (`club_name`,`PL_trophies`,`FA_cups`,`CL_trophies`,`Managers_id`,`Stadiums_id`)
            VALUES(club_name_param,pl_param,fa_param,cl_param,Manager_id_param,Stadium_id_param);
        /*    
		IF sqlerror THEN
			ROLLBACK;
            SELECT 'ERROR: The club has not been added to table';
		ELSE 
			COMMIT;
            SELECT 'The club has been inserted';
		END IF;
        */
	END //
    
CALL sp_club_insert("Everton",9,5,0,8,6);
            
-- Actually CRUD statements for grade
# players table
UPDATE players
SET appearances = 209, goals = 91, assists = 36
WHERE id = 10;

INSERT INTO EPL.players
(`id`,`fname`,`lname`,`position`,`dob`,`nationality`,`height_cm`,`appearances`,`goals`,`assists`,`clean_sheets`,`club_id`)
VALUES(DEFAULT,"joe","doe","Midfielder","2000/01/01","England","180","50","5","10",NULL,"1");

DELETE FROM players 
WHERE id = 16;

# club
# I had to do this because I created everton 5 times lol
DELETE FROM club 
WHERE id = 19;

SELECT club_name, PL_trophies
FROM club
ORDER BY PL_trophies DESC;

# season_table
SELECT *
FROM season_table
WHERE start_year = 2021
ORDER BY points DESC, GD;

UPDATE season_table
SET played = 16, won = 12, drawn = 2, lost = 2 ,GF = 33 , GA =9 , GD = 24,points = 38 , position = 1
WHERE id = 1;

UPDATE season_table
SET played = 16, won = 11, drawn = 4, lost = 1 ,GF = 45 , GA =12 , GD = 33,points = 37 , position = 2
WHERE id = 2;

UPDATE season_table
SET played = 16, won = 11, drawn = 3, lost = 2 ,GF = 38 , GA =11 , GD = 27,points = 36 , position = 3
WHERE id = 3;

UPDATE season_table
SET played = 16, won = 8, drawn = 4, lost = 4 ,GF = 28 , GA =19 , GD = 9,points = 28 , position = 4
WHERE id = 4;

UPDATE season_table
SET played = 16, won = 8, drawn = 2, lost = 6 ,GF = 21 , GA =26 , GD = -1,points = 26 , position = 6
WHERE id = 5;

UPDATE season_table
SET played = 16, won = 8, drawn = 3, lost = 5 ,GF = 26 , GA =24 , GD = 2,points = 27 , position = 5
WHERE id = 6;

