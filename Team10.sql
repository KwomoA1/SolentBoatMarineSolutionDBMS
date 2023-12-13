/* Solent Boats SQL code */
/*
Collaborators:
Kwami Smith: up2114687
Robin: up2123493
Zac: up2114856
*/

/*-------------------------------------------------------------------------------------------------
Triggers/Functions 
*/-------------------------------------------------------------------------------------------------

-- Update storage capacity

-- View triggers/functions

-- Boat size update trigger/function


/*-------------------------------------------------------------------------------------------------
Database Creation and connection 
*/-------------------------------------------------------------------------------------------------
CREATE DATABASE team10;
\c team10;

/*------------------------------------------------------------------------------------------------
Enum type creations 
*/------------------------------------------------------------------------------------------------
CREATE TYPE CUST_TYPE AS ENUM('business', 'individual');
CREATE TYPE STORAGETYPE AS ENUM ('wet slip', 'dry slip', 'indoors');
CREATE TYPE BOATTYPE AS ENUM ('commercial', 'private');
CREATE TYPE BOOKINGTYPE AS ENUM('pre-booked','emergency service');
CREATE TYPE BOOKINGSTATUS AS ENUM('scheduled','on-going','completed'); 
CREATE TYPE ENGINETYPE AS ENUM('inboard-engine','outboard-engine','stern drive');
/*-------------------------------------------------------------------------------------------------
Table Creations 
*/-------------------------------------------------------------------------------------------------

CREATE TABLE customer_details(
  customer_id SERIAL PRIMARY KEY,
  customer_type CUST_TYPE NOT NULL,
  business_name VARCHAR(50),
  CONSTRAINT customer_type_check CHECK(
    (customer_type = 'business' AND business_name IS NOT NULL)
    OR
    (customer_type = 'individual' AND business_name IS NULL)
  ),
  customer_fname VARCHAR(40) NOT NULL,
  customer_lname VARCHAR(40) NOT NULL,
  dob DATE NOT NULL,
  CONSTRAINT age_check CHECK (EXTRACT('YEAR' FROM AGE(CURRENT_DATE, dob)) >= 16),
  country VARCHAR(40) NOT NULL,
  address1 VARCHAR(60) NOT NULL,
  address2 VARCHAR(50),
  town VARCHAR(60) NOT NULL,
  postcode CHAR(15),
  emailaddress VARCHAR(100) NOT NULL,
  mobile_number CHAR(15) NOT NULL,
  landline_number CHAR(15)
);

CREATE TABLE emergency_contact(
  emergency_contact_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customer_details(customer_id) NOT NULL,
  contact_fname VARCHAR(50) NOT NULL,
  contact_lname  VARCHAR(50) NOT NULL,
  contact_mobile  CHAR(15) NOT NULL,
  contact_landline CHAR(15),
  contact_emailaddress VARCHAR (100) NOT NULL
);

CREATE TABLE boatyard_details(
  boatyard_id SERIAL PRIMARY KEY,
  boatyard_name VARCHAR(100) NOT NULL,
  country VARCHAR(40) NOT NULL,
  address1 VARCHAR(60) NOT NULL,
  address2  VARCHAR(60),
  postcode_zip CHAR(15),
  indoor_storage_capacity SMALLINT NOT NULL
);

CREATE TABLE facilities(
  facility_id SERIAL PRIMARY KEY,
  facility_name VARCHAR(40) NOT NULL
);

CREATE TABLE boatyard_facilities(
  boatyard_id INT NOT NULL,
  facility_id SMALLINT NOT NULL,
  FOREIGN KEY (boatyard_id) REFERENCES boatyard_details(boatyard_id),
  FOREIGN KEY (facility_id) REFERENCES facilities(facility_id) 
);


CREATE TABLE dock_details(
  dock_id SERIAL PRIMARY KEY,
  boatyard_id INT REFERENCES boatyard_details(boatyard_id) NOT NULL,
  wet_slips_current_capacity SMALLINT NOT NULL,
  dry_slips_current_capacity SMALLINT NOT NULL
);

CREATE TABLE staff_details(
    staff_id SERIAL PRIMARY KEY,
    boatyard_id INT NOT NULL REFERENCES boatyard_details(boatyard_id),
    staff_fname VARCHAR(40) NOT NULL,
    staff_lname  VARCHAR(40) NOT NULL,
    dob DATE NOT NULL,
    CONSTRAINT age_check CHECK (EXTRACT('YEAR' FROM AGE(CURRENT_DATE, dob)) >= 16),
    address1 VARCHAR (60) NOT NULL,
    address2 VARCHAR (50),
    town VARCHAR(60) NOT NULL,
    postcode CHAR (15) NOT NULL,
    mobile_number  CHAR(15) NOT NULL,
    landline_number CHAR(15),
    personal_emailaddress VARCHAR(100) NOT NULL,
    work_emailaddress VARCHAR(100) NOT NULL
);

CREATE TABLE roles(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR (30) NOT NULL
);

CREATE TABLE staff_roles(
    staff_id INT NOT NULL,
    role_id SMALLINT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff_details(staff_id), 
    FOREIGN KEY (role_id) REFERENCES roles(role_id) 
);

CREATE TABLE boat_details(
    boat_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customer_details (customer_id),
    boatyard_id INTEGER NOT NULL REFERENCES boatyard_details ( boatyard_id),
    dock_id INTEGER NOT NULL REFERENCES dock_details (dock_id),
    boat_storage_type STORAGETYPE NOT NULL,
    boat_type BOATTYPE NOT NULL,
    boat_name VARCHAR (80) NOT NULL,
    model VARCHAR (40) NOT NULL,
    build_date DATE,
    length_overall INTEGER NOT NULL,
    beam INTEGER NOT NULL,
    draft INTEGER NOT NULL,
    cargo_tankers_capacity VARCHAR (15),
    CONSTRAINT boat_type_check CHECK(
      (boat_type = 'commercial' AND cargo_tankers_capacity IS NOT NULL)
      OR
      (boat_type = 'private' AND cargo_tankers_capacity IS NULL)
    )
);

