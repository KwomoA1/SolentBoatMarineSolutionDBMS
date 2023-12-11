INSERT INTO facilities (facility_id, facility_name) 
VALUES
(1, 'Fuel station'),
(2, 'Hoist'),
(3, 'Crane'),
(4, 'Cafeteria'),
(5, 'Boat Ramp'),
(6, 'Pump-station'),
(7, 'Work-shop');

/*boatyard details*/
INSERT INTO boatyard_details (boatyard_id, boatyard_name, country, address1, address2, postcode_zip, indoors_storage_capcity)
VALUES
(1, 'Blue Bill Park', 'Poland', '8 Orin Park', null, '05-090', 12),
(2, 'Hazelcrest', 'Ukraine', '635 Dennis Alley', null, null, 13),
(3, 'Crownhardt', 'Greece', '2290 Columbus Hill', '18th Floor', null, 13),
(4, 'Colorado', 'Sweden', '30187 Burrows Pass', '9th Floor', '542 95', 10),
(5, 'Dawn', 'Peru', '2889 Anhalt Pass', 'Suite 90', null, 10);

INSERT INTO dock_details(dock_id, boatyard_id, dock_allowed_boat_size, wet_slips_max_capcity, dry_slips_max_capacity)
VALUES
(1, 1, 'Small', 3, 9),
(2, 2, 'Medium', 9, 5),
(3, 3, 'Small', 5, 3),
(4, 4, 'Large', 4, 4),
(5, 5, 'Small', 10, 5),
(6, 1, 'Small', 6, 5),
(7, 2, 'Small', 9, 6),
(8, 3, 'Small', 4, 8),
(9, 4, 'Small', 9,9),
(10, 5, 'Medium', 5, 3),
(11, 1, 'Small', 6, 6),
(12, 2, 'Medium', 5, 4),
(13, 3, 'Medium', 6, 5),
(14, 4, 'Large', 6, 5),
(15, 5, 'Small', 10, 3);

INSERT INTO service (service_id, service_description)
VALUES
(1, 'Duis at velit eu est congue elementum.'),
(2, 'Morbi quis tortor id nulla ultrices aliquet.'),
(3, 'Fusce congue, diam id ornare imperdiet.'),
(4, 'Sed sagittis.'),
(5, 'Quisque erat eros, viverra eget.'),
(6, 'Why are you looking so closely'),
(7, 'Maecenas tincidunt lacus at velit.'),
(8, 'Morbi quis tortor id nulla ultrices aliquet.'),
(9, 'Duis ac nibh.'),
(10, 'Lorem ipsum dolor sit amet, consectetuer.'),
(11, 'Maecenas pulvinar lobortis est.'),
(12, 'Aliquam sit amet diam in magna bibendum.'),
(13, 'Donec vitae nisi.'),
(14, 'Aenean fermentum.'),
(15, 'Suspendisse potenti.');

/* staff details*/
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
(10, 5, 'Carry', 'Fabri', '7/20/2014', '635 Dryden Center', '16th Floor', 'Pende', 'banana1', '619-293-9931', null, 'cfabri9@histats.com', 'cfabri9@mit.edu'),
(11, 1, 'Mateo', 'Maffi', '2/1/2010', '33 David Center', null, 'Tippi', 'apple1', '533-296-3881', '289-228-6838', 'mmaffia@chicagotribune.com', 'mmaffia@about.me'),
(12, 2, 'Clint', 'Maker', '12/19/1991', '11 Thackeray Street', 'PO Box 84647', 'Bangluo', 'cheese1', '275-827-9400', '576-255-8002', null, 'cmakerb@hibu.com'),
(13, 3, 'Loren', 'McGroarty', '4/2/1974', '563 Marquette Place', null, 'Havtsal', 'onion1', '432-657-8977', null, 'lmcgroartyc@bbc.co.uk', 'lmcgroartyc@independent.co.uk'),
(14, 4, 'Dal', 'Huegett', '1/1/1979', '85113 Swallow Avenue', null, 'Pimenta Bueno', '78984-000', '841-802-9469', '798-975-9567', 'dhuegettd@businessinsider.com', 'dhuegettd@feedburner.com'),
(15, 5, 'Libbi', 'Linley', '10/25/1978', '7 Drewry Plaza', 'Suite 54', 'Douentza', 'brixton3', '514-554-0146', '171-669-4652', null, 'llinleye@a8.net');

