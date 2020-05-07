.PHONY : clean kill_xcode project

WORKSPACE=Injection.xcworkspace

setup:
	bash <(curl -Ls https://install.tuist.io)
	tuist generate
	xed $(WORKSPACE)

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
	tuist generate
	xed $(WORKSPACE)