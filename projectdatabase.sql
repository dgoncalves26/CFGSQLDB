CREATE DATABASE MUSICBANK;

USE MUSICBANK;

CREATE TABLE artist(
artist_ID INT,
artist_name VARCHAR(50),
debut_year DATE,
PRIMARY KEY (artist_ID)
);

INSERT INTO artist(artist_ID,artist_name,debut_year)
VALUES
(1000,"Jungkook Jeon",'2013-01-01'),
(1001,"Miley Cyrus",'2007-01-01'),
(1002,"Jimin Park",'2013-01-01'),
(1003,"Post Malone",'2011-01-01'),
(1004,"Dave",'2019-01-01'),
(1005,"Bad Bunny",'2018-01-01'),
(1006,"New Jeans",'2022-01-01'),
(1007,"J Cole",'2011-01-01'),
(1008,"Taylor Swift",'2006-01-01'),
(1009,"Drake",'2010-01-01');

SELECT * FROM artist;

ALTER TABLE artist ADD COLUMN debut_album VARCHAR(50) AFTER debut_year;

UPDATE artist SET debut_album = "Golden" WHERE artist_id = 1000;
UPDATE artist SET debut_album = "Meet Miley Cyrus" WHERE artist_id = 1001;
UPDATE artist SET debut_album = "Face" WHERE artist_id = 1002;
UPDATE artist SET debut_album = "Stoney" WHERE artist_id = 1003;
UPDATE artist SET debut_album = "Psychodrama" WHERE artist_id = 1004;
UPDATE artist SET debut_album = "X 100pre" WHERE artist_id = 1005;
UPDATE artist SET debut_album = "New Jeans" WHERE artist_id = 1006;
UPDATE artist SET debut_album = "The Come Up" WHERE artist_id = 1007;
UPDATE artist SET debut_album = "Taylor Swift" WHERE artist_id = 1008;
UPDATE artist SET debut_album = "Thank Me Later" WHERE artist_id = 1009;

SELECT * FROM artist;

CREATE TABLE artist_topsong(
artist_ID INT,
top_track_name VARCHAR(50),
total_streams BIGINT,
release_year INT,
CONSTRAINT FK_artist_id FOREIGN KEY (artist_ID)
    REFERENCES artist(artist_ID)
);

INSERT INTO artist_topsong(artist_id,top_track_name,total_streams,release_year)
VALUES
(1000,"Seven",141381703,2023),
(1001,"Flowers",131685571,2023),
(1002,"Like Crazy",363369738,2023),
(1003,"Sunflower",280809655,2018),
(1004,"Sprinter",183706234,2023),
(1005,"WHERE SHE GOES",303236322,2023),
(1006,"Super Shy",58255150,2023),
(1007,"All My Life",144565150,2023),
(1008,"Cruel Summer",800840817,2019),
(1009,"Jimmy Cooks",618885532,2022);

SELECT * FROM artist_topsong;

CREATE TABLE artist_second_song(
artist_ID INT,
second_track_name VARCHAR(50),
streams BIGINT,
released INT,
CONSTRAINT FK_artist_id2 FOREIGN KEY (artist_ID)
    REFERENCES artist(artist_ID)
);

INSERT INTO artist_second_song(artist_id,second_track_name,streams,released)
VALUES
(1000,"Still With You",38411956,2020),
(1001,"Angels Like You",570515054,2020),
(1002,"Set Me Free Pt 2",168448603,2023),
(1003,"Overdrive",14780425,2023),
(1004,"Starlight",229473310,2022),
(1005,"un x100to",505671438,2023),
(1006,"New Jeans",29562220,2023),
(1007,"No Role Modelz",1791000570,2014),
(1008,"I Can See You",52135248,2023),
(1009,"One Dance",2713922350,2016);

SELECT * FROM artist_second_song;

CREATE TABLE artist_genre(
  artist_ID INT NOT NULL,
  genre VARCHAR(50),
  CONSTRAINT FK_artist_id3 FOREIGN KEY (artist_ID)
    REFERENCES artist(artist_ID)
);

INSERT INTO artist_genre(artist_id, genre)
VALUES
(1000,"Pop"),
(1001,"Pop"),
(1002,"Pop"),
(1003,"Pop"),
(1004,"Rap"),
(1005,"Pop"),
(1006,"Pop"),
(1007,"Rap"),
(1008,"Pop"),
(1009,"RnB");

SELECT * FROM artist_genre
WHERE genre = "Rap";  

DROP TABLE artist_genre;             

CREATE TABLE spotify_charts(
  artist_ID INT NOT NULL,
  top_song_charts INT NOT NULL,
  second_song_charts INT NOT NULL,
  CONSTRAINT FK_artist_id4 FOREIGN KEY (artist_ID)
    REFERENCES artist(artist_ID)
);

INSERT INTO spotify_charts(artist_id, top_song_charts, second_song_charts)
VALUES
(1000,147,39),
(1001,115,19),
(1002,68,13),
(1003,78,36),
(1004,91,3),
(1005,50,40),
(1006,55,35),
(1007,23,36),
(1008,100,38),
(1009,27,24);

SELECT * FROM spotify_charts;

CREATE TABLE apple_charts(
  artist_ID INT NOT NULL,
  top_song_charts INT NOT NULL,
  second_song_charts INT NOT NULL,
  CONSTRAINT FK_artist_id5 FOREIGN KEY (artist_ID)
    REFERENCES artist(artist_ID)
);

INSERT INTO apple_charts(artist_id,top_song_charts,second_song_charts)
VALUES
(1000,263,107),
(1001,215,48),
(1002,104,71),
(1003,117,32),
(1004,213,40),
(1005,133,205),
(1006,202,166),
(1007,145,65),
(1008,207,119),
(1009,121,107);

SELECT * FROM apple_charts;