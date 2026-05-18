SHELL := /usr/bin/env bash
ROOT := $(shell pwd)

.PHONY: help extract catalog update lint clean status test template om

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

status: ## Show project overview with counts
	@echo "=== Omarchy Project Overview ==="
	@printf "%-30s %s\n" "Category" "Count"
	@printf "%-30s %s\n" "-----------------------------" "-----"
	@printf "%-30s %d\n" "docs/ (guides)" "$$(find docs/guides -name '*.md' | wc -l)"
	@printf "%-30s %d\n" "docs/ (ecosystem)" "$$(find docs/ecosystem -name '*.md' | wc -l)"
	@printf "%-30s %d\n" "docs/ (themes)" "$$(find docs/themes -name '*.md' | wc -l)"
	@printf "%-30s %d\n" "repos/themes/gui-apps" "$$(find repos/themes/gui-apps -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "repos/themes/waybar" "$$(find repos/themes/waybar -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "repos/themes/colorschemes" "$$(find repos/themes/colorschemes -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "repos/themes/gtk" "$$(find repos/themes/gtk -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "repos/tools" "$$(find repos/tools -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "repos/configs" "$$(find repos/configs -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "repos/curated" "$$(find repos/curated -mindepth 2 -maxdepth 2 -name '.git' -type d | wc -l)"
	@printf "%-30s %d\n" "templates/" "$$(find templates -name 'colors.toml' | wc -l)"
	@printf "%-30s %d\n" "modules/" "$$(find modules -name '*.jsonc' -o -name '*.conf' -o -name '*.ini' -o -name '*.toml' | wc -l)"
	@printf "%-30s %d\n" "overlays/" "$$(find overlays -maxdepth 2 -name '*.conf' | wc -l)"
	@printf "%-30s %d\n" "tests/" "$$(find tests/validators -name '*.sh' | wc -l)"
	@printf "%-30s %d\n" "wallpapers/ (categories)" "$$(find wallpapers -mindepth 1 -maxdepth 1 -type d | wc -l)"
	@printf "%-30s %d\n" "packages/ (manifests)" "$$(find packages -name '*.yml' | wc -l)"
	@printf "%-30s %d\n" "keybindings/ (refs)" "$$(find keybindings -name '*.md' | wc -l)"
	@printf "%-30s %d\n" "notes/" "$$(find notes -name '*.md' | wc -l)"
	@printf "%-30s %d\n" "patches/" "$$(find patches -maxdepth 1 -name '*.md' | wc -l)"
	@printf "%-30s %d\n" "nexus/ (AI)" "$$(find nexus -name '*.json' -o -name '*.md' -o -name '*.sh' | wc -l)"
	@printf "%-30s %d\n" "cyberdeck/ (security)" "$$(find cyberdeck -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "observatory/ (monitoring)" "$$(find observatory -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "hologram/ (visuals)" "$$(find hologram -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "cortex/ (adaptive)" "$$(find cortex -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "orbital/ (containers)" "$$(find orbital -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "singularity/ (self-heal)" "$$(find singularity -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "protocol/ (integration)" "$$(find protocol -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "matrix/ (mesh)" "$$(find matrix -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "ark/ (recovery)" "$$(find ark -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "synapse/ (AI)" "$$(find synapse -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "echo/ (voice)" "$$(find echo -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "phantom/ (sandbox)" "$$(find phantom -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "drone/ (CI/CD)" "$$(find drone -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "ghost/ (stealth)" "$$(find ghost -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "aegis/ (access)" "$$(find aegis -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "forge/ (build)" "$$(find forge -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "oracle/ (predict)" "$$(find oracle -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "beacon/ (presence)" "$$(find beacon -type f -not -path '*/.git/*' | wc -l)"
	@printf "%-30s %d\n" "prism/ (color)" "$$(find prism -type f -not -path '*/.git/*' | wc -l)"
	@printf "%s\n" "-----------------------------"
	@printf "%-30s %d\n" "TOTAL REPOS" "$$(find repos -mindepth 2 -maxdepth 4 -name '.git' -type d | wc -l)"

extract: ## Extract all assets from repos/ into dist/
	@echo "Extracting assets from repos/ into dist/..."
	@bash src/scripts/extract.sh

catalog: ## Show catalog metadata
	@echo "Catalog: catalog/themes.json, catalog/tools.json, catalog/configs.json"
	@echo "Total repos: $$(find repos -mindepth 2 -maxdepth 4 -name '.git' -type d | wc -l)"

update: ## Pull latest from all cloned repos
	@echo "Updating all repos..."
	@find repos -name '.git' -type d -execdir sh -c 'echo "  $$PWD" && git pull --ff-only' \;

lint: ## Check structure integrity
	@echo "Checking structure..."
	@test -d docs/guides || (echo "ERROR: docs/guides missing"; exit 1)
	@test -d repos/themes/colorschemes || (echo "ERROR: repos/themes/colorschemes missing"; exit 1)
	@test -d repos/themes/gui-apps || (echo "ERROR: repos/themes/gui-apps missing"; exit 1)
	@test -d repos/themes/waybar || (echo "ERROR: repos/themes/waybar missing"; exit 1)
	@test -d catalog || (echo "ERROR: catalog/ missing"; exit 1)
	@test -d modules || (echo "ERROR: modules/ missing"; exit 1)
	@test -d templates/theme || (echo "ERROR: templates/theme missing"; exit 1)
	@test -d overlays || (echo "ERROR: overlays/ missing"; exit 1)
	@test -d tests/validators || (echo "ERROR: tests/validators missing"; exit 1)
	@test -d notes/adr || (echo "ERROR: notes/adr missing"; exit 1)
	@test -d nexus || (echo "ERROR: nexus/ missing"; exit 1)
	@test -d cyberdeck || (echo "ERROR: cyberdeck/ missing"; exit 1)
	@test -d observatory || (echo "ERROR: observatory/ missing"; exit 1)
	@test -d hologram || (echo "ERROR: hologram/ missing"; exit 1)
	@test -d cortex || (echo "ERROR: cortex/ missing"; exit 1)
	@test -d orbital || (echo "ERROR: orbital/ missing"; exit 1)
	@test -d singularity || (echo "ERROR: singularity/ missing"; exit 1)
	@test -d protocol || (echo "ERROR: protocol/ missing"; exit 1)
	@test -d matrix || (echo "ERROR: matrix/ missing"; exit 1)
	@test -d ark || (echo "ERROR: ark/ missing"; exit 1)
	@test -d synapse || (echo "ERROR: synapse/ missing"; exit 1)
	@test -d echo || (echo "ERROR: echo/ missing"; exit 1)
	@test -d phantom || (echo "ERROR: phantom/ missing"; exit 1)
	@test -d drone || (echo "ERROR: drone/ missing"; exit 1)
	@test -d ghost || (echo "ERROR: ghost/ missing"; exit 1)
	@test -d aegis || (echo "ERROR: aegis/ missing"; exit 1)
	@test -d forge || (echo "ERROR: forge/ missing"; exit 1)
	@test -d oracle || (echo "ERROR: oracle/ missing"; exit 1)
	@test -d beacon || (echo "ERROR: beacon/ missing"; exit 1)
	@test -d prism || (echo "ERROR: prism/ missing"; exit 1)
	@echo "Structure OK"

test: ## Run all validators
	@bash tests/validators/run-all.sh

template: ## Create a new theme from the skeleton
	@read -p "Theme name: " name; \
	dest="$$HOME/.config/omarchy/themes/$$name"; \
	cp -r templates/theme "$$dest"; \
	echo "Created theme at $$dest"; \
	echo "Run: omarchy theme set \"$$name\""

om: ## Run the Omarchy CLI toolbox
	@bash src/cli/om help

clean: ## Remove extracted dist/ artifacts
	rm -rf dist/themes dist/wallpapers dist/waybar dist/scripts
	@echo "Cleaned dist/"
