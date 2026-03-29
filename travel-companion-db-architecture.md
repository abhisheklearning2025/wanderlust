# Travel Companion App — Database Architecture and DDL Design

## Database Strategy

A relational database is suitable for the core travel platform because the domain has strong entity relationships among users, preferences, destinations, reviews, restaurants, lodging options, itineraries, bookings, groups, loyalty events, and moderation workflows. Booking-oriented systems and travel planning platforms benefit from normalized schemas, constraints, and indexes for integrity and operational performance.[cite:14][cite:17][cite:20]

PostgreSQL is recommended as the primary system of record, with selective JSONB usage for provider payloads, flexible preference blobs, dynamic amenity maps, and external API snapshots. This balances relational consistency with controlled schema flexibility, which is useful in travel systems that combine structured transactional data with variable third-party content.[cite:16][cite:17]

## High-Level Data Domains

- Identity and traveler profile.
- Preferences and travel history.
- Destination catalog and taxonomy.
- Food, lodging, transportation, and attractions.
- Reviews, ratings, media, and tips.
- Itinerary planning and itinerary items.
- Booking intents and partner bookings.
- Real-time signals such as weather, events, and safety notices.
- Social groups and trip sharing.
- Rewards, points, and offers.
- Admin moderation and audit.

## Core Design Principles

- Normalize stable operational entities and use JSONB only for flexible provider-specific attributes.[cite:17]
- Separate catalog data from user-generated data.
- Support many-to-many relationships for destination tags, activities, cuisines, amenities, and accessibility features.
- Preserve recommendation explainability by storing recommendation runs, contributing factors, and user interaction outcomes.[cite:16]
- Model bookings, itineraries, and reviews as separate bounded subdomains even when tied to destinations.
- Store large media files outside the database and persist only metadata and moderation state.

## Suggested Schema Areas

### 1. Identity and Profile Schema

This schema stores users, profiles, travel personas, preference settings, accessibility needs, dietary preferences, budget preferences, and home locale data. The platform should preserve both the latest profile state and historical preference changes so recommendation quality can evolve with the user’s behavior.[cite:13][cite:16]

### 2. Destination Catalog Schema

This schema stores countries, regions, cities, destinations, destination types, seasonality, vibe tags, activities, cuisines, attractions, hidden gems, restaurant listings, lodging listings, local transport modes, accessibility notes, and partner reference identifiers. Even simple travel guide systems usually require structured country-city relationships and destination metadata before higher-level planning features can work well.[cite:14]

### 3. Recommendation and Interaction Schema

This schema stores search sessions, recommendation requests, recommendation result sets, ranked destination candidates, explanation labels, and subsequent interaction outcomes such as save, click, view, itinerary add, booking intent, and booking completion. AI trip planning systems typically separate ingestion, processing, and recommendation layers, so preserving recommendation events in the data model helps both analytics and model refinement.[cite:16]

### 4. Content and Community Schema

This schema stores reviews, ratings, uploaded photos and videos, tips, helpfulness votes, flags, moderation actions, and contributor badges. Community-driven travel platforms rely on persistent user-contributed content to improve trust and destination evaluation quality.[cite:12][cite:21]

### 5. Itinerary and Trip Schema

This schema stores trips, itinerary versions, day plans, itinerary items, transport legs, booking references, collaborators, offline packages, and sharing tokens. Itinerary-centric travel applications commonly model the trip as the parent entity and then add structured day-wise child items for activities, stays, and transport.[cite:15][cite:16][cite:20]

### 6. Booking and Commercial Schema

This schema stores partner providers, booking intents, booking line items, booking status transitions, price quotes, offers, reward accruals, referral rewards, and promotions. Reservation-oriented domains require accurate status tracking, key constraints, and linkages between offers, users, and providers.[cite:17]

## Recommended Core Tables

