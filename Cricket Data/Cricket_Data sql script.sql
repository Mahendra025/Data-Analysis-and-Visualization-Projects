USE DEMO_DATABASE;

-------FOR DATACLEANING-------

CREATE OR REPLACE TABLE BATSMAN(
"Bat1"VARCHAR(6),
"Runs"VARCHAR(6),
"BF"VARCHAR(6),
"SR"VARCHAR(6),
"4s"VARCHAR(6),
"6s"VARCHAR(6),
"Opposition"VARCHAR(15),
"Ground"VARCHAR(30),
"Start Date"DATE,
"Match_ID"VARCHAR(10),
"Batsman"VARCHAR(25),
"Player_ID"INT
);

CREATE OR REPLACE TABLE BOWLER(
"Overs"VARCHAR(4),
"Mdns"VARCHAR(3),
"Runs"VARCHAR(3),
"Wkts"VARCHAR(3),
"Econ"VARCHAR(5),
"Ave"VARCHAR(6),
"SR"VARCHAR(6),
"Opposition"VARCHAR(20),
"Ground"VARCHAR(30),
"Start Date"DATE,
"Match_ID"VARCHAR(10),
"Bowler"VARCHAR(30),
"Player_ID"INT
);

CREATE OR REPLACE TABLE ODI_Match_Results(
"Result"VARCHAR(5),
"Margin"VARCHAR(10),
"BR"VARCHAR(3),
"Toss"VARCHAR(5),
"Bat"VARCHAR(5),
"Opposition"VARCHAR(30),
"Ground"VARCHAR(30),
"Start Date"DATE,
"Match_ID"VARCHAR(15),
"Country"VARCHAR(30),
"Country_ID"INT
);

SELECT COUNT(*) FROM BATSMAN;---11149
SELECT COUNT(*) FROM BOWLER;----11118
SELECT COUNT(*) FROM ODI_Match_Results;----1322

----------BATSMAN DATA-------
DELETE FROM BATSMAN
WHERE "Bat1" IN('DNB','TDNB','absent','sub');---2231

UPDATE BATSMAN
SET "SR"='0' 
WHERE "SR"='-';---100

UPDATE BATSMAN
SET "Opposition"=REPLACE("Opposition",'v');---8918

SELECT "Bat1",
           CASE 
               WHEN "Bat1" LIKE '%*'THEN 'NOT_OUT'
               WHEN "Bat1"LIKE '%'THEN 'OUT'
               END AS "OUT/NOT_OUT"
                FROM BATSMAN;  
                
UPDATE BATSMAN
SET "Start Date"=
         CASE
             WHEN "Start Date"LIKE'0099%'THEN ('19'||SUBSTR("Start Date",3))
             WHEN "Start Date"LIKE'00%'THEN ('20'||SUBSTR("Start Date",3))
             END;

SELECT * FROM BATSMAN;             

-------------BOWLER DATA----------
ALTER TABLE BOWLER
DROP COLUMN "Ave","SR";

DELETE FROM BOWLER
WHERE "Overs"='-';----5270

UPDATE BOWLER
SET "Opposition"= REPLACE("Opposition",'v');----5848

ALTER TABLE BOWLER
ADD COLUMN "Balls_Bowled"INT ;

UPDATE BOWLER
SET "Balls_Bowled"=("Overs"*6);---5848

UPDATE BOWLER
SET "Start Date"=
         CASE
             WHEN "Start Date"LIKE'0099%'THEN ('19'||SUBSTR("Start Date",3))
             WHEN "Start Date"LIKE'00%'THEN ('20'||SUBSTR("Start Date",3))
             END;
             
SELECT * FROM BOWLER;

---------------ODI_Match_Results--------
DELETE FROM ODI_MATCH_RESULTS
WHERE "Result"IN ('-','n/r','aban','canc')---83

ALTER TABLE ODI_MATCH_RESULTS
DROP COLUMN"BR";

UPDATE ODI_MATCH_RESULTS
SET "Opposition"=REPLACE("Opposition",'v');---1239


UPDATE ODI_MATCH_RESULTS
SET "Start Date"=
         CASE
             WHEN "Start Date"LIKE'0099%'THEN ('19'||SUBSTR("Start Date",3))
             WHEN "Start Date"LIKE'00%'THEN ('20'||SUBSTR("Start Date",3))
             END;
             
SELECT * FROM ODI_MATCH_RESULTS;
