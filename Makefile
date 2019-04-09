MD := -name '*.md'
IMG := -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg'
ASSETS := $(shell find . $(MD) -o $(IMG))
SVG := $(shell ls ~/Downloads/appmesh-*.svg 2>/dev/null)

.DEFAULT_GOAL := published

.PHONY: getassets
getassets: $(SVG)
	@mv $(SVG) colorapp/ 2>/dev/null || true

published: $(ASSETS)
	@git add . && git commit -am "Update colorapp" && git push -u origin master
	@echo $$(date) > published
	@echo "published:" $$(cat published)

.PHONY: publish
publish: getassets
	@git add . && git commit -am "Update colorapp" && git push -u origin master
	@echo $$(date) > published
	@echo "published:" $$(cat published)
