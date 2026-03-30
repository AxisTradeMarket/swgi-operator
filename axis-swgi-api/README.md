# Axis SWGI API

`axis-swgi-api` is the production-oriented SWGI service scaffold. It builds on `swgi_core`, currently uses SQLite for receipt persistence,
exposes versioned `/v1/...` APIs, enforces token-based auth with `admin` and `viewer` roles, and
ships with a Helm chart for OpenShift deployment.

## Included
- FastAPI service using `swgi_core`
- SQLite receipt store for the current deployment baseline
- Optional Postgres backend path kept in code for later migration
- Versioned endpoints:
  - `POST /v1/authorize`
  - `GET /v1/receipts/{receipt_id}`
  - `GET /v1/receipts`
  - `GET /v1/receipts/export.csv`
  - `GET /v1/health`
  - `GET /healthz`
  - `GET /metrics`
- UBI minimal Dockerfile with Red Hat metadata labels
- Helm chart with Deployment, Service, Route, ConfigMap, Secret, ServiceAccount, Role, and RoleBinding

## Local run

### 1. Prepare environment
```bash
cd /Users/zohaibahmad/Desktop/swgi-redhat/axis-swgi-api
cp .env.example .env
openssl genpkey -algorithm Ed25519 -out data/input/signing_key_ed25519.pem
```

Update `.env`:
- replace `ADMIN_API_TOKEN` and `VIEWER_API_TOKEN`
- keep `SWGI_MODE=production`
- keep `RECEIPT_STORE_BACKEND=sqlite`
- change `RECEIPT_DB_PATH` only if you want the SQLite file elsewhere

Local signing key:
- generate `data/input/signing_key_ed25519.pem` locally before starting the app
- container and Helm deployments can still override `SIGNING_KEY_PATH` to `/tmp/secrets/signing_key_ed25519.pem`

### 2. Install dependencies
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 3. Start the API
```bash
python -m app.main
```

The service listens on `http://localhost:8080`.

## Auth model
- `admin` token can call `POST /v1/authorize`
- `viewer` token can read receipts
- send tokens as `Authorization: Bearer <token>`

## Example requests
Health:
```bash
curl http://localhost:8080/v1/health
```

Authorize:
```bash
curl -X POST http://localhost:8080/v1/authorize \
  -H "Authorization: Bearer change-admin-token" \
  -H "content-type: application/json" \
  -d '{
    "intent":"TEST",
    "context":{"env":"prod"},
    "action":"ai.infer",
    "authority":{"role":"admin"},
    "state":{"s":0},
    "workload_id":"workload-prod"
  }'
```

List receipts:
```bash
curl http://localhost:8080/v1/receipts \
  -H "Authorization: Bearer change-viewer-token"
```

Current storage note:
- SQLite is the active receipt store for now
- the code still includes a Postgres backend for a later cutover

## Container build
```bash
cd /Users/zohaibahmad/Desktop/swgi-redhat
docker build -f axis-swgi-api/Dockerfile -t axis-swgi-api:0.1.0 .
podman tag axis-swgi-api:0.1.0 registry.connect.redhat.com/axissystems/swgi-core:0.1.0
podman push registry.connect.redhat.com/axissystems/swgi-core:0.1.0
```

Red Hat Connect note:
- The target repository is `registry.connect.redhat.com/axissystems/swgi-core:0.1.0`
- If the Connect UI still shows an empty `Repository path`, the backend repo is not provisioned yet and `podman push` will fail with a repository/name unknown error
- Save or submit the container entry in Connect, wait for provisioning, then refresh until `registry.connect.redhat.com/axissystems/swgi-core` appears

## Helm deployment
```bash
helm upgrade --install axis-swgi-api ./axis-swgi-api/helm/axis-swgi-api \
  --namespace swgi-system \
  --create-namespace \
  --set image.repository=registry.connect.redhat.com/axissystems/swgi-core \
  --set image.tag=0.1.0
```

See `docs/DEPLOYMENT.md` for deployment details.
