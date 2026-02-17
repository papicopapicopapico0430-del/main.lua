local OrionLib =  loadstring(game:HttpGet("https://raw.githubusercontent.com/jadpy/suki/refs/heads/main/orion"))()
local Window = OrionLib:MakeWindow({Name = "🐦‍⬛Yoizaki🐦‍⬛", HidePremium = true, SaveConfig = false})

-- [[ 設定セクション ]]
local CorrectKey1 = "ヨイザキ"
local CorrectKey2 = "Sex"
local CorrectKey3 = "0306"
local KeyInput = ""
local Attempts = 0
local MaxAttempts = 3
local IsLoaded = false

-- [[ メイン機能 ]]
function LoadMainScript()
    if IsLoaded then return end
    IsLoaded = true

    local Tab1 = Window:MakeTab({Name = "頂上", Icon = "rbxassetid://4483362458"})
    local Tab2 = Window:MakeTab({Name = "みそらタワー", Icon = "rbxassetid://4483362458"})
    local Tab3 = Window:MakeTab({Name = "マグマが上がってくるタワー", Icon = "rbxassetid://4483362458"})
    local Tab4 = Window:MakeTab({Name = "開発用", Icon = "rbxassetid://4483362458"})

    -- 固定座標テレポート
    Tab2:AddButton({
        Name = "みそらタワー頂上",
        Callback = function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(53, 812, -3024)
            end
        end    
    })

    -- 複数ターゲットからの自動TP
    Tab1:AddButton({
        Name = "ターゲットをスキャンしてTP",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")

            if hrp then
                local target = nil
                -- ここに探したい名前を10個以上並べてもOK！
                local targetNames = {
                    "Goal", 
                    "King", 
                    "OtherTarget", 
                    "Treeget",  
                    "Coin", 
                    "Chest", 
                    "Diamond", 
                    "Key",
                    "Star"
                } 

                -- Workspace内をスキャン
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if table.find(targetNames, obj.Name) and obj:IsA("BasePart") then
                        target = object
                        break -- 最初に見つかった1つで停止
                    end
                end
                
                if target then
                    hrp.CFrame = target.CFrame * CFrame.new(0, 3, 0)
                    OrionLib:MakeNotification({
                        Name = "Auto Teleport",
                        Content = target.Name .. " に自動移動しました！",
                        Time = 3
                    })
                else
                    OrionLib:MakeNotification({
                        Name = "fack you",
                        Content = "見つからなーい",
                        Time = 3
                    })
                end
            end
        end    
    })
Tab3:AddButton({
    Name = "Vfly",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/09025Qs5"))()
    end    
})
Tab4:AddButton({
    Name = "座標",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/2RkwMiLp"))()
    end    
})
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
        if KeyInput == CorrectKey1 or KeyInput == CorrectKey3 then
            OrionLib:MakeNotification({
                Name = "Access Granted",
                Content = "🖤Yoizaki🖤",
                Time = infinite -- infiniteを数値に変更
            })
            LoadMainScript()
        else
            Attempts = Attempts + 1
            local Left = MaxAttempts - Attempts
            
            if Attempts >= MaxAttempts then
                game.Players.LocalPlayer:Kick("\n【🖤Yoizaki🖤】\nざっこーkeyもわからないんですかー。")
            else
                OrionLib:MakeNotification({
                    Name = "Wrong Key",
                    Content = "キーが違います。残り: " .. tostring(Left) .. "回",
                    Time = 3
                })
            end
        end
    end
})

OrionLib:Init()
_G.LavaNoDamage = true -- Set to true for constant activation

task.spawn(function()
    while _G.LavaNoDamage do
        -- Scan all parts in workspace
        for _, v in pairs(workspace:GetDescendants()) do
            -- Target parts named Lava or Magma
            if v:IsA("BasePart") and (v.Name:lower():find("lava") or v.Name:lower():find("magma")) then
                -- Disable Damage (TouchTransmitter)
                local t = v:FindFirstChildOfClass("TouchTransmitter")
                if t then 
                    t:Destroy() 
                end
                -- Disable Collision/Touch
                v.CanTouch = false
            end
        end
        -- Wait 1 second before next scan to prevent lag
        task.wait(1)
    end
end)
