# homework

To pass ACCENT_COLOR parameters, config.json is used. This is flutter's default mechanism for passing assembly parameters --dart-define-from-file
The default parameter is specified for ease of development

To set the application icon, replace assets/appicon/icon.png
CI will automatically create the necessary icons for iOS and Android.
It can be done via config.json by specifying a link to the new icon and in CI download the icon and replace it. Due to lack of time this mechanism is not implemented.

Added checks for questions.json parameters used github action.

## Visual Studio Code launch.json

```
"configurations": [
	{
		"name": "Flutter",
		"request": "launch",
		"type": "dart",
		"toolArgs": [
			"--dart-define",
			"ACCENT_COLOR=0xFF533BEF"
		]
	}
]
```

## Flutter CLI

```
flutter run --dart-define=ACCENT_COLOR=0xFF533BEF 
```
