PYTHON ?= python3

.PHONY: test-operator build-bundle print-next-steps

test-operator:
	PYTHONPATH=axis-swgi-operator $(PYTHON) -m unittest discover -s axis-swgi-operator/tests

build-bundle:
	podman build -f bundle.Dockerfile -t axis-swgi-operator-bundle:0.1.0 .

print-next-steps:
	@echo "1. Build and push operand image"
	@echo "2. Build and push operator image"
	@echo "3. Build and push bundle image"
	@echo "4. Build and push catalog image"
	@echo "5. Run OLM install/upgrade/uninstall validation and save logs under validation/"
