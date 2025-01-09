# Dental Practice Patient Appointment Database

This project is a fully designed SQL database for managing a dental practice. The database covers patient records, appointment scheduling, billing and payments, treatments, follow-ups, and reporting. It provides efficient data organization and simplifies operations for the practice.

---

## Features

### **1. Patient Management**
- Stores patient records, including first name, last name, birth date, contact details, email, and gender.
- Prevents duplicate patient records using constraints on full name and birth date.
- Manages patient addresses through a dedicated table with unique constraints on Eircode to avoid duplication.

### **2. Appointment Scheduling**
- Allows booking new appointments during business hours (08:00 AM to 03:30 PM).
- Prevents scheduling if a patient has overdue bills:
  - Bills unpaid for over 30 days.
  - Outstanding balances exceeding €50.
- Provides a view (`Open Appointments`) to display available time slots.
- Automatically assigns default values like `status` (“active”) and `date created` to new appointments.

### **3. Billing and Payments**
- Tracks payments with options for:
  - **Cheque Payments**: Stores cheque details such as cheque number, IBAN, and sort code.
  - **Card Payments**: Stores cardholder name, card type, number, and expiry date.
  - **Cash Payments**: Recorded directly in the payment method table.
- Links payments to invoices and calculates remaining balances automatically.
- Provides refund functionality by marking payments as “cancelled,” which adjusts the outstanding balance.
- Tracks overdue bills using the `Unpaid Bills` view, which lists unpaid invoices and outstanding amounts.

### **4. Treatment and Procedure Management**
- Maintains a catalog of treatments, each identified by a unique treatment ID, name, fee, and duration.
- Associates treatments with appointments, generating itemized invoices and total fees.
- Supports adding, updating, and removing treatments from appointments as required.
- Automatically adds a default “consultation” treatment for new patients.

### **5. Follow-Up and Referrals**
- Handles follow-up appointments for specialist treatments not provided in-house.
- Links follow-ups to the original appointments and tracks their status (“pending” or “complete”).
- Organizes referrals based on specialty codes, assigning the correct dentist for external procedures.
- Stores dentist and clinic contact details for efficient referral management.

### **6. Appointment Cancellations**
- Supports rescheduling or cancellation of appointments by updating their status.
- Automatically removes associated procedures when an appointment is cancelled.
- Tracks cancellation types with specific codes:
  - **General Cancellation (Code 102):** No additional charges.
  - **Late Cancellation (Code 103):** Adds a €10 fee to the invoice.

### **7. Weekly Appointment Reminders**
- Generates weekly views of upcoming appointments, including patient contact details.
- Allows filtering appointments by custom date ranges for scheduling and reminders.

### **8. Overdue Bills Tracking**
- Provides views to track overdue and unpaid bills.
- Displays itemized treatments and fees associated with each appointment.

### **9. Reports and Views**
- Supports various queries and views to simplify data access:
  - `Open Appointments`: Displays available appointment slots.
  - `Overdue Bills`: Tracks unpaid bills with outstanding balances.
  - `Weekly Appointments`: Lists appointments for the week for reminder purposes.
  - `Itemized Treatments`: Provides detailed breakdowns of treatments per appointment.

---

## Installation

### Prerequisites
- MySQL or any compatible SQL database system.
- SQL client (e.g., MySQL Workbench, DBeaver, or command-line tools).

### Steps
1. Clone this repository or download the SQL file.
   ```bash
   git clone https://github.com/your-username/dental-practice-database.git
   ```
2. Open your SQL client and connect to your database server.
3. Execute the SQL file to set up the database:
   ```sql
   SOURCE path/to/SQLExportDentistDB.sql;
   ```
4. Verify that the database (`DentistDB`) and its tables have been created successfully.

---

## Usage

### Querying the Database
- **Patient Records:** View all patients and their details.
  ```sql
  SELECT * FROM patients;
  ```
- **Check Open Appointment Slots:**
  ```sql
  SELECT * FROM Open_Appointments;
  ```
- **Track Overdue Bills:**
  ```sql
  SELECT * FROM Unpaid_Bills;
  ```
- **Generate Weekly Appointment Reminders:**
  ```sql
  SELECT * FROM Weekly_Appointments WHERE week_start_date = 'YYYY-MM-DD';
  ```

### Customizing Data
- Add new treatments or update treatment fees:
  ```sql
  INSERT INTO treatment_details (treatment_id, treatment_name, fee, duration) VALUES (211, 'Cyst Removal', 200, 60);
  ```
- Cancel an appointment:
  ```sql
  UPDATE appointments SET status = 'cancelled' WHERE appointment_id = 101;
  ```

---

## Schema Overview

### **Key Tables**
- **`patients`**: Stores patient details.
- **`appointments`**: Manages appointment records.
- **`invoice`**: Tracks billing and payment statuses.
- **`treatment_details`**: Stores treatment catalog.
- **`payment_method`**: Tracks payments (cheque, card, cash).

### **Views**
- **`Open_Appointments`**: Displays available slots.
- **`Unpaid_Bills`**: Tracks overdue bills.
- **`Weekly_Appointments`**: Lists appointments for the week.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contributing
Contributions are welcome! If you have suggestions for improvements, please fork the repository and submit a pull request.

---

## Contact
For questions or feedback, please contact:
- Name: pj-oboyle
- GitHub: [pj-oboyle](https://github.com/pj-oboyle)

---

Thank you for exploring this project! If you found it helpful, please give it a star on GitHub!