| Table | Purpose |
|---|---|
| app_user | Master user account |
| user_profile | Extended traveler profile |
| user_preference | Typed preferences such as mountain, beach, peaceful, party |
| user_budget_profile | Budget ranges and spending style |
| user_trip_history | Completed or prior trips |
| country | Country master |
| region | Region or state master |
| city | City master |
| destination | Searchable destination entity |
| destination_tag | Tags for season, vibe, family, accessibility, etc. |
| activity | Activity master |
| destination_activity | Link between destinations and activities |
| cuisine | Cuisine or food category |
| destination_food_highlight | Local food recommendations |
| restaurant | Restaurant listing |
| restaurant_price_band | Budget classification for restaurant offerings |
| lodging | Hotel, resort, hostel, homestay, etc. |
| lodging_amenity | Amenity master |
| lodging_amenity_map | Lodging to amenity mapping |
| transport_option | Local transport choices |
| attraction | Must-visit places and hidden gems |
| review | User review for destination or venue |
| review_media | Photos and videos linked to a review |
| user_tip | Traveler-contributed tips |
| itinerary | Trip plan header |
| itinerary_day | Day-wise itinerary bucket |
| itinerary_item | Visit, food stop, stay, transport, activity |
| recommendation_run | Recommendation request header |
| recommendation_result | Ranked recommendation outputs |
| booking_provider | External booking integration provider |
| booking_intent | User booking decision record |
| booking_item | Sub-records for stay, activity, transport |
| event_feed | Local events and festivals |
| weather_snapshot | Weather snapshots per destination/date |
| safety_alert | Security and travel advisories |
| travel_group | Social planning group |
| travel_group_member | Group membership |
| loyalty_account | Points wallet |
| loyalty_transaction | Accrual and redemption history |
| moderation_case | Flagged content workflow |
| audit_log | Administrative and sensitive action trail |

## PostgreSQL DDL Skeleton