CREATE TABLE classes(
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR (40) NOT NULL
);

CREATE TABLE boat_classes(
    boat_id INT NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (boat_id) REFERENCES boat_details(boat_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

CREATE TABLE hull_materials( 
    hull_material_id SERIAL PRIMARY KEY, 
    hull_material_name VARCHAR(40) NOT NULL 
); 

CREATE TABLE boat_hullmaterials(
    boat_id INTEGER NOT NULL, 
    hull_material_id INTEGER NOT NULL,
    FOREIGN KEY (boat_id) REFERENCES boat_details(boat_id) ,
    FOREIGN KEY (hull_material_id) REFERENCES hull_materials(hull_material_id)
); 

CREATE TABLE fuel_types(
    fuel_id SERIAL PRIMARY KEY,
    fuel_type VARCHAR(30) NOT NULL
); 

CREATE TABLE engines(
    engine_id SERIAL PRIMARY KEY,
    fuel_id SMALLINT NOT NULL REFERENCES fuel_types(fuel_id),
    engine_type ENGINETYPE NOT NULL, 
    engine_make VARCHAR(40) NOT NULL,
    engine_model VARCHAR(40) NOT NULL 
);

CREATE TABLE boats_engine(
    boat_id INTEGER NOT NULL,
    engine_id INTEGER NOT NULL, 
    FOREIGN KEY(boat_id) REFERENCES boat_details(boat_id),
    FOREIGN KEY(engine_id) REFERENCES engines(engine_id) 
);

CREATE TABLE booking(
    booking_id SERIAL PRIMARY KEY, 
    customer_id INTEGER NOT NULL REFERENCES customer_details(customer_id),
    boat_id INTEGER NOT NULL REFERENCES boat_details(boat_id),
    boatyard_id INTEGER NOT NULL REFERENCES boatyard_details(boatyard_id),
    booking_type BOOKINGTYPE NOT NULL,
    booking_date DATE NOT NULL,
    issue_description TEXT NOT NULL,
    booking_status BOOKINGSTATUS NOT NULL
);

CREATE TABLE service(
    service_id SERIAL PRIMARY KEY, 
    service_description VARCHAR(50) NOT NULL 
); 

CREATE TABLE booking_service(
    booking_id INTEGER NOT NULL,
    service_id SMALLINT NOT NULL,
    staff_id INTEGER REFERENCES staff_details(staff_id) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id)
);

-------------------------
-- Function
-------------------------

-- update wet slip capacity
CREATE FUNCTION fn_update_wet_slip_capacity() RETURNS trigger AS $update_wet_slip_capacity$
  BEGIN 
    IF (TG_OP = 'INSERT' AND NEW.boat_storage_type = 'wet slip') THEN
    UPDATE dock_details SET wet_slips_current_capacity = wet_slips_current_capacity - 1
    WHERE dock_id = new.dock_id;

    ELSEIF (TG_OP = 'DELETE' AND NEW.boat_storage_type = 'wet slip') THEN
    UPDATE dock_details SET wet_slips_current_capacity = wet_slips_current_capacity + 1
    WHERE dock_id = new.dock_id; 
    END IF;
    RETURN NULL;
  END;
$update_wet_slip_capacity$ LANGUAGE plpgsql;

-- update dry slip capacity 
CREATE FUNCTION fn_update_dry_slip_capacity() RETURNS trigger AS $update_dry_slip_capacity$
  BEGIN 
    IF (TG_OP = 'INSERT' AND NEW.boat_storage_type = 'dry slip') THEN
    UPDATE dock_details SET dry_slips_current_capacity = dry_slips_current_capacity - 1
    WHERE dock_id = new.dock_id;

    ELSEIF (TG_OP = 'DELETE' AND NEW.boat_storage_type = 'dry slip') THEN
    UPDATE dock_details SET dry_slips_current_capacity = dry_slips_current_capacity + 1
    WHERE dock_id = new.dock_id; 
    END IF;
    RETURN NULL;
  END;
$update_dry_slip_capacity$ LANGUAGE plpgsql;

-- update indoor storage capacity 
CREATE FUNCTION fn_update_indoor_storage_capacity() RETURNS trigger AS $update_indoor_storage_capacity$
  BEGIN 
    IF (TG_OP = 'INSERT' AND NEW.boat_storage_type = 'indoors') THEN
    UPDATE boatyard_details SET indoor_storage_capacity = indoor_storage_capacity - 1
    WHERE boatyard_id = new.boatyard_id;

    ELSEIF (TG_OP = 'DELETE' AND NEW.boat_storage_type = 'indoors') THEN
    UPDATE boatyard_details SET indoor_storage_capacity = indoor_storage_capacity + 1
    WHERE boatyard_id = new.boatyard_id; 
    END IF;
    RETURN NULL;
  END;
$update_indoor_storage_capacity$ LANGUAGE plpgsql;

----------------------
-- Triggers 
----------------------

-- Wet Slip update trigger 
CREATE TRIGGER trigger_update_wet_slip
AFTER INSERT OR DELETE on boat_details
FOR EACH ROW
EXECUTE FUNCTION fn_update_wet_slip_capacity();

-- Dry slip update trigger
CREATE TRIGGER trigger_update_dry_slip
AFTER INSERT OR DELETE on boat_details
FOR EACH ROW
EXECUTE FUNCTION fn_update_dry_slip_capacity();

-- Indoor storage update trigger
CREATE TRIGGER trigger_update_indoor_storage
AFTER INSERT OR DELETE on boat_details
FOR EACH ROW
EXECUTE FUNCTION fn_update_indoor_storage_capacity();


/*-------------------------------------------------------------------------------------------------
Data inserts 
*/-------------------------------------------------------------------------------------------------

-- Facilities 
INSERT INTO facilities (facility_id, facility_name) 
VALUES
(1, 'Fuel station'),
(2, 'Hoist'),
(3, 'Crane'),
(4, 'Cafeteria'),
(5, 'Boat ramp'),
(6, 'Pump-out station'),
(7, 'work-shop'),
(8, 'Fuel dock'),
(9, 'Boat cleaning services');

-- Boatyard Details 
INSERT INTO boatyard_details (boatyard_id, boatyard_name, country, address1, address2, postcode_zip, indoor_storage_capacity)
VALUES
(1, 'Blue Bill Park', 'Poland', '8 Orin Park', null, '05-090', 12),
(2, 'Hazelcrest', 'Ukraine', '635 Dennis Alley', null, null, 13),
(3, 'Crownhardt', 'Greece', '2290 Columbus Hill', '18th Floor', null, 13),
(4, 'Colorado', 'Sweden', '30187 Burrows Pass', '9th Floor', '542 95', 10),
(5, 'Dawn', 'Peru', '2889 Anhalt Pass', 'Suite 90', null, 10);

-- Dock details
INSERT INTO dock_details(dock_id, boatyard_id, wet_slips_current_capacity, dry_slips_current_capacity)
VALUES
(1, 1, 3, 9),
(2, 2, 9, 5),
(3, 3, 5, 3),
(4, 4, 4, 4),
(5, 5, 10, 5),
(6, 1, 6, 5),
(7, 2, 9, 6),
(8, 3, 4, 8),
(9, 4, 9, 9),
(10, 5, 5, 3),
(11, 1, 6, 6),
(12, 2, 5, 4),
(13, 3, 6, 5),
(14, 4, 6, 5),
(15, 5, 10, 3);

-- Services
INSERT INTO service (service_id, service_description)
VALUES
(1, 'Hull cleaning'),
(2, 'Bottom Painting'),
(3, 'Engine Servicing'),
(4, 'Propeller inspection and repair'),
(5, 'Electrical system check'),
(6, 'Bilge Pump Maintenance'),
(7, 'Steering systems inspection'),
(8, 'Fuel systems inspection'),
(9, 'Fluid checks'),
(10, 'Anode Replacement'),
(11, 'Interior and exterior cleaning'),
(12, 'Safety equipment inspection'),
(13, 'Rigging inspection'),
(14, 'Hose and fitting inspection'),
(15, 'Navigation equipment calibration');

-- Staff details 
INSERT INTO staff_details (staff_id, boatyard_id, staff_fname, staff_lname, dob, address1, address2, town, postcode, mobile_number, landline_number, personal_emailaddress, work_emailaddress) 
VALUES
(1, 1, 'Sandi', 'Vignaux', '2/6/2004', '1 Graceland Court', 'PO Box 94618', 'Szubin', '89-200', '978-546-9364', null, 'svignaux1@friendfeed.com', 'svignaux0@friendfeed.com'),
(2, 2, 'Steward', 'Rowsel', '8/5/1973', '743 Elmside Terrace', 'Room 1410', 'Pankovka', '173526', '715-591-9780', null, 'srowsel1@arstechnica.com', 'srowsel1@blogspot.com'),
(3, 3, 'Celesta', 'Vannuccini', '5/13/2001', '66 Grasskamp Trail', null, 'Esigodini', 'PO2 6AF', '162-500-0991', '499-361-4207', 'cvannuccini2@bloglovin.com', 'cvannuccini2@guardian.co.uk'),
(4, 4, 'Ivy', 'Mayman', '10/27/1985', '463 Carioca Avenue', null, 'Puning', '12djijfw', '786-998-1837', null, 'imayman3@prlog.org', 'imayman3@google.fr'),
(5, 5, 'Shelli', 'Prinnett', '7/25/2001', '47 Bellgrove Park', 'PO Box 78008', 'Stykkishólmur', '340', '716-354-3818', null, 'sprinnett4@sfgate.com', 'sprinnett4@craigslist.org'),
(6, 1, 'Micki', 'McCathie', '8/28/1983', '4510 Randy Place', 'Apt 968', 'Citeguh', 'dsf341', '885-834-9380', '240-396-0049', 'mmccathie5@bravesites.com', 'mmccathie5@netscape.com'),
(7, 2, 'Becca', 'Pedrol', '4/27/1982', '6432 Lawn Court', 'Suite 97', 'Kiltamagh', 'P75', '150-832-5808', null, 'bpedrol6@blogspot.com', 'bpedrol6@tripadvisor.com'),
(8, 3, 'Forester', 'Hitzschke', '1/1/1973', '9948 Corben Pass', 'PO Box 32976', 'Benešov nad Ploučnicí', '407 22', '305-118-7951', '919-279-9754', 'fhitzschke7@dropbox.com', 'fhitzschke7@youtu.be'),
(9, 4, 'Tom', 'Leverett', '7/28/1999', '4023 Loeprich Parkway', 'Apt 188', 'Dolna Banjica', '1238', '994-698-9238', '501-826-0158', 'tleverett8@acquirethisname.com', 'tleverett8@baidu.com'),
(10, 5, 'Carry', 'Fabri', '7/20/2004', '635 Dryden Center', '16th Floor', 'Pende', 'banana1', '619-293-9931', null, 'cfabri9@histats.com', 'cfabri9@mit.edu'),
(11, 1, 'Mateo', 'Maffi', '2/1/2000', '33 David Center', null, 'Tippi', 'apple1', '533-296-3881', '289-228-6838', 'mmaffia@chicagotribune.com', 'mmaffia@about.me'),
(12, 2, 'Clint', 'Maker', '12/19/1991', '11 Thackeray Street', 'PO Box 84647', 'Bangluo', 'cheese1', '275-827-9400', '576-255-8002', 'pwhybray0@businesswire.com', 'cmakerb@hibu.com'),
(13, 3, 'Loren', 'McGroarty', '4/2/1974', '563 Marquette Place', null, 'Havtsal', 'onion1', '432-657-8977', null, 'lmcgroartyc@bbc.co.uk', 'lmcgroartyc@independent.co.uk'),
(14, 4, 'Dal', 'Huegett', '1/1/1979', '85113 Swallow Avenue', null, 'Pimenta Bueno', '78984-000', '841-802-9469', '798-975-9567', 'dhuegettd@businessinsider.com', 'dhuegettd@feedburner.com'),
(15, 5, 'Libbi', 'Linley', '10/25/1978', '7 Drewry Plaza', 'Suite 54', 'Douentza', 'brixton3', '514-554-0146', '171-669-4652', 'jdownie1@princeton.edu', 'llinleye@a8.net'),
(16, 4, 'Fidela', 'Alwen', '4/26/1971', '9 Nobel Avenue', 'Room 674', 'Amboasary', 'po212gd', '260-484-6713', '465-283-1359', 'falwen0@goo.ne.jp', 'falwen0@sogou.com'),
(17, 1, 'Kathi', 'Veschambes', '12/26/1980', '0 Carberry Terrace', 'PO Box 41729', 'f7ehj5k', '17-123', '817-843-0517', '829-385-0118', 'kveschambes1@tumblr.com', 'kveschambes1@imageshack.us'),
(18, 3, 'Sasha', 'Pimblett', '3/28/2001', '9967 Riverside Lane', '4th Floor', 'Baishi', 'fhf74hr', '713-997-8502', '317-654-9631', 'spimblett2@tinypic.com', 'spimblett2@friendfeed.com'),
(19, 2, 'Hank', 'Arent', '3/2/1999', '01731 8th Park', 'Room 1943', 'Al Ḩarajah', '7dfh47', '462-990-1284', '512-954-1320', 'harent3@marriott.com', 'harent3@mozilla.org'),
(20, 4, 'Fanechka', 'Schirok', '2/19/1977', '47 Victoria Park', 'Room 19', 'Ovsyanka', '663083', '804-130-4010', '325-886-3231', 'fschirok4@hatena.ne.jp', 'fschirok4@github.io');


-- Boatyard facilities
INSERT INTO boatyard_facilities (boatyard_id, facility_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6),
(2, 7),
(3, 1),
(4, 2),
(5, 3),
(1, 4),
(2, 5),
(3, 6),
(4, 7),
(5, 1);

-- Customer Details 
INSERT INTO customer_details (customer_id, customer_type, business_name, customer_fname, customer_lname, dob, country, address1, address2, town, postcode, emailaddress, mobile_number, landline_number)
VALUES
(1, 'business', 'Bogisich, Jones and Sauer', 'Patric', 'Chalmers', '3/12/2002', 'France', '9378 Main Court', 'Apt 561', 'Roubaix', '59100', 'pchalmers0@issuu.com', '649-149-7094', null),
(2, 'business', 'Daugherty and Sons', 'Goldi', 'Tovey', '1/4/1993', 'Brazil', '3011 Magdeline Drive', 'PO Box 91647', 'Breves', '68800-000', 'gtovey1@g.co', '798-811-1088', null),
(3, 'business', 'Larson, O''Keefe and Herzog', 'Desiree', 'Dyhouse', '11/5/1990', 'Morocco', '79 Gateway Way', 'Room 1310', 'Saddina', 'poop1', 'ddyhouse2@is.gd', '786-709-2088', null),
(4, 'individual',null, 'Zach', 'Dict', '8/2/1994', 'China', '614 Becker Parkway', null, 'Xibu', 'fart1', 'zdict3@hubpages.com', '147-540-7123', null),
(5, 'individual',null, 'Lynnett', 'Shaefer', '11/16/1983', 'Philippines', '40 Fulton Hill', 'PO Box 85131', 'Eustaquio Lopez', '6116', 'lshaefer4@cnet.com', '108-552-0990', null),
(6, 'individual',null , 'Philbert', 'Garnsworth', '8/1/2000', 'Honduras', '852 Messerschmidt Alley', null, 'Casa Quemada', 'cheese2', 'pgarnsworth5@so-net.ne.jp', '488-389-8098', null),
(7, 'business', 'Marvin-Schoen', 'Benito', 'Kenny', '2/25/2005', 'Russia', '06 Melody Drive', null, 'Lakinsk', '662133', 'bkenny6@slashdot.org', '866-677-0794', null),
(8, 'business', 'Deckow-Rutherford', 'Gertrud', 'Bresner', '5/5/1998', 'Ukraine', '53 Scoville Road', 'PO Box 44319', 'Sheshory', 'unyen1', 'gbresner7@cnbc.com', '364-324-5964', null),
(9, 'individual',null , 'Perry', 'Braunle', '7/17/1971', 'Colombia', '80 5th Court', 'Room 89', 'Giraldo', '057047', 'pbraunle8@redcross.org', '420-664-6641', null),
(10, 'individual',null , 'Donnie', 'Neylan', '10/23/2005', 'Sweden', '961 Prairieview Parkway', 'PO Box 16241', 'Örebro', '702 21', 'dneylan9@theguardian.com', '966-687-7661', '381-969-7684'),
(11, 'individual',null , 'Wolf', 'Wildash', '11/25/2004', 'Poland', '412 Westend Court', 'Apt 1516', 'Lubichowo', '83-240', 'wwildasha@bigcartel.com', '580-823-6663', null),
(12, 'business', 'Wiza, Brekke and Prohaska', 'Portie', 'Stutt', '7/23/1972', 'Indonesia', '78 Longview Pass', '5th Floor', 'Mursaba', 'epic7', 'pstuttb@tiny.cc', '306-873-0638', null),
(13, 'individual',null , 'Pippy', 'Ferriday', '5/12/1987', 'Sweden', '0286 Riverside Parkway', null, 'Enskede', '122 44', 'pferridayc@ycombinator.com', '604-663-3756', null),
(14, 'business', 'Veum, Mraz and Williamson', 'Fabian', 'Somersett', '10/27/1989', 'Cuba', '86916 Superior Way', null, 'Santa Cruz del Norte', 'oof4', 'nbattabee0@mapy.cz', '481-652-0432', '651-409-1958'),
(15, 'individual',null , 'Hayes', 'Vamplus', '6/21/1979', 'Serbia', '0639 Evergreen Terrace', null, 'Rača', 'cheese4', 'gbedo1@craigslist.org', '416-570-0419', '118-400-3803');

-- boats 
INSERT INTO boat_details (boat_id, customer_id, boatyard_id, dock_id, boat_storage_type, boat_type, boat_name, model, build_date, length_overall, beam, draft, cargo_tankers_capacity)
VALUES
(1, 13, 4, 6, 'dry slip','commercial', 'Saudra', 417699, '5/4/1993', 184, 85, 175, 397),
(2, 11, 1, 9, 'indoors','commercial', 'Timothea', 951237, '8/20/1982', 292, 137, 479, 432),
(3, 15, 4, 8, 'indoors', 'private', 'Connie', 336967, '9/26/1978', 377, 469, 461, null),
(4, 9, 4, 4, 'dry slip','commercial', 'Kendra', 304266, '5/30/1945', 435, 261, 276, 496),
(5, 8, 1, 3, 'wet slip', 'private', 'Danika', 949416, '8/7/1952', 69, 74, 468, null),
(6, 13, 2, 4, 'indoors', 'commercial', 'Chelsea', 848229, '7/31/1949', 496, 98, 384, 460),
(7, 12, 5, 8, 'wet slip', 'private', 'Keriann', 172324, '10/23/1907', 488, 11, 334, null),
(8, 7, 2, 4, 'wet slip', 'commercial', 'Kattie', 959562, '7/9/1909', 400, 499, 192, 348),
(9, 11, 3, 11, 'dry slip','commercial', 'Olwen', 258571, '12/7/1916', 300, 102, 371, 25),
(10, 14, 5, 14, 'indoors','commercial', 'Sally', 982831, '11/14/1930', 399, 176, 372, 29),
(11, 7, 2, 12, 'indoors','commercial', 'Barbara', 248747, '10/7/1999', 135, 339, 274, 154),
(12, 14, 5, 7, 'wet slip','private', 'Sissie', 464049, '1/5/1978', 466, 323, 177, null),
(13, 11, 2, 8, 'indoors', 'private', 'Mara', 249078, '7/13/1948', 172, 121, 68, null),
(14, 2, 4, 8, 'wet slip', 'commercial', 'Aindrea', 976396, '7/2/1940', 322, 356, 178, 294),
(15, 12, 1, 12, 'dry slip', 'commercial', 'Beverly', 311251, '12/18/1974', 126, 293, 422, 346);

-- Bookings
INSERT INTO booking (booking_id, customer_id, boat_id, boatyard_id, booking_type, booking_date, issue_description, booking_status)
VALUES
(1, 14, 9, 3, 'pre-booked', '11/12/2023', 'The boat experiences frequent engine stalls, disrupting smooth navigation and necessitating a thorough inspection of the engine components.', 'completed'),
(2, 15, 3, 2, 'pre-booked', '3/20/2023', 'The propeller shows signs of wear and tear, affecting the boats performance and requiring replacement or repair to ensure optimal propulsion.', 'scheduled'),
(3, 12, 3, 5, 'emergency service', '9/7/2023', 'Water leakage is observed in the hull, indicating potential structural issues. Repair work is essential to prevent further damage and maintain buoyancy.', 'scheduled'),
(4, 10, 1, 4, 'pre-booked', '6/21/2023', 'The boats electrical system is malfunctioning, causing issues with navigation lights, instruments, or the overall power supply. An electrical diagnosis and repairs are needed.', 'on-going'),
(5, 10, 2, 4, 'emergency service', '10/18/2023', 'The boat experiences issues with the fuel system, such as clogged filters or a faulty fuel pump, leading to engine inefficiency and potential breakdowns.', 'completed'),
(6, 11, 1, 3, 'emergency service', '5/6/2023', 'The rudder is misaligned, impacting steering and making it challenging to control the boat. Alignment adjustments and potential replacement are necessary.', 'scheduled'),
(7, 3, 12, 5, 'pre-booked', '6/24/2023', 'The bilge pump is not functioning correctly, risking water accumulation in the bilge area. Prompt repair or replacement is crucial to prevent flooding and potential damage.', 'on-going'),
(8, 11, 15, 1, 'pre-booked', '6/19/2023', 'The boats fiberglass structure has developed cracks, compromising its integrity. Fiberglass repairs are essential to restore strength and prevent further damage', 'scheduled'),
(9, 6, 14, 2, 'pre-booked', '8/27/2023', 'Various metal components, such as hinges, bolts, or railings, show signs of corrosion. Replacement or anti-corrosion treatment is needed to ensure structural stability.', 'scheduled'),
(10, 8, 8, 5, 'emergency service', '4/29/2023', 'The stern of the boat is noticeably lower in the water, suggesting a possible weight distribution issue or water accumulation. Investigation and corrective measures are required.', 'scheduled'),
(11, 4, 15, 2, 'pre-booked', '12/10/2022', 'Critical navigation equipment, such as GPS or sonar systems, is not functioning properly. Repairs or replacements are necessary to ensure safe navigation.', 'scheduled'),
(12, 1, 9, 1, 'pre-booked', '7/27/2023', 'The boat emits an unusual amount of smoke from the exhaust, indicating potential engine problems. Diagnostic testing and engine repairs are essential.', 'completed'),
(13, 9, 11, 1, 'emergency service', '10/25/2023', 'Wires in the boats electrical system are frayed or damaged, posing a risk of short circuits or electrical failures. Rewiring and insulation replacement are needed.', 'completed'),
(14, 9, 13, 1, 'pre-booked', '3/16/2023', 'The boats steering mechanism is stiff or unresponsive, making navigation difficult. Inspection and lubrication of the steering components are required.', 'completed'),
(15, 5, 8, 1, 'pre-booked', '9/27/2023', 'The boats upholstery shows signs of water damage, affecting the aesthetic appeal and comfort. Drying, cleaning, and potential upholstery replacement are necessary.', 'on-going');


INSERT INTO booking_service (booking_id, service_id, staff_id) 
VALUES
(1, 6, 9),
(2, 2, 6),
(3, 3, 12),
(4, 4, 11),
(5, 5, 6),
(6, 6, 6),
(7, 7, 5),
(8, 8, 10),
(9, 9, 13),
(10, 10, 9),
(11, 11, 13),
(12, 12, 2),
(13, 13, 3),
(14, 14, 13),
(15, 15, 7);

INSERT INTO classes (class_id, class_name)
VALUES
(1, 'Sailboat'),
(2, 'Motor Yacht'),
(3, 'Barge'),
(4, 'Fishing Trawler'),
(5, 'Military'),
(6, 'Catamaran'),
(7, 'Ferry'),
(8, 'Cruise Ship'),
(9, 'Submarine'),
(10, 'Sloop');

INSERT INTO boat_classes (boat_id, class_id) 
VALUES
(1, 1),
(2, 10),
(3, 6),
(4, 10),
(5, 1),
(6, 4),
(7, 3),
(8, 7),
(9, 2),
(10, 5),
(11, 10),
(12, 9),
(13, 6),
(14, 8),
(15, 8);

INSERT INTO hull_materials (hull_material_id, hull_material_name) 
VALUES
(1, 'carbon fibre'),
(2, 'aluminum'),
(3, 'steel'),
(4, 'fibre glass'),
(5, 'plastic');

INSERT INTO boat_hullmaterials (boat_id, hull_material_id) 
VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 4),
(5, 4),
(6, 3),
(7, 1),
(8, 1),
(9, 5),
(10, 4),
(11, 4),
(12, 2),
(13, 3),
(14, 5),
(15, 2);

