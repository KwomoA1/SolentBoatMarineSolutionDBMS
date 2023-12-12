/* Query 1 */

/* Query is designed so that the manager or HR can retrieve the names 
and IDs of all staff on their site, this could be useful for human 
resource management tasks */

SELECT staff_id AS "ID", CONCAT(staff_fname, ' ', staff_lname) AS "Staff Members" 
FROM staff_details
JOIN boatyard_details ON staff_details.boatyard_id = boatyard_details.boatyard_id
WHERE boatyard_details.boatyard_name = 'Blue Bill Park';

/* Query 2 */

/* Query 2 is designed so that managers can list all scheduled tasks in the future,
this can help with scheduling and procurement */

SELECT booking_id AS "Booking ID", boat_name AS "Boat", boatyard_name AS "Boatyard", booking_date AS "Booking Date", issue_description AS "Issue Description"
FROM bookings
JOIN boats ON boats.boat_id = bookings.boat_id
JOIN boatyard_details ON boatyard_details.boatyard_id = bookings.boatyard_id
WHERE booking_type = 'Pre-booked' AND booking_status = 'Scheduled';

/* Query 3 */

/* Query 3 is designed to help HR procurement by telling you how many members of a selected staff type,
in this case, boat mechanics, are available. This has then been split into how many are on each site,
as this can then be used to help decide which place is best for certain jobs for ships */

SELECT count(staff_roles.staff_id) AS "Number of Boat Mechanics", boatyard_details.boatyard_name AS "Site"
FROM staff_roles
JOIN roles ON roles.role_id = staff_roles.role_id
JOIN staff_details ON staff_roles.staff_id = staff_details.staff_id
JOIN boatyard_details ON boatyard_details.boatyard_id = staff_details.boatyard_id
WHERE roles.role_name = 'Boat Mechanic'
GROUP BY boatyard_details.boatyard_id;