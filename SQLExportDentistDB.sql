/*
	INFO08007 Database Design and Development Project 2021
	Dental Clinic Database
*/


DROP DATABASE IF EXISTS DentistDB;

CREATE DATABASE DentistDB;

USE DentistDB;

SET time_zone = "+00:00";

-- 
-- Table structure for table 'Cheque Payment'
--

CREATE TABLE cheque_payment (
	cheque_id 				smallint(6) NOT NULL,
	payment_id 				int(11) NOT NULL,
	signatory_name 			varchar(25) NOT NULL,
	cheque_number 			int(11) NOT NULL,
	sort_code 				int(6) NOT NULL,
	IBAN 					varchar(34) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Cheque Payment'
--

INSERT INTO cheque_payment(cheque_id, payment_id, signatory_name, cheque_number, sort_code, IBAN) VALUES
(101, 101, 'John Smith', 54446329, 948765, "IE29 ULSB 8625 6719 3456 12"),
(102, 102, 'Scott Murphy', 24544646, 942118, "IE22 DABA 0876 9742 8821 81"),
(103, 104, 'John Smith', 75641168, 948765, "IE29 ULSB 8625 6719 3456 12"),
(104, 107, 'Sarah Carroll', 64116116, 948765, "IE33 BOFI 5521 3678 5512 93"),
(105, 111, 'Tommy Carroll', 41611116, 948765, "IE76 AIBK 9311 5212 2653 69"),
(106, 114, 'Catherine Martin', 46111141, 945465, "IE49 ULSB 4761 8871 7276 27"),
(107, 118, 'Sarah Carroll', 10555541, 948765, "IE33 BOFI 5521 3678 5512 93"),
(108, 123, 'Mary Smith', 45379812, 987432, "IE33 AIBK 6421 8134 6512 73"),
(109, 126, 'Marta Kloss', 73219546, 934431, "IE33 ULSB 9531 7541 3321 44"),
(110, 129, 'Marta Kloss', 54213657, 934431, "IE33 ULSB 9531 7541 3321 44");

-- 
-- Table structure for table 'Card Payment'
--

CREATE TABLE card_payment (
	card_id 				smallint(6) NOT NULL,
	payment_id 				int(11) NOT NULL,
	holder_name 			varchar(25) NOT NULL,
	card_number 			int(10) NOT NULL,
	exp_date     			date NOT NULL,
	card_type 				ENUM('VISA', 'Mastercard') NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Card Payment'
--

INSERT INTO card_payment(card_id, payment_id, holder_name, card_number, exp_date, card_type) VALUES
(101, 103, 'John Smith', 546298745, "2024-08-06", 'Mastercard'),
(102, 105, 'Catherine Martin', 255254515, "2022-12-05", 'VISA'),
(103, 106, 'Tommy Carroll', 741453155, "2024-02-12", 'Mastercard'),
(104, 109, 'Sarah Carroll', 414259783, "2023-12-15", 'VISA'),
(105, 110, 'Scott Murphy', 54645416164, "2022-08-16", 'Mastercard'),
(106, 113, 'Sarah Carroll', 414259783, "2023-12-15", 'VISA'),
(107, 115, 'Mary Smith', 978367882, "2025-01-05", 'Mastercard'),
(108, 117, 'Catherine Martin', 255254515, "2022-12-05", 'VISA'),
(109, 120, 'Akiko Yoshi', 546987321, "2023-02-15", 'Mastercard'),
(110, 122, 'Akiko Yoshi', 546987321, "2023-02-15", 'Mastercard'),
(111, 125, 'Marta Kloss', 542424168, "2021-12-29", 'VISA'),
(112, 127, 'Akiko Yoshi', 546987321, "2023-02-15", 'Mastercard'),
(113, 127, 'Dorothy Martin', 753951456, "2022-07-19", 'VISA'),
(114, 130, 'Akiko Yoshi', 546987321, "2023-02-15", 'Mastercard');

-- 
-- Table structure for table 'Payment Method'
--

CREATE TABLE payment_method (
	payment_id 				int(11) NOT NULL,
	invoice_id				int(11) NOT NULL,
	payment_date 			date DEFAULT CURRENT_DATE,
	payment_type 			ENUM('card', 'cheque', 'cash') NOT NULL,
	amount_paid 			decimal(10,2), 
	payment_status			ENUM('approved', 'declined', 'cancelled') DEFAULT "approved"
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Payment Method'
--

INSERT INTO payment_method(payment_id, invoice_id, payment_date, payment_type, amount_paid, payment_status) VALUES
(101, 101, "2020-12-29", 'cheque', 25.00, 'approved'),
(102, 103, "2021-01-25", 'cheque', 10.00, 'approved'),
(103, 103, "2021-02-13", 'card', 45.00, 'approved'),
(104, 101, "2021-01-11", 'cheque', 31.00, 'approved'),
(105, 104, "2021-02-27", 'card', 40.00, 'approved'),
(106, 105, "2021-02-13", 'card', 35.00, 'approved'),
(107, 106, "2022-01-15", 'cheque', 0.00, 'cancelled'),
(108, 107, "2021-02-12", 'cash', 88.00, 'approved'),
(109, 108, "2021-02-13", 'card', 70.00, 'approved'),
(110, 103, "2021-03-23", 'card', 65.00, 'approved'),

(111, 105, "2021-01-12", 'cheque', 15.00, 'approved'),
(112, 105, "2021-02-26", 'cash', 15.00, 'approved'),
(113, 108, "2021-02-09", 'card', 25.00, 'approved'),
(114, 104, "2021-01-25", 'cheque', 50.00, 'approved'),
(115, 107, "2021-03-13", 'card', 10.00, 'approved'),
(116, 110, "2021-04-18", 'cash', 20.00, 'approved'),
(117, 112, "2021-04-21", 'card', 10.00, 'approved'),
(118, 114, "2021-04-11", 'cheque', 105.00, 'approved'),
(119, 110, "2021-03-23", 'card', 25.00, 'declined'),
(120, 124, "2021-01-12", 'cash', 50.00, 'approved'),

(121, 118, "2021-02-26", 'cash', 60.00, 'approved'),
(122, 124, "2021-02-09", 'card', 25.00, 'approved'),
(123, 110, "2021-01-25", 'cheque', 25.00, 'approved'),
(124, 124, "2021-03-13", 'card', 10.00, 'declined'),
(125, 118, "2021-04-18", 'card', 15.00, 'approved'),
(126, 118, "2021-04-23", 'cheque', 10.00, 'cancelled'),
(127, 124, "2021-04-14", 'card', 20.00, 'approved'),
(128, 116, "2021-04-15", 'card', 120.00, 'approved'),
(129, 118, "2021-04-11", 'cheque', 75.00, 'approved'),
(130, 124, "2021-04-18", 'card', 25.00, 'approved');

-- 
-- Table structure for table 'Invoice'
--

CREATE TABLE invoice (
	invoice_id 				int(11) NOT NULL,
	invoice_status 			ENUM('unpaid', 'paid', 'overdue') DEFAULT 'unpaid'
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Invoice'
--

INSERT INTO invoice(invoice_id, invoice_status) VALUES
(101, 'unpaid'),
(102, 'paid'),
(103, 'unpaid'),
(104, 'unpaid'),
(105, 'unpaid'),
(106, 'unpaid'),
(107, 'unpaid'),
(108, 'paid'),

(109, 'unpaid'),
(110, 'paid'),
(111, 'unpaid'),
(112, 'paid'),
(113, 'paid'),
(114, 'paid'),
(115, 'unpaid'),
(116, 'unpaid'),

(117, 'unpaid'),
(118, 'paid'),
(119, 'unpaid'),
(120, 'unpaid'),
(121, 'unpaid'),
(122, 'paid'),
(123, 'unpaid'),
(124, 'paid'),

(125, 'unpaid'),
(126, 'unpaid'),
(127, 'unpaid'),
(128, 'paid'),
(129, 'unpaid'),
(130, 'unpaid'),
(131, 'unpaid'),
(132, 'unpaid');

-- 
-- Table structure for table 'Patients'
--

CREATE TABLE patients (
	patient_id 				smallint(6) NOT NULL,
	address_id 				smallint(6) NOT NULL,
	first_name 				varchar(15) NOT NULL,
	last_name 				varchar(15) NOT NULL,
	birth_date 				date NOT NULL,
	contact_number 			varchar(20) NOT NULL,
	email 					varchar(40) NOT NULL,
	gender 					ENUM('male', 'female') DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Patients'
--

INSERT INTO patients(patient_id, address_id, first_name, last_name, birth_date, contact_number, email, gender) VALUES
(101, 101, 'John', 'Smith', "1980-01-01", "0874525028", 'john_smith@yahoo.com', 'male'),
(102, 101, 'Mary', 'Smith', "1984-07-02", "0864123428", 'mary_smith@gmail.com', 'female'),
(103, 103, 'Scott', 'Murphy', "1989-10-15", "0872877543", 'scotty1989@gmail.com', 'male'),
(104, 104, 'Catherine', 'Martin', "1954-06-23", "0862852521", 'katty.martin@outlook.com', 'female'),
(105, 102, 'Tommy', 'Carroll', "1979-09-06", "0863428412", 'tommy1979@gmail.com', 'male'),
(106, 102, 'Sarah', 'Carroll', "1981-11-04", "0877754328", 'sarahcarroll@gmail.com', 'female'),

(107, 105, 'Alex', 'Natividad', "1979-08-04", "0864643028", 'naviAlex@yahoo.com', 'male'),
(108, 106, 'Marta', 'Kloss', "1984-07-02", "0874843425", 'marta_K2001@hotmail.com', 'female'),
(109, 107, 'Jeff', 'Larson', "1989-10-15", "0862877543", 'larson1989@yahoo.com', 'male'),
(110, 104, 'Dorothy', 'Martin', "2014-08-16", "0865251521", 'dotty_martin@outlook.com', 'female'),
(111, 108, 'Peter', 'Kloss', "1979-09-06", "0867628842", 'kloss.Peter@outlook.com', 'male'),
(112, 109, 'Akiko', 'Yoshi', "1981-11-04", "0878855628", 'yoshiAkiki@gmail.com', 'female');

-- 
-- Table structure for table 'Addresses'
--

CREATE TABLE addresses (
	address_id 				smallint(6) NOT NULL,
	street_name 			varchar(50) NOT NULL,
	town_name 				varchar(50) NOT NULL,
	county_name 			varchar(50) NOT NULL,
	eircode 				varchar(7) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Addresses'
--

INSERT INTO addresses(address_id, street_name, town_name, county_name, eircode) VALUES
(101, '123 Appian Way', 'Ballycastle', 'Cork', 'F66 DS77'),
(102, '56 Ocean Road', 'Fairhill', 'Cork', 'C87 DA85'),
(103, '102 Kinsale Road', 'Kilnahoe', 'Cork', 'B24 FC44'),
(104, 'Upper Cross Street', 'Kenmare', 'Kerry', 'E15 FC43'),
(105, 'St Mary''s Street', 'Dublin Hill', 'Cork', 'D87 EC32'),
(106, '24 Maple Lawn', 'Mallow', 'Cork', 'A22 DC12'),
(107, '2 Friars Road', 'Wilton', 'Cork', 'C22 EA45'),
(108, '21 Main Street', 'Macroom', 'Cork', 'C54 EA31'),

(109, '123 Centre Park Road', 'Ballintemple', 'Cork', 'C64 EA42'),
(110, '16 Pearse Road', 'Ballyphehane', 'Cork', 'A63 EB24'),
(111, '20 Tramore Road', 'Blackpool', 'Cork', 'A29 FC76'),
(112, 'Loreta Park', 'Cloyne', 'Cork', 'F41 BC31'),
(113, 'Lower Cork Road', 'Monkstown', 'Cork', 'E71 EB23'),
(114, '14 Cedar Grove', 'Blarney', 'Cork', 'A22 BC11'),
(115, '8 Ashgrove', 'Carrigaline', 'Cork', 'D27 EF43'),
(116, '6 Chestnut Mews', 'Whitegate', 'Cork', 'C32 FB11');

-- 
-- Table structure for table 'Dentist'
--

Create TABLE dentist (
	dentist_id				smallint(6) NOT NULL,
	referral_id				smallint(6) NOT NULL,
    clinic_id               smallint(6) NOT NULL,
    dentist_fname           varchar(15) NOT NULL,
    dentist_surname         varchar(15) NOT NULL,
	dentist_email           varchar(40) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Dentist'
--

INSERT INTO dentist(dentist_id, referral_id, clinic_id, dentist_fname, dentist_surname, dentist_email) VALUES
(101, 200, 101, "John", "O'Donnell", 'john_smith@theglebe.com'),
(102, 300, 102, "Heather", "Sharkey", 'dr.sharkey.heather@seapoint.com'),
(103, 400, 103, "Ian", "Chen", 'ian.h.chen@yahoo.com'),
(104, 500, 104, "Gary", "Bonner", 'drG_bonner@outlook.com'),
(105, 400, 102, "Simon", "Buckley", 'dr.buckley.simon@seapoint.com'),
(106, 500, 101, "Gita", "Singh", 'dr.singh.gita@seapoint.com'),
(107, 300, 103, "Geraldine", "Davis", 'davis_dentisry@yahoo.com'),
(108, 200, 102, "Greta", "Fischer", 'drgreta.fischer@theglebe.com');

-- 
-- Table structure for table 'Clinic'
--

CREATE TABLE clinic (
	clinic_id 		    	smallint(6) NOT NULL,
	clinic_name 			varchar(50) NOT NULL,
	street_name 			varchar(50) NOT NULL,
	town_name 				varchar(50) NOT NULL,
	county_name 			varchar(50) NOT NULL,
	eircode 				varchar(7) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Clinic'
--

INSERT INTO clinic(clinic_id, clinic_name, street_name, town_name, county_name, eircode) VALUES
(101, 'The Glebe Clinic', 'Bru Na Mara', 'Ballycastle', 'Cork', 'F66 DS77'),
(102, 'Seapoint Dental Clinic', '56 Ocean Road', 'Ballycastle', 'Cork', 'C87 DA85'),
(103, 'Harcourt Dental', '52 Harcourt Street', 'City Centre', 'Dublin', 'D2 FC43'),
(104, 'Ready Steady Smiles', '12 Bridge Street', 'Blarney', 'Cork', 'A22 DC12'),
(105, 'Salthill Dentists', '21 Main Street', 'Salthill', 'Galway', 'C54 EA31');

-- 
-- Table structure for table 'Appointments'
--

CREATE TABLE appointments (
	appointment_id 			int(11) NOT NULL,
	patient_id 				smallint(6) NOT NULL,
    invoice_id 				int(11) NOT NULL,
	appointment_date 		date NOT NULL,
	appointment_starttime	time NOT NULL,
	appointment_status 		ENUM('active', 'complete', 'cancelled') DEFAULT 'active',
	date_created			date DEFAULT CURRENT_DATE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Appointments'
--

INSERT INTO appointments(appointment_id, patient_id, invoice_id, appointment_date, appointment_starttime, appointment_status, date_created) VALUES
(101, 101, 101, "2021-04-07", "14:30:00", "complete", "2021-0-05"),
(102, 102, 102, "2021-03-27", "10:00:00", "cancelled", "2021-02-12"),
(103, 103, 103, "2021-03-30", "13:30:00", "complete", "2021-03-11"),
(104, 104, 104, "2021-02-28", "14:00:00", "complete", "2021-01-12"),
(105, 105, 105, "2021-01-02", "12:30:00", "complete", "2020-12-05"),
(106, 106, 106, "2021-03-01", "14:00:00", "cancelled", "2021-01-12"),
(107, 102, 107, "2020-12-30", "11:00:00", "complete", "2020-12-11"),
(108, 106, 108, "2021-03-11", "09:00:00", "complete", "2021-02-12"),

(109, 101, 109, "2021-04-27", "08:00:00", "active", "2021-04-05"),
(110, 102, 110, "2021-04-27", "09:00:00", "active", "2021-04-12"),
(111, 103, 111, "2021-04-30", "13:00:00", "active", "2021-04-11"),
(112, 104, 112, "2021-04-28", "14:00:00", "cancelled", "2021-04-12"),
(113, 105, 113, "2021-05-02", "08:00:00", "cancelled", "2021-04-05"),
(114, 106, 114, "2021-05-01", "09:00:00", "active", "2021-03-12"),
(115, 104, 115, "2021-05-06", "13:00:00", "active", "2021-04-11"),
(116, 110, 116, "2021-05-10", "08:00:00", "complete", "2021-04-12"),

(117, 107, 117, "2021-03-27", "15:00:00", "complete", "2021-04-05"),
(118, 108, 118, "2021-02-27", "09:30:00", "complete", "2021-04-12"),
(119, 109, 119, "2021-04-01", "12:30:00", "cancelled", "2021-04-11"),
(120, 105, 120, "2021-04-29", "11:30:00", "active", "2021-04-12"),
(121, 111, 121, "2021-03-02", "10:00:00", "complete", "2021-04-05"),
(122, 112, 122, "2021-02-01", "14:00:00", "cancelled", "2021-03-12"),
(123, 109, 123, "2021-04-16", "12:30:00", "complete", "2021-04-11"),
(124, 112, 124, "2021-04-19", "08:30:00", "complete", "2021-04-12"),

(125, 111, 125, "2021-04-27", "14:30:00", "cancelled", "2021-04-03"),
(126, 110, 126, "2021-04-27", "13:00:00", "active", "2021-04-20"),
(127, 109, 127, "2021-04-30", "08:00:00", "active", "2021-04-05"),
(128, 107, 128, "2021-04-28", "08:30:00", "cancelled", "2021-04-21"),
(129, 108, 129, "2021-05-02", "10:00:00", "active", "2021-04-07"),
(130, 112, 130, "2021-05-01", "13:00:00", "active", "2021-03-08"),
(131, 107, 131, "2021-05-06", "14:30:00", "active", "2021-04-15"),
(132, 111, 132, "2021-05-10", "11:00:00", "active", "2021-04-17");

-- 
-- Table structure for table 'Procedures'
--

CREATE TABLE procedures (
	procedures_id 			int(11) NOT NULL,
	invoice_id				int(11) NOT NULL,
	treatment_id			smallint(6) DEFAULT 101
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Procedures'
--

INSERT INTO procedures(procedures_id, invoice_id, treatment_id) VALUES
(101, 101, 101),
(102, 101, 203),
(103, 102, 102),
(104, 103, 202),
(105, 103, 203),
(106, 103, 206),
(107, 104, 202),
(108, 104, 204),
(109, 105, 205),
(110, 105, 202),
(111, 106, 103),
(112, 107, 203),
(113, 107, 205),
(114, 108, 204),

(115, 109, 101),
(116, 109, 201),
(117, 110, 101),
(118, 110, 201),
(119, 111, 205),
(120, 112, 103),
(121, 113, 102),
(122, 114, 201),
(123, 114, 205),
(124, 114, 206),
(125, 115, 101),
(126, 115, 206),
(127, 116, 101),
(128, 116, 205),
(129, 116, 203),

(130, 117, 101),
(131, 117, 201),
(132, 117, 101),
(133, 118, 202),
(134, 118, 203),
(135, 119, 103),
(136, 120, 101),
(137, 120, 201),
(138, 121, 101),
(139, 122, 102),
(140, 123, 101),
(141, 123, 202),
(142, 123, 101),
(143, 124, 204),
(144, 124, 206),

(145, 125, 103),
(146, 126, 201),
(147, 126, 101),
(148, 127, 204),
(149, 127, 205),
(150, 128, 102),
(151, 129, 102),
(152, 129, 201),
(153, 130, 205),
(154, 130, 206),
(155, 131, 101),
(156, 131, 206),
(157, 132, 101),
(158, 132, 205),
(159, 132, 206);

-- 
-- Table structure for table 'Follow Up'
--

CREATE TABLE follow_up (
	followup_id				int(11) NOT NULL,
	appointment_id 			int(11) NOT NULL,
	next_appointment		datetime,
	followup_status			ENUM('complete', 'pending') DEFAULT 'pending'
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Follow Up'
--

INSERT INTO follow_up(followup_id, appointment_id, next_appointment, followup_status) VALUES
(101, 101, "2021-04-27 08:00:00", 'complete'),
(102, 102, "2021-04-27 13:00:00", 'complete'),
(103, 103, "2021-04-30 08:00:00", 'complete'),
(104, 104, "2021-04-28 08:00:00", 'complete'),
(105, 105, "2021-05-02 08:00:00", 'complete'),
(106, 106, "2021-05-01 09:00:00", 'complete'),
(107, 107, "2021-05-06 13:00:00", 'complete'),
(108, 108, "2021-05-11 08:00:00", 'complete'),

(109, 109, "2021-07-10 08:00:00", 'pending'),
(110, 110, "2021-07-11 13:00:00", 'complete'),
(111, 111, "2021-07-10 08:00:00", 'pending'),
(112, 112, "2021-07-10 08:00:00", 'pending'),
(113, 113, "2021-07-10 08:00:00", 'pending'),
(114, 114, "2021-07-12 09:00:00", 'complete'),
(115, 115, "2021-07-10 08:00:00", 'pending'),
(116, 116, "2021-07-10 08:00:00", 'pending');

-- 
-- Table structure for table 'Follow Up Procedures'
--

CREATE TABLE followup_procedures (
	f_procedures_id 		int(11) NOT NULL,
	followup_id				int(11) NOT NULL,
	treatment_id			smallint(6) DEFAULT 101
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Follow Up Procedures'
--

INSERT INTO followup_procedures (f_procedures_id, followup_id, treatment_id) VALUES
(101, 102, 203),
(102, 102, 205),
(103, 106, 204),
(104, 106, 208),
(105, 101, 207),
(106, 103, 202),
(107, 103, 212),
(108, 104, 210),
(109, 105, 204),
(110, 107, 206),
(111, 108, 211),
(112, 108, 209),

(113, 109, 211),
(114, 110, 205),
(115, 110, 204),
(116, 111, 209),
(117, 111, 208),
(118, 112, 204),
(119, 113, 212),
(120, 113, 211),
(121, 114, 205),
(122, 115, 210),
(123, 116, 214),
(124, 116, 212);

-- 
-- Table structure for table 'Treatment Details'
--

CREATE TABLE treatment_details (
	treatment_id 			smallint(6) NOT NULL,
	referral_id				smallint(6) NOT NULL,
	treatment_name 			varchar(50) NOT NULL,
	treatment_description 	text(100),
	treatment_duration 		time NOT NULL,
	treatment_fee 			decimal(10,2) NOT NULL,
	last_updated 			date DEFAULT CURRENT_DATE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Treatment Details'
--

INSERT INTO treatment_details(treatment_id, referral_id, treatment_name, treatment_description, treatment_duration, treatment_fee, last_updated) VALUES
(101, 100, 'Consultation', 'Default - Consultation fee', "0:15:00", 20.00, "2015-06-07"),
(102, 100, 'Cancellation', 'Default - No Cancellation fee', "0:00:00", 0.00, "2015-06-07"),
(103, 100, 'Late Cancellation', 'Default - Late Cancellation fee', "0:00:00", 10.00, "2015-06-07"),
(201, 100, 'Oral Health Check Up', 'Routine oral health check', "0:15:00", 25.00, "2021-02-12"),
(202, 100, 'Root Canal', 'Removal of tooth pulp', "01:00:00", 25.00, "2021-01-09"),
(203, 100, 'Dental Crowns', 'Enamel capping of tooth', "01:00:00", 125.00, "2018-11-19"),
(204, 100, 'Tooth Extraction', 'Removal of tooth', "00:30:00", 95.00, "2019-04-07"),
(205, 100, 'Scale and Polish', 'Polish and cleaning of teeth', "00:30:00", 55.00, "2013-05-23"),
(206, 100, 'X-ray', 'Standard X-ray', "00:10:00", 25.00, "2011-04-13"),

(207, 200, 'Clear Aligners', 'Teeth straightners', "0:00:00", 0.00, "2015-06-07"),
(208, 200, 'Palate Expanders', 'Fitting of orthodontic RPE', "00:00:00", 0.00, "2020-01-26"),
(209, 300, 'Gum Grafts', 'Soft tissue graft', "00:00:00", 0.00, "2017-12-09"),
(210, 300, 'Dental Implant Placement', 'Surgical placement of endosseous implant', "00:00:00", 0.00, "2017-02-27"),
(211, 400, 'Cyst Removal', 'Surgical removal of cyst', "00:00:00", 0.00, "2015-08-29"),
(212, 400, 'Surgical Tooth Removal', 'Removal of embedded or impacted teeth', "00:00:00", 0.00, "2017-04-03"),
(213, 500, 'Tooth Sealant', 'For cavity protection', "00:00:00", 0.00, "2018-02-23"),
(214, 500, 'Paediatric Pulp Therapy', 'Tooth decay treatment', "00:00:00", 0.00, "2020-09-19");

-- 
-- Table structure for table 'Referral Details'
--

Create TABLE referral_details (
    referral_id             smallint(6) NOT NULL,
    speciality              varchar(50) NOT NULL   
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table 'Referral Details'
--

INSERT INTO referral_details(referral_id, speciality) VALUES
(100, "In-House"),
(200, "Orthodontics"),
(300, "Periodontics"),
(400, "Oral/Maxillofacial Surgery"),
(500, "Pediatric Dentistry");

--
-- Primary Keys for dumped tables
--

--
-- Primary Key for table 'Treatment Details'
--

ALTER TABLE treatment_details
	ADD PRIMARY KEY (treatment_id),
	MODIFY treatment_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- Primary Key for table 'Patients'
--

ALTER TABLE patients
	ADD PRIMARY KEY (patient_id),
	MODIFY patient_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- Primary Key for table 'Cheque Payment'
--
ALTER TABLE cheque_payment
	ADD PRIMARY KEY (cheque_id),
	MODIFY cheque_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- Primary Key for table 'Card Payment'
--
ALTER TABLE card_payment
	ADD PRIMARY KEY (card_id),
	MODIFY card_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- Primary Key for table 'Payment Method'
--
ALTER TABLE payment_method
	ADD PRIMARY KEY (payment_id),
	MODIFY payment_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- Primary Key for table 'Addresses'
--
ALTER TABLE addresses
	ADD PRIMARY KEY (address_id),
	MODIFY address_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- Primary Key for table 'Invoice'
--	
ALTER TABLE invoice
	ADD PRIMARY KEY (invoice_id),
	MODIFY invoice_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- Primary Key for table 'Appointments'
--
ALTER TABLE appointments
	ADD PRIMARY KEY (appointment_id),
	MODIFY appointment_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- Primary Key for table 'Follow Up'
--
ALTER TABLE follow_up
	ADD PRIMARY KEY (followup_id),
	MODIFY followup_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- Primary Key for table 'Follow Up Procedures'
--
ALTER TABLE followup_procedures
	ADD PRIMARY KEY (f_procedures_id),
	MODIFY f_procedures_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- Primary Key for table 'Procedures'
--
ALTER TABLE procedures
	ADD PRIMARY KEY (procedures_id),
	MODIFY procedures_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- Primary Key for table 'Referral Details'
--
ALTER TABLE referral_details
	ADD PRIMARY KEY (referral_id),
	MODIFY referral_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=600;

--
-- Primary Key for table 'Dentist'
--
ALTER TABLE dentist
	ADD PRIMARY KEY (dentist_id),
	MODIFY dentist_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- Primary Key for table 'Clinic'
--
ALTER TABLE clinic
	ADD PRIMARY KEY (clinic_id),
	MODIFY clinic_id smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;
	

--
-- Constraints for dumped tables
--

--
-- Constraints for table 'Payment Method'
--
ALTER TABLE payment_method
	ADD CONSTRAINT payment_method_ibfk_1 FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id);

--
-- Constraints for table 'Card Payment'
--
ALTER TABLE card_payment
	ADD CONSTRAINT card_payment_ibfk_1 FOREIGN KEY (payment_id) REFERENCES payment_method(payment_id);

--
-- Constraints for table 'Cheque Payment'
--
ALTER TABLE cheque_payment
	ADD CONSTRAINT cheque_payment_ibfk_1 FOREIGN KEY (payment_id) REFERENCES payment_method(payment_id),
	ADD CONSTRAINT chequepayment_ibuc_1 UNIQUE (cheque_number, sort_code, IBAN);

--
-- Constraints for table 'Patients'
--
ALTER TABLE patients
	ADD CONSTRAINT patients_ibfk_1 FOREIGN KEY (address_id) REFERENCES addresses(address_id),
	ADD CONSTRAINT patients_ibuc_1 UNIQUE (first_name, last_name, birth_date);

--
-- Constraints for table 'Appointments'
--	
ALTER TABLE appointments
	ADD CONSTRAINT appointments_ibfk_1 FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    ADD CONSTRAINT appointments_ibfk_2 FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	ADD CONSTRAINT chk_time_1 CHECK (appointment_starttime >= "08:00:00" AND appointment_starttime <= "15:30:00");

--
-- Constraints for table 'Follow Up'
--
ALTER TABLE follow_up
	ADD CONSTRAINT follow_up_ibfk_1 FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id);

--
-- Constraints for table 'Follow Up Procedures'
--
ALTER TABLE followup_procedures
	ADD CONSTRAINT fol_procedures_ibfk_1 FOREIGN KEY (treatment_id) REFERENCES treatment_details(treatment_id),
	ADD CONSTRAINT fol_procedures_ibfk_2 FOREIGN KEY (followup_id) REFERENCES follow_up(followup_id);

--
-- Constraints for table 'Procedures'
--	
ALTER TABLE procedures
	ADD CONSTRAINT procedures_ibfk_1 FOREIGN KEY (treatment_id) REFERENCES treatment_details(treatment_id),
	ADD CONSTRAINT procedures_ibfk_2 FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id);

--
-- Constraints for table 'Treatment Details'
--
ALTER TABLE treatment_details
	ADD CONSTRAINT treatments_ibfk_1 FOREIGN KEY (referral_id) REFERENCES referral_details(referral_id);

--
-- Constraints for table 'Dentist'
--
ALTER TABLE dentist
	ADD CONSTRAINT dentist_ibfk_1 FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id),
	ADD CONSTRAINT dentist_ibfk_2 FOREIGN KEY (referral_id) REFERENCES referral_details(referral_id);

--
-- Constraints for table 'Addresses'
--
ALTER TABLE addresses 
	ADD CONSTRAINT addresses_ibuc_1 UNIQUE (eircode);

--
-- Create Views
--

--
-- View 'Unpaid Bills'
--
CREATE VIEW `View Unpaid Bills` AS
SELECT PatientName, A.invoice_id, TotalFees, TotalPaid, (TotalFees - TotalPaid) AS TotalRemain, appointment_status, DaysUnpaid, invoice_status
FROM (SELECT invoice.invoice_id, SUM(treatment_details.treatment_fee) AS TotalFees
FROM invoice
LEFT JOIN procedures ON procedures.invoice_id = invoice.invoice_id
LEFT JOIN treatment_details ON treatment_details.treatment_id = procedures.treatment_id GROUP BY invoice.invoice_id) AS A
INNER JOIN (SELECT appointment_id, appointment_status, invoice.invoice_id, invoice_status, SUM(IFNULL(payment_method.amount_paid, 0)) AS TotalPaid, CONCAT(patients.first_name, " ", patients.last_name) AS PatientName, DATEDIFF(now(), appointments.appointment_date) AS DaysUnpaid
FROM appointments
LEFT JOIN invoice ON appointments.invoice_id=invoice.invoice_id
LEFT JOIN patients ON appointments.patient_id=patients.patient_id
LEFT JOIN payment_method ON payment_method.invoice_id = invoice.invoice_id AND (payment_status="approved" OR payment_status IS NULL) GROUP BY invoice.invoice_id) AS B
ON A.invoice_id=B.invoice_id WHERE invoice_status="unpaid" GROUP BY appointment_id;

--
-- View 'Overdue Bills'
--
CREATE VIEW `View Overdue Bills` AS
SELECT patient_id, A.invoice_id, PatientName, (TotalFees - TotalPaid) AS TotalRemain, DaysUnpaid, invoice_status
FROM (SELECT invoice.invoice_id, SUM(treatment_details.treatment_fee) AS TotalFees
FROM invoice
LEFT JOIN procedures ON procedures.invoice_id = invoice.invoice_id
LEFT JOIN treatment_details ON treatment_details.treatment_id = procedures.treatment_id GROUP BY invoice.invoice_id) AS A
INNER JOIN (SELECT appointment_id, invoice.invoice_id, invoice_status, SUM(IFNULL(payment_method.amount_paid, 0)) AS TotalPaid, appointments.patient_id, CONCAT(patients.first_name, " ", patients.last_name) AS PatientName, DATEDIFF(now(), appointments.appointment_date) AS DaysUnpaid
FROM appointments
LEFT JOIN invoice ON appointments.invoice_id=invoice.invoice_id
LEFT JOIN patients ON appointments.patient_id=patients.patient_id
LEFT JOIN payment_method ON payment_method.invoice_id = invoice.invoice_id WHERE (payment_status="approved" OR payment_status IS NULL) GROUP BY invoice.invoice_id) AS B
ON A.invoice_id=B.invoice_id WHERE (DaysUnpaid > 30 OR ((TotalFees - TotalPaid) > 50) AND DaysUnpaid > 0) AND invoice_status="unpaid" GROUP BY appointment_id;


--
-- View 'Open Apppointments'
--
CREATE VIEW `View Open Apppointments` AS
SELECT PatientName, appointment_id, appointment_date, TIME_FORMAT(appointment_starttime, "%H:%i") AS StartTime, TIME_FORMAT(ADDTIME(appointment_starttime, TotalTime), "%H:%i") AS EndTime 
FROM (SELECT invoice.invoice_id, SEC_TO_TIME(SUM(TIME_TO_SEC(treatment_details.treatment_duration))) AS TotalTime
FROM invoice
LEFT JOIN procedures ON procedures.invoice_id = invoice.invoice_id
LEFT JOIN treatment_details ON treatment_details.treatment_id = procedures.treatment_id GROUP BY invoice.invoice_id) AS A
INNER JOIN (SELECT appointment_id, appointment_date, appointment_starttime, appointment_status, invoice.invoice_id, invoice_status, CONCAT(patients.first_name, " ", patients.last_name) AS PatientName
FROM appointments
LEFT JOIN invoice ON appointments.invoice_id=invoice.invoice_id
LEFT JOIN patients ON appointments.patient_id=patients.patient_id) AS B
ON A.invoice_id=B.invoice_id WHERE appointment_status="active" GROUP BY appointment_date, appointment_starttime;

--
-- View 'View Wk17 Appointments'
--
CREATE VIEW `View Wk17 Appointments` AS
SELECT CONCAT(first_name, " ", last_name) AS "Patient Name", appointment_id, appointment_date, TIME_FORMAT(appointment_starttime, "%H:%i") AS StartTime, contact_number, email, CONCAT(street_name, ", ", town_name, ", ", county_name, ", ", eircode) AS PostalAddress 
FROM appointments, patients, addresses
WHERE appointments.patient_id=patients.patient_id AND patients.address_id=addresses.address_id AND appointment_status="active" AND (appointment_date BETWEEN "2021-04-27" AND "2021-05-03")
ORDER BY appointment_date, appointment_starttime;