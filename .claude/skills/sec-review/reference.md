# Reference Material

## 2. OWASP Top 10 (2021) Checklist

Run each item against the identified security-sensitive surfaces. Record findings with file path, line number, and severity.

### A01 — Broken Access Control

**What to look for:**
- Missing authorization checks before resource access.
- Insecure Direct Object References (IDOR): user-controlled IDs accessing other users' resources without ownership verification.
- CORS misconfiguration: wildcard origins (`*`) on credentialed endpoints, or overly permissive origin allowlists.
- Privilege escalation paths: role or scope checks missing on elevated actions.
- IDOR search: `findById(req.params.id)` or equivalent without `where: {userId: req.user.id}` ownership filter.
- Auth gap search: route definitions lacking auth middleware or decorator; compare route list against authenticated endpoint inventory; admin routes without role-check middleware.

**Search hint:** Route handlers using `req.params.id` without ownership check; `Access-Control-Allow-Origin: *` with `Allow-Credentials: true`; admin routes without role middleware.

**Reviewer action:** Flag every data access path where user-controlled input selects a resource record without an explicit ownership or permission check. IDOR: T1. Missing auth on sensitive routes (user data, financial, admin, system config): T1; low-sensitivity reads without auth: T2.

---

### A02 — Cryptographic Failures

**What to look for:**
- Sensitive data (passwords, tokens, PII, payment info) transmitted or stored in plaintext.
- Weak or deprecated algorithms: MD5, SHA-1, DES, RC4, ECB mode.
- Missing or incorrectly configured TLS.
- Symmetric encryption keys stored in source code or config files.
- Missing `secure` / `httpOnly` flags on cookies carrying sensitive data.
- Hardcoded secrets: search `(api_key|apikey|api-key|password|passwd|secret|token|private_key|auth_token)\s*[=:]\s*["'][^"']{8,}`, `AKIA[0-9A-Z]{16}` (AWS key), `ghp_[A-Za-z0-9]{36}` (GitHub token), `.env` or `secrets.json` committed to VCS.

**Search hint:** `createHash("md5"|"sha1")`, plaintext password storage, cookies missing `Secure`/`HttpOnly`, base64 strings >40 chars in source.

**Reviewer action:** Flag any path where sensitive data bypasses encryption at rest or in transit, or where a weak cryptographic primitive is used. Confirmed hardcoded secret: T0 — route to developer for immediate rotation and migration to secrets manager before any other remediation.

---

### A03 — Injection

**What to look for:**
- SQL injection: user input concatenated into SQL strings without parameterization.
- XSS: user input rendered into HTML without escaping or sanitization.
- Command injection: user input passed to shell execution functions.
- LDAP injection: user input concatenated into LDAP filter strings.
- Template injection: user input interpreted by a server-side template engine.
- Search: `req.body.*`, `req.query.*`, `req.params.*` flowing directly into DB query strings, ORM raw methods, file path construction (`path.join`, `fs.readFile`, `open`), shell commands (`exec`, `spawn`, `system`, `subprocess`), or HTML rendering without encoding.

**Search hint:** SQL string concatenation with `req.*`; `exec`/`spawn` with user input; `res.send` rendering unescaped `req.*`.

**Reviewer action:** Flag every location where external input reaches an interpreter (database, shell, HTML renderer, template engine) without strict parameterization or encoding. T1 if input reaches an interpreter sink without validation; T2 if validation exists but is incomplete or bypassable.

---

### A04 — Insecure Design

**What to look for:**
- No evidence of threat modeling or security requirements documentation.
- Business logic flaws: workflows that can be abused by skipping steps or replaying requests.
- Absence of rate limiting on sensitive operations (login, password reset, OTP).
- Missing data-minimization controls: collecting or returning more data than necessary.

**Search hint:** Password-reset/OTP endpoints without token expiry or single-use enforcement; login/registration differential response enabling account enumeration; no rate-limit middleware on auth endpoints.

**Reviewer action:** Flag design-level gaps that no amount of implementation hardening can fully compensate for, and note where security requirements are absent or unverifiable.

---