INSERT INTO staff_task (service_id, staff_id)
VALUES
(1, 5),
(2, 5),
(3, 1),
(4, 9),
(5, 3),
(6, 4),
(7, 13),
(8, 4),
(9, 11),
(10, 10),
(11, 14),
(12, 12),
(13, 15),
(14, 3),
(15, 13);

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

/*customer details*/
INSERT INTO customer_details (customer_id, customer_type, business_name, customer_fname, customer_lname, dob, country, address1, address2, town, postcode, emailaddress, mobile_number, landline_number)
VALUES
(1, 'Business', 'Bogisich, Jones and Sauer', 'Patric', 'Chalmers', '3/12/2002', 'France', '9378 Main Court', 'Apt 561', 'Roubaix', '59100', 'pchalmers0@issuu.com', '649-149-7094', null),
(2, 'Business', 'Daugherty and Sons', 'Goldi', 'Tovey', '1/4/1993', 'Brazil', '3011 Magdeline Drive', 'PO Box 91647', 'Breves', '68800-000', 'gtovey1@g.co', '798-811-1088', null),
(3, 'Business', 'Larson, O''Keefe and Herzog', 'Desiree', 'Dyhouse', '11/5/1990', 'Morocco', '79 Gateway Way', 'Room 1310', 'Saddina', 'poop1', 'ddyhouse2@is.gd', '786-709-2088', null),
(4, 'Individual', 'Waters LLC', 'Zach', 'Dict', '8/2/1994', 'China', '614 Becker Parkway', null, 'Xibu', 'fart1', 'zdict3@hubpages.com', '147-540-7123', null),
(5, 'Individual', 'Kuhlman, Wilkinson and Beatty', 'Lynnett', 'Shaefer', '11/16/1983', 'Philippines', '40 Fulton Hill', 'PO Box 85131', 'Eustaquio Lopez', '6116', 'lshaefer4@cnet.com', '108-552-0990', null),
(6, 'Individual', 'Hackett Group', 'Philbert', 'Garnsworth', '8/1/2000', 'Honduras', '852 Messerschmidt Alley', null, 'Casa Quemada', 'cheese2', 'pgarnsworth5@so-net.ne.jp', '488-389-8098', null),
(7, 'Business', 'Marvin-Schoen', 'Benito', 'Kenny', '2/25/2005', 'Russia', '06 Melody Drive', null, 'Lakinsk', '662133', 'bkenny6@slashdot.org', '866-677-0794', null),
(8, 'Business', 'Deckow-Rutherford', 'Gertrud', 'Bresner', '5/5/1998', 'Ukraine', '53 Scoville Road', 'PO Box 44319', 'Sheshory', 'unyen1', 'gbresner7@cnbc.com', '364-324-5964', null),
(9, 'Individual', 'Heathcote, Wolf and King', 'Perry', 'Braunle', '7/17/1971', 'Colombia', '80 5th Court', 'Room 89', 'Giraldo', '057047', 'pbraunle8@redcross.org', '420-664-6641', null),
(10, 'Individual', 'Kerluke, Abernathy and Green', 'Donnie', 'Neylan', '10/23/2005', 'Sweden', '961 Prairieview Parkway', 'PO Box 16241', 'Örebro', '702 21', 'dneylan9@theguardian.com', '966-687-7661', '381-969-7684'),
(11, 'Individual', 'Roberts Group', 'Wolf', 'Wildash', '11/25/2004', 'Poland', '412 Westend Court', 'Apt 1516', 'Lubichowo', '83-240', 'wwildasha@bigcartel.com', '580-823-6663', null),
(12, 'Business', 'Wiza, Brekke and Prohaska', 'Portie', 'Stutt', '7/23/1972', 'Indonesia', '78 Longview Pass', '5th Floor', 'Mursaba', 'epic7', 'pstuttb@tiny.cc', '306-873-0638', null),
(13, 'Individual', 'Kautzer Inc', 'Pippy', 'Ferriday', '5/12/1987', 'Sweden', '0286 Riverside Parkway', null, 'Enskede', '122 44', 'pferridayc@ycombinator.com', '604-663-3756', null),
(14, 'Business', 'Veum, Mraz and Williamson', 'Fabian', 'Somersett', '10/27/1989', 'Cuba', '86916 Superior Way', null, 'Santa Cruz del Norte', 'oof4', null, '481-652-0432', '651-409-1958'),
(15, 'Individual', 'Daugherty, Anderson and Kohler', 'Hayes', 'Vamplus', '6/21/1979', 'Serbia', '0639 Evergreen Terrace', null, 'Rača', 'cheese4', null, '416-570-0419', '118-400-3803');

