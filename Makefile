.PHONY: generate
generate: cv/Adam_Williams.pdf
	hugo \
		--cleanDestinationDir \
		--minify \
		--enableGitInfo \
		--destination ./docs \
		--baseURL https://awilliams.github.io/


cv/Adam_Williams.pdf: cv/cv.html $(wildcard cv/css/cv/*.css)
	wkhtmltopdf \
		--title "Adam Williams" \
		--allow . \
		--no-background \
		--no-outline \
		--print-media-type \
		cv/cv.html cv/Adam_Williams.pdf


# Start development server
.PHONY: server
server:
	hugo server \
		--buildDrafts
		--enableGitInfo \
		--destination ./docs
