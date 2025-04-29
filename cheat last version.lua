local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local inputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local drawing = Drawing

-- Состояние читов
local chamsEnabled = false
local aimbotEnabled = false
local instantAimEnabled = false
local silentAimEnabled = false
local aimSpeed = 1 -- 1 = мгновенно, 100 = медленно
local teamModeEnabled = false
local visibilityCheckEnabled = false
local aimFOV = 100
local silentFOV = 100
local speedhackEnabled = false
local speedhackBypassEnabled = false
local menuVisible = false
local aimTabVisible = false
local visualsTabVisible = false
local extrasTabVisible = false

-- Настройки спидхака
local defaultSpeed = 16
local speedMultiplier = 1 -- Начальная скорость (1x)
local boostedSpeed = defaultSpeed * speedMultiplier -- Итоговая скорость

-- Меню
local function createMenu()
    print("[DAN DEBUG]: Создаю статичное закругленное меню...")

    -- Кнопка открытия (круглая)
    local toggleButton = drawing.new("Circle")
    toggleButton.Radius = 30
    toggleButton.Position = Vector2.new(camera.ViewportSize.X - 40, 40)
    toggleButton.Color = Color3.fromRGB(50, 50, 50)
    toggleButton.Filled = true
    toggleButton.Visible = true

    local buttonIcon = drawing.new("Text")
    buttonIcon.Text = "⚡"
    buttonIcon.Size = 30
    buttonIcon.Color = Color3.fromRGB(255, 255, 255)
    buttonIcon.Position = Vector2.new(camera.ViewportSize.X - 50, 35)
    buttonIcon.Font = Drawing.Fonts.Plex
    buttonIcon.Visible = true

    -- Фон меню (закругленный)
    local menuBox = drawing.new("Square")
    menuBox.Size = Vector2.new(300, 500)
    menuBox.Position = Vector2.new(20, 50)
    menuBox.Color = Color3.fromRGB(40, 40, 40)
    menuBox.Filled = true
    menuBox.Radius = 20
    menuBox.Visible = false

    -- Разделительная линия
    local separatorLine = drawing.new("Square")
    separatorLine.Size = Vector2.new(2, 440)
    separatorLine.Position = Vector2.new(120, 80)
    separatorLine.Color = Color3.fromRGB(60, 60, 60)
    separatorLine.Filled = true
    separatorLine.Visible = false

    -- Кнопки категорий (слева, вертикально)
    local aimTabButton = drawing.new("Square")
    aimTabButton.Size = Vector2.new(80, 40)
    aimTabButton.Position = Vector2.new(30, 100)
    aimTabButton.Color = Color3.fromRGB(60, 60, 60)
    aimTabButton.Filled = true
    aimTabButton.Radius = 10
    aimTabButton.Visible = false

    local aimTabText = drawing.new("Text")
    aimTabText.Text = "Aim"
    aimTabText.Size = 20
    aimTabText.Color = Color3.fromRGB(255, 255, 255)
    aimTabText.Position = Vector2.new(45, 110)
    aimTabText.Font = Drawing.Fonts.Plex
    aimTabText.Visible = false

    local visualsTabButton = drawing.new("Square")
    visualsTabButton.Size = Vector2.new(80, 40)
    visualsTabButton.Position = Vector2.new(30, 150)
    visualsTabButton.Color = Color3.fromRGB(60, 60, 60)
    visualsTabButton.Filled = true
    visualsTabButton.Radius = 10
    visualsTabButton.Visible = false

    local visualsTabText = drawing.new("Text")
    visualsTabText.Text = "Visuals"
    visualsTabText.Size = 20
    visualsTabText.Color = Color3.fromRGB(255, 255, 255)
    visualsTabText.Position = Vector2.new(35, 160)
    visualsTabText.Font = Drawing.Fonts.Plex
    visualsTabText.Visible = false

    local extrasTabButton = drawing.new("Square")
    extrasTabButton.Size = Vector2.new(80, 40)
    extrasTabButton.Position = Vector2.new(30, 200)
    extrasTabButton.Color = Color3.fromRGB(60, 60, 60)
    extrasTabButton.Filled = true
    extrasTabButton.Radius = 10
    extrasTabButton.Visible = false

    local extrasTabText = drawing.new("Text")
    extrasTabText.Text = "Дополнение"
    extrasTabText.Size = 20
    extrasTabText.Color = Color3.fromRGB(255, 255, 255)
    extrasTabText.Position = Vector2.new(35, 210)
    extrasTabText.Font = Drawing.Fonts.Plex
    extrasTabText.Visible = false

    -- Функции Aim (справа)
    local aimButton = drawing.new("Square")
    aimButton.Size = Vector2.new(140, 40)
    aimButton.Position = Vector2.new(140, 100)
    aimButton.Color = Color3.fromRGB(50, 50, 50)
    aimButton.Filled = true
    aimButton.Radius = 10
    aimButton.Visible = false

    local aimText = drawing.new("Text")
    aimText.Text = "Aimbot"
    aimText.Size = 18
    aimText.Color = Color3.fromRGB(255, 255, 255)
    aimText.Position = Vector2.new(150, 110)
    aimText.Font = Drawing.Fonts.Plex
    aimText.Visible = false

    local instantAimButton = drawing.new("Square")
    instantAimButton.Size = Vector2.new(140, 40)
    instantAimButton.Position = Vector2.new(140, 150)
    instantAimButton.Color = Color3.fromRGB(50, 50, 50)
    instantAimButton.Filled = true
    instantAimButton.Radius = 10
    instantAimButton.Visible = false

    local instantAimText = drawing.new("Text")
    instantAimText.Text = "Instant Aim"
    instantAimText.Size = 18
    instantAimText.Color = Color3.fromRGB(255, 255, 255)
    instantAimText.Position = Vector2.new(150, 160)
    instantAimText.Font = Drawing.Fonts.Plex
    instantAimText.Visible = false

    local silentAimButton = drawing.new("Square")
    silentAimButton.Size = Vector2.new(140, 40)
    silentAimButton.Position = Vector2.new(140, 200)
    silentAimButton.Color = Color3.fromRGB(50, 50, 50)
    silentAimButton.Filled = true
    silentAimButton.Radius = 10
    silentAimButton.Visible = false

    local silentAimText = drawing.new("Text")
    silentAimText.Text = "Silent Aim"
    silentAimText.Size = 18
    silentAimText.Color = Color3.fromRGB(255, 255, 255)
    silentAimText.Position = Vector2.new(150, 210)
    silentAimText.Font = Drawing.Fonts.Plex
    silentAimText.Visible = false

    local teamModeButton = drawing.new("Square")
    teamModeButton.Size = Vector2.new(140, 40)
    teamModeButton.Position = Vector2.new(140, 250)
    teamModeButton.Color = Color3.fromRGB(50, 50, 50)
    teamModeButton.Filled = true
    teamModeButton.Radius = 10
    teamModeButton.Visible = false

    local teamModeText = drawing.new("Text")
    teamModeText.Text = "Team Mode"
    teamModeText.Size = 18
    teamModeText.Color = Color3.fromRGB(255, 255, 255)
    teamModeText.Position = Vector2.new(150, 260)
    teamModeText.Font = Drawing.Fonts.Plex
    teamModeText.Visible = false

    local fovText = drawing.new("Text")
    fovText.Text = "FOV: " .. aimFOV
    fovText.Size = 18
    fovText.Color = Color3.fromRGB(255, 255, 255)
    fovText.Position = Vector2.new(140, 300)
    fovText.Font = Drawing.Fonts.Plex
    fovText.Visible = false

    local sliderBarFOV = drawing.new("Square")
    sliderBarFOV.Size = Vector2.new(140, 10)
    sliderBarFOV.Position = Vector2.new(140, 330)
    sliderBarFOV.Color = Color3.fromRGB(70, 70, 70)
    sliderBarFOV.Filled = true
    sliderBarFOV.Radius = 5
    sliderBarFOV.Visible = false

    local sliderKnobFOV = drawing.new("Square")
    sliderKnobFOV.Size = Vector2.new(15, 20)
    sliderKnobFOV.Color = Color3.fromRGB(255, 50, 50)
    sliderKnobFOV.Filled = true
    sliderKnobFOV.Radius = 5
    sliderKnobFOV.Visible = false
    sliderKnobFOV.Position = Vector2.new(140 + ((aimFOV - 50) / 250) * 130, 325)

    local silentFovText = drawing.new("Text")
    silentFovText.Text = "Silent FOV: " .. silentFOV
    silentFovText.Size = 18
    silentFovText.Color = Color3.fromRGB(255, 255, 255)
    silentFovText.Position = Vector2.new(140, 360)
    silentFovText.Font = Drawing.Fonts.Plex
    silentFovText.Visible = false

    local sliderBarSilentFOV = drawing.new("Square")
    sliderBarSilentFOV.Size = Vector2.new(140, 10)
    sliderBarSilentFOV.Position = Vector2.new(140, 390)
    sliderBarSilentFOV.Color = Color3.fromRGB(70, 70, 70)
    sliderBarSilentFOV.Filled = true
    sliderBarSilentFOV.Radius = 5
    sliderBarSilentFOV.Visible = false

    local sliderKnobSilentFOV = drawing.new("Square")
    sliderKnobSilentFOV.Size = Vector2.new(15, 20)
    sliderKnobSilentFOV.Color = Color3.fromRGB(255, 50, 50)
    sliderKnobSilentFOV.Filled = true
    sliderKnobSilentFOV.Radius = 5
    sliderKnobSilentFOV.Visible = false
    sliderKnobSilentFOV.Position = Vector2.new(140 + ((silentFOV - 50) / 250) * 130, 385)

    local speedText = drawing.new("Text")
    speedText.Text = "Aim Speed: " .. aimSpeed
    speedText.Size = 18
    speedText.Color = Color3.fromRGB(255, 255, 255)
    speedText.Position = Vector2.new(140, 420)
    speedText.Font = Drawing.Fonts.Plex
    speedText.Visible = false

    local sliderBarSpeed = drawing.new("Square")
    sliderBarSpeed.Size = Vector2.new(140, 10)
    sliderBarSpeed.Position = Vector2.new(140, 450)
    sliderBarSpeed.Color = Color3.fromRGB(70, 70, 70)
    sliderBarSpeed.Filled = true
    sliderBarSpeed.Radius = 5
    sliderBarSpeed.Visible = false

    local sliderKnobSpeed = drawing.new("Square")
    sliderKnobSpeed.Size = Vector2.new(15, 20)
    sliderKnobSpeed.Color = Color3.fromRGB(255, 50, 50)
    sliderKnobSpeed.Filled = true
    sliderKnobSpeed.Radius = 5
    sliderKnobSpeed.Visible = false
    sliderKnobSpeed.Position = Vector2.new(140 + ((aimSpeed - 1) / 99) * 130, 445)

    -- Функции Visuals (справа)
    local chamsButton = drawing.new("Square")
    chamsButton.Size = Vector2.new(140, 40)
    chamsButton.Position = Vector2.new(140, 100)
    chamsButton.Color = Color3.fromRGB(50, 50, 50)
    chamsButton.Filled = true
    chamsButton.Radius = 10
    chamsButton.Visible = false

    local chamsText = drawing.new("Text")
    chamsText.Text = "Chams"
    chamsText.Size = 18
    chamsText.Color = Color3.fromRGB(255, 255, 255)
    chamsText.Position = Vector2.new(150, 110)
    chamsText.Font = Drawing.Fonts.Plex
    chamsText.Visible = false

    local visCheckButton = drawing.new("Square")
    visCheckButton.Size = Vector2.new(140, 40)
    visCheckButton.Position = Vector2.new(140, 150)
    visCheckButton.Color = Color3.fromRGB(50, 50, 50)
    visCheckButton.Filled = true
    visCheckButton.Radius = 10
    visCheckButton.Visible = false

    local visCheckText = drawing.new("Text")
    visCheckText.Text = "Vis Check"
    visCheckText.Size = 18
    visCheckText.Color = Color3.fromRGB(255, 255, 255)
    visCheckText.Position = Vector2.new(150, 160)
    visCheckText.Font = Drawing.Fonts.Plex
    visCheckText.Visible = false

    -- Функции Дополнение (справа с подложкой)
    local extrasBackground = drawing.new("Square")
    extrasBackground.Size = Vector2.new(160, 200)
    extrasBackground.Position = Vector2.new(130, 90)
    extrasBackground.Color = Color3.fromRGB(45, 45, 45)
    extrasBackground.Filled = true
    extrasBackground.Radius = 15
    extrasBackground.Visible = false

    local speedBoostButton = drawing.new("Square")
    speedBoostButton.Size = Vector2.new(140, 40)
    speedBoostButton.Position = Vector2.new(140, 100)
    speedBoostButton.Color = Color3.fromRGB(50, 50, 50)
    speedBoostButton.Filled = true
    speedBoostButton.Radius = 10
    speedBoostButton.Visible = false

    local speedBoostText = drawing.new("Text")
    speedBoostText.Text = "Speed Boost"
    speedBoostText.Size = 18
    speedBoostText.Color = Color3.fromRGB(255, 255, 255)
    speedBoostText.Position = Vector2.new(150, 110)
    speedBoostText.Font = Drawing.Fonts.Plex
    speedBoostText.Visible = false

    local speedSliderText = drawing.new("Text")
    speedSliderText.Text = "Speed: " .. speedMultiplier .. "x"
    speedSliderText.Size = 18
    speedSliderText.Color = Color3.fromRGB(255, 255, 255)
    speedSliderText.Position = Vector2.new(140, 150)
    speedSliderText.Font = Drawing.Fonts.Plex
    speedSliderText.Visible = false

    local speedSliderBar = drawing.new("Square")
    speedSliderBar.Size = Vector2.new(140, 10)
    speedSliderBar.Position = Vector2.new(140, 180)
    speedSliderBar.Color = Color3.fromRGB(70, 70, 70)
    speedSliderBar.Filled = true
    speedSliderBar.Radius = 5
    speedSliderBar.Visible = false

    local speedSliderKnob = drawing.new("Square")
    speedSliderKnob.Size = Vector2.new(15, 20)
    speedSliderKnob.Color = Color3.fromRGB(255, 50, 50)
    speedSliderKnob.Filled = true
    speedSliderKnob.Radius = 5
    speedSliderKnob.Visible = false
    speedSliderKnob.Position = Vector2.new(140, 175)

    local speedBypassButton = drawing.new("Square")
    speedBypassButton.Size = Vector2.new(140, 40)
    speedBypassButton.Position = Vector2.new(140, 220)
    speedBypassButton.Color = Color3.fromRGB(50, 50, 50)
    speedBypassButton.Filled = true
    speedBypassButton.Radius = 10
    speedBypassButton.Visible = false

    local speedBypassText = drawing.new("Text")
    speedBypassText.Text = "Speedhack Bypass"
    speedBypassText.Size = 18
    speedBypassText.Color = Color3.fromRGB(255, 255, 255)
    speedBypassText.Position = Vector2.new(150, 230)
    speedBypassText.Font = Drawing.Fonts.Plex
    speedBypassText.Visible = false

    local draggingFOV = false
    local draggingSpeed = false
    local draggingSpeedHack = false
    local draggingSilentFOV = false

    local aimObjects = {aimButton, aimText, instantAimButton, instantAimText, silentAimButton, silentAimText, teamModeButton, teamModeText, fovText, sliderBarFOV, sliderKnobFOV, silentFovText, sliderBarSilentFOV, sliderKnobSilentFOV, speedText, sliderBarSpeed, sliderKnobSpeed}
    local visualsObjects = {chamsButton, chamsText, visCheckButton, visCheckText}
    local extrasObjects = {extrasBackground, speedBoostButton, speedBoostText, speedSliderText, speedSliderBar, speedSliderKnob, speedBypassButton, speedBypassText}

    local function toggleMenu()
        menuVisible = not menuVisible
        menuBox.Visible = menuVisible
        separatorLine.Visible = menuVisible
        aimTabButton.Visible = menuVisible
        aimTabText.Visible = menuVisible
        visualsTabButton.Visible = menuVisible
        visualsTabText.Visible = menuVisible
        extrasTabButton.Visible = menuVisible
        extrasTabText.Visible = menuVisible
        if not menuVisible then
            aimTabVisible = false
            visualsTabVisible = false
            extrasTabVisible = false
            for _, obj in pairs(aimObjects) do obj.Visible = false end
            for _, obj in pairs(visualsObjects) do obj.Visible = false end
            for _, obj in pairs(extrasObjects) do obj.Visible = false end
        end
        print("[DAN DEBUG]: Меню " .. (menuVisible and "открыто" or "закрыто"))
    end

    inputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = inputService:GetMouseLocation()
            if mousePos.X >= toggleButton.Position.X - 30 and mousePos.X <= toggleButton.Position.X + 30 and
               mousePos.Y >= toggleButton.Position.Y - 30 and mousePos.Y <= toggleButton.Position.Y + 30 then
                toggleMenu()
            elseif menuVisible then
                if mousePos.X >= aimTabButton.Position.X and mousePos.X <= aimTabButton.Position.X + 80 and
                   mousePos.Y >= aimTabButton.Position.Y and mousePos.Y <= aimTabButton.Position.Y + 40 then
                    if not aimTabVisible then
                        aimTabVisible = true
                        visualsTabVisible = false
                        extrasTabVisible = false
                        for _, obj in pairs(visualsObjects) do obj.Visible = false end
                        for _, obj in pairs(extrasObjects) do obj.Visible = false end
                        for _, obj in pairs(aimObjects) do obj.Visible = true end
                        aimTabButton.Color = Color3.fromRGB(80, 80, 80)
                        visualsTabButton.Color = Color3.fromRGB(60, 60, 60)
                        extrasTabButton.Color = Color3.fromRGB(60, 60, 60)
                    end
                elseif mousePos.X >= visualsTabButton.Position.X and mousePos.X <= visualsTabButton.Position.X + 80 and
                       mousePos.Y >= visualsTabButton.Position.Y and mousePos.Y <= visualsTabButton.Position.Y + 40 then
                    if not visualsTabVisible then
                        visualsTabVisible = true
                        aimTabVisible = false
                        extrasTabVisible = false
                        for _, obj in pairs(aimObjects) do obj.Visible = false end
                        for _, obj in pairs(extrasObjects) do obj.Visible = false end
                        for _, obj in pairs(visualsObjects) do obj.Visible = true end
                        visualsTabButton.Color = Color3.fromRGB(80, 80, 80)
                        aimTabButton.Color = Color3.fromRGB(60, 60, 60)
                        extrasTabButton.Color = Color3.fromRGB(60, 60, 60)
                    end
                elseif mousePos.X >= extrasTabButton.Position.X and mousePos.X <= extrasTabButton.Position.X + 80 and
                       mousePos.Y >= extrasTabButton.Position.Y and mousePos.Y <= extrasTabButton.Position.Y + 40 then
                    if not extrasTabVisible then
                        extrasTabVisible = true
                        aimTabVisible = false
                        visualsTabVisible = false
                        for _, obj in pairs(aimObjects) do obj.Visible = false end
                        for _, obj in pairs(visualsObjects) do obj.Visible = false end
                        for _, obj in pairs(extrasObjects) do obj.Visible = true end
                        extrasTabButton.Color = Color3.fromRGB(80, 80, 80)
                        aimTabButton.Color = Color3.fromRGB(60, 60, 60)
                        visualsTabButton.Color = Color3.fromRGB(60, 60, 60)
                    end
                elseif aimTabVisible then
                    if mousePos.X >= aimButton.Position.X and mousePos.X <= aimButton.Position.X + 140 and
                       mousePos.Y >= aimButton.Position.Y and mousePos.Y <= aimButton.Position.Y + 40 then
                        aimbotEnabled = not aimbotEnabled
                        aimButton.Color = aimbotEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        print("[DAN CHEAT]: Aimbot " .. (aimbotEnabled and "врублен" or "вырублен"))
                    elseif mousePos.X >= instantAimButton.Position.X and mousePos.X <= instantAimButton.Position.X + 140 and
                           mousePos.Y >= instantAimButton.Position.Y and mousePos.Y <= instantAimButton.Position.Y + 40 then
                        instantAimEnabled = not instantAimEnabled
                        instantAimButton.Color = instantAimEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        print("[DAN CHEAT]: Instant Aim " .. (instantAimEnabled and "врублен" or "вырублен"))
                    elseif mousePos.X >= silentAimButton.Position.X and mousePos.X <= silentAimButton.Position.X + 140 and
                           mousePos.Y >= silentAimButton.Position.Y and mousePos.Y <= silentAimButton.Position.Y + 40 then
                        silentAimEnabled = not silentAimEnabled
                        silentAimButton.Color = silentAimEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        print("[DAN CHEAT]: Silent Aim " .. (silentAimEnabled and "врублен" or "вырублен"))
                    elseif mousePos.X >= teamModeButton.Position.X and mousePos.X <= teamModeButton.Position.X + 140 and
                           mousePos.Y >= teamModeButton.Position.Y and mousePos.Y <= teamModeButton.Position.Y + 40 then
                        teamModeEnabled = not teamModeEnabled
                        teamModeButton.Color = teamModeEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        print("[DAN CHEAT]: Team Mode " .. (teamModeEnabled and "врублен" or "вырублен"))
                    elseif mousePos.X >= sliderKnobFOV.Position.X and mousePos.X <= sliderKnobFOV.Position.X + 15 and
                           mousePos.Y >= sliderKnobFOV.Position.Y and mousePos.Y <= sliderKnobFOV.Position.Y + 20 then
                        draggingFOV = true
                    elseif mousePos.X >= sliderKnobSilentFOV.Position.X and mousePos.X <= sliderKnobSilentFOV.Position.X + 15 and
                           mousePos.Y >= sliderKnobSilentFOV.Position.Y and mousePos.Y <= sliderKnobSilentFOV.Position.Y + 20 then
                        draggingSilentFOV = true
                    elseif mousePos.X >= sliderKnobSpeed.Position.X and mousePos.X <= sliderKnobSpeed.Position.X + 15 and
                           mousePos.Y >= sliderKnobSpeed.Position.Y and mousePos.Y <= sliderKnobSpeed.Position.Y + 20 then
                        draggingSpeed = true
                    end
                elseif visualsTabVisible then
                    if mousePos.X >= chamsButton.Position.X and mousePos.X <= chamsButton.Position.X + 140 and
                       mousePos.Y >= chamsButton.Position.Y and mousePos.Y <= chamsButton.Position.Y + 40 then
                        chamsEnabled = not chamsEnabled
                        chamsButton.Color = chamsEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        print("[DAN CHEAT]: Chams " .. (chamsEnabled and "врублены" or "вырублены"))
                    elseif mousePos.X >= visCheckButton.Position.X and mousePos.X <= visCheckButton.Position.X + 140 and
                           mousePos.Y >= visCheckButton.Position.Y and mousePos.Y <= visCheckButton.Position.Y + 40 then
                        visibilityCheckEnabled = not visibilityCheckEnabled
                        visCheckButton.Color = visibilityCheckEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        print("[DAN CHEAT]: Vis Check " .. (visibilityCheckEnabled and "врублен" or "вырублен"))
                    end
                elseif extrasTabVisible then
                    if mousePos.X >= speedBoostButton.Position.X and mousePos.X <= speedBoostButton.Position.X + 140 and
                       mousePos.Y >= speedBoostButton.Position.Y and mousePos.Y <= speedBoostButton.Position.Y + 40 then
                        speedhackEnabled = not speedhackEnabled
                        speedBoostButton.Color = speedhackEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        local character = player.Character or player.CharacterAdded:Wait()
                        local humanoid = character:WaitForChild("Humanoid")
                        if speedhackEnabled then
                            humanoid.WalkSpeed = boostedSpeed
                            print("[DAN CHEAT]: Ты теперь в " .. speedMultiplier .. " раза быстрее, пиздец, беги, сука!")
                        else
                            humanoid.WalkSpeed = defaultSpeed
                            print("[DAN CHEAT]: Скорость выключена, ходи как лох")
                        end
                    elseif mousePos.X >= speedSliderKnob.Position.X and mousePos.X <= speedSliderKnob.Position.X + 15 and
                           mousePos.Y >= speedSliderKnob.Position.Y and mousePos.Y <= speedSliderKnob.Position.Y + 20 then
                        draggingSpeedHack = true
                    elseif mousePos.X >= speedBypassButton.Position.X and mousePos.X <= speedBypassButton.Position.X + 140 and
                           mousePos.Y >= speedBypassButton.Position.Y and mousePos.Y <= speedBypassButton.Position.Y + 40 then
                        speedhackBypassEnabled = not speedhackBypassEnabled
                        speedBypassButton.Color = speedhackBypassEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(50, 50, 50)
                        if speedhackBypassEnabled then
                            print("[DAN CHEAT]: Спидхак-обход врублен, сука, бегай плавно с 48 скоростью!")
                        else
                            print("[DAN CHEAT]: Спидхак-обход выключен, ходи как лох")
                        end
                    end
                end
            end
        end
    end)

    inputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingFOV = false
            draggingSpeed = false
            draggingSpeedHack = false
            draggingSilentFOV = false
        end
    end)

    inputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = inputService:GetMouseLocation()
            if draggingFOV then
                local newX = math.clamp(mousePos.X, sliderBarFOV.Position.X, sliderBarFOV.Position.X + 130)
                sliderKnobFOV.Position = Vector2.new(newX, sliderBarFOV.Position.Y - 5)
                aimFOV = math.floor(50 + ((newX - sliderBarFOV.Position.X) / 130) * 250)
                fovText.Text = "FOV: " .. aimFOV
                print("[DAN DEBUG]: FOV изменен на " .. aimFOV)
            elseif draggingSilentFOV then
                local newX = math.clamp(mousePos.X, sliderBarSilentFOV.Position.X, sliderBarSilentFOV.Position.X + 130)
                sliderKnobSilentFOV.Position = Vector2.new(newX, sliderBarSilentFOV.Position.Y - 5)
                silentFOV = math.floor(50 + ((newX - sliderBarSilentFOV.Position.X) / 130) * 250)
                silentFovText.Text = "Silent FOV: " .. silentFOV
                print("[DAN DEBUG]: Silent FOV изменен на " .. silentFOV)
            elseif draggingSpeed then
                local newX = math.clamp(mousePos.X, sliderBarSpeed.Position.X, sliderBarSpeed.Position.X + 130)
                sliderKnobSpeed.Position = Vector2.new(newX, sliderBarSpeed.Position.Y - 5)
                aimSpeed = math.floor(1 + ((newX - sliderBarSpeed.Position.X) / 130) * 99)
                speedText.Text = "Aim Speed: " .. aimSpeed
                print("[DAN DEBUG]: Aim Speed изменен на " .. aimSpeed)
            elseif draggingSpeedHack then
                local newX = math.clamp(mousePos.X, speedSliderBar.Position.X, speedSliderBar.Position.X + 130)
                speedSliderKnob.Position = Vector2.new(newX, speedSliderBar.Position.Y - 5)
                speedMultiplier = math.floor(1 + ((newX - speedSliderBar.Position.X) / 130) * 2)
                speedSliderText.Text = "Speed: " .. speedMultiplier .. "x"
                boostedSpeed = defaultSpeed * speedMultiplier
                if speedhackEnabled then
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:WaitForChild("Humanoid")
                    humanoid.WalkSpeed = boostedSpeed
                    print("[DAN DEBUG]: Скорость спидхака изменена на " .. speedMultiplier .. "x (" .. boostedSpeed .. ")")
                end
            end
        end
    end)

    -- Обычный спидхак
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    local function makeYouGoddamnFast()
        if humanoid then
            humanoid.WalkSpeed = boostedSpeed
            print("[DAN CHEAT]: Ты теперь в " .. speedMultiplier .. " раза быстрее, пиздец, беги, сука!")
        else
            warn("[DAN CHEAT]: Где твой гуманоид, мудила? Не могу ускорить пустоту!")
        end
    end

    spawn(function()
        while true do
            wait(1)
            if speedhackEnabled and humanoid and humanoid.WalkSpeed ~= boostedSpeed then
                humanoid.WalkSpeed = boostedSpeed
                print("[DAN CHEAT]: Скорость пыталась съебаться, но я её вернул, мать твою!")
            elseif not speedhackEnabled and humanoid and humanoid.WalkSpeed ~= defaultSpeed then
                humanoid.WalkSpeed = defaultSpeed
            end
        end
    end)

    player.CharacterAdded:Connect(function(newChar)
        character = newChar
        humanoid = newChar:WaitForChild("Humanoid")
        rootPart = newChar:WaitForChild("HumanoidRootPart")
        if speedhackEnabled then
            makeYouGoddamnFast()
            print("[DAN CHEAT]: Перс обновился, но я снова сделал тебя богом скорости, сука!")
        end
    end)

    -- Спидхак-обход через CFrame
    local function applySpeedHackBypass()
        if speedhackBypassEnabled and rootPart and humanoid then
            local moveDirection = humanoid.MoveDirection
            if moveDirection.Magnitude > 0 then
                local newCFrame = rootPart.CFrame + (moveDirection * (48 / 30))
                rootPart.CFrame = newCFrame
            end
        end
    end

    spawn(function()
        while true do
            wait(0.03)
            applySpeedHackBypass()
        end
    end)

    return chamsButton, aimButton, instantAimButton, silentAimButton, teamModeButton, visCheckButton, sliderKnobFOV, sliderKnobSilentFOV, sliderKnobSpeed, toggleButton, aimTabButton, visualsTabButton, extrasTabButton, separatorLine, speedBoostButton, speedBypassButton, speedSliderKnob
