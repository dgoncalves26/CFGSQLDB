USE musicbank;

-- music analysis of database: 

-- artists top songs and total streams 
SELECT DISTINCT a.artist_id, a.artist_name, t.top_track_name, t.total_streams AS Streams FROM artist a
LEFT JOIN artist_topsong t
ON a.artist_id = t.artist_id
WHERE total_streams > 1000000;
 
-- artists second top song and total streams
SELECT DISTINCT a.artist_id, a.artist_name, s.second_track_name, s.streams AS Streams FROM artist a
LEFT OUTER JOIN artist_second_song s
ON a.artist_id = s.artist_id
WHERE streams > 1000000
AND a.artist_name LIKE "%I%";

-- total streams by artists in descending order 
SELECT DISTINCT a.artist_name, t.top_track_name, t.total_streams FROM artist a
INNER JOIN artist_topsong t
ON a.artist_id = t.artist_id
ORDER BY total_streams DESC
LIMIT 5;

-- artists and their genres
SELECT a.artist_id, a.artist_name, g.genre
FROM artist_genre g
JOIN artist a ON g.artist_id = a.artist_id;

-- artists and their chart positions on spotify and apple music
SELECT a.artist_id, a.artist_name, s.top_song_charts AS spotify_chart, s.second_song_charts AS spotify_second_chart,
       ac.top_song_charts AS apple_chart, ac.second_song_charts AS apple_second_chart
FROM spotify_charts s
JOIN apple_charts ac ON s.artist_id = ac.artist_id
JOIN artist a ON s.artist_id = a.artist_id;

CREATE VIEW all_artistinfo
AS
SELECT a.artist_id, a.artist_name, a.debut_album, t.top_track_name AS top_song, s.second_track_name AS second_song FROM artist a
LEFT JOIN artist_topsong t
ON a.artist_id = t.artist_id
INNER JOIN artist_second_song s
ON a.artist_id = s.artist_id;

SELECT DISTINCT * FROM all_artistinfo;

/*Create a view that uses at least 3-4 base tables; prepare and demonstrate a query that uses the view to produce a logically arranged result set for analysis.*/
CREATE VIEW spotify_artistcharts
AS
SELECT a.artist_id, a.artist_name, t.top_track_name AS top_track, m.top_song_charts AS top_song_charts FROM artist a
LEFT JOIN artist_topsong t
ON a.artist_id = t.artist_id
INNER JOIN spotify_charts m
ON a.artist_id = m.artist_id;

/*Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis*/
SELECT DISTINCT * FROM spotify_artistcharts;

SELECT DISTINCT artist_name, top_track, spotify_charts FROM spotify_artistcharts;

-- number of top tracks for each artist 
SELECT artist_id, artist_name, COUNT(top_track) AS total_top_tracks
FROM spotify_artistcharts
GROUP BY artist_id, artist_name;

-- avergae chart position for each artist 
SELECT artist_id, artist_name, AVG(top_song_charts) AS avg_chart_position
FROM spotify_artistcharts
GROUP BY artist_id, artist_name;

-- artist with highest number of top tracks
SELECT artist_id, artist_name, COUNT(top_track) AS total_top_tracks
FROM spotify_artistcharts
GROUP BY artist_id, artist_name
ORDER BY total_top_tracks DESC
LIMIT 1;

SELECT total_streams AS Category, COUNT(total_streams) AS Total_Streams
FROM artist_topsong
GROUP BY total_streams;

DELIMITER //

CREATE FUNCTION no_of_years(date1 DATE) RETURNS INT DETERMINISTIC
BEGIN
  DECLARE date2 DATE;
  SET date2 = CURRENT_DATE();
  RETURN YEAR(date2) - YEAR(date1);
END //

DELIMITER ;

SELECT artist_id, artist_name, no_of_years(debut_year) AS 'years' FROM artist;