-- Roles
INSERT INTO roles(role_id, role_name)
VALUES
(1, 'Boat Mechanic'),
(2, 'Manager'),
(3, 'Assistant manager'),
(4, 'Boat Technician'),
(5, 'Boat Electrician'),
(6, 'Boat Painter'),
(7, 'Boat Detailer');

-- Emergency contact
INSERT INTO emergency_contact (emergency_contact_id, customer_id, contact_fname, contact_lname, contact_mobile, contact_landline, contact_emailaddress)
VALUES
(1, 7, 'Liè', 'Birkwood', '568-379-8372', '333-855-3205', 'jbirkwood0@nydailynews.com'),
(2, 10, 'Wá', 'Walklott', '643-587-8645', null, 'bwalklott1@domainmarket.com'),
(3, 12, 'Maïwenn', 'Sommer', '597-787-9824', null, 'ibeament0@issuu.com'),
(4, 4, 'Naéva', 'Ambrosoni', '626-539-1403', '113-925-5200', 'bambrosoni3@last.fm'),
(5, 3, 'Alizée', 'Flanigan', '327-704-3187', '156-582-8622', 'tflanigan4@independent.co.uk'),
(6, 12, 'Méthode', 'Wooton', '498-916-7657', '540-888-1905', 'swooton5@hostgator.com'),
(7, 5, 'Wá', 'Palk', '918-441-6258', '634-785-7774', 'kpalk6@nytimes.com'),
(8, 8, 'Léa', 'Eldritt', '950-323-2507', '433-489-9359', 'reldritt7@wix.com'),
(9, 2, 'Estée', 'Thunnercliffe', '980-812-2973', null, 'dthunnercliffe8@utexas.edu'),
(10, 1, 'Ophélie', 'Cinavas', '462-964-5011', null, 'bfeechan1@zdnet.com'),
(11, 14, 'Zoé', 'Swinglehurst', '544-690-8243', null, 'jswinglehursta@usatoday.com'),
(12, 3, 'Örjan', 'Bucky', '275-842-4074', '154-886-9599', 'sbuckyb@jigsy.com'),
(13, 11, 'Gaïa', 'Kinde', '120-722-5074', '285-791-2653', 'wkindec@economist.com'),
(14, 15, 'Sòng', 'Isacsson', '536-567-1235', '218-836-1186', 'sroote2@hhs.gov'),
(15, 1, 'Andrée', 'Belch', '307-450-9977', null, 'jcrufts3@1und1.de');

