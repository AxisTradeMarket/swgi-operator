# SWGI Red Hat Workspace

This workspace contains the SWGI components needed for the current Red Hat / OpenShift path.

## Repositories in this workspace
- `swgi_core/`: reusable SWGI core package for deterministic policy evaluation and trust receipt generation
- `axis-swgi-api/`: production-oriented SWGI operand/API service, packaged for OpenShift deployment
- `axis-swgi-operator/`: operator/control-plane scaffold for CRDs, reconciliation, scaling, and lifecycle management

## Certification artifacts
- `bundle/`: operator bundle scaffold for hosted pipeline and certification workflows
- `bundle.Dockerfile`: bundle image build file
- `catalog/`: file-based catalog scaffold for the operator index image
- `validation/`: install, reconcile, upgrade, and uninstall evidence placeholders

## Start here
- API service: `axis-swgi-api/README.md`
- Core package: `swgi_core/README.md`
- Operator scaffold: `axis-swgi-operator/README.md`
- Catalog scaffold: `catalog/README.md`

## Current structure
```text
  axis-swgi-operator/
  bundle/
  bundle.Dockerfile
  swgi_core/
  axis-swgi-api/
```
