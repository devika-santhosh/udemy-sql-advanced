CREATE TABLE salaries (
    yearID INT,
    teamID VARCHAR(3),
    lgID VARCHAR(2),
    playerID VARCHAR(20),
    salary INT,
    PRIMARY KEY (yearID, teamID, playerID)
);
