-- 引入CommonLibF4子项目依赖
includes("lib/commonlibf4")

-- 项目基础配置
set_project("NPCInfoDisplay")
set_version("1.0.0")
set_license("GPL-3.0")
set_languages("c++23")
-- 启用全量编译警告，提前排查代码隐患
set_warnings("allextra")
-- 强制绑定动态运行时，避免和游戏本体依赖冲突
set_runtimes("MD")

-- 预配置spdlog日志库，适配F4SE插件的宽字符输出要求
add_requires("spdlog 1.16.0", {
    configs = {
        wchar = true,
        std_format = true
    }
})

-- 注册全场景编译模式
add_rules("mode.debug", "mode.release", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")

-- 插件构建目标
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
    -- 关联spdlog依赖
    add_packages("spdlog")
