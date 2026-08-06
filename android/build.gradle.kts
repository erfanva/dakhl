allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Some plugins (e.g. another_telephony) ship their own build.gradle with a
// stale Java/Kotlin JVM target (Java 11 vs Kotlin 1.8), which newer AGP/Kotlin
// versions reject as inconsistent. Force those modules onto the same target
// our app already uses (17) instead of patching each plugin individually.
// The app module configures its own toolchain already, so it's excluded here
// to avoid re-finalizing a property Kotlin has already locked in.
subprojects {
    if (project.name == "app") return@subprojects
    // afterEvaluate: AGP sets each module's compileOptions/kotlinOptions from
    // its own build.gradle during evaluation, so our override must run after
    // that — configuring eagerly here gets silently clobbered by AGP's own
    // (older) defaults for these plugin modules.
    afterEvaluate {
        plugins.withId("org.jetbrains.kotlin.android") {
            extensions.configure<org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension> {
                compilerOptions {
                    jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
                }
            }
        }
        // The Java side has to be set on AGP's own extension — overriding the
        // JavaCompile tasks directly gets overwritten by AGP's compileOptions.
        extensions.findByName("android")?.let { android ->
            (android as com.android.build.gradle.BaseExtension).compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
