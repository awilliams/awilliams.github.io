.PHONY: generate
generate:
	hugo \
		--cleanDestinationDir \
		--enableGitInfo \
		--destination ./public

.PHONY: server
server:
	hugo server \
		--buildDrafts
		--enableGitInfo \
		--destination ./public
