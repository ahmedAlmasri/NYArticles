# NYArticles

**NYArticles**  is an sample iOS App written in RxSwift using the MVVM architecture.  


- [Features](#features)
- [Running the Example](#run-sample)
- [Fastlane Command](#fastlane-command)
- [Requirements](#requirements)
- [Build with](#build-with)
- [Links](#links)
- [Author](#author)

### Features

- [ ] modular architecture using pod spec.
- [ ] Reactive programing.
- [ ] Dependency injection use swinject.
- [ ] multi layer architecture.
- [ ] repository pattern.
- [ ] unit Tested covered ~ 90%.
- [ ] code coverage report.
- [ ] test cases report.

### Run Sample 
1. Clone this repository.
    ```
    git https://github.com/ahmedAlmasri/NYArticles.git
    ```
2. run `pod install` in terminal. 

3. Open `NYArticles.xcworkspace` in Xcode. 

4. Run

### Fastlane Command

### ios run tests
Run test cases
```
fastlane ios tests
```

### ios xcov
code coverage report
```
fastlane ios cov
```
### Test Result Reports on `feature/TestResult` branch

* Test cases report [here](http://htmlpreview.github.io/?https://github.com/ahmedAlmasri/NYArticles/feature/TestResult/blob/fastlane/test_output/report.html)
* Test coverage report [here](http://htmlpreview.github.io/?https://github.com/ahmedAlmasri/NYArticles/feature/TestResult/blob/fastlane/xcov_output/index.html)

### Build with
* [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive framework
* [swinject](https://github.com/Swinject/Swinject) - Dependency injection
* [Pod Spec](https://guides.cocoapods.org/making/specs-and-specs-repo.html) - PodSpec for modular architecture 

### Requirements
- Xcode 11.4+
- Swift 5.2+
- iOS 13.0+
- Fastlane 2.148.1
- Swiftlint

### Links

- [Coordinators Redux](http://khanlou.com/2015/10/coordinators-redux/)

### Author

Ahmad Almasri, ahmed.almasri@ymail.com
