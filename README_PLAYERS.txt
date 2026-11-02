FLR PLAYERS UPDATE
==================

1. Open Supabase → SQL Editor.
2. Open players_setup.sql from this ZIP, copy all its SQL, and run it once.
3. Deploy this ZIP to the matching Netlify site (public ZIP to the public site; owners ZIP to the Owners Panel site).

The public site reads player stats and displays rankings for goals, assists, clean sheets, yellow cards and red cards.
The Owners Panel lets authorised owners/admins add, edit and delete players.
Player images are entered as image URLs.

Discord sign-in on the public site uses the Discord provider already configured in your Supabase project. The visitor chooses a language first, then can sign in. Their Supabase session is remembered by the browser; the avatar and username appear at the top-right.

Security: the SQL enables public read-only access. Only authenticated users with owner/admin rows in public.user_roles can change player records. Never put a Supabase service-role key or Discord client secret in either website.
