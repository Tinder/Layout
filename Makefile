.PHONY: lint
lint: format ?= emoji
lint:
	@swiftlint lint --strict --progress --reporter "$(format)"

.PHONY: site
site: target ?= Layout
site: prefix ?= $(shell pwd)
site: DOCC_PATH = $(shell xcrun --find docc)
site: ARCHIVE_PATH = .build/documentation/archive
site:
	@make docs open="no"
	"$(DOCC_PATH)" process-archive \
		transform-for-static-hosting \
		"$(ARCHIVE_PATH)/$(target).doccarchive" \
		--output-path "$(prefix)/_site"
	cp docs.html "$(prefix)/_site/index.html"
	cp docs.html "$(prefix)/_site/documentation/index.html"

.PHONY: docs
docs: target ?= Layout
docs: destination ?= generic/platform=iOS
docs: open ?= OPEN
docs: workaround ?= DISABLED
docs: DERIVED_DATA_PATH = .build/documentation/data
docs: ARCHIVE_PATH = .build/documentation/archive
docs:
	@mkdir -p "$(DERIVED_DATA_PATH)" "$(ARCHIVE_PATH)"
ifeq ($(strip $(workaround)),ENABLED)
# BEGIN: Temporary Xcode 14 workaround to fix DocC CI issue
	swift package dump-pif >/dev/null
	xcodebuild clean \
		-scheme "$(target)" \
		-destination "$(destination)" \
		-derivedDataPath "$(DERIVED_DATA_PATH)" || true
# END: Temporary Xcode 14 workaround to fix DocC CI issue
endif
	xcodebuild docbuild \
		-scheme "$(target)" \
		-destination "$(destination)" \
		-derivedDataPath "$(DERIVED_DATA_PATH)"
	@find "$(DERIVED_DATA_PATH)" \
		-type d \
		-name "$(target).doccarchive" \
		-exec cp -R {} "$(ARCHIVE_PATH)/" \;
	$(if $(filter $(open),OPEN),@open "$(ARCHIVE_PATH)/$(target).doccarchive",)

.PHONY: delete-snapshots
delete-snapshots:
	rm -rf Tests/LayoutTests/__Snapshots__/*
