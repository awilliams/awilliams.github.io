.PHONY: render
render:
	rm cv/*
	docker run \
		--rm \
		--volume ./cv:/SRC/out/ \
		--volume ./AdamWilliams.yaml:/SRC/AdamWilliams.yaml:ro \
		rendercv:latest \
		render \
			--dont-generate-png \
			--typst-path /tmp/Adam_Williams.typ \
			--markdown-path /SRC/out/Adam_Williams.md \
			--html-path /SRC/out/Adam_Williams.html \
			--pdf-path /SRC/out/Adam_Williams.pdf \
			/SRC/AdamWilliams.yaml
	cp ./cv/Adam_Williams.html ./public/Adam_Williams.html
	cp ./cv/Adam_Williams.pdf ./public/Adam_Williams.pdf

.PHONY: build-rendercv
build-rendercv:
	docker build ~/src/github.com/rendercv/rendercv \
		-t rendercv:latest

# Start development server
.PHONY: server
server:
	docker run \
		--rm \
		-it \
		--volume $(shell pwd):/SRC \
		--workdir /SRC \
		--publish 1313:1313 \
		--publish 1314:1314 \
		klakegg/hugo:0.93.2-alpine \
			server \
				--liveReloadPort 1314 \
				--destination ./docs \
				--buildDrafts
