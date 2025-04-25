buildscript {
    repositories {
        google()
        mavenCentral()
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = File("../build")

subprojects {
    buildDir = File(rootProject.buildDir, name)
    evaluationDependsOn(":app")
}

// ✅ Correct Kotlin DSL way to define the clean task
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
