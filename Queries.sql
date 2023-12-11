/* Query 1 */

SELECT staff_id AS "ID", CONCAT(staff_fname, ' ', staff_lname) AS "Staff Members", 
FROM staff_details
JOIN boatyard_details ON staff_details.boatyard_id = boatyard_details.boatyard_id
WHERE boatyard_details.boatyard_name = 'Blue Bill Park';