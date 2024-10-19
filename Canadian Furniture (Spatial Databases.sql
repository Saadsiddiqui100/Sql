	SELECT
    t1.name AS id1,
    t2.name AS id2,
    ST_Distance(t1.wkb_geometry, t2.wkb_geometry) AS distance
FROM
    stationsinire t1
JOIN
    stationsinire t2 
	ON t1.name <> t2.name;



----------------
		
with cte_updates as(
		SELECT
		t1.osm_id,
		ST_Distance(ST_Transform(t1.wkb_geometry, 4326), ST_Transform(t2.wkb_geometry, 4326)) AS distance
	FROM
		industrialbuildings t1
	CROSS JOIN
		stationsinire t2

)

update industrialbuildings 
set distancefromstation = cte_updates.distance
from cte_updates
where industrialbuildings.osm_id = cte_updates.osm_id

	

-----------------------

SELECT
    t1.name AS IRE,
    t2.name AS CAD ,
       ST_Distance(ST_Transform(t1.wkb_geometry, 4326), ST_Transform(t2.wkb_geometry, 4326)) AS distance
FROM
    irelandports t1
CROSS JOIN
    portsofcanada t2
	ORDER BY
    distance;
	
	
------------------	
	

SELECT
    t1.name AS IRE,
    t2.name AS CAD,
    ST_DistanceSphere(ST_Transform(t1.wkb_geometry, 4326), ST_Transform(t2.wkb_geometry, 4326)) / 1000 AS distance_km
FROM
    irelandports t1
CROSS JOIN
    portsofcanada t2
WHERE
    t2.name = 'St. John''s'
ORDER BY
    distance_km;
	
	
	---------
	
SELECT
    t1.name AS port,
    t2.name AS tra ,
       ST_Distance(ST_Transform(t1.wkb_geometry, 4326), ST_Transform(t2.wkb_geometry, 4326)) AS distance
FROM
    industrialbuildings t1
CROSS JOIN
    stationsinire t2
	where t2.name = 'Kent Station (Cork)'
	ORDER BY
    distance;
	
	
	




