# Travel Companion App — Cost Estimation (1,000 Active Users)

## Infrastructure

| Component | Choice | Cost/Month |
|---|---|---|
| Database (Postgres) | Supabase / Neon free tier | $0 |
| Cache (Redis) | Upstash free tier | $0 |
| App Server | Railway / Fly.io hobby | $5–$25 |
| Object Storage | Cloudflare R2 free tier | $0–$5 |
| CDN | Cloudflare free | $0 |
| **Subtotal** | | **$5–$30** |

## Third-Party APIs

| Service | Cost/Month |
|---|---|
| Google Maps/Places | $0–$50 |
| Weather API | $0 |
| AI/LLM (recommendations, itinerary gen) | $30–$300 |
| Email (Resend) | $0 |
| Push (Firebase) | $0 |
| Auth (Supabase/Firebase) | $0 |
| **Subtotal** | **$30–$350** |

## Total Monthly

| Scenario | Cost |
|---|---|
| Lean (free tiers, cached AI) | **$35–$80/mo** |
| Moderate (paid tiers, active AI) | **$80–$250/mo** |
| Full-featured | **$250–$500/mo** |

## Annual

| Scenario | Cost |
|---|---|
| Lean | **~$500–$1,000/yr** |
| Moderate | **~$1,000–$3,000/yr** |
| Full-featured | **~$3,000–$6,000/yr** |

## One-Time

- Domain: $12
- Apple Developer: $99/yr
- Google Play: $25 (once)

## Key Insight

The AI/LLM usage accounts for 70-80% of the total bill. Caching recommendation results aggressively keeps the monthly cost under **$100/mo** at 1,000 active users.
