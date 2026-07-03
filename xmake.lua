-- 引入CommonLibF4依赖库
includes("lib/commonlibf4")

-- 项目基础全局配置
set_project("NPCInfoDisplay")
set_version("1.0.0")
set_license("GPL-3.0")
set_languages("c++23")
set_warnings("allextra")
set_runtimes("MD") -- 强制对齐VS的MD动态运行时，避免和F4SE运行环境冲突

-- 启用标准构建模式与辅助规则
add_rules("mode.debug", "mode.release", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")

-- 预声明spdlog依赖，完全匹配之前报错的参数要求
add_requires("spdlog 1.16.0", {
    configs = {
        wchar = true,
        std_format = true
    }
})

-- 插件目标配置
target("NPCInfoDisplay")
    add_rules("commonlibf4.plugin", {
        name = "NPCInfoDisplay",
        author = "hokeche",
        description = "辐射4 NPC信息显示F4SE插件"
    })

    set_kind("shared")
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")
    add_packages("spdlog") -- 关联预声明的spdlog依赖
