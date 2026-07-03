-- 引入子项目CommonLibF4依赖
includes("lib/commonlibf4")

-- 项目基础配置
set_project("NPCInfoDisplay")
set_version("1.0.0")
set_license("GPL-3.0")
set_languages("c++23")
-- 修正拼写错误，启用全量额外编译警告
set_warnings("allextra")

-- 注册编译模式，补充缺失的release模式
add_rules("mode.debug", "mode.release", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")

-- 目标插件完整配置
target("NPCInfoDisplay")
    -- 启用F4SE插件专属构建规则
    add_rules("commonlibf4.plugin", {
        name = "NPCInfoDisplay",
        author = "hokecche",
        description = "基于CommonLibF4的辐射4 NPC信息显示插件"
    })

    -- 构建类型与源码配置
    set_kind("shared")
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")
