/*
    Queries have a query number (Q) that corresponds to a part in the narrtive document (ProjectReport.pdf).
*/

--
-- Section 1: Booking Appointments
--

-- Q1.1: Create some new patient records
INSERT INTO patients(address_id, first_name, last_name, birth_date, contact_number, email, gender) VALUES
(113, 'George', 'Wilson', "1999-08-17", "0875468971", 'wilsons99@yahoo.com', 'male'),
(114, 'Sam', 'Smith', "2011-03-24", "0868642197", 'sammySthy_2011@gmail.com', 'female'),
(115, 'Maria', 'Alonso', "1995-03-14", "0868642197", 'maria.alonso@outlook.com', 'female');

-- Q1.2: Query the "Overdue Bills" view to see if patient meets criteria for overdue bills
SELECT * FROM `view overdue bills` WHERE PatientName="John Smith";

-- Q1.3: Query the view for appointments after the 28th April
SELECT * FROM `view open apppointments` WHERE appointment_date >= "2021-04-28";

-- Q1.4: To demonstrate creating a new appointment for an existing patient (patient_id 106)
INSERT INTO invoice(invoice_id) VALUES (0);
INSERT INTO appointments(invoice_id, patient_id, appointment_date, appointment_starttime) VALUES 
((SELECT LAST_INSERT_ID()), 106, "2021-07-08", "08:30:00");
INSERT INTO procedures(invoice_id, treatment_id) VALUES ((SELECT LAST_INSERT_ID()), 101);

-- Q1.5: Insert for new procedures for an appointment using treatment id
INSERT INTO procedures(invoice_id, treatment_id) VALUES (109,101), (109,205), (109,203);

--  Insert for new procedures for an appointment using treatment name
INSERT INTO procedures(invoice_id, treatment_id) VALUES 
(109, (SELECT treatment_id FROM treatment_details WHERE treatment_name="Consultation")), 
(109, (SELECT treatment_id FROM treatment_details WHERE treatment_name="Scale and Polish")), 
(109, (SELECT treatment_id FROM treatment_details WHERE treatment_name="Dental Crowns"));

-- Q1.6: Update a procedure duration and fee
UPDATE treatment_details SET treatment_duration="00:45:00", treatment_fee=110.00, last_updated=CURRENT_DATE() WHERE treatment_id=203;

--
-- Section 2: Appointment Cancelations
--

-- Q2.1 To demonstrate rearranging the time and date of an existing appointment
UPDATE appointments
SET appointment_date = "2021-05-18", appointment_starttime="09:45"
WHERE appointment_id=117;

-- Q2.2 Cancel an appointment, remove procedures from bill and add a late cancellation fee
-- Cancel all procedures for the appointment
DELETE FROM procedures WHERE invoice_id=109; 

-- Update the appointment status to 'cancelled'
UPDATE appointments, procedures
SET appointment_status = "cancelled"
WHERE appointment_id=109;

-- Add a late cancellation fee to the appointment invoice using treatment id 103
INSERT INTO procedures(invoice_id, treatment_id) VALUES (109, 103);

--
-- Section 3: Appointment Visits
--

-- Q3.1 List all the treatments that are planned for appointment_id 103
SELECT treatment_id, treatment_name, PatientName, patient_id, appointment_id, appointment_date
FROM (SELECT invoice.invoice_id, treatment_details.treatment_id, treatment_details.treatment_name
FROM treatment_details
LEFT JOIN procedures ON procedures.treatment_id = treatment_details.treatment_id 
LEFT JOIN invoice ON invoice.invoice_id = procedures.invoice_id) AS A
INNER JOIN (SELECT appointment_id, appointment_date, invoice.invoice_id, appointments.patient_id, CONCAT(patients.first_name, " ", patients.last_name) AS PatientName
FROM appointments
LEFT JOIN invoice ON appointments.invoice_id=invoice.invoice_id
LEFT JOIN patients ON appointments.patient_id=patients.patient_id) AS B
ON A.invoice_id=B.invoice_id WHERE appointment_id=103;


-- Q3.2 Update appointment status as completed for appointmet id 116
 UPDATE appointments SET appointment_status="complete" WHERE appointment_id=116;

--
-- Section 4: Follow Up Appointments
--

-- Q4.1: Create a new follow up appointment
INSERT INTO follow_up(appointment_id, next_appointment) VALUES (117, "2021-05-14 11:30:00");

-- Q4.2: Add some treatments for the follow-up appointment 
INSERT INTO followup_procedures(followup_id, treatment_id) VALUES (117,101), (117,205), (117,203);

-- Add a surgical tooth removal procedure to follow up appointment 106
INSERT INTO followup_procedures(followup_id, treatment_id) VALUES 
(106,(SELECT treatment_id FROM treatment_details WHERE treatment_name="Surgical Tooth Removal"));


-- Q4.3: Selects all appointments that need a patient referral
SELECT appointments.appointment_id, CONCAT(patients.first_name, " ", patients.last_name) AS PatientName, treatment_details.treatment_id, treatment_details.treatment_name, treatment_details.referral_id
FROM treatment_details
INNER JOIN followup_procedures ON followup_procedures.treatment_id = treatment_details.treatment_id 
INNER JOIN follow_up ON follow_up.followup_id = followup_procedures.followup_id
INNER JOIN appointments ON appointments.appointment_id=follow_up.appointment_id
INNER JOIN patients ON appointments.patient_id=patients.patient_id WHERE referral_id!=100 AND followup_status="pending" GROUP BY PatientName, treatment_id;