/*boats*/
INSERT INTO boats (boat_id, customer_id, boat_yard_id, dock_id, boat_storage_type, boat_size_class, boat_type, boat_name, model, build_date, length_overall, beam, draft, cargo_tankers_capacity)
VALUES
(1, 13, 4, 6, 'Dry Slip', 'Medium', 'Commercial', 'Saudra', 417699, '5/4/1993', 184, 85, 175, 397),
(2, 11, 1, 9, 'Indoors', 'Medium', 'Commercial', 'Timothea', 951237, '8/20/1982', 292, 137, 479, 432),
(3, 15, 4, 8, 'Indoors', 'Large', 'Private', 'Connie', 336967, '9/26/1978', 377, 469, 461, 237),
(4, 9, 4, 4, 'Dry Slip', 'Large', 'Commercial', 'Kendra', 304266, '5/30/1945', 435, 261, 276, 496),
(5, 8, 1, 3, 'Wet Slip', 'Large', 'Private', 'Danika', 949416, '8/7/1952', 69, 74, 468, 93),
(6, 13, 2, 4, 'Indoors', 'Medium', 'Commercial', 'Chelsea', 848229, '7/31/1949', 496, 98, 384, 460),
(7, 12, 5, 8, 'Wet Slip', 'Medium', 'Private', 'Keriann', 172324, '10/23/1907', 488, 11, 334, 64),
(8, 7, 2, 4, 'Wet Slip', 'Medium', 'Commercial', 'Kattie', 959562, '7/9/1909', 400, 499, 192, 348),
(9, 11, 3, 11, 'Dry Slip', 'Medium', 'Commercial', 'Olwen', 258571, '12/7/1916', 300, 102, 371, 25),
(10, 14, 5, 14, 'Indoors', 'Large', 'Commercial', 'Sally', 982831, '11/14/1930', 399, 176, 372, 29),
(11, 7, 2, 12, 'Indoors', 'Medium', 'Commercial', 'Barbara', 248747, '10/7/1999', 135, 339, 274, 154),
(12, 14, 5, 7, 'Wet Slip', 'Small', 'Private', 'Sissie', 464049, '1/5/1978', 466, 323, 177, 118),
(13, 11, 2, 8, 'Indoors', 'Small', 'Private', 'Mara', 249078, '7/13/1948', 172, 121, 68, 95),
(14, 2, 4, 8, 'Wet Slip', 'Medium', 'Commercial', 'Aindrea', 976396, '7/2/1940', 322, 356, 178, 294),
(15, 12, 1, 12, 'Dry Slip', 'Small', 'Commercial', 'Beverly', 311251, '12/18/1974', 126, 293, 422, 346);

