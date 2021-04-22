.PHONY: generate
generate: Adam_Williams.pdf
	hugo \
		--cleanDestinationDir \
		--minify \
		--enableGitInfo \
		--destination ./docs \
		--baseURL https://awilliams.github.io/


.PHONY: Adam_Williams.pdf
Adam_Williams.pdf:
	wkhtmltopdf \
		--title "Adam Williams" \
		--allow . \
		--no-background \
		--no-outline \
		--print-media-type \
		cv/cv.html cv/Adam_Williams.pdf


.PHONY: server
server:
	hugo server \
		--buildDrafts
		--enableGitInfo \
		--destination ./docs