-- Q4.4: Convert a follow up appointment to the appointments table
-- Create a new invoice
INSERT INTO invoice(invoice_id) VALUES (0);
-- Copy the appointment date/time in follow table to the new appointment record
INSERT INTO appointments(invoice_id, patient_id, appointment_date, appointment_starttime) VALUES 
((SELECT LAST_INSERT_ID()), 106, (SELECT next_appointment FROM follow_up WHERE followup_id=116), (SELECT next_appointment FROM follow_up WHERE followup_id=116));
-- Add a treatment to the procedures for the new appointment
INSERT INTO procedures(invoice_id, treatment_id) VALUES ((SELECT LAST_INSERT_ID()), 101);


-- Q4.5: Set the follow up appointment status field as "completed"
UPDATE follow_up SET followup_status="complete" WHERE followup_id=116;

--
-- Section 6: Referrals
--

-- Q6.1 Show all dentist with contact details who speciality is Orthodontics
SELECT CONCAT("Dr. ", dentist_fname, " ", dentist_surname) AS DentistName, dentist_email, CONCAT(clinic_name, ", ", street_name, ", ", town_name, ", ", county_name, ", ", eircode) AS Clinic
FROM dentist, referral_details, clinic WHERE dentist.referral_id=referral_details.referral_id AND dentist.clinic_id=clinic.clinic_id AND speciality="Orthodontics";

-- Show all dentists with contact details for a Dental Implant Placement referral
SELECT CONCAT("Dr. ", dentist_fname, " ", dentist_surname) AS DentistName, dentist_email, CONCAT(clinic_name, ", ", street_name, ", ", town_name, ", ", county_name, ", ", eircode) AS Clinic
FROM dentist
INNER JOIN referral_details ON dentist.referral_id=referral_details.referral_id
INNER JOIN clinic ON dentist.clinic_id=clinic.clinic_id
INNER JOIN treatment_details ON treatment_details.referral_id=referral_details.referral_id WHERE treatment_name="Dental Implant Placement";

--
-- Section 7: Payments
--

-- Q7.1: Insert for new payment using cash
INSERT INTO payment_method(invoice_id, payment_type, amount_paid) VALUES 
(109, 'cash', 10.00);

-- Q7.2: Insert for multiple new payments using cash, cheque and card payments
INSERT INTO payment_method(invoice_id, payment_type, amount_paid) VALUES (103, 'cash', 20.00);

INSERT INTO payment_method(invoice_id, payment_type, amount_paid) VALUES (104, 'cheque', 30.00);
INSERT INTO cheque_payment(payment_id, signatory_name, cheque_number, sort_code, IBAN) VALUES 
((SELECT LAST_INSERT_ID()), 'Catherine Martin', 344565445, "978435", 'IE33 BOFI 7983 2158 6326 56');

INSERT INTO payment_method(invoice_id, payment_type, amount_paid) VALUES (101, "Card", 89.00);
INSERT INTO card_payment(payment_id, holder_name, card_number, exp_date, card_type) VALUES 
((SELECT LAST_INSERT_ID()), 'John Smith', 546298745, "2024-08-06", 'Mastercard');

-- Q7.3: Cancel a payment transaction using invoice id
UPDATE payment_method, invoice
SET payment_status= "cancelled", invoice_status="unpaid"
WHERE payment_method.invoice_id=112 AND payment_date="2021-04-21";

--
-- Section 8: Weekly Tasks
--

-- Q8.1 Query for appointments during week 18
SELECT CONCAT(first_name, " ", last_name) AS "Patient Name", appointment_id, appointment_date, appointment_starttime, contact_number, email, CONCAT(street_name, ", ", town_name, ", ", county_name, ", ", eircode) AS PostalAddress 
FROM appointments, patients, addresses
WHERE appointments.patient_id=patients.patient_id AND patients.address_id=addresses.address_id AND appointment_status="active" AND (appointment_date BETWEEN "2021-05-04" AND "2021-05-10")
ORDER BY appointment_date, appointment_starttime;

-- Q8.2: List all the treatments fees (itemised bill) for a patient using appointment_id 103
SELECT treatment_id, treatment_name, treatment_fee, PatientName, patient_id, appointment_id
FROM (SELECT invoice.invoice_id, treatment_details.treatment_id, treatment_details.treatment_name, treatment_details.treatment_fee, treatment_details.referral_id
FROM treatment_details
LEFT JOIN procedures ON procedures.treatment_id = treatment_details.treatment_id 
LEFT JOIN invoice ON invoice.invoice_id = procedures.invoice_id) AS A
INNER JOIN (SELECT appointment_id, appointment_date, invoice.invoice_id, appointments.patient_id, CONCAT(patients.first_name, " ", patients.last_name) AS PatientName
FROM appointments
LEFT JOIN invoice ON appointments.invoice_id=invoice.invoice_id
LEFT JOIN patients ON appointments.patient_id=patients.patient_id) AS B
ON A.invoice_id=B.invoice_id WHERE appointment_id=103;

--
-- Section 9: 
--

-- Delete the follow up appointment 108 and all its planned procedures using follow up id
DELETE FROM followup_procedures WHERE followup_id=108;
DELETE FROM follow_up WHERE followup_id=108;

-- Delete a specific procedure for the follow up appointment 106 using treatment id.
DELETE FROM followup_procedures WHERE followup_id=106 and treatment_id=208;

-- Delete a tooth extraction procedure from follow up appointmnet 106
DELETE FROM followup_procedures WHERE followup_id=106 and treatment_id IN 
(SELECT treatment_id FROM treatment_details WHERE treatment_name="Tooth Extraction");


-- Select all patients who are under the age of 18
SELECT * FROM patients WHERE birth_date>"2003-04-24"