end

local chamsButton, aimButton, instantAimButton, silentAimButton, teamModeButton, visCheckButton, sliderKnobFOV, sliderKnobSilentFOV, sliderKnobSpeed, toggleButton, aimTabButton, visualsTabButton, extrasTabButton, separatorLine, speedBoostButton, speedBypassButton, speedSliderKnob = createMenu()

-- FOV круг
local fovCircle = drawing.new("Circle")
fovCircle.Radius = aimFOV
fovCircle.Color = Color3.fromRGB(255, 0, 0)
fovCircle.Thickness = 2
fovCircle.Filled = false
fovCircle.Visible = false
fovCircle.Position = inputService:GetMouseLocation()

-- Silent FOV круг
local silentFovCircle = drawing.new("Circle")
silentFovCircle.Radius = silentFOV
silentFovCircle.Color = Color3.fromRGB(0, 255, 0)
silentFovCircle.Thickness = 2
silentFovCircle.Filled = false
silentFovCircle.Visible = false
silentFovCircle.Position = inputService:GetMouseLocation()

-- Chams
local highlights = {}

local function createHighlight(enemy)
    if not highlights[enemy] then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = nil
        highlight.Parent = game.CoreGui
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.OutlineTransparency = 0
        highlight.FillTransparency = 0.5
        highlights[enemy] = highlight

        enemy.CharacterAdded:Connect(function(newChar)
            task.wait(0.1)
            if highlights[enemy] then
                highlights[enemy].Adornee = newChar
            end
        end)

        enemy.CharacterRemoving:Connect(function()
            if highlights[enemy] then
                highlights[enemy].Adornee = nil
            end
        end)

        game.Players.PlayerRemoving:Connect(function(leavingPlayer)
            if leavingPlayer == enemy and highlights[enemy] then
                highlights[enemy]:Destroy()
                highlights[enemy] = nil
            end
        end)
    end
