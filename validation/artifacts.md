# Validation Artifacts

- Operator image: `localhost/axis-swgi-operator:0.1.0`
- Operator image (Quay): `quay.io/axis919/swgi-operator:0.1.0`
- Operand image: published from separate operand repository
- Bundle image: `localhost/axis-swgi-operator-bundle:0.1.0`
- Catalog image: `localhost/axis-swgi-operator-index:0.1.0`
- Red Hat Connect operator path attempted: `registry.connect.redhat.com/axissystems/69a1ea5d9ff73edc46ba7323:latest`
- Operator component ID: `69a1ea5d9ff73edc46ba7323`
- Cluster version: not validated from this environment
- Namespace: `swgi-system` planned
- Commands run: see `commands-run.txt`
- Notes:
  - Red Hat Connect push failed with `name unknown: Image not found`, which indicates the backend repository path for the operator component is not provisioned yet.
  - Quay push completed for `quay.io/axis919/swgi-operator:0.1.0`.
  - Quay pull verification completed for `quay.io/axis919/swgi-operator:0.1.0`.
  - `preflight` passed for `quay.io/axis919/swgi-operator:0.1.0` on arm64.
  - Pyxis submission failed with HTTP 400: `certification_status can only transition from "Started" to "In Progress" if container.type is set to container or scratch`.
  - That Pyxis failure is external component metadata, not an image-content failure.
