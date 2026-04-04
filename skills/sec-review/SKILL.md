---
name: sec-review
description: Security review specialist skill with OWASP checklist, detection patterns, and severity framework.
user-invocable: false
---

# sec-review — Security Review Specialist Skill

## Structural Contract

- This skill is owned by the **reviewer** lane.
- Load this skill when security review is needed for the active task.
- It extends, not replaces, the reviewer's core review capability.
- Structural order: Activation, OWASP Checklist, Detection Patterns, Severity Framework, Review Workflow, Allowed/Prohibited Practices, Dependency Security.
- This skill is **advisory only**: reviewer identifies and classifies findings; fixes go to the developer lane via standard handoff.
- All severity assignments use the shared T0–T3 framework from `CLAUDE.md`; do not apply external severity labels directly.
- Patterns in this skill are framework-agnostic and apply to any language or runtime.

---

## 1. Activation

Load this skill when security-sensitive surfaces are in scope for the active review task. team-lead may also direct loading via SKILL-AUTH.

On activation:
- Confirm scope of security-sensitive surfaces from the dispatch packet.
- Execute sections 2–4 (Checklist, Detection Patterns, Severity Framework) in sequence.
- Return findings using the report format in section 5 (Review Workflow).
- Apply the gate decision rule at the end of section 5 before issuing review verdict.

---

## 2. OWASP Top 10 (2021) Checklist

Run each item against the identified security-sensitive surfaces. Record findings with file path, line number, and severity.

### A01 — Broken Access Control

**What to look for:**
- Missing authorization checks before resource access.
- Insecure Direct Object References (IDOR): user-controlled IDs that access other users' resources without ownership verification.
- CORS misconfiguration: wildcard origins (`*`) on credentialed endpoints, or overly permissive origin allowlists.
- Privilege escalation paths: role or scope checks missing on elevated actions.

**Common code patterns:**
- Route handler fetches record by `req.params.id` without verifying `record.owner === req.user.id`.
- `Access-Control-Allow-Origin: *` combined with `Access-Control-Allow-Credentials: true`.
- Admin-only endpoints reachable without role middleware.

**Reviewer action:** Flag every data access path where user-controlled input selects a resource record without an explicit ownership or permission check.

---

### A02 — Cryptographic Failures

**What to look for:**
- Sensitive data (passwords, tokens, PII, payment info) transmitted or stored in plaintext.
- Weak or deprecated algorithms: MD5, SHA-1, DES, RC4, ECB mode.
- Missing or incorrectly configured TLS.
- Symmetric encryption keys stored in source code or config files.
- Missing `secure` / `httpOnly` flags on cookies carrying sensitive data.

**Common code patterns:**
- `crypto.createHash("md5")` or `crypto.createHash("sha1")` for password hashing.
- Passwords stored with reversible encryption instead of a strong KDF (bcrypt, Argon2, scrypt).
- HTTP endpoints (not HTTPS) for any auth or data flow.
- Cookie set without `Secure` or `HttpOnly` attributes.

**Reviewer action:** Flag any path where sensitive data bypasses encryption at rest or in transit, or where a weak cryptographic primitive is used.

---

### A03 — Injection

**What to look for:**
- SQL injection: user input concatenated into SQL strings without parameterization.
- Cross-Site Scripting (XSS): user input rendered into HTML without escaping or sanitization.
- Command injection: user input passed to shell execution functions.
- LDAP injection: user input concatenated into LDAP filter strings.
- Template injection: user input interpreted by a server-side template engine.

**Common code patterns:**
- `"SELECT * FROM users WHERE id = " + req.params.id`
- `res.send("<div>" + req.query.name + "</div>")` without encoding.
- `exec("ls " + req.body.dir)` or `child_process.spawn` with unsanitized args.
- ORM raw query methods called with user-provided strings.

**Reviewer action:** Flag every location where external input reaches an interpreter (database, shell, HTML renderer, template engine) without strict parameterization or encoding.

---

### A04 — Insecure Design

**What to look for:**
- No evidence of threat modeling or security requirements documentation.
- Business logic flaws: workflows that can be abused by skipping steps or replaying requests.
- Absence of rate limiting on sensitive operations (login, password reset, OTP).
- Missing data-minimization controls: collecting or returning more data than necessary.

**Common code patterns:**
- Password-reset endpoints with no token expiry or single-use enforcement.
- Account enumeration via differential response on login or registration.
- No rate-limit middleware on auth or payment endpoints.

**Reviewer action:** Flag design-level gaps that no amount of implementation hardening can fully compensate for, and note where security requirements are absent or unverifiable.

---

### A05 — Security Misconfiguration