/*fuel types*/
INSERT INTO fuel_types (fuel_id, fuel_type)
VALUES
(1, 'Ethanol-free gasoline'),
(2, 'Marine gas oil'),
(3, 'Marine diesel oil'),
(4, 'Ethanol(E10)'),
(5, 'Ethanol(E15)'),
(6, 'Biofuels'),
(7, 'Electricity'),
(8, 'Heavy Fuel Oil'),
(9, 'Low Sulfur Fuel Oil');


INSERT INTO engines (engine_id, fuel_id, engine_type, engine_make, engine_model) 
VALUES
(1, 1, 'inboard-engine', 'Volvo Penta', 'UY6 HJ3'),
(2, 3, 'outboard-engine', 'Volvo', 'DA7XO2'),
(3, 2, 'inboard-engine', 'Yanmar', 'FI3 NS5'),
(4, 6, 'stern drive', 'Vetus Deutz', 'IO2WE9'),
(5, 5, 'stern drive', 'Volvo', 'PT4OL7'),
(6, 4, 'outboard-engine', 'Volvo', 'Y2RTL7'),
(7, 7, 'inboard-engine', 'Yanmar', 'X8 FG2P'),
(8, 8, 'stern drive', 'Sabb', 'KL 9SE4'),
(9, 8, 'inboard-engine', 'Suzki', 'BX 1AZ9'),
(10, 9, 'outboard-engine', 'Sabb', 'GM9CQ2'),
(11, 3, 'outboard-engine', 'Volvo Penta', 'V2 U9W'),
(12, 2, 'inboard-engine', 'Yanmar', 'X7E3A'),
(13, 4, 'stern drive', 'Mercury', 'R9K2X'),
(14, 9, 'outboard-engine', 'Volvo', 'D6S4V'),
(15, 2, 'stern drive', 'Vetus Deutz', 'K8Z 3Y');