/*bookings*/
INSERT INTO bookings (booking_id, customer_id, boat_id, boatyard_id, booking_type, booking_date, issue_description, booking_status)
VALUES
(1, 14, 9, 3, 'Pre-booked', '11/12/2023', 'The boat experiences frequent engine stalls, disrupting smooth navigation and necessitating a thorough inspection of the engine components.', 'Completed'),
(2, 15, 3, 2, 'Pre-booked', '3/20/2023', 'The propeller shows signs of wear and tear, affecting the boats performance and requiring replacement or repair to ensure optimal propulsion.', 'Scheduled'),
(3, 12, 3, 5, 'Emergency Service', '9/7/2023', 'Water leakage is observed in the hull, indicating potential structural issues. Repair work is essential to prevent further damage and maintain buoyancy.', 'Scheduled'),
(4, 10, 1, 4, 'Pre-booked', '6/21/2023', 'The boats electrical system is malfunctioning, causing issues with navigation lights, instruments, or the overall power supply. An electrical diagnosis and repairs are needed.', 'On-going'),
(5, 10, 2, 4, 'Emergency Service', '10/18/2023', 'The boat experiences issues with the fuel system, such as clogged filters or a faulty fuel pump, leading to engine inefficiency and potential breakdowns.', 'Completed'),
(6, 11, 1, 3, 'Emergency Service', '5/6/2023', 'The rudder is misaligned, impacting steering and making it challenging to control the boat. Alignment adjustments and potential replacement are necessary.', 'Scheduled'),
(7, 3, 12, 5, 'Pre-booked', '6/24/2023', 'The bilge pump is not functioning correctly, risking water accumulation in the bilge area. Prompt repair or replacement is crucial to prevent flooding and potential damage.', 'On-going'),
(8, 11, 15, 1, 'Pre-booked', '6/19/2023', 'The boats fiberglass structure has developed cracks, compromising its integrity. Fiberglass repairs are essential to restore strength and prevent further damage', 'Scheduled'),
(9, 6, 14, 2, 'Pre-booked', '8/27/2023', 'Various metal components, such as hinges, bolts, or railings, show signs of corrosion. Replacement or anti-corrosion treatment is needed to ensure structural stability.', 'Scheduled'),
(10, 8, 8, 5, 'Emergency Service', '4/29/2023', 'The stern of the boat is noticeably lower in the water, suggesting a possible weight distribution issue or water accumulation. Investigation and corrective measures are required.', 'Scheduled'),
(11, 4, 15, 2, 'Pre-booked', '12/10/2022', 'Critical navigation equipment, such as GPS or sonar systems, is not functioning properly. Repairs or replacements are necessary to ensure safe navigation.', 'Scheduled'),
(12, 1, 9, 1, 'Pre-booked', '7/27/2023', 'The boat emits an unusual amount of smoke from the exhaust, indicating potential engine problems. Diagnostic testing and engine repairs are essential.', 'Completed'),
(13, 9, 11, 1, 'Emergency Service', '10/25/2023', 'Wires in the boats electrical system are frayed or damaged, posing a risk of short circuits or electrical failures. Rewiring and insulation replacement are needed.', 'Completed'),
(14, 9, 13, 1, 'Pre-booked', '3/16/2023', 'The boats steering mechanism is stiff or unresponsive, making navigation difficult. Inspection and lubrication of the steering components are required.', 'Completed'),
(15, 5, 8, 1, 'Pre-booked', '9/27/2023', 'The boats upholstery shows signs of water damage, affecting the aesthetic appeal and comfort. Drying, cleaning, and potential upholstery replacement are necessary.', 'On-going');


INSERT INTO bookings_service (booking_id, service_id, staff_id) VALUES
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

INSERT INTO boat_classes (boat_id, class_id) VALUES
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

INSERT INTO hull_materials (hull_material_id, hull_material_name) VALUES
(1, 'carbon fibre'),
(2, 'aluminum'),
(3, 'steel'),
(4, 'fibre glass'),
(5, 'plastic');

INSERT INTO boat_hullmaterials (boat_id, hull_material_id) VALUES
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

/*roles*/
INSERT INTO roles(role_id, role_name)
VALUES
(1, 'Boat Mechanic'),
(2, 'Boat Technician'),
(3, 'Boat Electrician'),
(4, 'Boat Painter'),
(5, 'Boat Detailer');

