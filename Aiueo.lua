local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jadpy/suki/refs/heads/main/orion"))()

-- 正しいキー
local correctKey = "Yoizaki"

-- メインスクリプトURL
local mainScriptUrl = "https://raw.githubusercontent.com/papicopapicopapico0430-del/main.lua/main/main.lua"
-- URLだけを書くのが正解です！

-- グローバル変数
local keyVerified = false
local keyInput = ""
local OrionWindow

-- クリップボードにコピーする関数
local function copyToClipboard(text)
    local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    if clipboard then
        clipboard(text)
        return true
    else
        return false
    end
end

-- Orion UIを完全に閉じる関数
local function closeOrionUI()
    if OrionLib then
        -- OrionLibの全てのGUIを破棄
        if OrionLib.Flags then
            for _, flag in pairs(OrionLib.Flags) do
                pcall(function()
                    flag:Destroy()
                end)
            end
        end
        
        -- ウィンドウを破棄
        if OrionWindow then
            pcall(function()
                OrionWindow:Destroy()
            end)
            OrionWindow = nil
        end
        
        -- OrionLibのインスタンスをnilにする
        OrionLib = nil
        
        -- ガベージコレクションを促す
        wait()
        collectgarbage()
        
        print("🖤Yoizaki🖤 KeySystem - Orion UIを閉じました")
    end
end

-- メインスクリプト読み込み関数
local function loadMainScript()
    if keyVerified then
        local success, err = pcall(function()
            -- まずOrion UIを閉じる
            closeOrionUI()
            
            -- メインスクリプトを読み込む
            loadstring(game:HttpGet(mainScriptUrl))()
        end)
        
        if success then
            return true, "✅ メインスクリプトを読み込みました！KeySystemを終了します。"
        else
            return false, "❌ スクリプトの読み込みに失敗しました: " .. tostring(err)
        end
    else
        return false, "❌ キーが検証されていません"
    end
end

-- キー検証関数
local function verifyKey(inputKey)
    return inputKey == correctKey
end

-- GUI作成関数
local function createGUI()
    -- ウィンドウ作成
    OrionWindow = OrionLib:MakeWindow({
        Name = "🌸さくらhub🌸",
        HidePremium = true,
        SaveConfig = false,
        ConfigFolder = "SakuraHub"
    })

    -- タブ作成
    local KeyTab = OrionWindow:MakeTab({
        Name = "Key🔑",
        Icon = "rbxassetid://4483362458",
        PremiumOnly = false
    })

    local InfoTab = OrionWindow:MakeTab({
        Name = "詳細",
        Icon = "rbxassetid://4483362458",
        PremiumOnly = false
    })

    -- キータブの要素
    local statusLabel = KeyTab:AddLabel("ステータス: キーを入力してください")

    -- キー入力ボックス
    local keyInputValue = ""
    KeyTab:AddParagraph("キー入力", "下の欄にキーを入力してください:")
    
    local inputBox = KeyTab:AddTextbox({
        Name = "キー入力欄",
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            keyInputValue = Value
        end
    })

    -- 検証ボタン
    KeyTab:AddButton({
        Name = "🔑 キーを検証して実行",
        Callback = function()
            if verifyKey(keyInputValue) then
                keyVerified = true
                statusLabel:Set("✅ キーを確認しました！メインスクリプトを読み込んでいます...")
                
                -- メインスクリプトを読み込み
                local success, message = loadMainScript()
                
                if success then
                    -- 成功メッセージ（Orion UIが閉じられるので表示されないかもしれません）
                    print(message)
                else
                    -- エラーが発生した場合
                    statusLabel:Set(message)
                    OrionLib:MakeNotification({
                        Name = "エラー",
                        Content = "スクリプト読み込みに失敗しました",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                end
            else
                keyVerified = false
                statusLabel:Set("❌ 無効なキーです")
                OrionLib:MakeNotification({
                    Name = "エラー",
                    Content = "入力されたキーが正しくありません",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end
    })

    KeyTab:AddParagraph("", "") -- スペース
    KeyTab:AddParagraph("情報", "KeyはDiscordに記載されています！")

    -- Discordリンクコピーボタン
    KeyTab:AddButton({
        Name = "📋 Discordリンクをコピー",
        Callback = function()
            local success = copyToClipboard("https://discord.gg/qqb6U7gpX")
            if success then
                OrionLib:MakeNotification({
                    Name = "コピー成功",
                    Content = "Discordリンクをクリップボードにコピーしました！",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            else
                OrionLib:MakeNotification({
                    Name = "コピー失敗",
                    Content = "クリップボードへのコピーに失敗しました",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end
    })

    -- 詳細タブの要素
    InfoTab:AddParagraph("🖤Yoizaki hub🖤", "Key System - 正式版")
    InfoTab:AddParagraph("", "") -- スペース
    -- コミュニティDiscordリンク
    InfoTab:AddButton({
        Name = "📋 コミュニティDiscordをコピー",
        Callback = function()
            local success = copyToClipboard("https://discord.gg/T59y4gvBkJ")
            if success then
                OrionLib:MakeNotification({
                    Name = "コピー成功",
                    Content = "コミュニティリンクをコピーしました！",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end
    })

    InfoTab:AddParagraph("", "") -- スペース
    InfoTab:AddParagraph("サポート", "Gemini\nメイン生成: DeepSeek")
    InfoTab:AddParagraph("", "") -- スペース
    InfoTab:AddParagraph("", "") -- スペース
    InfoTab:AddParagraph("バージョン", "正式版 v0.5")

    -- 初期メッセージ
    OrionLib:MakeNotification({
        Name = "🖤Yoizaki hub🖤へようこそ！",
        Content = "Keyを入力してメインスクリプトをアンロックしてください",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    -- OrionLib初期化
    OrionLib:Init()
end

-- GUIを作成
createGUI()

-- ヒントメッセージ
print("🖤Yoizaki🖤")
print("Keyを入力してメインスクリプトをアンロックしてください")
print("正しいキーを入力すると、メインスクリプトが読み込まれ、KeySystemは閉じます")