INSERT INTO boats_engine (boat_id, engine_id)
VALUES
(1, 9),
(2, 1),
(3, 2),
(4, 3),
(5, 3),
(6, 5),
(7, 8),
(8, 5),
(9, 9),
(10, 4),
(11, 5),
(12, 7),
(13, 3),
(14, 4),
(15, 9);

INSERT INTO staff_roles (staff_id, role_id)
VALUES
(1, 3),
(2, 3),
(3, 3),
(4, 4),
(5, 2),
(6, 1),
(7, 2),
(8, 5),
(9, 3),
(10, 5),
(11, 2),
(12, 5),
(13, 2),
(14, 2),
(15, 3),
(16, 4),
(17, 6),
(18, 7),
(19, 5),
(20, 3);


----------------
-- Views 
----------------

-- Staff working on boatyard 
CREATE VIEW staff_boatyard_view AS
SELECT
  byd.boatyard_id AS "Boatyard ID",
  byd.boatyard_name AS "Boatyard Name",
  sd.staff_id AS "Staff ID",
  CONCAT(sd.staff_fname,' ',sd.staff_lname) AS "staff name",
  r.role_name AS "Staff role",
  sd.work_emailaddress AS "Work Email address"
FROM boatyard_details byd
  INNER JOIN staff_details sd ON sd.boatyard_id = byd.boatyard_id
  INNER JOIN staff_roles stf ON sd.staff_id = stf.staff_id
  INNER JOIN roles r ON stf.role_id = r.role_id
