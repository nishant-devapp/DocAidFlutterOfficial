## Please add these rules to your existing keep rules in order to suppress warnings.
## This is generated automatically by the Android Gradle plugin.
#-dontwarn proguard.annotation.Keep
#-dontwarn proguard.annotation.KeepClassMembers

# Razorpay SDK Keep Rules
-keep class proguard.annotation.Keep
-keepclassmembers class proguard.annotation.KeepClassMembers
-keepclassmembers class * {
    @proguard.annotation.Keep <fields>;
    @proguard.annotation.Keep <methods>;
}
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Suppress warnings for missing annotations
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers
