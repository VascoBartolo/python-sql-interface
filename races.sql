CREATE TABLE runner (
    id INTEGER PRIMARY KEY,                    -- runner id
    name VARCHAR(64) NOT NULL,                 -- name
    birth_date DATE NOT NULL,                  -- birthday FORMAT: 'MM-DD-YYYY'
	sex VARCHAR (1) CHECK (sex IN ('M', 'F')), -- gender
    nation VARCHAR (2),                        -- nationality
    UNIQUE (name, birth_date)                  -- person with the same name on the same birthday is not allowed
);

-- UNIQUENESS OF team, age_class, event names should be verified in backend (python)
CREATE TABLE team (
    id INTEGER PRIMARY KEY,   -- team id
    name VARCHAR NOT NULL     -- team name 
);

CREATE TABLE age_class (
    id INTEGER PRIMARY KEY,   -- age_class id
    name VARCHAR NOT NULL     -- age_class  
);

CREATE TABLE event (
    id INTEGER PRIMARY KEY,   -- event id
    name VARCHAR NOT NULL     -- event name 
);

CREATE TABLE race (
    id INTEGER PRIMARY KEY,                     -- race id
	id_event INTEGER NOT NULL REFERENCES event, -- event id
    distance INTEGER NOT NULL,                  -- distance (km)
	year INTEGER NOT NULL                       -- race year
);

CREATE TABLE participation (
    id_runner INTEGER REFERENCES runner,                -- This runner is enrolled
    id_race INTEGER REFERENCES race,                    -- in this race
	bib INTEGER,                                        -- bib
    id_age_class INTEGER REFERENCES age_class NOT NULL, -- in this age_class
    id_team INTEGER REFERENCES team,                    -- team if of the runner (if any)
	place_overall INTEGER,                              -- place over all age classes
	place_in_class INTEGER,                             -- place in their age_class
	official_time TIME,                                 -- official time to finish the race
    net_time TIME,                                      -- net time to finish the race
    PRIMARY KEY (id_runner, id_race),                   -- runners cannot enrole twice in the same race
    UNIQUE (id_race, bib)                               -- bib is unique within every race
);


-- EXAMPLES:
INSERT INTO runner  VALUES  (1,'Rojan Aslani', '09-09-1998' , 'F','IR');
INSERT INTO runner  VALUES  (2,'Farzam Salimi', '09-10-1998' , 'M','PT');
INSERT INTO runner  VALUES  (3,'Vasco Bartooo', '12-27-1998' , 'M','PT');

INSERT INTO team VALUES (1, 'fast runners');
INSERT INTO team VALUES (2, 'cheetos');
INSERT INTO team VALUES (3, 'redbullers');

INSERT INTO age_class VALUES (1, 'F20');
INSERT INTO age_class VALUES (2, 'M20');

INSERT INTO event VALUES (1, 'dia do pai');
INSERT INTO event VALUES (2, 'xmass');

INSERT INTO race VALUES (1, 1, 10, 2015 );
INSERT INTO race VALUES (2, 2, 15, 2015 );

INSERT INTO participation VALUES (1, 1, 1, 1, 1, 2, 1, '01:17:43', '01:17:43');