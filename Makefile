.PHONY: open
open: fix
open:
	xed Package.swift

.PHONY: fix
fix: XCSHAREDDATA = .swiftpm/xcode/package.xcworkspace/xcshareddata
fix:
	@mkdir -p $(XCSHAREDDATA)
	@/usr/libexec/PlistBuddy -c \
		"Delete :FILEHEADER" \
		"$(XCSHAREDDATA)/IDETemplateMacros.plist" >/dev/null 2>&1 || true
	@header=$$'\n//  All Contributions by Match Group\n//\n//  Copyright © ___YEAR___ Tinder (Match Group, LLC)\n//\n//  Licensed under the Match Group Modified 3-Clause BSD License.\n//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.\n//'; \
	/usr/libexec/PlistBuddy -c \
		"Add :FILEHEADER string $$header" \
		"$(XCSHAREDDATA)/IDETemplateMacros.plist" >/dev/null 2>&1

.PHONY: lint
lint: format ?= emoji
lint:
	@swift package plugin \
		swiftlint lint --strict --progress --reporter "$(format)"

.PHONY: analyze
analyze: target ?= Layout
analyze: destination ?= generic/platform=iOS
analyze: format ?= emoji
analyze:
	@DERIVED_DATA="$$(mktemp -d)"; \
	XCODEBUILD_LOG="$$DERIVED_DATA/xcodebuild.log"; \
	xcodebuild \
		-scheme "$(target)" \
		-destination "$(destination)" \
		-derivedDataPath "$$DERIVED_DATA" \
		-configuration "Debug" \
		CODE_SIGNING_ALLOWED="NO" \
		> "$$XCODEBUILD_LOG"; \
	swift package plugin \
		swiftlint analyze --strict --progress --reporter "$(format)" --compiler-log-path "$$XCODEBUILD_LOG"

.PHONY: delete-snapshots
delete-snapshots:
	@for snapshots in $$(find Tests -type d -name "__Snapshots__"); \
	do \
		rm -rf "$$snapshots"; \
		echo "Deleted $$snapshots"; \
	done

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
	mkdir -p "$(prefix)/_site/cheatsheet"
	cp cheatsheet.html "$(prefix)/_site/cheatsheet/index.html"

.PHONY: docs
docs: target ?= Layout
docs: destination ?= generic/platform=iOS
docs: open ?= OPEN
docs: DERIVED_DATA_PATH = .build/documentation/data
docs: ARCHIVE_PATH = .build/documentation/archive
docs:
	@mkdir -p "$(DERIVED_DATA_PATH)" "$(ARCHIVE_PATH)"
	xcodebuild docbuild \
		-scheme "$(target)" \
		-destination "$(destination)" \
		-derivedDataPath "$(DERIVED_DATA_PATH)"
	@find "$(DERIVED_DATA_PATH)" \
		-type d \
		-name "$(target).doccarchive" \
		-exec cp -R {} "$(ARCHIVE_PATH)/" \;
	$(if $(filter $(open),OPEN),@open "$(ARCHIVE_PATH)/$(target).doccarchive",)
