.PHONY: ci-wb

ci-wb:
	# run bash script at  scripts/macos/macOS-13.arm64.tart.build.sh
	echo "Building for macOS-13.arm64.tart"
	@sh scripts/macos/macOS-13.arm64.tart.build.sh

ci-post-wb:
	# run bash script at  scripts/macos/macOS-13.arm64.tart.push.sh
	echo "Pushing to macOS-13.arm64.tart"
	@sh scripts/macos/macOS-13.arm64.tart.push.sh
	