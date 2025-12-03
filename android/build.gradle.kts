<<<<<<< HEAD
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

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
=======


// 2. Build Directory Relocation (Root Project)
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../build") // Changed from "../../build" to "../build" for standard flutter/android structure
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

// 3. Subprojects Configuration and Build Directory Relocation (Consolidated)
subprojects {

 val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
 project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Set up project dependencies (if needed, but usually belongs in build.gradle.kts)
    // project.evaluationDependsOn(":app") // WARNING: See note below
}

>>>>>>> 428a6df (updated images final code)
