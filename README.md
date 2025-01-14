# Neumorphic Calculator Compile Script

A GitHub Action Script to compile [Neumorphic Calculator](https://github.com/belelaritra/Neumorphic_Calculator) APKs.

![Downloads](https://img.shields.io/github/downloads/belelaritra/Neumorphic_Calculator/total)


[Script](https://github.com/ILoveScratch2/NeumorphicCalculator-BuildAction/blob/main/.github/workflows/build_flutter.yml)

```yaml
name: Build Flutter APK

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    # 1. Checkout the repository
    - name: Checkout code
      uses: actions/checkout@v2

    # 2. Set up Flutter
    - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '2.8.1'

    # 3. Install Java 11
    - name: Set up JDK
      uses: actions/setup-java@v2
      with:
        java-version: '11'  # 选择合适的 Java 版本
        distribution: 'adopt'

    # 4. Install dependencies
    - name: Install dependencies
      run: |
        flutter config --no-analytics
        flutter pub get

    # 5. Build APK
    - name: Build APK
      run: |
        flutter build apk --debug

    # 6. Upload APK artifact
    - name: Upload APK artifact
      uses: actions/upload-artifact@v3
      with:
        name: app-release.apk
        path: build/app/outputs/flutter-apk/app-debug.apk
```
