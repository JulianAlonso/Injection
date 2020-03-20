fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### setup_project
```
fastlane setup_project
```
Download carthage dependencies and generate the XCWorkspace project
### test
```
fastlane test
```
Run the Unit Tests
### ci_increment_build_number
```
fastlane ci_increment_build_number
```
Increment build number
### bump_version
```
fastlane bump_version
```
Bumps version



- Only works on `master` branch

- Create as a new version number e.g. 2.1.8 -> 2.1.9 and 2.1.9 -> 2.2.0

- Increments the build number by 1

- Commits and pushes new version number to master

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
