import java.util.Properties

plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // FlutterFire
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// ✅ Proper Kotlin code to load keystore.properties
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
    println("✅ Loaded keystore.properties from: ${keystorePropertiesFile.absolutePath}")
} else {
    println("❌ keystore.properties not found at: ${keystorePropertiesFile.absolutePath}")
}

android {
    namespace = "com.habibi.mehvesujood"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.habibi.mehvesujood"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keyAliasProp = keystoreProperties.getProperty("keyAlias")
            val keyPasswordProp = keystoreProperties.getProperty("keyPassword")
            val storeFileProp = keystoreProperties.getProperty("storeFile")
            val storePasswordProp = keystoreProperties.getProperty("storePassword")

            if (keyAliasProp.isNullOrBlank() || keyPasswordProp.isNullOrBlank() ||
                storeFileProp.isNullOrBlank() || storePasswordProp.isNullOrBlank()) {
                throw GradleException("Missing one or more keystore properties. Please check keystore.properties.")
            }

            keyAlias = keyAliasProp
            keyPassword = keyPasswordProp
            storeFile = file(storeFileProp)
            storePassword = storePasswordProp
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
