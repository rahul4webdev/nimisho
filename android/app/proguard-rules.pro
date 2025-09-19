# ✅ Razorpay SDK
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# ✅ ProGuard annotations (required by Razorpay)
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# ✅ Google Pay dependencies (PaymentsClient, Wallet, WalletUtils)
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**

# ✅ Keep all annotations (general safety)
-keepattributes *Annotation*
