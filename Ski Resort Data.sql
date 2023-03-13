-- set safe update mode, autocommit and local_infile 
SET SQL_SAFE_UPDATES = 0;
SET GLOBAL local_infile = 1;
SET autocommit = 0; 

-- importing csv data files 
load data local infile '/Users/marcusogata/Desktop/Ski Resorts Data/snow.csv' into table snow fields terminated by ',' ignore 1 rows;   
load data local infile '/Users/marcusogata/Desktop/Ski Resorts Data/resorts.csv' into table resorts fields terminated by ',' ignore 1 rows;

-- delete duplicates

CREATE TABLE resorts1 LIKE resorts;

INSERT INTO resorts1
    SELECT DISTINCT * FROM resorts;

DROP TABLE resorts;

RENAME TABLE resorts1 TO resorts;

-- remove '?' in Resort names
SELECT 
    COUNT(DISTINCT ID) total_errors
FROM resorts
WHERE Resort LIKE '%?%';

SELECT *
FROM resorts
WHERE Resort LIKE '%?%';

UPDATE resorts
	SET Resort = REPLACE(Resort, '-?', '/')
WHERE Resort LIKE '%-?%';

UPDATE resorts
	SET Resort = REPLACE(Resort, '/?', '/')
WHERE Resort LIKE '%/?%';

UPDATE resorts
	SET Resort = REPLACE(Resort, 'e?es', 'ées')
WHERE Resort LIKE '%e?es%';

UPDATE resorts
	SET Resort = REPLACE(Resort, '?', '')
WHERE Resort LIKE '?%';

UPDATE resorts
	SET Resort = REPLACE(Resort, 'a?', 'å')
WHERE ID = 482;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'a?', 'á')
WHERE ID IN (8, 485);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'a?', 'ä')
WHERE ID IN (219, 304, 371, 398, 412, 431, 494);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'c?', 'ç')
WHERE ID IN (159, 171);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'e?', 'é')
WHERE ID IN (69, 149, 189, 256, 336, 351, 381, 389, 459, 484);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'e?', 'è')
WHERE ID IN (78, 153, 182, 188, 190, 224, 297, 334, 386);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'e?', 'ê')
WHERE ID IN (158, 379);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'e?', 'ë')
WHERE ID = 152;

UPDATE resorts
    SET Resort = REPLACE(Resort, 'g?' , 'ğ')
WHERE ID = 349;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'i?', 'í')
WHERE ID = 80;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'n?', 'ñ')
WHERE ID = 322;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'o?', 'ö')
WHERE ID IN (107, 161, 205, 220, 307, 318, 368, 369, 403, 409, 426, 453, 472, 493);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'o?', 'ô')
WHERE ID = 359;

UPDATE resorts
	SET Resort = REPLACE(Resort, 's?', 'ș')
WHERE ID = 408;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'u?', 'ü')
WHERE ID IN (113, 236, 309, 325, 418, 440, 452, 465);

UPDATE resorts
	SET Resort = REPLACE(Resort, 'u?', 'ú')
WHERE ID IN (338, 378);

UPDATE resorts
	SET Resort = 'Brauneck - Lenggries/​Wegscheid'
WHERE ID = 14;

UPDATE resorts
	SET Resort = 'Madonna di Campiglio/​Pinzolo/​Folgàrida/​Marilleva'
WHERE ID = 34;

UPDATE resorts
	SET Resort = CONCAT("Tignes - Val d","'Isère")
WHERE ID = 57;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'Cha?tel', 'Châtel')
WHERE ID = 62;

UPDATE resorts
	SET Resort = 'Serre Chevalier–Briançon/​Chantemerle/​Villeneuve-la-Salle/​Le Monêtier-les-Bains'
WHERE ID = 75;

UPDATE resorts
	SET Resort = 'Kleine Scheidegg/​Männlichen–Grindelwald/​Wengen'
WHERE ID = 76;

UPDATE resorts
	SET Resort = 'Hochkönig–Maria Alm/​Dienten/​Mühlbach'
WHERE ID = 102;

UPDATE resorts 
	SET Resort = REPLACE(Resort, 'Z r', 'Zür')
WHERE ID = 120;

UPDATE resorts
	SET Resort = 'Courmayeur - Chécrouit / Val Veny'
WHERE ID = 124;

UPDATE resorts
	SET Resort = REPLACE(Resort, '?', '-')
WHERE ID = 132;

UPDATE resorts
	SET Resort = CONCAT("Les Sybelles-Le Corbier/La Toussuire/Les Bottières/St Colomban des Villards/St Sorlin/St Jean d","'Arves")
WHERE ID = 151;

UPDATE resorts
	SET Resort = 'Auron (Saint-Etienne-de-Tinée)'
WHERE ID = 164;

UPDATE resorts
	SET Resort = 'Kaltenbach – Hochzillertal/​Hochfügen (SKi-optimal)'
WHERE ID = 228;

UPDATE resorts
	SET Resort = 'Mont-Sainte-Anne(Beaupré)'
WHERE ID = 260;

UPDATE resorts
	SET Resort = 'Ponte di Legno/​Tonale/​Presena Glacier/​Temù (Pontedilegno-Tonale)'
WHERE ID = 294;

UPDATE resorts
	SET Resort = 'Font-Romeu/​Bolquère Pyrénées 2000'
WHERE ID = 299;

UPDATE resorts
	SET Resort = 'Le Brévent/La Flégère(Chamonix)'
WHERE ID = 301;