/*emergency contact*/
INSERT INTO emergency_contact (emergency_contact_id, customer_id, contact_fname, contact_lname, contact_mobile, contact_landline, contact_emailaddress)
VALUES
(1, 7, 'Liè', 'Birkwood', '568-379-8372', '333-855-3205', 'jbirkwood0@nydailynews.com'),
(2, 10, 'Wá', 'Walklott', '643-587-8645', null, 'bwalklott1@domainmarket.com'),
(3, 12, 'Maïwenn', 'Sommer', '597-787-9824', null, null),
(4, 4, 'Naéva', 'Ambrosoni', '626-539-1403', '113-925-5200', 'bambrosoni3@last.fm'),
(5, 3, 'Alizée', 'Flanigan', '327-704-3187', '156-582-8622', 'tflanigan4@independent.co.uk'),
(6, 12, 'Méthode', 'Wooton', '498-916-7657', '540-888-1905', 'swooton5@hostgator.com'),
(7, 5, 'Wá', 'Palk', '918-441-6258', '634-785-7774', 'kpalk6@nytimes.com'),
(8, 8, 'Léa', 'Eldritt', '950-323-2507', '433-489-9359', 'reldritt7@wix.com'),
(9, 2, 'Estée', 'Thunnercliffe', '980-812-2973', null, 'dthunnercliffe8@utexas.edu'),
(10, 1, 'Ophélie', 'Cinavas', '462-964-5011', null, null),
(11, 14, 'Zoé', 'Swinglehurst', '544-690-8243', null, 'jswinglehursta@usatoday.com'),
(12, 3, 'Örjan', 'Bucky', '275-842-4074', '154-886-9599', 'sbuckyb@jigsy.com'),
(13, 11, 'Gaïa', 'Kinde', '120-722-5074', '285-791-2653', 'wkindec@economist.com'),
(14, 15, 'Sòng', 'Isacsson', '536-567-1235', '218-836-1186', null),
(15, 1, 'Andrée', 'Belch', '307-450-9977', null, null);

/*fuel types*/
INSERT INTO fuel_type (fuel_id, fuel_type1, fuel_type2)
VALUES
(1, 'Hydrogen', 'Biofuel'),
(2, 'Gasoline', 'Diesel'),
(3, 'Biofuel', null),
(4, 'Hydrogen', null),
(5, 'Gasoline', null),
(6, 'Biofuel', null),
(7, 'Diesel', 'Hydrogen'),
(8, 'Electric', null),
(9, 'Gasoline', null),
(10, 'Diesel', 'Biofuel'),
(11, 'Biofuel', null),
(12, 'Diesel', 'Electric'),
(13, 'Diesel', 'Electric'),
(14, 'Hydrogen', 'Diesel'),
(15, 'Hydrogen', null);

INSERT INTO engines (engine_id, fuel_type, engine_type, engine_make, engine_model) VALUES
(1, 'Biofuel', 'magna', 'consequat', 'venenatis'),
(2, 'Electric', 'nisi eu', 'vulputate luctus', 'quisque'),
(3, 'Hydrogen', 'nibh', 'felis', 'diam erat'),
(4, 'Diesel', 'interdum', 'at turpis', 'quam sapien'),
(5, 'Electric', 'erat', 'sem', 'ornare'),
(6, 'Gasoline', 'nonummy integer', 'magna', 'feugiat'),
(7, 'Biofuel', 'orci eget', 'quis', 'nec euismod'),
(8, 'Biofuel', 'porttitor lacus', 'luctus', 'pede justo'),
(9, 'Hydrogen', 'eget orci', 'nulla tellus', 'dictumst etiam'),
(10, 'Diesel', 'nec nisi', 'mauris enim', 'nulla neque'),
(11, 'Hydrogen', 'porttitor', 'sollicitudin', 'primis'),
(12, 'Biofuel', 'congue', 'sed vestibulum', 'nulla'),
(13, 'Gasoline', 'mauris', 'in', 'vivamus'),
(14, 'Biofuel', 'sit', 'felis fusce', 'vestibulum ante'),
(15, 'Gasoline', 'felis', 'nunc purus', 'convallis');

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