end

for _, enemy in pairs(game.Players:GetPlayers()) do
    if enemy ~= player then
        createHighlight(enemy)
    end
end

game.Players.PlayerAdded:Connect(function(newPlayer)
    if newPlayer ~= player then
        createHighlight(newPlayer)
    end
end)

-- Новая функция проверки видимости
local function isVisible(target)
    if not target then 
        print("[DAN DEBUG]: Цель - nil, пиздец, нету врага!")
        return false 
    end
    
    -- Точка старта луча: из камеры + смещение вперед
    local rayOrigin = camera.CFrame.Position + camera.CFrame.LookVector * 2 -- Смещение на 2 единицы вперед от камеры
    print("[DAN DEBUG]: Raycast идет из камеры со смещением: " .. tostring(rayOrigin))
    
    local rayDirection = (target.Position - rayOrigin)
    local raycastParams = RaycastParams.new()
    -- Фильтруем весь перс, а не только голову
    if player.Character then
        raycastParams.FilterDescendantsInstances = {player.Character}
    else
        raycastParams.FilterDescendantsInstances = {}
    end
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true -- Игнорим воду
    
    local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    -- Проверяем, виден ли враг на экране
    local screenPos, onScreen = camera:WorldToViewportPoint(target.Position)
    if not onScreen then
        print("[DAN DEBUG]: Враг " .. target.Parent.Name .. " не на экране")
        return false
    end
    
    -- Если raycast ничего не нашел или попал в цель (или её часть), считаем видимым
    if not rayResult then
        print("[DAN DEBUG]: Raycast ничего не нашел, враг " .. target.Parent.Name .. " виден")
        return true
    elseif rayResult.Instance and rayResult.Instance:IsDescendantOf(target.Parent) then
        print("[DAN DEBUG]: Raycast попал в " .. rayResult.Instance.Name .. ", враг " .. target.Parent.Name .. " виден")
        return true
    else
        print("[DAN DEBUG]: Raycast попал в " .. rayResult.Instance.Name .. ", враг " .. target.Parent.Name .. " НЕ виден")
        return false
    end
