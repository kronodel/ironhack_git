/*
-- Looking for the report :
SELECT *

FROM crime_scene_report
where date = 20180115 AND type = 'murder' AND city = 'SQL City';

Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave".

-- Looking for the witnesses indentity :
SELECT person.*
FROM person
WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave';

SELECT person.*, highest_address_number
FROM person
JOIN (SELECT MAX(address_number) as highest_address_number
      FROM person
      WHERE address_street_name = 'Northwestern Dr') highest_address
ON person.address_number = highest_address.highest_address_number;

-- Looking for the interviews :

SELECT * 
FROM interview
WHERE person_id = 14887;

person_id	transcript
14887	I heard a gunshot and then saw a man run out. 
He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. 
The man got into a car with a plate that included "H42W".


person_id	transcript
16371	I saw the murder happen, and I recognized the killer from my gym when 
I was working out last week on January the 9th.

-- Looking for the killer's membership_id :

SELECT * FROM get_fit_now_check_in
WHERE membership_id LIKE '%48Z%'
AND CAST(check_in_date AS VARCHAR) LIKE '%0109%'

-- Looking for the killer in get_fit_now_member:

SELECT * FROM get_fit_now_member
WHERE id = '48Z7A' OR id = '48Z55'
;

-- Looking for the ids from person :

SELECT * 
FROM person
WHERE name = 'Jeremy Bowers'
OR name ='Joe Germuska';

-- Looking for the killer's identity by matching his car's plate_number :
SELECT * 
FROM drivers_license
WHERE plate_number LIKE '%H42W%' AND (id = 423327 OR id = 173289);

-- The murderer is Jeremy Bowers !

-- murderer's interview : 
SELECT * 
FROM interview
WHERE person_id = 67318;

-- Looking for the villain's driver's licence id
SELECT * 
FROM drivers_license
WHERE car_make = 'Tesla' 
AND car_model = 'Model S'
AND hair_color = 'red'
AND gender = 'female'
;
-- Looking for the villain's id

SELECT * 
FROM person
WHERE license_id = 202298
OR license_id = 291182
OR license_id = 918773
;

-- Looking for the villain's id

SELECT * 
FROM income
WHERE ssn = 961388910
OR ssn = 337169072
OR ssn = 987756388
;

*/

-- Looking for the villain's id

SELECT * 
FROM facebook_event_checkin
WHERE event_name LIKE '%SQL%'
AND CAST(date AS VARCHAR) LIKE '%2017%'
AND (person_id = 99716 OR person_id = 78881 OR person_id = 90700)
;

-- It's Miranda Priestly !





