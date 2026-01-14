_G.AutoFarm = true -- ปรับเป็น false เพื่อหยุด

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while task.wait(0.1) do
        if not _G.AutoFarm then break end

        local folder = workspace:FindFirstChild("Collectibles")
        
        if folder then
            local items = folder:GetChildren()

            if #items > 0 then
                for _, item in pairs(items) do
                    if not _G.AutoFarm then break end
                    
                    -- [จุดที่แก้] เช็คว่าชื่อต้อง "ไม่เท่ากับ" ClientModels
                    if item.Name ~= "ClientModels" then
                        
                        -- เช็คว่าของยังอยู่ไหม
                        if item and item.Parent then
                            local char = LocalPlayer.Character
                            local hrp = char and char:FindFirstChild("HumanoidRootPart")

                            if hrp then
                                -- หาตำแหน่ง
                                local targetCFrame = nil
                                if item:IsA("Model") then
                                    targetCFrame = item:GetPivot()
                                elseif item:IsA("BasePart") then
                                    targetCFrame = item.CFrame
                                end

                                -- ถ้าเจอตำแหน่ง ให้วาร์ปไป
                                if targetCFrame then
                                    hrp.CFrame = targetCFrame
                                    
                                    -- รอให้ Server รู้ว่าเก็บแล้ว
                                    task.wait(0.2) 
                                end
                            end
                        end
                    end -- จบเงื่อนไขเช็คชื่อ
                    
                end
            end
        end
    end
end)
