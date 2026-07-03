-- 引入CommonLibF4子项目
includes("lib/commonlibf4")

-- 全局基础配置 强绑定不允许被覆盖
set_project("NPCInfoDisplay")
set_version("1.0.0")
set_license("GPL-3.0")
set_languages("c++23")
set_warnings("allextra")
-- 全局强制锁定CRT运行时为MD，和CommonLibF4完全对齐，从根源避免链接冲突
set_runtimes("MD")

-- 预配置spdlog依赖，适配F4的宽字符输出要求
add_requires("spdlog 1.16.0", {
    configs = {
        wchar = true,
        std_format = true
    }
})

-- 注册全场景编译模式
add_rules("mode.debug", "mode.release", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")
add_defines("NOMINMAX")
add_cxxflags("/permissive-", {tools = "msvc"})

-- 插件构建目标 所有配置都在独立作用域内生效
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
    add_packages("spdlog")

-- 针对Release模式做定向强约束，避免默认规则覆盖
if is_mode("release") then
    set_optimize("fastest")
    add_defines("NDEBUG")
    set_symbols("none")
end


if is_plat("windows") and is_toolchain("msvc") then
    add_cxflags("/utf-8")
end
