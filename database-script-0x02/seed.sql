/* ===============================================================
   SAMPLE DATA
   — load Users first, then Properties, Bookings, Payments, Reviews
=================================================================*/

/* ---------- USERS ------------------------------------------------ */
INSERT INTO users (user_id, full_name, email, phone)
VALUES
  (1, 'Alice Johnson', 'alice@example.com',  '+14155550101'),
  (2, 'Bob Mensah',    'bob@example.com',    '+233201234567'),
  (3, 'Clara Lee',     'clara@example.com',  '+447911123456');

/* ---------- PROPERTIES ------------------------------------------- */
INSERT INTO properties (property_id, title, location, nightly_rate, owner_id)
VALUES
  (1, 'Cozy Loft in Accra',        'Accra, Ghana',            120.00, 2),  -- owned by Bob
  (2, 'Lakeview Cabin',            'Lake Bosumtwi, Ghana',     90.00, 2),
  (3, 'Beach House',               'Cape Coast, Ghana',       200.00, 3),  -- owned by Clara
  (4, 'Modern Apartment',          'Kumasi, Ghana',            80.00, 1);  -- owned by Alice

/* ---------- BOOKINGS --------------------------------------------- */
INSERT INTO bookings (booking_id, user_id, property_id, check_in,  check_out)
VALUES
  (1, 1, 1, '2025-07-10', '2025-07-15'),   -- Alice → Loft
  (2, 2, 3, '2025-08-05', '2025-08-08'),   -- Bob   → Beach House
  (3, 1, 2, '2025-12-20', '2025-12-27'),   -- Alice → Cabin
  (4, 3, 4, '2025-07-12', '2025-07-16');   -- Clara → Apartment

/* ---------- PAYMENTS --------------------------------------------- */
INSERT INTO payments (payment_id, booking_id, amount, currency, payment_status, paid_at)
VALUES
  (1, 1, 600.00, 'USD', 'PAID',    '2025-06-30 10:00:00+00'),
  (2, 2, 600.00, 'USD', 'PAID',    '2025-06-30 10:05:00+00'),
  (3, 3, 630.00, 'USD', 'PENDING', NULL),   -- awaiting payment
  (4, 4, 320.00, 'USD', 'PAID',    '2025-06-30 10:10:00+00');

/* ---------- REVIEWS ---------------------------------------------- */
INSERT INTO reviews (review_id, user_id, property_id, rating, comment)
VALUES
  (1, 1, 1, 5, 'Lovely loft, very clean and central.'),
  (2, 2, 3, 4, 'Amazing beach house, but Wi‑Fi was slow.'),
  (3, 3, 4, 4, 'Modern flat with comfy beds.'),
  (4, 1, 2, 5, 'Beautiful lakeside cabin—so relaxing!');

