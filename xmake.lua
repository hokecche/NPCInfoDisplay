-- 全局兼容补丁，彻底解决is_toolchain空值报错，不会再丢失
if not is_toolchain then
    is_toolchain = function(toolchain_name)
        return is_config("toolchain", toolchain_name)
    end
end

-- 引入CommonLibF4依赖
includes("lib/commonlibf4")

-- 项目基础配置
set_project("NPCInfoDisplay")
set_version("1.0.0")
set_license("GPL-3.0")
set_languages("c++23")
set_warnings("allextra")

-- 注册全量编译模式，覆盖debug/release/releasedbg所有场景
add_rules("mode.debug", "mode.release", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")

-- Windows平台专属优化，解决MSVC编码兼容问题
if is_plat("windows") then
    add_cxxflags("/utf-8", "/Zc:__cplusplus")
end

-- F4SE插件目标配置
target("NPCInfoDisplay")
    add_rules("commonlibf4.plugin", {
        name = "NPCInfoDisplay",
        author = "hokeche",
        description = "F4 plugin template using CommonLibF4"
    })
    set_kind("shared")
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")