end

-- Обновленный Chams
runService.RenderStepped:Connect(function()
    if not chamsEnabled then
        for _, highlight in pairs(highlights) do
            highlight.Enabled = false
        end
        return
    end

    for enemy, highlight in pairs(highlights) do
        local char = enemy.Character
        local humanoid = char and char:FindFirstChild("Humanoid")
        local rootPart = char and char:FindFirstChild("HumanoidRootPart")

        if char and humanoid and rootPart then
            if humanoid.Health <= 0 then
                highlight.Enabled = false
            else
                highlight.Adornee = char
                highlight.Enabled = true

                if teamModeEnabled and enemy.Team == player.Team then
                    highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Желтый для тиммейтов
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                else
                    if isVisible(rootPart) then
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Зеленый, если виден
                        highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                    else
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Красный, если не виден
                        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                    end
                end
            end
        else
            highlight.Enabled = false
        end
    end
end)

-- Поиск ближайшего врага в Silent FOV
local function getNearestPlayerInSilentFOV()
    local closestEnemy = nil
    local shortestDistance = silentFOV
    local mousePos = inputService:GetMouseLocation()

    for _, enemy in pairs(game.Players:GetPlayers()) do
        if enemy ~= player and (not teamModeEnabled or enemy.Team ~= player.Team) and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.Health > 0 then
            local enemyHead = enemy.Character:FindFirstChild("Head")
            if enemyHead then
                local screenPos, onScreen = camera:WorldToViewportPoint(enemyHead.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < shortestDistance and (not visibilityCheckEnabled or isVisible(enemyHead)) then
                        shortestDistance = distance
                        closestEnemy = enemyHead
                    end
                end
            end
        end
    end
    return closestEnemy
end

-- Aimbot
local function getNearestPlayerInFOV()
    local closestEnemy = nil
    local shortestDistance = aimFOV
    local mousePos = inputService:GetMouseLocation()

    for _, enemy in pairs(game.Players:GetPlayers()) do
        if enemy ~= player and (not teamModeEnabled or enemy.Team ~= player.Team) and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.Health > 0 then
            local enemyRoot = enemy.Character:FindFirstChild("Head")
            if enemyRoot then
                local screenPos, onScreen = camera:WorldToViewportPoint(enemyRoot.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < shortestDistance and (not visibilityCheckEnabled or isVisible(enemyRoot)) then
                        shortestDistance = distance
                        closestEnemy = enemyRoot
                    end
                end
            end
        end
    end
    return closestEnemy
end

local function applyAimbot()
    if not (aimbotEnabled or instantAimEnabled) then
        fovCircle.Visible = false
        return
    end

    local target = getNearestPlayerInFOV()
    if target then
        local targetPos = target.Position
        local currentLook = camera.CFrame.LookVector
        local targetDir = (targetPos - camera.CFrame.Position).Unit

        if instantAimEnabled then
            local lerpSpeed = math.clamp(1 / aimSpeed, 0.01, 1)
            camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + currentLook:Lerp(targetDir, lerpSpeed))
            print("[DAN DEBUG]: Instant Aim наводка, скорость: " .. lerpSpeed)
        elseif aimbotEnabled and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + currentLook:Lerp(targetDir, 0.2))
            print("[DAN DEBUG]: Обычный Aimbot наводка")
        end
    else
        print("[DAN DEBUG]: Нет цели в FOV")
    end

    fovCircle.Radius = aimFOV
    fovCircle.Position = inputService:GetMouseLocation()
    fovCircle.Visible = aimbotEnabled or instantAimEnabled
