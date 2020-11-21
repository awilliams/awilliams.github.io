.PHONY: Adam_Williams.pdf
Adam_Williams.pdf:
	wkhtmltopdf \
		--title "Adam Williams" \
		--allow . \
		--no-background \
		--no-outline \
		--print-media-type \
		cv.html Adam_Williams.pdf
