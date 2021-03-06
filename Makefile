.PHONY : bootstrap test clean kill_xcode project

WORKSPACE=Injection.xcworkspace

bootstrap:
	curl -Ls https://install.tuist.io
	tuist focus

test:
	swift test

clean: 
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	rm -rf **/Derived

kill_xcode:
	killall Xcode || true
	killall Simulator || true

project: kill_xcode clean
	tuist focus