ORDER BY 
byd.boatyard_id,
CASE r.role_name
  WHEN 'Manager' THEN 1
  WHEN 'Assistant manager' THEN 2
  ELSE 3
end,
sd.staff_id;

-- Boatyard storage availability
CREATE VIEW boatyard_storage_availabllity_view AS 
SELECT
  dd.boatyard_id AS "boatyard ID",
  byd.boatyard_name AS "boatyard Name",
  SUM(dd.wet_slips_current_capacity) AS "wet slips available",
  SUM(dd.dry_slips_current_capacity) AS "dry slips available",
  byd.indoor_storage_capacity AS "indoor storage available",
  (SUM(dd.wet_slips_current_capacity) + SUM(dd.dry_slips_current_capacity) + byd.indoor_storage_capacity) AS "total storage available"
FROM dock_details dd
  INNER JOIN boatyard_details byd ON byd.boatyard_id = dd.boatyard_id
GROUP BY dd.boatyard_id, byd.boatyard_name, byd.indoor_storage_capacity
ORDER BY dd.boatyard_id;


-- Business storing boats with company
CREATE VIEW Business_Storing_Boats_view AS 
SELECT 
  cd.customer_id AS "Customer ID",
  cd.business_name AS "Business name",
  CONCAT(cd.customer_fname,' ', cd.customer_lname) AS "Business employee contact", 
  cd.country AS "Country based",
  CONCAT(cd.address1,' ', cd.address2) AS "Business Address",
  cd.town AS "Town",
  cd.postcode AS "Postcode",
  cd.emailaddress AS "Business email adress", 
  cd.mobile_number AS "Business mobile contact",
  cd.landline_number AS "Business landline contact"