```sql
CREATE TABLE app_user (
    id UUID PRIMARY KEY,
    email VARCHAR(320) NOT NULL UNIQUE,
    phone VARCHAR(32),
    password_hash TEXT,
    auth_provider VARCHAR(50) NOT NULL DEFAULT 'local',
    status VARCHAR(30) NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE user_profile (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL UNIQUE REFERENCES app_user(id),
    full_name VARCHAR(200),
    date_of_birth DATE,
    home_country_code VARCHAR(3),
    home_city VARCHAR(120),
    preferred_language VARCHAR(20),
    preferred_currency VARCHAR(10),
    traveler_type VARCHAR(50),
    accessibility_notes JSONB,
    dietary_preferences JSONB,
    travel_companions JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE user_preference (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_user(id),
    preference_type VARCHAR(50) NOT NULL,
    preference_value VARCHAR(100) NOT NULL,
    weight NUMERIC(5,2) NOT NULL DEFAULT 1.00,
    source VARCHAR(30) NOT NULL DEFAULT 'explicit',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_user_preference_user_type ON user_preference(user_id, preference_type);

CREATE TABLE destination (
    id UUID PRIMARY KEY,
    country_code VARCHAR(3) NOT NULL,
    city_name VARCHAR(120),
    destination_name VARCHAR(200) NOT NULL,
    destination_type VARCHAR(50),
    summary TEXT,
    avg_budget_per_day NUMERIC(12,2),
    family_friendly BOOLEAN NOT NULL DEFAULT FALSE,
    accessibility_friendly BOOLEAN NOT NULL DEFAULT FALSE,
    nightlife_score NUMERIC(5,2),
    peaceful_score NUMERIC(5,2),
    hiking_score NUMERIC(5,2),
    beach_score NUMERIC(5,2),
    mountain_score NUMERIC(5,2),
    best_seasons JSONB,
    geo_lat NUMERIC(10,7),
    geo_lng NUMERIC(10,7),
    status VARCHAR(30) NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_destination_type ON destination(destination_type);
CREATE INDEX idx_destination_budget ON destination(avg_budget_per_day);

CREATE TABLE restaurant (
    id UUID PRIMARY KEY,
    destination_id UUID NOT NULL REFERENCES destination(id),
    restaurant_name VARCHAR(200) NOT NULL,
    cuisine_type VARCHAR(100),
    price_band VARCHAR(20),
    kid_friendly BOOLEAN NOT NULL DEFAULT FALSE,
    accessibility_friendly BOOLEAN NOT NULL DEFAULT FALSE,
    average_rating NUMERIC(3,2),
    review_count INTEGER NOT NULL DEFAULT 0,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE lodging (
    id UUID PRIMARY KEY,
    destination_id UUID NOT NULL REFERENCES destination(id),
    lodging_name VARCHAR(200) NOT NULL,
    lodging_type VARCHAR(50),
    price_per_night NUMERIC(12,2),
    currency_code VARCHAR(10) NOT NULL,
    kid_friendly BOOLEAN NOT NULL DEFAULT FALSE,
    accessibility_friendly BOOLEAN NOT NULL DEFAULT FALSE,
    quietness_score NUMERIC(5,2),
    amenity_map JSONB,
    average_rating NUMERIC(3,2),
    review_count INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE review (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_user(id),
    destination_id UUID REFERENCES destination(id),
    restaurant_id UUID REFERENCES restaurant(id),
    lodging_id UUID REFERENCES lodging(id),
    rating NUMERIC(2,1) NOT NULL,
    title VARCHAR(200),
    review_text TEXT,
    travel_context JSONB,
    status VARCHAR(30) NOT NULL DEFAULT 'published',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CHECK ((destination_id IS NOT NULL)::int + (restaurant_id IS NOT NULL)::int + (lodging_id IS NOT NULL)::int = 1)
);

CREATE TABLE review_media (
    id UUID PRIMARY KEY,
    review_id UUID NOT NULL REFERENCES review(id) ON DELETE CASCADE,
    media_type VARCHAR(20) NOT NULL,
    object_url TEXT NOT NULL,
    thumbnail_url TEXT,
    file_size_bytes BIGINT,
    moderation_status VARCHAR(30) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE itinerary (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_user(id),
    destination_id UUID NOT NULL REFERENCES destination(id),
    itinerary_name VARCHAR(200) NOT NULL,
    start_date DATE,
    end_date DATE,
    traveler_count INTEGER,
    budget_total NUMERIC(12,2),
    currency_code VARCHAR(10),
    status VARCHAR(30) NOT NULL DEFAULT 'draft',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE itinerary_day (
    id UUID PRIMARY KEY,
    itinerary_id UUID NOT NULL REFERENCES itinerary(id) ON DELETE CASCADE,
    day_number INTEGER NOT NULL,
    day_date DATE,
    theme VARCHAR(100),
    notes TEXT,
    UNIQUE(itinerary_id, day_number)
);

CREATE TABLE itinerary_item (
    id UUID PRIMARY KEY,
    itinerary_day_id UUID NOT NULL REFERENCES itinerary_day(id) ON DELETE CASCADE,
    item_type VARCHAR(50) NOT NULL,
    reference_id UUID,
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    estimated_cost NUMERIC(12,2),
    currency_code VARCHAR(10),
    metadata JSONB
);

CREATE TABLE recommendation_run (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_user(id),
    request_context JSONB NOT NULL,
    algorithm_version VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE recommendation_result (
    id UUID PRIMARY KEY,
    recommendation_run_id UUID NOT NULL REFERENCES recommendation_run(id) ON DELETE CASCADE,
    destination_id UUID NOT NULL REFERENCES destination(id),
    rank_position INTEGER NOT NULL,
    score NUMERIC(8,4) NOT NULL,
    reason_codes JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(recommendation_run_id, rank_position)
);

CREATE TABLE booking_provider (
    id UUID PRIMARY KEY,
    provider_name VARCHAR(120) NOT NULL,
    provider_type VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'active',
    config JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE booking_intent (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_user(id),
    itinerary_id UUID REFERENCES itinerary(id),
    provider_id UUID REFERENCES booking_provider(id),
    booking_type VARCHAR(50) NOT NULL,
    reference_id UUID,
    price_amount NUMERIC(12,2),
    currency_code VARCHAR(10),
    status VARCHAR(30) NOT NULL DEFAULT 'initiated',
    provider_booking_ref VARCHAR(120),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

## Indexing Guidance

- Index foreign keys across all high-cardinality operational tables for query performance.[cite:17]
- Add composite indexes for recommendation and search workflows, such as destination type plus budget and family-friendliness.
- Use full-text or search engine indexing for destination description, review text, food highlights, and attraction summaries.
- Use geospatial indexing if location proximity search becomes core.

## Storage Split Recommendation

- PostgreSQL: source of truth for operational records.
- Object storage: photos, videos, offline bundles, cached maps.
- Search engine: fast destination and review search.
- Analytical warehouse or lakehouse: reporting, recommendation retraining, cohort analysis.
- Cache layer: trending destinations, hot recommendations, live weather summaries.[cite:16]

## Data Governance

- Separate personally identifiable information from public profile content.
- Apply soft-delete or archival rules for user-generated content and booking records where business or legal retention is required.
- Retain moderation and audit records for sensitive actions.
- Keep recommendation reason traces for explainability and tuning.[cite:16]

## DB Architecture Recommendation

The preferred production approach is PostgreSQL as the system of record, Redis for hot cache and session-like ephemeral state, object storage for media, and a search engine for text-heavy discovery. This combination preserves the relational rigor needed for trips, reviews, itineraries, and bookings while supporting flexible search and scalable recommendation experiences.[cite:16][cite:17]
