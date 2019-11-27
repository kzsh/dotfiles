SHELL = /bin/sh

all: update build
build:
	swift build

update:
	swift package update
	swift package generate-xcodeproj

test:
	swift test

release: test
	swift build -c release -Xswiftc -static-stdlib

add-to-local-path: release
	cp -f .build/release/CommandLineTool /usr/local/bin/commandlinetool
