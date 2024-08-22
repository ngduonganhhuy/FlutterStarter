# Flutter Starter

## 🐦‍🔥🐦‍🔥 Snippet-code:

- Use `newPage` to create new page
- Use `newNavigation` to create new navigation method

## 🤗🤗 Steps start:

- Need to resolve all `TODO` comments
- Need to set variables for `ENV` files ( debug - release )

## 💥💥 How to use Navigator:

- Create new method in `navigator_service.dart`
- Use `NavigationService.${method()}` to navigate to specific page

## 🥴🥴 How to use cmd

- In makefile, example

```
get:
	 flutter pub get
```

- Run short cmd `make get` to run `flutter pub get`. You can create new `cmd` in makefile if you want

## 🌐🌐 Multi Languages

- Create new language by create file `app_$locale` in `lib/root/l10n/arb/app_$locale.arb` and set `@@locale`
- Add `key: value` in `app_$locale.arb` and use in page `context.l10n.$key`
- Note*: When you add new `key: value` in arb file. Please run `make lang` to generate and then you can use it