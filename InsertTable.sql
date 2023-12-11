INSERT INTO facilities (facility_id, facility_name) 
VALUES
(1, 'Fuel station'),
(2, 'Hoist'),
(3, 'Crane'),
(4, 'Cafeteria'),
(5, 'Boat Ramp'),
(6, 'Pump-station'),
(7, 'Work-shop');

INSERT INTO dock_details(dock_id, boatyard_id, dock_allowed_boat_size, wet_slips_max_capcity, dry_slips_max_capacity)
VALUES
(1, 1, 'Small', 3, 9),
(2, 2, 'Medium', 9, 5),
(3, 3, 'Small', 5, 3),
(4, 4, 'Large', 4, 6),
(5, 5, 'Small', 10, 5),
(6, 6, 'Small', 6, 5),
(7, 7, 'Small', 9, 6),
(8, 8, 'Small', 4, 8),
(9, 9, 'Small', 9,9),
(10, 10, 'Medium', 5, 3),
(11, 11, 'Small', 6, 6),
(12, 12, 'Medium', 5, 4),
(13, 13, 'Medium', 6, 5),
(14, 14, 'Large', 6, 5),
(15, 15, 'Small', 10, 3);

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
(1, 8),
(2, 13),
(3, 13),
(4, 3),
(5, 14),
(6, 8),
(7, 6),
(8, 4),
(9, 8),
(10, 11),
(11, 12),
(12, 10),
(13, 8),
(14, 5),
(15, 6);

INSERT INTO booking_service (booking_id, service_id, staff_id) VALUES
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

INSERT INTO boat_engine (boat_id, engine_id)
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
