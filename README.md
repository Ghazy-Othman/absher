# Absher App Summary

## What is Absher ?
Absher is a multi-role delivery & marketplace app (Flutter frontends + Laravel backend, JWT auth) that lets customers buy items, vendors manage products & ads, and delivery men accept/complete deliveries — with full admin/vendor/vendor-public pages, real-time events, image uploads and multi-step delivery man registration.

---

## Main user roles
- **Customer** — browse products, view categories, search, place orders, see order details and OTPs, view vendor public pages and vendor ads.
- **Vendor (admin in vendor app)** — manage products (CRUD + images), add ads, view orders for their store, and manage profile.
- **Delivery man** — multi-step registration (identity + documents + vehicle), see delivery requests, accept/decline, generate/see OTPs, view daily/weekly/monthly earnings, update profile and documents.

---

## Core features
### Customers
- Browse home page: categories, trending, recommended, flash-sale, ads slider.
- Search products by title or description (paginated + debounce).
- View single category pages (Trending / New / All).
- View vendor public page (vendor ads slider, vendor info card, vendor products).
- Place orders (orders tied to carts); view order details and OTPs.
- Forgot password → OTP generation & verify → reset password (JWT flow).
- Receive real-time notifications about order lifecycle via WebSocket events (orders_published, assigned, picked_up, delivered).

### Vendors
- My Products: list, view, edit, delete products; add product image support (multipart or Spatie media).
- Add/Edit Ads (image only) and view/delete/update them.
- Vendor public page accessible to customers (ads, info, products).
- View/Filter orders for vendor; generate pickup OTP (with 3-minute countdown dialog).

### Delivery men
- Sign up flow split into steps: General info (name, email, national id, gender, city), Profile photo, ID card photo, Driver license photo, Choose vehicle.
- Upload and store images (avatar, id card, driver license) and have DeliveryManAttributes model with enums (Syrian cities, gender, vehicle types).
- View delivery requests (history), accept/decline, see vendor/customer avatars and details.
- Generate delivery OTP (3-minute expiration) for customer app flow.
- Earnings page (select date with date picker, default today) — total earnings and list of deliveries for that date.
