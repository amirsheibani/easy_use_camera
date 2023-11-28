# EasyUseCamera
# 🌍 About Project
This package for use camera take picture & video for all platform

# 🛠 Built With
- camera: [Camera](https://pub.dev/packages/camera)
- svg picture: [Flutter SVG](https://pub.dev/packages/flutter_svg)

### source structure :
```
/my_camera
  example/
        lib/
          main.dart
  lib/
    camera/
        dialog/
        widget/
        take_picture.dart
    my_camera.dart    
```

# 🧾 Setting up the project

### Android :
```
android {
  ...
  defaultConfig {
  minSdkVersion 21
  }
}
```
### iOS :
```
<key>NSCameraUsageDescription</key>
<string>This app needs access to camera when used</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app needs access to microphone when used</string>
```
### PWA :
```
We need SSL on host
```
### Naming

| what | how     | etc    |
| :-------- | :------- | :---------- |
| Classes, enums, typedefs | Pascal Case | ProductBloc  |
| Libraries, packages, directories, and source files names | snake_case | product_detail_view  |
| Variables, constants, parameters, and named parameters | camel Case | variants  |

### Cleaning
[Read this article about clean coding in flutter]("https://medium.com/flutter-community/flutter-best-practices-and-tips-7c2782c9ebb5")
- Create widgets int uikit for common components
- Don't use directly colors or font style, use uikit
- Split widgets into sub Widgets
- Create components package for sub widgets in each features
- Specify types for class member
- Use if condition instead of conditional expression
- Use ?? and ?. operators
- User cascade operators
    ```
    // Don't
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();


    // Do
    var path = Path()
    ..lineTo(0, size.height)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0)
    ..close();

    ```
- Use Const in Widgets

# ⛑ Code Review

**What Do Code Reviewers Look For?**
- Code reviews should look at:

- Design: Is the code well-designed and appropriate for your system?
- Functionality: Does the code behave as the author likely intended? Is the way the code behaves well for its users?
- Complexity: Could the code be made simpler? Would another developer be able to easily understand and use this code when they come across it in the future?
- Tests: Does the code have correct and well-designed automated tests?
- Naming: Did the developer choose clear names for variables, classes, methods, etc.?
- Comments: Are the comments clear and useful?
- Style: Does the code follow our style guides?
- Documentation: Did the developer also update relevant documentation?
- How to implement code review?


**According to the above points every merge request (pull request), must meet the check-list for ensuring about any concern maybe happened in the process.**

- check branch is not broken
- check feature is fulfill
- check test-case is passed
- check code style (with lint or manually)
- check readability
- check side-effects
- check consistency with other class/package/module
- check all comments on the merge request
- The reviewer if has any point about the merge request (pull request) leaves a comment on the line.

# 📚 Acknowledgements

- [Clean architecture in flutter](https://devmuaz.medium.com/flutter-clean-architecture-series-part-1-d2d4c2e75c47)
- [Clean coding in flutter](https://medium.com/flutter-community/flutter-best-practices-and-tips-7c2782c9ebb5)
- [Modularization in flutter](https://medium.com/flutter-community/mastering-flutter-modularization-in-several-ways-f5bced19101a)
- [Dependency injection with get it](https://pub.dev/packages/get_it)
- [Bloc Architecture in flutter](https://medium.com/codechai/architecting-your-flutter-project-bd04e144a8f1)
