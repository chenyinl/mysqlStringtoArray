-- Convert string to array in MySQL and chec if a value is in the array
-- Was from Disha Goyal @ https://stackoverflow.com/questions/5928599/equivalent-of-explode-to-work-with-strings-in-mysql

CREATE PROCEDURE explode( pDelim VARCHAR(32), pStr TEXT)                                
BEGIN                                
  DROP TABLE IF EXISTS temp_explode;                                
  CREATE TEMPORARY TABLE temp_explode (id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, word VARCHAR(40));                                
  SET @sql := CONCAT('INSERT INTO temp_explode (word) VALUES (', REPLACE(QUOTE(pStr), pDelim, '\'), (\''), ')');                                
  PREPARE myStmt FROM @sql;                                
  EXECUTE myStmt;                                
END

SET @str  = "2,4,6,8,10,12,14"; 
SET @delim = ",";
CALL explode(@delim,@str);
SELECT id,word FROM temp_explode;

select word from temp_explode;

select 
(
CASE 
    WHEN CAST(16 AS CHAR) IN (SELECT word FROM temp_explode)
    THEN 'true'
    ELSE 'false'
END
) AS d