**What to look for:**
- Default or weak credentials left in place.
- Unnecessary features, ports, services, or debug endpoints enabled in production.
- Missing security hardening at the framework, server, or container level.
- Overly permissive file permissions or directory listings.
- Verbose error messages revealing stack traces, version numbers, or internal paths to clients.

**Common code patterns:**
- `app.use(morgan("dev"))` in production configuration.
- `/debug`, `/status`, `/health` endpoints returning internal state without auth.
- `NODE_ENV` not set to `production`; development middleware active.
- Default admin credentials not rotated in deployment configuration.

**Reviewer action:** Flag every configuration surface where the default, development, or permissive setting has not been explicitly hardened for production.

---

### A06 — Vulnerable and Outdated Components

**What to look for:**
- Dependencies with known CVEs in published security advisories.
- Unmaintained packages: no releases in over one year.
- Packages with very low adoption (<1 000 weekly downloads): supply-chain risk.
- Transitive dependency chains that include vulnerable versions.

**Common code patterns:**
- `package.json` or `requirements.txt` pinning to versions flagged by `npm audit`, `pip-audit`, `trivy`, or similar tools.
- `package-lock.json` or `yarn.lock` absent (unpinned transitive deps).

**Reviewer action:** Run or request a dependency audit. Flag components with active CVEs as T1+. Flag unmaintained or low-adoption packages as T2–T3 depending on attack surface.

---

### A07 — Identification and Authentication Failures

**What to look for:**
- Weak password policies (no minimum length, no complexity enforcement).
- Missing multi-factor authentication on privileged or sensitive paths.
- Session fixation: session ID not rotated on login.
- Session tokens with excessive lifetime or no absolute expiry.
- Credential stuffing protection absent (no account lockout, no anomaly detection).
- JWT with `alg: none` accepted, or symmetric secret weak or shared.

**Common code patterns:**
- `req.session.regenerate` not called after successful login.
- JWT verified with a short or hardcoded secret.
- No `maxAge` or `expires` on session cookies.
- No lockout counter after repeated login failures.

**Reviewer action:** Flag every authentication and session management surface where hardening controls are absent or insufficient.

---

### A08 — Software and Data Integrity Failures

**What to look for:**
- Unsigned or unverified software updates or plugin loading.
- Insecure CI/CD pipelines: untrusted code executed in privileged build context.
- Insecure deserialization: user-controlled data deserialized into objects without integrity checks.
- Auto-update mechanisms that do not verify package signatures.

**Common code patterns:**
- `pickle.loads(user_data)` or `unserialize($_POST["data"])` without validation.
- CI pipeline steps that `curl | bash` from unverified URLs.
- Dynamic `require()` or `import()` with user-controlled module paths.
- npm `postinstall` scripts in third-party packages executing arbitrary code.

**Reviewer action:** Flag every path where external or user-supplied data is executed, deserialized into objects, or used to control code loading without integrity verification.

---

### A09 — Security Logging and Monitoring Failures

**What to look for:**
- Missing audit logs for authentication events, privilege changes, and sensitive data access.
- Log data that includes secrets, tokens, or PII.
- No alerting on repeated failures, suspicious access patterns, or privilege escalation.
- Log files writable by the application process (tampering risk).
- Logs not centralized or retained for a sufficient period.

**Common code patterns:**
- Login success/failure not logged.
- `console.log(req.headers.authorization)` logging credentials.
- No structured logging framework; ad hoc `console.log` only.
- No integration with SIEM or centralized logging pipeline.

**Reviewer action:** Flag authentication, authorization, and sensitive-data paths that lack audit logging. Flag any log statement that writes credential or PII data.

---

### A10 — Server-Side Request Forgery (SSRF)

**What to look for:**
- User-controlled URLs fetched by the server without allowlist validation.
- Internal service endpoints reachable via user-supplied URL parameters.
- Cloud metadata endpoints (169.254.169.254, fd00:ec2::254) reachable from the application.
- Missing scheme, host, and path validation before outbound HTTP calls.

**Common code patterns:**
- `fetch(req.query.url)` or `axios.get(req.body.webhook)` without URL validation.
- File read functions called with user-controlled paths that could be `file://` URLs.
- Redirect endpoints that forward to user-supplied destinations without domain allowlisting.
- URL parsing that can be confused by embedded credentials or fragment tricks.

**Reviewer action:** Flag every outbound network call or URL-consuming operation where the target URL is fully or partially controlled by user input without strict allowlist enforcement.

---

## 3. Key Detection Patterns

Apply these seven patterns as a targeted scan across the codebase in addition to the OWASP checklist pass.

### P1 — Hardcoded Secrets

**What it catches:** API keys, passwords, tokens, private keys, or base64-encoded credentials embedded in source code.

