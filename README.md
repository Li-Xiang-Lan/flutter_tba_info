# flutter_tba_info

A new Flutter project.

## Get started

### Set Proguard

Create `proguard-rules.pro` file into your android->app, add content in this file
```dart
-keep public class com.android.installreferrer.**{ *; }
```

Quote proguard-rules.pro into your app->`build.gradle`
```dart
buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
```