end

-- Silent Aim
local function applySilentAim()
    if not silentAimEnabled then
        silentFovCircle.Visible = false
        return
    end

    silentFovCircle.Radius = silentFOV
    silentFovCircle.Position = inputService:GetMouseLocation()
    silentFovCircle.Visible = true

    local target = getNearestPlayerInSilentFOV()
    if target and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Handle") then
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local eventsFolder = replicatedStorage:FindFirstChild("Events")
            if not eventsFolder then
                warn("[DAN CHEAT]: Не нашел Events в ReplicatedStorage, пиздец!")
                return
            end

            local hitEvent = eventsFolder:FindFirstChild("Hit") or eventsFolder:FindFirstChild("GunEvent") or eventsFolder:FindFirstChild("FireEvent")
            if not hitEvent then
                warn("[DAN CHEAT]: Не нашел подходящий RemoteEvent (Hit/GunEvent/FireEvent), ищи вручную в ReplicatedStorage.Events!")
                for _, event in pairs(eventsFolder:GetChildren()) do
                    print("[DAN DEBUG]: Найден RemoteEvent - " .. event.Name)
                end
                return
            end

            local headPos = target.Position
            local direction = (headPos - tool.Handle.Position).Unit

            local args = {
                [1] = tool,
                [2] = headPos,
                [3] = direction
            }

            print("[DAN DEBUG]: Silent Aim стреляет в " .. target.Parent.Name .. " с RemoteEvent: " .. hitEvent.Name)
            for i, v in pairs(args) do
                print("[DAN DEBUG]: Arg " .. i .. " = " .. tostring(v))
            end

            hitEvent:FireServer(unpack(args))
            print("[DAN CHEAT]: Silent Aim хедшот в " .. target.Parent.Name)
        else
            warn("[DAN CHEAT]: Нет оружия или Handle, держи пушку, сука!")
        end
    end
end

runService.RenderStepped:Connect(function()
    applyAimbot()
    applySilentAim()
end)

player.CharacterAdded:Connect(function(newChar)
    print("[DAN CHEAT]: Ты заспавнился, все пашет!")
end)