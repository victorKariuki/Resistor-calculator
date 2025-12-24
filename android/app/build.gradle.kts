plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.victorkariuki.resistorcalculator"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.victorkariuki.resistorcalculator"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("key.properties")
            if (keystorePropertiesFile.exists()) {
                val props = keystorePropertiesFile.readText()
                val keystoreProperties = props.lines()
                    .filter { it.contains("=") && !it.trimStart().startsWith("#") }
                    .associate {
                        val (key, value) = it.split("=", limit = 2)
                        key.trim() to value.trim()
                    }
                keyAlias = keystoreProperties["keyAlias"]
                keyPassword = keystoreProperties["keyPassword"]
                val storeFilePath = keystoreProperties["storeFile"]
                storeFile = storeFilePath?.let { rootProject.file(it) }
                storePassword = keystoreProperties["storePassword"]
            }
        }
    }

    buildTypes {
        release {
            val keystorePropertiesFile = rootProject.file("key.properties")
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                // Fallback to debug signing if key.properties doesn't exist
                // This allows building release APKs for testing without a keystore
                signingConfig = signingConfigs.getByName("debug")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
