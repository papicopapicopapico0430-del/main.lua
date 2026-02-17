local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jadpy/suki/refs/heads/main/orion"))()
local Window = OrionLib:MakeWindow({Name = "🐦‍⬛Yoizaki🐦‍⬛", HidePremium = true, SaveConfig = false})

-- [[ 設定セクション ]]
local CorrectKey1 = "ヨイザキ"
local CorrectKey2 = "Sex"
local CorrectKey3 = "0306"
local KeyInput = ""
local Attempts = 0
local MaxAttempts = 3
local IsLoaded = false

-- [[ メイン機能の定義 ]]
local function LoadMainScript()
    if IsLoaded then return end
    IsLoaded = true

    local Tab1 = Window:MakeTab({Name = "頂上", Icon = "rbxassetid://4483362458"})
    local Tab2 = Window:MakeTab({Name = "みそらタワー", Icon = "rbxassetid://4483362458"})
    local Tab3 = Window:MakeTab({Name = "マグマが上がってくるタワー", Icon = "rbxassetid://4483362458"})
    local Tab4 = Window:MakeTab({Name = "開発用", Icon = "rbxassetid://4483362458"})

    -- テレポート機能
    Tab2:AddButton({
        Name = "みそらタワー頂上",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(53, 812, -3024) end
        end    
    })

    Tab1:AddButton({
        Name = "ターゲットをスキャンしてTP",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local targetNames = {"Goal", "King", "OtherTarget", "Treeget", "Coin", "Chest", "Diamond", "Key", "Star"} 
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if table.find(targetNames, obj.Name) and obj:IsA("BasePart") then
                        hrp.CFrame = obj.CFrame * CFrame.new(0, 3, 0)
                        OrionLib:MakeNotification({Name = "Success", Content = obj.Name .. "へTPしました", Time = 3})
                        return
                    end
                end
                OrionLib:MakeNotification({Name = "Error", Content = "見つからん！", Time = 3})
            end
        end    
    })

    Tab3:AddButton({Name = "Vfly", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/09025Qs5"))() end})
    Tab4:AddButton({Name = "座標", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/2RkwMiLp"))() end})

    -- [[ 最強版マグマ無効化システム ]]
    _G.LavaNoDamage = true 
    
    local function NeutralizeLava(v)
        if v:IsA("BasePart") and (v.Name:lower():find("lava") or v.Name:lower():find("magma") or v.Name:lower():find("kill")) then
            v.CanTouch = false
            -- TouchTransmitter（ダメージ判定）を全て削除
            for _, child in pairs(v:GetDescendants()) do
                if child:IsA("TouchTransmitter") then
                    child:Destroy()
                end
            end
            -- スクリプト自体を止める（一部のゲームに有効）
            for _, s in pairs(v:GetChildren()) do
                if s:IsA("Script") or s:IsA("LocalScript") then
                    s.Disabled = true
                end
            end
        end
    end

    -- 既存のパーツを処理
    for _, v in pairs(workspace:GetDescendants()) do
        NeutralizeLava(v)
    end

    -- 新しく追加されるパーツを監視
    workspace.DescendantAdded:Connect(function(v)
        if _G.LavaNoDamage then
            task.wait(0.1) -- 生成直後のラグ対策
            NeutralizeLava(v)
        end
    end)

    -- 定期ループによる強制上書き（しつこいゲーム用）
    task.spawn(function()
        while _G.LavaNoDamage do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("lava") or v.Name:lower():find("magma")) then
                    if v.CanTouch == true then v.CanTouch = false end
                end
            end
            task.wait(1)
        end
    end)
end

-- [[ キー認証タブ ]]
local KeyTab = Window:MakeTab({Name = "Key🔑", Icon = "rbxassetid://4483362458"})
KeyTab:AddTextbox({Name = "キーを入力", Default = "", TextDisappear = true, Callback = function(v) KeyInput = v end})
KeyTab:AddButton({
    Name = "🔓 認証",
    Callback = function()
        if KeyInput == CorrectKey1 or KeyInput == CorrectKey2 or KeyInput == CorrectKey3 then
            OrionLib:MakeNotification({Name = "Access Granted", Content = "🖤Yoizaki🖤 認証成功！", Time = 5})
            LoadMainScript() -- ここでメイン機能が動く
        else
            Attempts = Attempts + 1
            if Attempts >= MaxAttempts then 
                game.Players.LocalPlayer:Kick("キー間違えすぎ。ざっこｗ") 
            else 
                OrionLib:MakeNotification({Name = "Wrong", Content = "残り"..(MaxAttempts-Attempts).."回", Time = 3}) 
            end
        end
    end
})

OrionLib:Init()
