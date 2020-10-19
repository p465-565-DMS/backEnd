--Test data


INSERT INTO Company VALUES (-1, 'Presidential Shark Industries', 1, 'image.jpg', 'WE SHIP. BY SHARK.', '107 S Indiana Ave, Bloomington, IN 47405') ON CONFLICT DO NOTHING;
INSERT INTO Company VALUES (-2, 'Iniatoyo Shippers', 2, 'image.jpg', 'You shipped my father, prepare to ship services.', '107 S Indiana Ave, Bloomington, IN 47405') ON CONFLICT DO NOTHING;
INSERT INTO Company VALUES (-3, "V's Viral Shippers", 3, 'image.jpg', 'Contagiously good.', '107 S Indiana Ave, Bloomington, IN 47405') ON CONFLICT DO NOTHING;


INSERT INTO Users VALUES (1, 'Jared', 'Johnston', 'jajohn', 'hetillio123!', 3, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (2, 'Caraque', 'Sutton', 'carsut', 'Parambe$$1', 3, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (3, 'Vimmie', 'Vazques', 'vimvaz', 'Shrdlu123!', 3, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;

INSERT INTO Users VALUES (4, 'Harambe', 'Gorilla', 'hGorilla', 'Parambe$$1', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (5, 'Shaq', "O'Neil", 'tallMan', 'Shrdlu123!', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (6, 'Louie', 'Louie', 'lewi', 'Farview1', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (7, 'Hashada', 'Huie', 'hashuei', 'Shrdlu123!', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (8, 'Nadia', 'Harmone', 'naharm', 'Parambe$$1', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (9, 'Bandi', 'Brue', 'banBrue', 'Shrdlu123!', 2, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;

--These users are customers
INSERT INTO Users VALUES (10, 'Lucas', 'Lapelle', 'llapelle', 'Parambe$$1', 4, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;
INSERT INTO Users VALUES (11, 'Shapar', 'Kudrick', 'shapkud', 'wwww$$1', 4, '500 S Park Ridge Rd, Bloomington, IN 47401') ON CONFLICT DO NOTHING;


INSERT INTO Package VALUES ('00001', 'Shark Fin Soup', 'These shark fins are grown from premium shark fin trees, and is 100% humane', '
502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408') ON CONFLICT DO NOTHING;
INSERT INTO Package VALUES ('00002', 'Ghost Grenades', 'These grenades are 100% effective against ghosts, guarenteed.', '
502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408') ON CONFLICT DO NOTHING;
INSERT INTO Package VALUES ('00003', 'Excalibur', 'Can only be delivered by the king.', '
502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408') ON CONFLICT DO NOTHING;
INSERT INTO Package VALUES ('00004', 'Gun', 'Get rid of your competition with this convienent weapon. Usable in almost any scenario!', '
502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408') ON CONFLICT DO NOTHING;
INSERT INTO Package VALUES ('00005', 'Magic Karate Belt', 'Wear this belt and magically gain karate powers rivaling any Bruce Lee baddie.', '
502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408') ON CONFLICT DO NOTHING;
INSERT INTO Package VALUES ('00006', 'Shark Fin Soup', 'These shark fins are grown from premium shark fin trees, and is 100% humane', '
502 E Kirkwood Ave', '10/11/2021', '430 E Kirkwood Ave # 18, Bloomington, IN 47408') ON CONFLICT DO NOTHING;


INSERT INTO CompanyRelations VALUES (-1,1) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-1,4) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-1,5) ON CONFLICT DO NOTHING;

INSERT INTO CompanyRelations VALUES (-2,2) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-2,6) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-2,7) ON CONFLICT DO NOTHING;

INSERT INTO CompanyRelations VALUES (-3,3) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-3,8) ON CONFLICT DO NOTHING;
INSERT INTO CompanyRelations VALUES (-3,9) ON CONFLICT DO NOTHING;


INSERT INTO PackageRelations VALUES (4, '00001') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (5, '00002') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (6, '00003') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (7, '00004') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (8, '00005') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (9, '00006') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (4, '00007') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (5, '00008') ON CONFLICT DO NOTHING;
INSERT INTO PackageRelations VALUES (6, '00009') ON CONFLICT DO NOTHING;


INSERT INTO CustomerToPackage VALUES (10, '00001') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (11, '00002') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (10, '00003') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (11, '00004') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (10, '00005') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (11, '00006') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (10, '00007') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (11, '00008') ON CONFLICT DO NOTHING;
INSERT INTO CustomerToPackage VALUES (10, '00009') ON CONFLICT DO NOTHING;
