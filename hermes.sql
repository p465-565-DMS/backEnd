CREATE DATABASE hermes;
\c hermes;

CREATE TABLE IF NOT EXISTS Company (compId int,
                                    compName text,
                                    creatorId int,
                                    logo text,
                                    description text,
                                    address text,
                                    PRIMARY KEY (compId)
                                  );

INSERT INTO Company VALUES (-1, 'Shark Shipping', 1, 'whatever.jpg', 'WE SHIP. BY SHARK.', '51446 Righter Lane, South Bend, Indiana') ON CONFLICT DO NOTHING;
INSERT INTO Company VALUES (-2, 'NIGHT TIME SEA HAWK', 2, 'whatever.jpg', 'AHHHHHHHHHYEA.', '51446 Righter Lane, South Bend, Indiana') ON CONFLICT DO NOTHING;


CREATE TABLE Users (userId int,
                   fname text,
                   lName text,
                   userName text,
                   userPassword text,
                   roleId int,
                   address text,
                   PRIMARY KEY (userId)
                 );

INSERT INTO Users VALUES (1, 'Jared', 'Johnston', 'jajohn', 'hetillio123!', 3, 'blah blah blah') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (2, 'Caraque', 'Sutton', 'carsut', 'Parambe$$1', 3, 'a location is here') ON CONFLICT DO NOTHING;


CREATE TABLE Package (packageId text,
                      packageTitle text,
                      packageDescription text,
                      packageSLocation text,
                      deadline text,
                      packageELocation text,
                      PRIMARY KEY (packageId)
                      );

INSERT INTO Package VALUES ('1s2fw1', 'Magic Bombs', 'BOOM BABY STEP BACK', 'starting locale', 'deadline date here', 'ending locale') ON CONFLICT DO NOTHING;
INSERT INTO Package VALUES ('1sfw1', 'Excalibur', 'The stronkest sword ever', 'starting locale', 'deadline date here', 'ending locale') ON CONFLICT DO NOTHING;

CREATE TABLE CompanyRelations (compId int,
                               userId int,
                               FOREIGN KEY (compId) REFERENCES Company(compId),
                               FOREIGN KEY (userId) REFERENCES Users(userId)
                              );

INSERT INTO CompanyRelations VALUES (-1, 1) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-2, 2) ON CONFLICT DO NOTHING;

CREATE TABLE PackageRelations (userId int,
                               packageId text,
                               FOREIGN KEY (userId) REFERENCES Users(userId),
                               FOREIGN KEY (packageId) REFERENCES Package(packageId)
                              );

INSERT INTO PackageRelations VALUES (1, '1s2fw1') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (2, '1sfw1') ON CONFLICT DO NOTHING;
