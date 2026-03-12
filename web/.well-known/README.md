momenture.app universal link/app link setup

1. `assetlinks.json`
- Replace `REPLACE_WITH_YOUR_RELEASE_SHA256_FINGERPRINT` with the Android release keystore SHA-256 fingerprint.
- Current package name is `com.example.uyoung`.

2. `apple-app-site-association`
- Replace `TEAM_ID.com.example.uyoung` with the actual Apple Team ID and bundle identifier.
- Current iOS bundle identifier is `com.example.uyoung`.

3. Hosting
- Serve both files from `https://momenture.app/.well-known/`.
- `apple-app-site-association` must be served without a `.json` extension and with `application/json` content type.
