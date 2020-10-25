CREATE DATABASE hermes;
\c hermes;

CREATE TABLE IF NOT EXISTS Company (compId SERIAL,
                                    compName text,
                                    creatorId int,
                                    logo text,
                                    description text,
                                    address text,
                                    PRIMARY KEY (compId)
                                  );
  INSERT INTO Company (compName, creatorId, logo, description, address) VALUES ('Presidential Shark Industries', 1, 'image.jpg', 'WE SHIP. BY SHARK.', '107 S Indiana Ave, Bloomington, IN 47405') ON CONFLICT DO NOTHING;
  INSERT INTO Company (compName, creatorId, logo, description, address) VALUES ('Iniatoyo Shippers', 2, 'image.jpg', 'You shipped my father, prepare to ship services.', '107 S Indiana Ave, Bloomington, IN 47405') ON CONFLICT DO NOTHING;
  INSERT INTO Company (compName, creatorId, logo, description, address) VALUES ('Vees Viral Shippers', 3, 'image.jpg', 'Contagiously good.', '107 S Indiana Ave, Bloomington, IN 47405') ON CONFLICT DO NOTHING;


CREATE TABLE Users (userId SERIAL,
                   fname text,
                   lName text,
                   userName text,
                   userPassword text,
                   roleId int,
                   address text,
                   PRIMARY KEY (userId)
                 );
   --These users are admins
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Jared', 'Johnston', 'jajohn', 'hetillio123!', 3, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Caraque', 'Sutton', 'carsut', 'Parambe$$1', 3, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Vimmie', 'Vazques', 'vimvaz', 'Shrdlu123!', 3, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   --These users are drivers
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Harambe', 'Gorilla', 'hGorilla', 'Parambe$$1', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Shaq', 'O-Neil', 'tallMan', 'Shrdlu123!', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Louie', 'Louie', 'lewi', 'Farview1', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Hashada', 'Huie', 'hashuei', 'Shrdlu123!', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Nadia', 'Harmone', 'naharm', 'Parambe$$1', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Bandi', 'Brue', 'banBrue', 'Shrdlu123!', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   --These users are customers
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Lucas', 'Lapelle', 'llapelle', 'Parambe$$1', 4, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
   INSERT INTO Users (fname, lName, userName, userPassword, roleId, address) VALUES ('Shapar', 'Kudrick', 'shapkud', 'wwww$$1', 4, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;


CREATE TABLE Package (packageId SERIAL,
                      packageTitle text,
                      packageDescription text,
                      packageSLocation text,
                      deadline text,
                      packageELocation text,
                      packageDeliveryStatus text,
                      packageWeight int,
                      packageSize int,
                      speedOfDelivery int,
                      rate int,
                      currentLocation text,
                      PRIMARY KEY (packageId)
                      );


  INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus, packageWeight,
                      packageSize, speedOfDelivery, rate, currentLocation) VALUES ('Shark Fin Soup', 'These shark fins are grown from premium shark fin trees, and is 100% humane', '
                      502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408', 'UNSHIPPED', 15, 33, 2, 4, 'Broadersfield, NH') ON CONFLICT DO NOTHING;
  INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus, packageWeight,
                      packageSize, speedOfDelivery, rate, currentLocation) VALUES ('Ghost Grenades', 'These grenades are 100% effective against ghosts, guarenteed.', '
                      502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408', 'UNSHIPPED', 0, 0, 2, 4, 'Broadersfield, NH') ON CONFLICT DO NOTHING;
  INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus, packageWeight,
                      packageSize, speedOfDelivery, rate, currentLocation) VALUES ('Excalibur', 'Can only be delivered by the king.', '
                      502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408','IN TRANSIT', 80, 20, 4, 4, 'Portsmouth, NH') ON CONFLICT DO NOTHING;
  INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus, packageWeight,
                      packageSize, speedOfDelivery, rate, currentLocation) VALUES ('Gun', 'Get rid of your competition with this convienent weapon. Usable in almost any scenario!', '
                      502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408', 'IN TRANSIT',  4, 4, 1, 1, 'Broadersfield, NH') ON CONFLICT DO NOTHING;
  INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus, packageWeight,
                      packageSize, speedOfDelivery, rate, currentLocation) VALUES ('Magic Karate Belt', 'Wear this belt and magically gain karate powers rivaling any Bruce Lee baddie.', '
                      502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408', 'DELIVERED',  1, 1, 1, 2, 'Broadersfield, NH') ON CONFLICT DO NOTHING;
  INSERT INTO Package (packageTitle, packageDescription, packageSLocation, deadline, packageELocation, packageDeliveryStatus, packageWeight,
                      packageSize, speedOfDelivery, rate, currentLocation) VALUES ('Shark Fin Soup', 'These shark fins are grown from premium shark fin trees, and is 100% humane', '
                      502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408', 'DELIVERED', 20, 10, 5, 4, 'Boston, MA') ON CONFLICT DO NOTHING;


CREATE TABLE CompanyRelations (compId int,
                               userId int,
                               FOREIGN KEY (compId) REFERENCES Company(compId),
                               FOREIGN KEY (userId) REFERENCES Users(userId)
                              );
  INSERT INTO CompanyRelations VALUES (1,1) ON CONFLICT DO NOTHING;
  INSERT INTO CompanyRelations VALUES (1,4) ON CONFLICT DO NOTHING;
  INSERT INTO CompanyRelations VALUES (1,5) ON CONFLICT DO NOTHING;

  INSERT INTO CompanyRelations VALUES (2,2) ON CONFLICT DO NOTHING;
  INSERT INTO CompanyRelations VALUES (2,6) ON CONFLICT DO NOTHING;
  INSERT INTO CompanyRelations VALUES (2,7) ON CONFLICT DO NOTHING;

  INSERT INTO CompanyRelations VALUES (3,3) ON CONFLICT DO NOTHING;
  INSERT INTO CompanyRelations VALUES (3,8) ON CONFLICT DO NOTHING;
  INSERT INTO CompanyRelations VALUES (3,9) ON CONFLICT DO NOTHING;



CREATE TABLE PackageRelations (userId int,
                               packageId int,
                               FOREIGN KEY (userId) REFERENCES Users(userId),
                               FOREIGN KEY (packageId) REFERENCES Package(packageId)
                              );
  INSERT INTO PackageRelations VALUES (4, 1) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (5, 2) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (6, 3) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (7, 4) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (8, 5) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (9, 6) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (4, 1) ON CONFLICT DO NOTHING;
  INSERT INTO PackageRelations VALUES (5, 4) ON CONFLICT DO NOTHING;

CREATE TABLE CustomerToPackage(userId int,
                               packageId int,
                               FOREIGN KEY (userId) REFERENCES Users(userId),
                               FOREIGN KEY (packageId) REFERENCES Package(packageId)
                              );
  INSERT INTO CustomerToPackage VALUES (10, 1) ON CONFLICT DO NOTHING;
  INSERT INTO CustomerToPackage VALUES (11, 2) ON CONFLICT DO NOTHING;
  INSERT INTO CustomerToPackage VALUES (10, 3) ON CONFLICT DO NOTHING;
  INSERT INTO CustomerToPackage VALUES (11, 4) ON CONFLICT DO NOTHING;
  INSERT INTO CustomerToPackage VALUES (10, 5) ON CONFLICT DO NOTHING;
  INSERT INTO CustomerToPackage VALUES (11, 6) ON CONFLICT DO NOTHING;
