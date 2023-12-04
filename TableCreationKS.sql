CREATE TABLE hull_materials( 
    hull_material_id SERIAL PRIMARY KEY, 
    hull_material_name VARCHAR(40) NOT NULL 
); 

CREATE TABLE boat_hullmaterials(
    boat_id INTEGER NOT NULL,
    hull_material_id INTEGER NOT NULL
    FOREIGN KEY(boat_id)REFERENCES boat(boat_id),
    FOREIGN KEY(hull_materials)REFERENCES hull_materials(hull_material_id)
); 

CREATE TABLE fuel_types(
    fuel_id SERIAL PRIMARY KEY,
    fuel_type1 VARCHAR(20) NOT NULL, 
    fuel_type2 VARCHAR(20) 
); 

CREATE TABLE engines(
    engine_id SERIAL PRIMARY KEY,
    fuel_id INTEGE NOT NULL REFERENCES fuel_type(fuel_id) 
    engine_type VARCHAR(40) NOT NULL, 
    engine_make VARCHAR(40) NOT NULL,
    enigne_model VARCHAR(40) NOT NULL 
);

CREATE TABLE boats_engine(
    boat_id INTEGER NOT NULL,
    enigne_id INTEGER NOT NULL, 
    FOREIGN KEY(boat_id) REFERENCES boat(boat_id),
    FOREIGN KEY(engine_id) REFERENCES engine(engine_id) 
);

CREATE TYPE bookingType AS ENUM('Pre-booked','Emergency Service')
CREATE TYPE bookingStatus AS ENUM('Scheduled','On-going','Completed') 

CREATE TABLE bookings(
    bookings_id SERIAL PRIMARY KEY, 
    customer_id INTEGER NOT NULL REFERENCES customers_details(customer_id) ,
    boat_id INTEGER NOT NULL REFERENCES boat_details(boat_id),
    boatyard_id INTEGER NOT NULL REFERENCES boatyard_details(boatyard_id) ,
    booking_type bookingType NOT NULL,
    booking_date DATE NOT NULL,
    issue_description TEXT NOT NULL,
    booking_status bookingStatus NOT NULL
);

CREATE TABLE service(
    service_id SERIAL PRIMARY KEY, 
    service_description VARCHAR(50) NOT NULL 
); 

CREATE TABLE bookings_service(
    booking_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    staff_id INTEGER REFERENCES staff_details(staff_id) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id)
);

CREATE staff_task(
    service_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    FOREIGN KEY(service_id) REFERENCES service(serivce_id),
    FOREIGN KEY(staff_id) REFERENCES staff_details(staff_id)
);

