if which /usr/local/bin/swiftlint >/dev/null; then
  /usr/local/bin/swiftlint lint --lenient --path ..
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi