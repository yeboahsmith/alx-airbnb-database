#Intitial Schema
Table: UserBooking
- user_id
- user_name
- property_id
- property_name
- booking_id
- booking_date
- duration
- amount
- payment_id
- payment_status
- review_id
- review_text

#Normalization Steps
 First Normal Form (1NF)
Eliminate repeating groups and ensure atomicity.
No multivalued fields or composite columns.

Already OK.

 Second Normal Form (2NF)
Remove partial dependencies: all non-key attributes must depend on the whole primary key.

Issue: If booking_id is the primary key, fields like user_name, property_name, review_text depend on parts of a composite concept (not fully dependent on booking_id).

Solution: Break into multiple tables based on entity themes.

 Third Normal Form (3NF)
Remove transitive dependencies: non-key attributes must not depend on other non-key attributes.

Issue: user_name depends on user_id, not directly on booking_id. Same with property_name on property_id.

#Final 3NF Schema
Table: Users
- user_id (PK)
- user_name
- other_user_info...

Table: Properties
- property_id (PK)
- property_name
- location
- other_property_info...

Table: Bookings
- booking_id (PK)
- user_id (FK)
- property_id (FK)
- booking_date
- duration

Table: Payments
- payment_id (PK)
- booking_id (FK)
- amount
- payment_status

Table: Reviews
- review_id (PK)
- user_id (FK)
- property_id (FK)
- review_text
- review_date

Here’s how we can **apply normalization up to 3NF** based on the information from the flowchart. I’ll outline:

1. **Initial Schema**
2. **Normalization Steps (1NF → 2NF → 3NF)**
3. **Final 3NF-Compliant Schema**
4. **Markdown Explanation**



###  1. Initial (Unnormalized) Schema


Table: UserBooking
- user_id
- user_name
- property_id
- property_name
- booking_id
- booking_date
- duration
- amount
- payment_id
- payment_status
- review_id
- review_text




###  2. Normalization Steps

####  First Normal Form (1NF)

* Eliminate repeating groups and ensure atomicity.
* No multivalued fields or composite columns.

**Already OK.**

####  Second Normal Form (2NF)

* Remove partial dependencies: all non-key attributes must depend on the whole primary key.

**Issue:** If `booking_id` is the primary key, fields like `user_name`, `property_name`, `review_text` depend on parts of a composite concept (not fully dependent on booking\_id).

**Solution:** Break into multiple tables based on entity themes.

####  Third Normal Form (3NF)

* Remove transitive dependencies: non-key attributes must not depend on other non-key attributes.

**Issue:** `user_name` depends on `user_id`, not directly on `booking_id`. Same with `property_name` on `property_id`.



###  3. Final 3NF Schema


Table: Users
- user_id (PK)
- user_name
- other_user_info...

Table: Properties
- property_id (PK)
- property_name
- location
- other_property_info...

Table: Bookings
- booking_id (PK)
- user_id (FK)
- property_id (FK)
- booking_date
- duration

Table: Payments
- payment_id (PK)
- booking_id (FK)
- amount
- payment_status

Table: Reviews
- review_id (PK)
- user_id (FK)
- property_id (FK)
- review_text
- review_date


# Database Normalization to 3NF

## Objective
Normalize the database schema derived from the user booking flow to the Third Normal Form (3NF) to eliminate redundancy and ensure data integrity.

## Step 1: First Normal Form (1NF)
We ensured that:
- All attributes are atomic (no multiple values in a single field).
- There are no repeating groups.

 Achieved 1NF.

## Step 2: Second Normal Form (2NF)
We removed partial dependencies:
- Attributes like `user_name`, `property_name`, and `review_text` were depending on part of the conceptual composite key (`booking_id`, `user_id`, `property_id`).

We decomposed the schema:
- Separated Users, Properties, Bookings, Payments, and Reviews into distinct entities.

Achieved 2NF.

## Step 3: Third Normal Form (3NF)
We removed transitive dependencies:
- `user_name` depends on `user_id`, not `booking_id`.
- `property_name` depends on `property_id`, not `booking_id`.

By referencing only foreign keys (user_id, property_id) in related tables and storing descriptive info only in the main entity tables, we eliminate redundancy.

Achieved 3NF.

## Final Schema
- **Users(user_id, user_name, …)**
- **Properties(property_id, property_name, …)**
- **Bookings(booking_id, user_id, property_id, duration, …)**
- **Payments(payment_id, booking_id, amount, status)**
- **Reviews(review_id, user_id, property_id, review_text, …)**

This design ensures:
- Minimal redundancy
- Referential integrity
- Data traceability across user activities (booking, payment, review)



