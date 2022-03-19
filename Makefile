.PHONY: generate
generate: cv/Adam_Williams.pdf
	docker run \
		--rm \
		--volume $(shell pwd):/SRC \
		--workdir /SRC \
		klakegg/hugo:0.93.2-alpine \
			--destination ./docs \
			--cleanDestinationDir \
			--minify \
			--baseURL https://awilliams.github.io/

cv/Adam_Williams.pdf: wkhtmltopdf.image cv/cv.html $(wildcard cv/css/cv/*.css)
	touch cv/Adam_Williams.pdf
	docker run \
		--rm \
		--volume $(shell pwd):/SRC:ro \
		--volume $(shell cd cv && pwd)/Adam_Williams.pdf:/OUT/Adam_Williams.pdf \
		--workdir /SRC \
		wkhtmltopdf \
			wkhtmltopdf \
				--title "Adam Williams" \
				--allow . \
				--no-background \
				--no-outline \
				--print-media-type \
				cv/cv.html /OUT/Adam_Williams.pdf

.PHONY: wkhtmltopdf.image
wkhtmltopdf.image:
	docker build \
		-t wkhtmltopdf \
		- < wkhtmltopdf.dockerfile

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
