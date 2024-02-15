.PHONY: ci-wb ci-post-wb


# Arguments:
# v:   macOS version 
# 	   values: 13 or 14
#
# env: environment
# 	   values: warpbuild-prod for production, anything else for preproduction

# Usage examples:
# make ci-wb v=13 env=warpbuild-prod
# make ci-post-wb v=14 env=warpbuild-prod
# make ci-wb v=14

ci-wb:
	@echo "Building for macOS-$(v).arm64.tart"
	@sh scripts/macos/macOS-$(v).arm64.tart.build.sh

ci-post-wb:
	@echo "Pushing to macOS-$(v).arm64.tart for [$(env)]";
	@sh scripts/macos/macOS.arm64.tart.push.sh -e $(env) -v $(v);
