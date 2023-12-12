--Query 4

-- For when you need to look up the capacity of the docks in a dockyard in a specific country. (This scenario is Poland)
SELECT boatyard_details.boatyard_name AS "Boatyard Name", dock_details.dock_id AS "Dock ID", dock_details.wet_slips_max_capcity AS "Wet Slip Capacity",dock_details.dry_slips_max_capacity AS "Dry Slip Capacity"
FROM boatyard_details
JOIN dock_details
ON boatyard_details.boatyard_id = dock_details.boatyard_id
WHERE boatyard_details.country = ('Poland')
ORDER BY dock_details.dock_id;


--Query 5

-- For when you need to see all of the boats that are owned by businesses rather than individuals not affiliated with a business
SELECT customer_details.customer_id AS "Customer ID", customer_details.business_name AS "Business Name", boats.boat_id AS "Boat ID", boats.boat_name AS "Boat Name"
FROM customer_details
JOIN boats
ON customer_details.customer_id = boats.customer_id
WHERE customer_details.customer_type = ('Business')
ORDER BY customer_details.customer_id;



