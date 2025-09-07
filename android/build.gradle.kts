/**
 * Top-level Gradle build file.
 * Plugin versions and repositories are declared in settings.gradle.
 * Keep this minimal to avoid repository-mode conflicts.
 */
tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