FROM customer_details cd
WHERE cd.customer_type = 'business';

-- Individuals storing boats with company 
CREATE VIEW indivudals_Storing_Boats_view AS 
SELECT 
  cd.customer_id AS "Customer ID",
  CONCAT(cd.customer_fname,' ', cd.customer_lname) AS "Customer name", 
  cd.country AS "Country ",
  CONCAT(cd.address1,' ', cd.address2) AS "Address",
  cd.town AS "Town",
  cd.postcode AS "Postcode",
  cd.emailaddress AS "Email adress",
  cd.mobile_number AS "Mobile number",
  cd.landline_number AS "landline number"
FROM customer_details cd
WHERE cd.customer_type = 'individual';

-- Service history 
CREATE VIEW completed_bookings_view AS
SELECT
  b.booking_id AS "Booking ID",
  b.customer_id AS "Customer ID",
  cd.customer_type AS "Is business or Individual",
  cd.business_name AS "Business name",
  CONCAT(cd.customer_fname,' ',cd.customer_lname) AS "Customer full name",
  b.booking_type AS "Booking Type",
  b.booking_date AS "Date Booked for",
  b.issue_description AS "Boat Issue description"
FROM booking b 
  INNER JOIN customer_details cd ON cd.customer_id = b.customer_id
WHERE b.booking_status = 'completed'
ORDER BY customer_type;

-- On-going services:
CREATE VIEW ongoing_bookings_view AS
SELECT
  b.booking_id AS "Booking ID",
  b.customer_id AS "Customer ID",
  cd.customer_type AS "Is business or Individual",
  cd.business_name AS "Business name",
  CONCAT(cd.customer_fname,' ',cd.customer_lname) AS "Customer full name",
  b.booking_type AS "Booking Type",
  b.booking_date AS "Date Booked for",
  b.issue_description AS "Boat Issue description"
FROM booking b 
  INNER JOIN customer_details cd ON cd.customer_id = b.customer_id
WHERE b.booking_status = 'on-going'
ORDER BY customer_type;

