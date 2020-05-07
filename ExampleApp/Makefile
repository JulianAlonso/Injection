.PHONY : clean kill_xcode project

clean: 
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	rm -rf **/Derived

kill_xcode:
	killall Xcode || true
	killall Simulator || true

project: kill_xcode clean
	tuist focus