SELECT customer_details.customer_id, customer_details.business_name, boats.boat_id, boats.boat_name
FROM customer_details
JOIN boats
ON customer_details.customer_id = boats.customer_id
WHERE customer_details.customer_type = ('Business')
ORDER BY customer_details.customer_id;