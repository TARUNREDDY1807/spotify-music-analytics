-- Test PostgreSQL connection
SELECT version();

-- Create the Spotify table matching the CSV structure
CREATE TABLE top_50_world (
    date DATE,
    position INTEGER,
    song TEXT,
    artist TEXT,
    popularity INTEGER,
    duration_ms BIGINT,
    album_type TEXT,
    total_tracks INTEGER,
    release_date DATE,
    is_explicit BOOLEAN,
    album_cover_url TEXT
);

-- Spotify Music Analytics SQL Analysis


-- View Spotify data
SELECT *
FROM top_50_world
LIMIT 10;


-- Count total records
SELECT COUNT(*) AS total_records
FROM top_50_world;


-- Count distinct songs
SELECT COUNT(DISTINCT song) AS distinct_songs
FROM top_50_world;


-- Count distinct artists
SELECT COUNT(DISTINCT artist) AS distinct_artists
FROM top_50_world;


-- Calculate average popularity
SELECT ROUND(AVG(popularity), 2) AS average_popularity
FROM top_50_world;


-- Find maximum popularity
SELECT MAX(popularity) AS maximum_popularity
FROM top_50_world;


-- Find minimum popularity
SELECT MIN(popularity) AS minimum_popularity
FROM top_50_world;


-- Find top 10 artists by number of records
SELECT
    artist,
    COUNT(*) AS song_count
FROM top_50_world
GROUP BY artist
ORDER BY song_count DESC
LIMIT 10;


-- Find top 10 most popular songs
SELECT
    song,
    artist,
    popularity
FROM top_50_world
ORDER BY popularity DESC
LIMIT 10;


-- Calculate average popularity by artist
SELECT
    artist,
    ROUND(AVG(popularity), 2) AS average_popularity
FROM top_50_world
GROUP BY artist
ORDER BY average_popularity DESC
LIMIT 10;


-- Analyze album type distribution
SELECT
    album_type,
    COUNT(*) AS song_count
FROM top_50_world
GROUP BY album_type
ORDER BY song_count DESC;


-- Calculate average popularity by album type
SELECT
    album_type,
    ROUND(AVG(popularity), 2) AS average_popularity
FROM top_50_world
GROUP BY album_type
ORDER BY average_popularity DESC;


-- Analyze explicit and non-explicit songs
SELECT
    is_explicit,
    COUNT(*) AS song_count
FROM top_50_world
GROUP BY is_explicit
ORDER BY song_count DESC;


-- Compare popularity of explicit and non-explicit songs
SELECT
    is_explicit,
    ROUND(AVG(popularity), 2) AS average_popularity
FROM top_50_world
GROUP BY is_explicit
ORDER BY average_popularity DESC;


-- Calculate average song duration in minutes
SELECT
    ROUND(AVG(duration_ms) / 60000.0, 2) AS average_duration_minutes
FROM top_50_world;


-- Find the 10 longest songs
SELECT
    song,
    artist,
    ROUND(duration_ms / 60000.0, 2) AS duration_minutes
FROM top_50_world
ORDER BY duration_ms DESC
LIMIT 10;


-- Find the 10 shortest songs
SELECT
    song,
    artist,
    ROUND(duration_ms / 60000.0, 2) AS duration_minutes
FROM top_50_world
ORDER BY duration_ms ASC
LIMIT 10;


-- Find artists with more than 10 records
SELECT
    artist,
    COUNT(*) AS song_count
FROM top_50_world
GROUP BY artist
HAVING COUNT(*) > 10
ORDER BY song_count DESC;


-- Find songs above average popularity
SELECT
    song,
    artist,
    popularity
FROM top_50_world
WHERE popularity > (
    SELECT AVG(popularity)
    FROM top_50_world
)
ORDER BY popularity DESC;


-- Rank songs by popularity
SELECT
    song,
    artist,
    popularity,
    RANK() OVER (
        ORDER BY popularity DESC
    ) AS popularity_rank
FROM top_50_world
ORDER BY popularity_rank
LIMIT 20;


-- Rank artists by average popularity
SELECT
    artist,
    ROUND(AVG(popularity), 2) AS average_popularity,
    RANK() OVER (
        ORDER BY AVG(popularity) DESC
    ) AS artist_rank
FROM top_50_world
GROUP BY artist
ORDER BY artist_rank
LIMIT 20;


-- Compare album types by popularity and duration
SELECT
    album_type,
    COUNT(*) AS song_count,
    ROUND(AVG(popularity), 2) AS average_popularity,
    ROUND(AVG(duration_ms) / 60000.0, 2) AS average_duration_minutes
FROM top_50_world
GROUP BY album_type
ORDER BY average_popularity DESC;


-- Final Spotify project summary
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT song) AS distinct_songs,
    COUNT(DISTINCT artist) AS distinct_artists,
    ROUND(AVG(popularity), 2) AS average_popularity,
    ROUND(AVG(duration_ms) / 60000.0, 2) AS average_duration_minutes
FROM top_50_world;