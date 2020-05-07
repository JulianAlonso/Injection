.PHONY : clean kill_xcode project

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
	swift package generate-xcodeproj
	xed .