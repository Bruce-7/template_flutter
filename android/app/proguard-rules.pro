## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

## Google Play Core
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

## Gson
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

## OkHttp & Retrofit
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontwarn org.codehaus.mojo.animal_sniffer.*

## RevenueCat (purchases_flutter)
-keep class com.revenuecat.purchases.** { *; }
-keep interface com.revenuecat.purchases.** { *; }

## Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

## Keep custom model classes (adjust package name as needed)
-keep class com.yourbundleid.www.** { *; }

## Preserve line number information for debugging stack traces
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
