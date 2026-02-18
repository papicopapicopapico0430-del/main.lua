-- メインスクリプト (GitHub保存用)
-- ここにはキー認証を書かないことで、認証を突破した人だけが使えるようになります。

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "🐦‍⬛Yoizaki🐦‍⬛", HidePremium = true, SaveConfig = false})

local Tab1 = Window:MakeTab({Name = "メイン", Icon = "rbxassetid://4483362458"})

-- TPボタン
Tab1:AddButton({
    Name = "tp",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(-105, 922, -57) end
    end
})

-- 荒らしボタン
Tab1:AddButton({
    Name = "荒らし",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(-62, 1160, -703) end
    end
})

-- ジャンプ力
Tab1:AddToggle({
    Name = "JumpPower",
    Default = false,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.UseJumpPower = Value
            hum.JumpPower = Value and 1000 or 50
        end
    end
})

-- スピード
Tab1:AddToggle({
    Name = "WalkSpeed",
    Default = false,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = Value and 100 or 16
        end
    end
})

OrionLib:Init()