**Search targets:**
- Regex: `(api_key|apikey|api-key|password|passwd|secret|token|private_key|auth_token)\s*[=:]\s*["'][^"']{8,}`
- Regex: `[A-Za-z0-9+/]{40,}={0,2}` (base64 candidate strings >40 chars)
- Filenames: `.env`, `config.yaml`, `secrets.json` committed to version control
- Known secret patterns: AWS access key (`AKIA[0-9A-Z]{16}`), GitHub token (`ghp_[A-Za-z0-9]{36}`)

**Reviewer action:** Any confirmed hardcoded secret is T0. Assign to developer for rotation and migration to secrets manager before any other remediation.

---

### P2 — Missing Input Validation

**What it catches:** User-supplied input flowing into sensitive sinks without sanitization or type enforcement.

**Search targets:**
- `req.body.*`, `req.query.*`, `req.params.*` used directly in:
  - DB query strings (SQL or ORM raw methods)
  - File path construction (`path.join`, `fs.readFile`, `open`)
  - Shell commands (`exec`, `spawn`, `system`, `subprocess`)
  - HTML rendering without encoding

**Reviewer action:** T1 if user input reaches an interpreter sink without validation. T2 if validation exists but is incomplete or bypassable.

---

### P3 — Insecure Direct Object References (IDOR)

**What it catches:** Route parameters or query parameters that directly select a database record without verifying the requesting user owns or is authorized to access that record.

**Search targets:**
- Route handlers where `req.params.id` or `req.query.id` is used in a DB lookup without a subsequent ownership check.
- Patterns: `findById(req.params.id)` without `where: { userId: req.user.id }` or equivalent.

**Reviewer action:** T1. Every data-access path where user-supplied identifiers select records must include an explicit authorization check.

---

### P4 — Missing Authentication or Authorization Middleware

**What it catches:** Route or endpoint definitions that handle sensitive operations without requiring authentication or role-based access control.

**Search targets:**
- Route definitions (Express, FastAPI, Django, Rails, etc.) that lack an auth middleware or decorator.
- Compare route list against documented public vs. authenticated endpoint inventory.
- Admin or privileged routes without role-check middleware.

**Reviewer action:** T1 for routes handling user data, financial operations, admin functions, or system configuration. T2 for routes that should require auth but only handle low-sensitivity reads.

---

### P5 — Improper Error Handling

**What it catches:** Internal error details, stack traces, file paths, or system configuration exposed to the client in error responses.

**Search targets:**
- `catch` blocks that return `error.message`, `error.stack`, or the full error object to `res.send()` or `res.json()`.
- Default framework error handlers not overridden in production.
- 500 responses that include internal path names or version strings.

**Reviewer action:** T2. Internal error details aid attackers in targeted exploitation and must not reach client responses.

---

### P6 — Unvalidated Redirects and Forwards

**What it catches:** Redirect targets derived from user-controlled input without domain or path allowlisting, enabling open redirect and phishing attacks.

**Search targets:**
- `res.redirect(req.query.url)`, `res.redirect(req.body.next)`, `res.redirect(req.params.dest)`
- `Location` response headers constructed from user input.
- Login/logout redirect flows where the `returnTo` or `next` parameter is not validated against an allowlist.

**Reviewer action:** T1 if redirect can leave the application domain. T2 if intra-app redirect lacks path validation.

---

### P7 — Missing Security Headers

**What it catches:** HTTP responses that omit security headers protecting against clickjacking, MIME sniffing, XSS, and protocol downgrade attacks.

**Search targets:**
- Response configuration missing any of: `Content-Security-Policy`, `Strict-Transport-Security`, `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`, `Permissions-Policy`.
- Middleware like `helmet` (Node.js) absent or configured to disable headers.
- CSP set to `default-src 'unsafe-inline'` or `'unsafe-eval'` without documented justification.

**Reviewer action:** T2 for complete absence of a header class. T3 for weak but present configuration.

---

## 4. Security Severity Framework

Map all findings to the shared T0–T3 severity framework from `CLAUDE.md`.

| Severity | Label | Action Required | Example Finding Types |
|---|---|---|---|
| **T0** | System halt | Block deployment immediately; fix required before any further release activity | Remote code execution (RCE), SQL injection with data exfiltration, authentication bypass, exposed secrets/credentials in source, deserialization of untrusted data leading to code execution |
| **T1** | Governance block | Fix before release; blocks the current release gate | Reflected/stored XSS, CSRF on state-changing endpoints, privilege escalation, IDOR, missing auth on sensitive routes, path traversal, SSRF with internal network access |
| **T2** | Quality gate | Fix in current sprint; blocks stage acceptance if 3 or more T2 findings accumulate | Missing security headers, weak session configuration, verbose error messages, unvalidated redirects within domain, weak password policy, unmaintained dependencies with no active CVE |
| **T3** | Advisory | Record and schedule; does not block current release | Minor information disclosure (version strings), cosmetic security improvements, low-risk configuration suggestions, low-adoption dependencies without known CVE |

