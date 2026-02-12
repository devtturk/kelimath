## Flutter ProGuard Rules for KeliMath
## -----------------------------------

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

## Hive
-keep class * extends com.google.crypto.tink.shaded.protobuf.GeneratedMessageLite { *; }
-keep class hive.** { *; }
-keepclassmembers class ** {
    @com.google.gson.annotations.SerializedName <fields>;
}

## Firebase Crashlytics
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class com.google.firebase.crashlytics.** { *; }

## Keep model classes for JSON serialization
-keepclassmembers class ** {
  @com.google.gson.annotations.SerializedName <fields>;
}

## Preserve enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

## Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Play Store Split Install (Deferred Components) eksikliği uyarısını yoksay
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
