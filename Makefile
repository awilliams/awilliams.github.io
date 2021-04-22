.PHONY: generate
generate:
	hugo \
		--cleanDestinationDir \
		--enableGitInfo \
		--destination ./public \
		--baseURL https://awilliams.github.io/

.PHONY: server
server:
	hugo server \
		--buildDrafts
		--enableGitInfo \
		--destination ./public
