local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "🐦‍⬛Yoizaki🐦‍⬛", HidePremium = true, SaveConfig = false})

-- [[ 設定セクション ]]
local CorrectKey1 = "Yoizaki"
local CorrectKey2 = "0306"
local CorrectKey3 = "宵崎"
local CorrectKey4 = "ヨイザキ"
local KeyInput = ""
local Attempts = 0
local MaxAttempts = 3
local IsLoaded = false

-- [[ メイン機能 ]]
function LoadMainScript()
    if IsLoaded then return end
    IsLoaded = true

    local Tab1 = Window:MakeTab({Name = "メイン", Icon = "rbxassetid://4483362458"})

    -- ボタンのカッコとカンマを修正しました
    Tab1:AddButton({
        Name = "tp",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(-105, 922, -57) end
        end
    })

    Tab1:AddButton({
        Name = "荒らし",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(-62, 1160, -703) end
        end
    })

Tab1:AddToggle({
Name = "JumpPower",
Default = false,
Callback = function(Value)
if Value then
game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 1000
else
game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = false
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end
})
Tab1:AddToggle({
Name = "WalkSpeed",
Default = false,
Callback = function(Value)
if Value then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
else
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
})
end
-- [[ キー認証タブ ]]
local KeyTab = Window:MakeTab({Name = "Key🔑", Icon = "rbxassetid://4483362458"})

KeyTab:AddTextbox({
    Name = "キーを入力してください",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        KeyInput = Value
    end
})

KeyTab:AddButton({
    Name = "🔓 認証する",
    Callback = function()
        if KeyInput == CorrectKey1 or KeyInput == CorrectKey4 then
            OrionLib:MakeNotification({
                Name = "Access Granted",
                Content = "🖤Yoizaki hub🖤 認証成功！",
                Time = infinite
            })
            LoadMainScript()
        else
            Attempts = Attempts + 1
            if Attempts >= MaxAttempts then
                game.Players.LocalPlayer:Kick("認証失敗")
            else
                OrionLib:MakeNotification({
                    Name = "Wrong Key",
                    Content = "キーが違います。残り: " .. tostring(MaxAttempts - Attempts) .. "回",
                    Time = 3
                })
            end
        end
    end
})

OrionLib:Init()

