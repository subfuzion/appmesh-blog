MD := -name '*.md'
IMG := -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg'
ASSETS := $(shell find . $(MD) -o $(IMG))

.DEFAULT_GOAL := published

published: $(ASSETS)
	@git add . && git commit -am "edit colorapp" && git push
	@echo $$(date) > published
	@echo "published:" $$(cat published)

.PHONY: publish
publish:
	@git add . && git commit -am "edit colorapp" && git push
	@echo $$(date) > published
	@echo "published:" $$(cat published)

