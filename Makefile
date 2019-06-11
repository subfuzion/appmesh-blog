MD := -name '*.md'
IMG := -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg'
ASSETS := $(shell find . $(MD) -o $(IMG))
SVG := $(shell ls ~/Downloads/appmesh-*.svg 2>/dev/null)

.DEFAULT_GOAL := published

.PHONY: getassets
getassets: $(SVG)
	@for f in $$(ls ~/Downloads/appmesh-ec2-*.svg 2>/dev/null); do \
		f=$$(basename $$f); \
		echo $$f; \
		mkdir -p colorapp/ec2/img; \
		mv ~/Downloads/$$f colorapp/ec2/img; \
		(cd colorapp/ec2/img && convert-svg-to-png --width 1600 $$f); \
	done
	@for f in $$(ls ~/Downloads/appmesh-fargate-*.svg 2>/dev/null); do \
		f=$$(basename $$f); \
		echo $$f; \
		mkdir -p colorapp/fargate/img; \
		mv ~/Downloads/$$f colorapp/fargate/img; \
		(cd colorapp/fargate/img && convert-svg-to-png --width 1600 $$f); \
	done
	@for f in $$(ls ~/Downloads/appmesh-*.svg 2>/dev/null); do \
		f=$$(basename $$f); \
		echo $$f; \
		mkdir -p colorapp/img; \
		mv ~/Downloads/$$f colorapp/img; \
		(cd colorapp/img && convert-svg-to-png --width 1600 $$f); \
	done

published: $(ASSETS)
	@git add . && git commit -am "Update colorapp" && git push -u origin master
	@echo $$(date) > published
	@echo "published:" $$(cat published)

.PHONY: publish
publish: getassets
	@git add . && git commit -am "Update colorapp" && git push -u origin master
	@echo $$(date) > published
	@echo "published:" $$(cat published)
