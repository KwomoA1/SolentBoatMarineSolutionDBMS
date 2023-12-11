SELECT customer_details.customer_id, customer_details.business_name
FROM customer_details
LEFT JOIN boats
ON customer_details.customer_id = boats.customer_id
WHERE customer_details.customer_type = ("Business")
