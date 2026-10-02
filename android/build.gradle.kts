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
// 部分第三方插件在其自身 build 脚本中硬编码了较低的 compileSdk，
// 会触发 AGP 的 AAR 元数据检查（要求 ≥36）。统一把插件子工程提升到 36。
// 注意：必须在 evaluationDependsOn(":app") 之前注册，否则 :app 已评估无法再挂回调。
subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let { androidExt ->
            runCatching {
                androidExt.javaClass
                    .getMethod("setCompileSdk", Int::class.javaPrimitiveType)
                    .invoke(androidExt, 36)
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