**Gate rule:** Any T0 or T1 finding is individually blocking. Three or more T2 findings collectively constitute a blocking condition equivalent to T1.

---

## 5. Security Review Workflow

Execute this workflow in full when this skill is active.

### Step 1 — Scope Identification

Identify all security-sensitive surfaces in the dispatch scope:
- Authentication and session management paths
- Authorization and access control checks
- All external input entry points (HTTP params, headers, cookies, file uploads, webhooks)
- Data access and storage layers (DB queries, file I/O, cache reads/writes)
- Outbound network calls and third-party integrations
- Cryptographic operations
- Error handling and logging paths
- Dependency manifest files

### Step 2 — OWASP Checklist Pass

Run each of the 10 OWASP items (section 2) against the identified surfaces. For each item, record:
- Whether the surface is present and inspectable
- Whether a finding exists
- Preliminary severity assignment

### Step 3 — Detection Pattern Scan

Apply all 7 detection patterns (section 3) to the codebase. Use Grep or equivalent search against the search targets listed for each pattern.

### Step 4 — Classify Findings

For each finding:
- Assign severity: T0, T1, T2, or T3 (section 4)
- Record: file path, line number, OWASP category (if applicable), detection pattern (if applicable), description, recommended fix
- Do not fix; classify only.

### Step 5 — Report

Return a structured findings report:

```
## Security Review Findings

### T0 Findings (System Halt)
[List each finding: file:line | OWASP/Pattern | Description | Recommended Fix]

### T1 Findings (Governance Block)
[List each finding: file:line | OWASP/Pattern | Description | Recommended Fix]

### T2 Findings (Quality Gate)
[List each finding: file:line | OWASP/Pattern | Description | Recommended Fix]

### T3 Findings (Advisory)
[List each finding: file:line | OWASP/Pattern | Description | Recommended Fix]

### Gate Decision
BLOCKING | NON-BLOCKING

Reason: [Any T0 or T1 present = BLOCKING. 3+ T2 present = BLOCKING. Otherwise NON-BLOCKING.]
```

### Step 6 — Gate Decision

- **BLOCKING**: Any T0 finding present, OR any T1 finding present, OR 3 or more T2 findings present.
- **NON-BLOCKING**: Only T2 (fewer than 3) and/or T3 findings present.

When BLOCKING: return review verdict `HOLD`. Route T0/T1 findings to developer lane via standard handoff. Do not issue a passing verdict until all blocking findings are resolved and re-verified.

When NON-BLOCKING: return review verdict with T2 and T3 findings recorded as required follow-up, but do not hold the current gate.

---

## 6. Allowed and Prohibited Practices

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

## 7. Dependency Security

Run or request a dependency audit for the following when the dispatch scope includes dependency manifests (`package.json`, `requirements.txt`, `go.mod`, `Gemfile`, `pom.xml`, etc.).

### Known CVE Check

- Run `npm audit`, `pip-audit`, `trivy`, `snyk`, `govulncheck`, or the appropriate ecosystem tool.
- Flag any dependency with an active CVE in NVD or the ecosystem advisory database.
- Severity mapping:
  - CVE CVSS 9.0–10.0 → T0
  - CVE CVSS 7.0–8.9 → T1
  - CVE CVSS 4.0–6.9 → T2
  - CVE CVSS <4.0 → T3

### Unmaintained Package Check

- Flag any package with no published release in over 12 months as T2.
- If the package is on a critical security path (auth, crypto, HTTP parsing), escalate to T1.

### Supply Chain Risk Check

- Flag any package with fewer than 1 000 weekly downloads as T3 supply-chain risk.
- If the package is on a critical path, escalate to T2 and recommend a maintained alternative.

### Lock File Check

- Flag absence of a lock file (`package-lock.json`, `yarn.lock`, `poetry.lock`, `Gemfile.lock`) as T2: unpinned transitive dependencies introduce supply-chain and reproducibility risk.

---

## Handoff Protocol

This skill is **advisory only**. The reviewer lane does not fix findings.

On completing the review workflow:
1. Send the structured findings report (section 5 format) upward to `team-lead` via standard `handoff` packet.
2. For each T0/T1 finding, include the specific file path, line number, description, and a bounded recommended fix so the developer lane can act without re-deriving the analysis.
3. State the gate decision explicitly: `BLOCKING` or `NON-BLOCKING`.
4. Do not self-certify implementation of the recommended fixes; route all fix work to the developer lane.
5. After developer fixes are applied, a re-review of the fixed surfaces is required before the blocking verdict can be lifted.
