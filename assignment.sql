-- Questions:


-- How many tracks does each album have? Your solution should include Album id and its number of tracks sorted from highest to lowest.

SELECT AlbumId, COUNT(AlbumId) 
FROM tracks
GROUP BY AlbumId
ORDER BY COUNT(AlbumId) DESC;



-- Find the album title of the tracks. Your solution should include track name and its album title.
SELECT  tracks.Name, albums.Title
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId;


-- Find the minimum duration of the track in each album. Your solution should include album id, album title and duration of the track sorted from highest to lowest.

SELECT  tracks.AlbumId, albums.Title,
MIN(tracks.Milliseconds) AS min_duration
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY tracks.AlbumId
ORDER BY min_duration DESC;

-- Find the total duration of each album. Your solution should include album id, album title and its total duration sorted from highest to lowest.

SELECT  tracks.AlbumId, albums.Title,
SUM(tracks.Milliseconds) AS Sum_duration
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY tracks.AlbumId
ORDER BY Sum_duration DESC;

-- Based on the previous question, find the albums whose total duration is higher than 70 minutes. Your solution should include album title and total duration.

SELECT  tracks.AlbumId, albums.Title,
SUM(tracks.Milliseconds) AS Sum_duration
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY tracks.AlbumId
HAVING Sum_duration> 4200000;









