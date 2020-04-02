if which /usr/local/bin/swiftformat >/dev/null; then 
  /usr/local/bin/swiftformat --config ../.swiftformat.yml .. 
else 
    echo "warning: SwiftFormat not installed, download from https://github.com/nicklockwood/SwiftFormat"
fi