### A05 — Security Misconfiguration

**What to look for:**
- Default or weak credentials left in place.
- Unnecessary features, ports, services, or debug endpoints enabled in production.
- Missing security hardening at the framework, server, or container level.
- Overly permissive file permissions or directory listings.
- Verbose error messages revealing stack traces, version numbers, or internal paths to clients.
- Error exposure search: `catch` blocks returning `error.message`/`error.stack` to `res.send()`/`res.json()`; default error handlers not overridden for production; 500 responses including internal path names or version strings.
- Missing headers search: response config lacking `Content-Security-Policy`, `Strict-Transport-Security`, `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`; `helmet` absent or `default-src 'unsafe-inline'` without documented justification.

**Search hint:** `morgan("dev")` in production config; unauthenticated `/debug`/`/health` endpoints; `NODE_ENV` not set to `production`.

**Reviewer action:** Flag every configuration surface where the default, development, or permissive setting has not been explicitly hardened for production. Error detail exposure: T2. Missing security headers: T2 for complete absence of a header class; T3 for weak but present configuration.

---

### A06 — Vulnerable and Outdated Components

**What to look for:**
- Dependencies with known CVEs in published security advisories.
- Unmaintained packages: no releases in over one year.
- Packages with very low adoption (<1,000 weekly downloads): supply-chain risk.
- Transitive dependency chains that include vulnerable versions.

**Search hint:** Run `npm audit`, `pip-audit`, or `trivy`; check `package.json`/`requirements.txt` against advisory databases; verify lock file present.

**Reviewer action:** Run or request a dependency audit. Flag components with active CVEs as T1+. Flag unmaintained or low-adoption packages as T2–T3 depending on attack surface.

---

### A07 — Identification and Authentication Failures

**What to look for:**
- Weak password policies (no minimum length, no complexity enforcement).
- Missing multi-factor authentication on privileged or sensitive paths.
- Session fixation: session ID not rotated on login.
- Session tokens with excessive lifetime or no absolute expiry.
- Credential stuffing protection absent (no account lockout, no anomaly detection).
- JWT with `alg: none` accepted, or symmetric secret weak or hardcoded.

**Search hint:** `session.regenerate` not called after login; short or hardcoded JWT secret; session cookies without `maxAge`; no lockout counter after repeated login failures.

**Reviewer action:** Flag every authentication and session management surface where hardening controls are absent or insufficient.

---

### A08 — Software and Data Integrity Failures

**What to look for:**
- Unsigned or unverified software updates or plugin loading.
- Insecure CI/CD pipelines: untrusted code executed in privileged build context.
- Insecure deserialization: user-controlled data deserialized into objects without integrity checks.
- Auto-update mechanisms that do not verify package signatures.

**Search hint:** `pickle.loads`/`unserialize` on user data; `curl | bash` in CI pipelines; dynamic `require()`/`import()` with user-controlled module paths; npm `postinstall` scripts from third-party packages.

**Reviewer action:** Flag every path where external or user-supplied data is executed, deserialized into objects, or used to control code loading without integrity verification.

---

### A09 — Security Logging and Monitoring Failures

**What to look for:**
- Missing audit logs for authentication events, privilege changes, and sensitive data access.
- Log data that includes secrets, tokens, or PII.
- No alerting on repeated failures, suspicious access patterns, or privilege escalation.
- Log files writable by the application process (tampering risk).
- Logs not centralized or retained for a sufficient period.

**Search hint:** Login success/failure not logged; `console.log(req.headers.authorization)` or similar credential logging; no structured logging framework; no SIEM integration.

**Reviewer action:** Flag authentication, authorization, and sensitive-data paths that lack audit logging. Flag any log statement that writes credential or PII data.

---

### A10 — Server-Side Request Forgery (SSRF)

**What to look for:**
- User-controlled URLs fetched by the server without allowlist validation.
- Internal service endpoints reachable via user-supplied URL parameters.
- Cloud metadata endpoints (169.254.169.254, fd00:ec2::254) reachable from the application.
- Missing scheme, host, and path validation before outbound HTTP calls.
- Redirect search: `res.redirect(req.query.url)`, `res.redirect(req.body.next)`, `Location` headers constructed from user input; `returnTo`/`next` redirect parameter not validated against domain allowlist.

