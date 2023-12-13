------------------------
-- Roles and Permissions
------------------------
------------------------------
-- Database administrator role
------------------------------
CREATE ROLE database_administrator WITH PASSWORD 'dbadministrator';
ALTER USER database_administrator WITH SUPERUSER;


-----------------
-- Manager role 
-----------------
CREATE ROLE manager WITH LOGIN PASSWORD 'dbmanager1';

---------------------
-- Manager Permission
---------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE staff_details, staff_roles, boatyard_id, bookings_service, bookings, customer_details, emergency_contact, boats, boat_classes, classes, boat_hullmaterials, hull_materials, boat_engines, engines, fuel_type TO manager;

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA public TO manager WITH GRANT OPTION;
REVOKE SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public FROM manager;

GRANT SELECT ON staff_boatyard_view, boatyard_storage_availabllity_view, Business_Storing_Boats_view, indivudals_Storing_Boats_view, completed_bookings_view, ongoing_bookings_view, scheduled_bookings_view, commercial_ships_stored_view, private_ships_stored_view TO manager;
-------------------------------
-- Group role - maintaince crew
-------------------------------
CREATE ROLE maintaince_crew; 
    GRANT maintaince_crew TO boat_mechanics;
    GRANT maintaince_crew TO boat_technician; 
    GRANT maintaince_crew TO boat_electrician;
    GRANT maintaince_crew TO boat_painter; 
    GRANT maintaince_crew TO boat_detailer;

-------------------------------
-- Maintaince crew permission 
--------------------------------
GRANT SELECT ON TABLE bookings, customer_details, emergency_contact, boats, boat_classes, boat_hullmaterials, boat_engines, engines, fuel_type, classes, hull_materials TO maintaince_crew;
GRANT INSERT ON TABLE bookings, bookings_service TO maintaince_crew;
GRANT UPDATE ON TABLE bookings_service, bookings, boat_hullmaterials, boat_engines, TO maintaince_crew;

GRANT SELECT ON boatyard_storage_availabllity_view, Business_Storing_Boats_view, indivudals_Storing_Boats_view, completed_bookings_view, ongoing_bookings_view, scheduled_bookings_view, commercial_ships_stored_view, private_ships_stored_view TO maintaince_crew;
---------------------------
-- customer assistant role
---------------------------
CREATE ROLE customer_assistant WITH LOGIN PASSWORD 'dbcustomerassistant1';

-------------------------------
-- customer assistant permission 
--------------------------------

GRANT SELECT ON TABLE bookings, customer_details, emergency_contact, boats, boat_classes, boat_hullmaterials, boat_engines, classes, hull_materials, engines, fuel_type TO customer_assistant;
GRANT INSERT, UPDATE ON TABLE bookings, customer_details, emergency_contact, boats, boat_classes, boat_hullmaterials, boat_engines TO customer_assistant;

GRANT SELECT ON boatyard_storage_availabllity_view, Business_Storing_Boats_view, indivudals_Storing_Boats_view, completed_bookings_view, ongoing_bookings_view, scheduled_bookings_view, commercial_ships_stored_view, private_ships_stored_view TO customer_assistant;