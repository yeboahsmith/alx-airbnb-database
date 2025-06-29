/* -------------------------------------------------
   USERS
--------------------------------------------------*/
CREATE TABLE users (
    user_id      BIGSERIAL PRIMARY KEY,
    full_name    VARCHAR(100)      NOT NULL,
    email        VARCHAR(255)      NOT NULL UNIQUE,
    phone        VARCHAR(20),
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* -------------------------------------------------
   PROPERTIES
--------------------------------------------------*/
CREATE TABLE properties (
    property_id  BIGSERIAL PRIMARY KEY,
    title        VARCHAR(150)      NOT NULL,
    location     TEXT,
    nightly_rate NUMERIC(10,2)     NOT NULL CHECK (nightly_rate >= 0),
    owner_id     BIGINT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/* -------------------------------------------------
   BOOKINGS
--------------------------------------------------*/
CREATE TABLE bookings (
    booking_id   BIGSERIAL PRIMARY KEY,
    user_id      BIGINT            NOT NULL REFERENCES users(user_id)      ON DELETE CASCADE,
    property_id  BIGINT            NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    check_in     DATE              NOT NULL,
    check_out    DATE              NOT NULL,
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dates        CHECK (check_out > check_in),
    /* Prevent double‑booking of the same unit on the same start date.
       Relax or extend as your business rules dictate. */
    UNIQUE (property_id, check_in)
);

/* -------------------------------------------------
   PAYMENTS
--------------------------------------------------*/
CREATE TABLE payments (
    payment_id    BIGSERIAL PRIMARY KEY,
    booking_id    BIGINT            NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    amount        NUMERIC(10,2)     NOT NULL CHECK (amount >= 0),
    currency      CHAR(3)           NOT NULL DEFAULT 'USD',
    payment_status VARCHAR(20)      NOT NULL,     -- e.g. PENDING, PAID, FAILED, REFUNDED
    paid_at       TIMESTAMPTZ
);

/* -------------------------------------------------
   REVIEWS
--------------------------------------------------*/
CREATE TABLE reviews (
    review_id    BIGSERIAL PRIMARY KEY,
    user_id      BIGINT            NOT NULL REFERENCES users(user_id)      ON DELETE CASCADE,
    property_id  BIGINT            NOT NULL REFERENCES properties(property_id) ON DELETE CASCADE,
    rating       SMALLINT          NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment      TEXT,
    created_at   TIMESTAMPTZ       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    /* One review per user per property (per stay). */
    UNIQUE (user_id, property_id)
);

/* =================================================
   SECONDARY INDEXES FOR PERFORMANCE
   (PK/FK columns receive indexes automatically)
===================================================*/
-- Faster look‑ups of a user’s bookings
CREATE INDEX idx_bookings_user_id      ON bookings(user_id);

-- Common search: all bookings for a given property
CREATE INDEX idx_bookings_property_id  ON bookings(property_id);

-- Payments traced back through booking
CREATE INDEX idx_payments_booking_id   ON payments(booking_id);

-- Display reviews by property or by user
CREATE INDEX idx_reviews_property_id   ON reviews(property_id);
CREATE INDEX idx_reviews_user_id       ON reviews(user_id);

-- List properties owned by a particular host
CREATE INDEX idx_properties_owner_id   ON properties(owner_id);

