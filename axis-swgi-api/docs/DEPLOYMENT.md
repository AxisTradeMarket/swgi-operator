# OpenShift Deployment

## Prerequisites
- OpenShift cluster access
- Helm 3.x
- A real Ed25519 private key stored as a Kubernetes Secret value
- A provisioned Red Hat Connect repository at `registry.connect.redhat.com/axissystems/swgi-core`

If the Connect UI still shows an empty `Repository path`, save or submit the container entry first and wait for Red Hat to provision the backend repository before pushing.

## Deploy
```bash
helm upgrade --install axis-swgi-api ./helm/axis-swgi-api \
  --namespace swgi-system \
  --create-namespace \
  --set image.repository=registry.connect.redhat.com/axissystems/swgi-core \
  --set image.tag=0.1.0 \
  --set config.receiptStoreBackend="sqlite" \
  --set config.receiptDbPath="/tmp/swgi/receipts.db" \
  --set secrets.adminApiToken="replace-admin-token" \
  --set secrets.viewerApiToken="replace-viewer-token" \
  --set-file secrets.signingKey=./data/input/real_signing_key_ed25519.pem
```

## Push Image
```bash
cd /Users/zohaibahmad/Desktop/swgi-redhat
docker build -f axis-swgi-api/Dockerfile -t axis-swgi-api:0.1.0 .
podman tag axis-swgi-api:0.1.0 registry.connect.redhat.com/axissystems/swgi-core:0.1.0
podman push registry.connect.redhat.com/axissystems/swgi-core:0.1.0
```

## Verify
```bash
oc get all -n swgi-system
oc get route -n swgi-system
oc logs deploy/axis-swgi-api -n swgi-system
```

## Upgrade
```bash
helm upgrade axis-swgi-api ./helm/axis-swgi-api -n swgi-system
```

## Uninstall
```bash
helm uninstall axis-swgi-api -n swgi-system
```

The chart keeps configuration externalized through ConfigMap and Secret. SQLite is the active store
for now, and a Postgres backend remains available in code for a later migration.
