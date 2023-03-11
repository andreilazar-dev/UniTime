# UniTime

Our project on GitHub consists of a time management application developed under GPL 3 license. The
app was created to provide users with a simple and intuitive interface to facilitate schedule
control and daily task planning. Our project encourages user collaboration so that they can
contribute to the improvement of the application. We are open to suggestions and feedback, and we
invite users to contribute to the source code to adapt it to their needs.

### Discalment
We would like to clarify that our project does not contain any files related to various servers for privacy reasons.
So you will need the following files to properly run the app: lib/misc/server/server.dart and lib/misc/server/servers.dart.
#### lib/misc/server/server.dart
```dart
@freezed
class Server with _$Server {
  const factory Server({
    required String label,
    required String code,
    required String server,
  }) = _Server;
}
```
#### lib/misc/server/servers.dart
```dart
class Servers {
  static final List<Server> servers = [
    const Server(
        label: "XXX",
        code: "XXX",
        server: "https://"),
  ];
}
```

## To correctly start an application, there are several steps you can follow:

1. Install [fvm](https://github.com/leoafarias/fvm)
2. Install the project Flutter version:

```bash 
fvm install
```

3. Generate the source code:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

If you want, you can use the watcher to generate code during development:

```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

To generate splash screen files

```bash
fvm flutter pub run flutter_native_splash:create
```

To generate icon files

```bash
fvm flutter pub run flutter_launcher_icons
```

To build the app correctly, the following example values must be in the local.properties file:

```
flutter.compileSdkVersion=33
flutter.minSdkVersion=21
flutter.targetSdkVersion=32
````




## Feel free to contact us for feedback or modifications. If you want to contribute, please create a branch from the development branch with a descriptive name of what you are working on. Then, submit a merge request.