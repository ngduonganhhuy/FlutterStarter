SHELL := /bin/bash
del-dot:
	find . -type f -name '._*' -delete

#HELPER
get:
	 flutter pub get
full:
	 flutter clean &&  flutter pub get && cd ios/ && rm -rf Pods && rm -rf Podfile.lock && pod install

#GEN
lang:
	 flutter gen-l10n --output-dir=lib/langs/arb
gen:
	 flutter pub run build_runner build --delete-conflicting-outputs

#AAB
aab-dev:
	 make copy-env
	 make full
	 make gen
	 flutter build appbundle -t lib/main_development.dart

aab-prod:
	 make copy-env
	 make full
	 make gen
	 flutter build appbundle -t lib/main_production.dart


#APK
apk-dev:
	 make copy-env
	 make full
	 make gen
	 flutter build apk -t lib/main_development.dart
apk-prod:
	 make copy-env
	 make full
	 make gen
	 flutter build apk -t lib/main_production.dart

#CMD RUN
rundev:
	 flutter run --release --target lib/main_development.dart

#OPEN XCODE
openios:
	open ios/Runner.xcworkspace

#ENV
env:
	flutter run --dart-define-from-file=.env

SOURCE_FILE := .env_dev
TARGET_FILE := .env
copy-env:
	cp $(SOURCE_FILE) $(TARGET_FILE)

	
