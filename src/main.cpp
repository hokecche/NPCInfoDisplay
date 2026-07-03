#include "pch.h"

namespace Plugin
{
    // 全局变量存储插件句柄
    static F4SE::PluginHandle g_pluginHandle{};

    // 屏幕渲染回调：每帧执行一次绘制逻辑
    class RenderHook
    {
    public:
        static void Install()
        {
            // 注册游戏UI渲染回调
            auto& renderManager = RE::UI::GetSingleton();
            renderManager.AddEventSink<RenderHook>();
        }

        void HandleEvent(RE::MenuOpenEvent* a_event)
        {
            // 空实现，仅用于注册事件接收器
        }

        void HandleEvent(RE::MenuCloseEvent* a_event)
        {
            // 空实现，仅用于注册事件接收器
        }

        void HandleEvent(RE::HUDRenderEvent* a_event)
        {
            if (!a_event || !a_event->renderTarget)
                return;

            // 获取当前准星指向的Actor对象
            auto crosshairPick = RE::PlayerCharacter::GetSingleton()->GetCrosshairPickRef();
            auto targetActor = crosshairPick ? crosshairPick->As<RE::Actor>() : nullptr;

            if (!targetActor || targetActor->IsDead())
                return;

            // 获取NPC名称
            std::string npcName = "";
            if (auto baseForm = targetActor->GetBaseObject())
            {
                if (auto name = baseForm->GetName())
                {
                    npcName = name;
                }
            }
            
            // 如果无法获取名称，使用默认值
            if (npcName.empty())
            {
                npcName = "未知目标";
            }

            // 读取NPC核心属性
            std::uint32_t npcLevel = targetActor->GetLevel();
            float currentHP = targetActor->GetActorValue(RE::ActorValue::kHealth);
            float maxHP = targetActor->GetBaseActorValue(RE::ActorValue::kHealth);

            // 格式化显示文本 - 添加名称显示
            std::wstring displayText = std::format(L"目标: {}\\n等级: {}\\n血量: {:.0f} / {:.0f}", 
                std::wstring(npcName.begin(), npcName.end()), // 转换string到wstring
                npcLevel, 
                currentHP, 
                maxHP);

            // 调用游戏内置的文本绘制接口，在屏幕左上角输出信息
            auto* uiDrawing = RE::UIRenderer::GetSingleton();
            uiDrawing->DrawText(displayText.c_str(), 20, 50, 0xFF, 0xFF, 0xFF, 255);
        }
    };

    // 插件初始化入口
    void Initialize()
    {
        // 注册F4SE消息回调
        F4SE::GetMessagingInterface()->RegisterListener([](F4SE::MessagingInterface::Message* msg) {
            if (msg->type == F4SE::MessagingInterface::kPostLoad)
            {
                // 所有游戏模块加载完成后安装渲染钩子
                RenderHook::Install();
                F4SE::log::info("NPC 等级血量显示插件加载完成");
            }
        });
    }
}

// F4SE 插件入口声明
F4SEPlugin_Load(const F4SE::LoadInterface* a_loadInterface)
{
    F4SE::Init(a_loadInterface, Plugin::g_pluginHandle);
    Plugin::Initialize();
    return true;
}
