

## Module Navigation Service (NS) Stack

<img width="482" alt="Screen Shot 2022-10-15 at 8 31 04 PM" src="https://user-images.githubusercontent.com/7789298/195992636-1763a277-381a-4e94-bf46-465cc66b43d6.png">

## Create a Module
```dart

class HostModule extends BaseModule {

  @override
  Future<void> init(BaseNavigationService navigationRouter,
      {DeepLink? deepLink}) async {
    //
  }

  @override
  Future<FeaturePage> pageWrapper(Widget child, {DeepLink? deepLink}) async {
    //
    return FeaturePage(
      page: MaterialPage(
        child: MaterialApp(
          home: child,
        ),
      ),
    );
  }

  @override
  Future<void> setRootPage({DeepLink? deepLink}) async {
    //
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
   //
  }
}

```
## Run a Module
```dart
var module = HostModule(
    key: "host",
    onReceive: ({deepLink}) => {},
    onError: (e) {
      print("Module Error ${e}");
    },
  );

  runAppModule(module, (a, b) {});
```
## Start Module
```dart
 var module1 = Modile1(
      key: "md1",
      onReceive: ({deepLink}) {},
      onError: (error) {
        print("Module1 Error ${error}");
      },
    );
    _navigationStack.startModule(module1, deepLink: deepLink);

```
## Finish Module
```dart
_navigationStack.finishModule(deepLink: deepLink)

```