-- Scheduled services:
CREATE VIEW scheduled_bookings_view AS
SELECT
  b.booking_id AS "Booking ID",
  b.customer_id AS "Customer ID",
  cd.customer_type AS "Is business or Individual",
  cd.business_name AS "Business name",
  CONCAT(cd.customer_fname,' ',cd.customer_lname) AS "Customer full name",
  b.booking_type AS "Booking Type",
  b.booking_date AS "Date Booked for",
  b.issue_description AS "Boat Issue description"
FROM booking b 
  INNER JOIN customer_details cd ON cd.customer_id = b.customer_id
WHERE b.booking_status = 'scheduled'
ORDER BY customer_type;

-- Commercial ships being stored 
CREATE VIEW commercial_ships_stored_view AS 
SELECT 
  bd.boat_type AS "Commercial ship boat Type",
  bd.boat_id AS "Boat ID",
  bd.boatyard_id AS "Boatyard ID",
  byd.boatyard_name AS "Boatyard_name", 
  bd.dock_id AS "Dock ID",
  bd.boat_storage_type AS "Method of storage",
  bd.boat_name AS "Boat name",
  bd.build_date AS "Boat built date",
  bd.length_overall AS "Length overall",
  bd.beam AS "Length of boat",
  bd.draft AS "Draft of boat",
  bd.cargo_tankers_capacity AS "Cargo capacity"
  FROM boat_details bd 
    INNER JOIN boatyard_details byd ON bd.boatyard_id = byd.boatyard_id 
  WHERE boat_type = 'commercial'
  ORDER BY bd.boatyard_id;
  
-- Private ships being stored 
CREATE VIEW private_ships_stored_view AS 
SELECT 
  bd.boat_type AS "Private ship boat Type",
  bd.boat_id AS "Boat ID",
  bd.boatyard_id AS "Boatyard ID",
  byd.boatyard_name AS "Boatyard_name", 
  bd.dock_id AS "Dock ID",
  bd.boat_storage_type AS "Method of storage",
  bd.boat_name AS "Boat name",
  bd.build_date AS "Boat built date",
  bd.length_overall AS "Length overall",
  bd.beam AS "Length of boat",
  bd.draft AS "Draft of boat",
  bd.cargo_tankers_capacity AS "Cargo capacity"
  FROM boat_details bd 
    INNER JOIN boatyard_details byd ON bd.boatyard_id = byd.boatyard_id 
  WHERE boat_type = 'private'
  ORDER BY bd.boatyard_id;


/*-------------------------------------------------------------------------------------------------
Queries 
*/-------------------------------------------------------------------------------------------------

-- Query 1

/*
Query 1 is designed so that managers can list all scheduled tasks in the future,
this can help with scheduling and procurement 
*/

SELECT 
  booking_id AS "Booking ID", 
  boat_name AS "Boat", 
  boatyard_name AS "Boatyard", 
  booking_date AS "Booking Date", 
  issue_description AS "Issue Description"
FROM booking
  JOIN boat_details ON boat_details.boat_id = booking.boat_id
  JOIN boatyard_details ON boatyard_details.boatyard_id = booking.boatyard_id
WHERE booking_type = 'pre-booked' AND booking_status = 'scheduled';

-- Query 2 

/* 
Query 2 is designed to help HR procurement by telling you how many members of a selected staff type,
in this case, boat mechanics, are available. This has then been split into how many are on each site,
as this can then be used to help decide which place is best for certain jobs for ships 
*/

SELECT 
  COUNT(staff_roles.staff_id) AS "Number of Boat Mechanics", 
  boatyard_details.boatyard_name AS "Site"
FROM staff_roles
  JOIN roles ON roles.role_id = staff_roles.role_id
  JOIN staff_details ON staff_roles.staff_id = staff_details.staff_id
  JOIN boatyard_details ON boatyard_details.boatyard_id = staff_details.boatyard_id
WHERE roles.role_name IN (SELECT role_name FROM roles WHERE role_name = ('Boat Mechanic'))
GROUP BY boatyard_details.boatyard_id;

--Query 3
/*
For when you need to look up the capacity of the docks in a dockyard in a specific country. (This scenario is Poland)
*/

SELECT 
  boatyard_details.boatyard_name AS "Boatyard Name", 
  dock_details.dock_id AS "Dock ID", 
  dock_details.wet_slips_current_capacity AS "Wet Slip Capacity",
  dock_details.dry_slips_current_capacity AS "Dry Slip Capacity"
FROM boatyard_details
  JOIN dock_details ON boatyard_details.boatyard_id = dock_details.boatyard_id
WHERE boatyard_details.country IN (SELECT country FROM boatyard_details WHERE country = ('Poland'))
ORDER BY dock_details.dock_id;


--Query 4
/*
For when you need to see all of the boats that are owned by businesses rather than individuals not affiliated with a business
*/
SELECT 
  customer_details.customer_id AS "Customer ID", 
  customer_details.business_name AS "Business Name", 
  boat_details.boat_id AS "Boat ID", 
  boat_details.boat_name AS "Boat Name"
FROM customer_details
  JOIN boat_details ON customer_details.customer_id = boat_details.customer_id
WHERE customer_details.customer_type IN (SELECT customer_type FROM customer_details WHERE customer_type =  ('business'))
ORDER BY customer_details.customer_id;

--Query 5
/*
This query allows you to search up a customer by their ID and then find the boats under their name/assosiated with them as well as it's booking status.
*/

SELECT 
  customer_details.customer_id AS "Customer ID", 
  boat_details.boat_id AS "Boat ID", 
  boat_details.boat_name AS "Boat Name", 
  boat_details.model AS "Boat Model", 
  booking.booking_status AS "Booking Status"
FROM customer_details
  JOIN boat_details ON customer_details.customer_id = boat_details.customer_id
  JOIN booking ON customer_details.customer_id = booking.customer_id
WHERE customer_details.customer_id IN (SELECT customer_id FROM customer_details WHERE customer_id = 14)
ORDER BY boat_details.boat_id;

