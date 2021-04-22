.PHONY: generate
generate:
	hugo \
		--cleanDestinationDir \
		--enableGitInfo \
		--destination ./docs \
		--baseURL https://awilliams.github.io/

.PHONY: server
server:
	hugo server \
		--buildDrafts
		--enableGitInfo \
		--destination ./docs
