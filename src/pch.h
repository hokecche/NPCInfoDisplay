#pragma once

// 优先引入CommonLibF4核心头文件，提前加载所有RE命名空间的基础定义
#include <RE/Fallout.h>
#include <F4SE/F4SE.h>

// 补全你之前用到的UI事件类的专属头文件，彻底解决找不到MenuOpenEvent/MenuCloseEvent的报错
#include <RE/UI/MenuOpenEvent.h>
#include <RE/UI/MenuCloseEvent.h>
#include <RE/UI/HUDRenderEvent.h>

// 按需引入标准库头文件，避免冗余引入拖慢编译速度
#include <string>
#include <format>

// 补充你后续绘制UI会用到的宽字符、容器头文件，不用再在每个cpp里重复引入
#include <string_view>
#include <vector>

using namespace std::literals;