**Search hint:** `fetch(req.query.url)`, `axios.get(req.body.*)`, file read with user-controlled `file://` URLs, redirect with unvalidated `next` parameter.

**Reviewer action:** Flag every outbound network call or URL-consuming operation where the target URL is fully or partially controlled by user input without strict allowlist enforcement. Redirect leaving application domain: T1. Intra-app redirect without path validation: T2.

---

## 3. Security Severity Framework

Map all findings to the shared T0–T3 severity framework from `CLAUDE.md`.

| Severity | Label | Action Required |
|---|---|---|
| **T0** | System halt | Block deployment immediately; fix required before any further release activity |
| **T1** | Governance block | Fix before release; blocks the current release gate |
| **T2** | Quality gate | Fix in current sprint; blocks stage acceptance if 3 or more T2 findings accumulate |
| **T3** | Advisory | Record and schedule; does not block current release |

**Gate rule:** Any T0 or T1 finding is individually blocking. Three or more T2 findings collectively constitute a blocking condition equivalent to T1.

---

## 5. Allowed and Prohibited Practices

### Allowed

- **Secrets management**: Secrets Manager (AWS, GCP, Azure, HashiCorp Vault), environment variables injected at runtime from a secrets store, IAM roles and service accounts for service-to-service auth.
- **Network security**: VPC-internal communication for service-to-service calls, TLS 1.2+ for all external communication, mutual TLS where service identity matters.
- **Data access**: Parameterized queries and prepared statements, ORM methods that enforce parameterization, stored procedures with typed inputs.
- **Cryptography**: Argon2, bcrypt, or scrypt for password hashing; AES-256-GCM or ChaCha20-Poly1305 for symmetric encryption; RSA-2048+ or ECDSA P-256+ for asymmetric; TLS 1.2+ for transport.
- **Session management**: Short-lived tokens with absolute expiry, session ID regeneration on privilege change, `httpOnly` + `Secure` + `SameSite=Strict` cookie attributes.
- **Logging**: Structured audit logs for auth events, access to sensitive data, and privilege changes — without logging credential or PII values.

### Prohibited

- **Hardcoded secrets**: No API keys, passwords, tokens, or private keys in source code, config files committed to VCS, or container images.
- **Public-facing database**: No database instance with a public-facing network interface without VPC isolation and network ACLs.
- **Root or admin account usage**: Application services must not run as root or with global admin credentials.
- **Excessive permissions**: IAM roles, service accounts, and DB users must follow least-privilege; wildcard permissions are prohibited.
- **Security through obscurity**: Hiding endpoints, using non-standard ports, or relying on undocumented paths as a primary security control is prohibited.
- **Weak cryptography**: MD5, SHA-1, DES, 3DES, RC4, ECB mode, RSA <2048 bits are prohibited for any new or active security use.
- **Unvalidated external input in interpreters**: Direct use of user input in SQL, shell, LDAP, XML, or HTML without parameterization or encoding is prohibited.

---

## 6. Dependency Security

Run or request a dependency audit when the dispatch scope includes dependency manifests (`package.json`, `requirements.txt`, `go.mod`, `Gemfile`, `pom.xml`, etc.).

- [ ] Run ecosystem audit tool (`npm audit`, `pip-audit`, `trivy`, `snyk`, `govulncheck`) against all dependency manifests.
- [ ] CVE severity mapping: CVSS 9.0–10.0 → T0; 7.0–8.9 → T1; 4.0–6.9 → T2; <4.0 → T3.
- [ ] Flag packages with no release in >12 months as T2; escalate to T1 if on auth/crypto/HTTP parsing path.
- [ ] Flag packages with <1,000 weekly downloads as T3; escalate to T2 and recommend alternative if on critical path.
- [ ] Flag absent lock file (`package-lock.json`, `yarn.lock`, `poetry.lock`, `Gemfile.lock`) as T2.

---