UPDATE resorts
	SET Resort = 'Lindvallen/​Högfjället (Sälen)'
WHERE ID = 341;

UPDATE resorts
	SET Resort = 'Jasná Nízke Tatry-Chopok'
WHERE ID = 342;

UPDATE resorts
	SET Resort = 'Tandådalen/​Hundfjället (Sälen)'
WHERE ID = 344;

UPDATE resorts
	SET Resort = 'Špindlerův Mlýn'
WHERE ID = 380;

UPDATE resorts
	SET Resort = 'Špičák'
WHERE ID = 420;

UPDATE resorts
	SET Resort = 'Bürchen/​Törbel – Moosalp'
WHERE ID = 446;

UPDATE resorts
	SET Resort = 'Białka Tatrzańska – Kotelnica/​Kaniówka/​Bania'
WHERE ID = 454;

UPDATE resorts
	SET Resort = 'Štrbské Pleso'
WHERE ID = 455;

UPDATE resorts
	SET Resort = 'Kubínska hoľa'
WHERE ID = 480;
    
-- fixing characters in names
UPDATE resorts
SET Resort = REPLACE(Resort, 'amedE', 'amadè')
WHERE Resort LIKE '%amedE%';

UPDATE resorts
SET Resort = REPLACE(Resort, 'La RosiEre', 'La Rosière')
WHERE Resort LIKE '%La RosiEre%';

UPDATE resorts
SET Resort = REPLACE(Resort, ' n ', ' in ')
WHERE ID IN (20,31,41,85);

UPDATE resorts
SET Resort = REPLACE(Resort, ' n ', '-')
WHERE ID IN (33);

-- fixing parenthases

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Halblech-', '(Halblech)')
WHERE ID = 147;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Vallnord-', '(Vallnord)')
WHERE ID = 275;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Seiser Alm-', '(Seiser Alm)')
WHERE ID = 285;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Anniviers-', '(Anniviers)')
WHERE ID = 287;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Chamonix-', '(Chamonix)')
WHERE ID = 303;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Mt. Naeba-', '(Mt. Naeba)')
WHERE ID = 343;

UPDATE resorts 
	SET Resort = 'Gazprom Mountain Resort (Laura) in Esto-Sadok(Sotschi)'
WHERE ID = 346;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Taninges/Mieussy-', '(Taninges/Mieussy)')
WHERE ID = 357;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Mt. Naeba-', '(Mt. Naeba)')
WHERE ID = 361;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Ejder 3200 World Ski Center-', '(Ejder 3200 World Ski Center)')
WHERE ID = 369;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Kerns-', '(Kerns)')
WHERE ID = 377;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Beaufort-', '(Beaufort)')
WHERE ID = 379;

UPDATE resorts
	SET Resort = REPLACE(Resort, 'P', 'p')
WHERE ID = 384;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Eaux Bonnes-', '(Eaux Bonnes)')
WHERE ID = 393;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Mölltaler Gletscher-', '(Mölltaler Gletscher)')
WHERE ID = 403;

UPDATE resorts 
	SET Resort = REPLACE(Resort, "-Solda all'Ortles-", "(Solda all'Ortles)")
WHERE ID = 406;

UPDATE resorts 
	SET Resort = REPLACE(Resort, "-Pitztaler Gletscher-", "(Pitztaler Gletscher)")
WHERE ID = 414;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Moos in Passeier-', '(Moos in Passeier)')
WHERE ID = 432;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Park Snow-', '(Park Snow)')
WHERE ID = 437;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Rettenberg-', '(Rettenberg)')
WHERE ID = 440;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Skiwelt-', '(Skiwelt)')
WHERE ID = 453;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Chimbulak-', '(Chimbulak)')
WHERE ID = 467;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-WA-', '(WA)')
WHERE ID = 471;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Passo Oclini-', '(Passo Oclini)')
WHERE ID = 476;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Ruhpolding-', '(Ruhpolding)')
WHERE ID = 478;

UPDATE resorts 
	SET Resort = 'Mitterdorf (Almberg) – Mitterfirmiansreut'
WHERE ID = 433;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Bad Hindelang-n', '(Bad Hindelang) -')
WHERE ID = 492;

UPDATE resorts 
	SET Resort = REPLACE(Resort, '-Wettersteinbahnen-n', '(Wettersteinbahnen)')
WHERE ID = 497;

-- update Season information
UPDATE resorts
	SET Season = REPLACE(Season, 'Unknown', 'November - April')
WHERE ID IN (368, 412, 467);

UPDATE resorts
	SET Season = REPLACE(Season, 'Unknown', 'November - May')
WHERE ID IN (415);

UPDATE resorts
	SET Season = REPLACE(Season, 'Unknown', 'December - April')
WHERE ID IN (124, 182, 234, 300, 345, 358, 360, 378, 391, 399, 411, 437, 439, 495);

UPDATE resorts
	SET Season = REPLACE(Season, 'Unknown', 'December - March')
WHERE ID IN (242, 314, 316, 349, 350, 351, 402, 457, 459);

-- update price
UPDATE resorts
	SET Price = REPLACE(Price, '0', '135')
WHERE ID = 196;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '22')
WHERE ID = 349;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '45')
WHERE ID = 335;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '16')
WHERE ID = 369;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '65')
WHERE ID = 387;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '38')
WHERE ID = 390;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '35')
WHERE ID = 475;

UPDATE resorts
	SET Price = REPLACE(Price, '0', '28')
WHERE ID = 495;

SELECT * FROM resorts;
























