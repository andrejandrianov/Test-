-- Hacker Panel - Refactored
-- Tabs: Decompilition, Visuals, Game, Other

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Main_Game module reference (for noclip, freecam, etc.)
local mainGameModule = nil
local function GetMainGame()
    if mainGameModule then return mainGameModule end
    pcall(function()
        mainGameModule = require(LocalPlayer.PlayerGui:WaitForChild("MainUI", 5):WaitForChild("Initiator", 5):WaitForChild("Main_Game", 5))
    end)
    return mainGameModule
end

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

task.wait(2.5)

-- ============================================
-- UTILITIES
-- ============================================

local function Caption(Message: string)
    if RunService:IsStudio() then
        print(Message)
    else
        pcall(function()
            local mainGame = require(LocalPlayer.PlayerGui:WaitForChild("MainUI", 4):WaitForChild("Initiator", 4):WaitForChild("Main_Game", 4))
            if mainGame and mainGame.caption then
                mainGame.caption(tostring(Message))
            end
        end)
    end
end

Caption("! Hacker Panel Initialized !")

-- Colors
local C = Color3.fromRGB
local COLOR_BG = C(30, 17, 16)
local COLOR_ACCENT = C(255, 222, 189)
local COLOR_ACCENT_DARK = C(84, 68, 61)
local COLOR_TEXT_DIM = C(145, 103, 92)
local COLOR_DANGER = C(119, 28, 42)

-- Layout order counter
local LayoutOrder = 0
local function NextOrder()
    LayoutOrder += 1
    return LayoutOrder
end

-- ============================================
-- MAIN GUI
-- ============================================

local GUI = Instance.new("ScreenGui")
GUI.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
GUI.Name = "SuperCoolHackerGUI"
GUI.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Name = "Container"
MainFrame.BackgroundColor3 = COLOR_BG
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, 0, 0, 40)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.Size = UDim2.new(0.9, 0, 0.95, -40)
MainFrame.Visible = false
MainFrame:AddTag("UnlockMouseVisible")

local pagesFolder = Instance.new("Folder", MainFrame)
pagesFolder.Name = "Pages"

Instance.new("UIAspectRatioConstraint", MainFrame).AspectRatio = 1.25

local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0.02, 0)

local mainStroke = Instance.new("UIStroke", MainFrame)
mainStroke.Color = COLOR_ACCENT
mainStroke.Thickness = 3
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Tab buttons frame
local tabFrame = Instance.new("Frame", MainFrame)
tabFrame.Name = "TabButtons"
tabFrame.AnchorPoint = Vector2.new(1, 0)
tabFrame.BackgroundTransparency = 1
tabFrame.BorderSizePixel = 0
tabFrame.Position = UDim2.fromOffset(-2, 0)
tabFrame.Size = UDim2.fromScale(0.1, 1)

local tabList = Instance.new("UIListLayout", tabFrame)
tabList.Padding = UDim.new(0.02, 0)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.VerticalAlignment = Enum.VerticalAlignment.Center

-- Header
local header = Instance.new("Frame", MainFrame)
header.Name = "Header"
header.AnchorPoint = Vector2.new(0.5, 0)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0
header.Position = UDim2.fromScale(0.5, 0.02)
header.Size = UDim2.fromScale(0.965, 0.068)

-- Close button
local closeButton = Instance.new("ImageButton", header)
closeButton.BackgroundTransparency = 1
closeButton.Modal = true
closeButton.Position = UDim2.fromScale(1, 0.5)
closeButton.AnchorPoint = Vector2.new(1, 0.5)
closeButton.Size = UDim2.fromScale(1.25, 1.25)
closeButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
closeButton.ZIndex = 15
closeButton.Image = "rbxassetid://2195446979"
closeButton.ImageColor3 = COLOR_ACCENT

-- Title label
local titleLabel = Instance.new("TextLabel", header)
titleLabel.Name = "Title"
titleLabel.AnchorPoint = Vector2.new(0, 0.5)
titleLabel.BackgroundTransparency = 1
titleLabel.BorderSizePixel = 0
titleLabel.Position = UDim2.fromScale(0, 0.5)
titleLabel.Size = UDim2.fromScale(1, 1)
titleLabel.ZIndex = 5
titleLabel.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
titleLabel.RichText = true
titleLabel.Text = "HACKER PANEL"
titleLabel.TextColor3 = COLOR_ACCENT
titleLabel.TextScaled = true
titleLabel.TextWrapped = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Top

local titleCorner = Instance.new("UICorner", titleLabel)
titleCorner.CornerRadius = UDim.new(0, 8)

local titlePad = Instance.new("UIPadding", titleLabel)
titlePad.PaddingBottom = UDim.new(-0.1, 0)
titlePad.PaddingTop = UDim.new(-0.2, 0)

-- Info label (Seconds Until Dread)
local infoLabel = Instance.new("TextLabel", header)
infoLabel.Name = "AttributeInformation"
infoLabel.AnchorPoint = Vector2.new(0, 0.5)
infoLabel.BackgroundTransparency = 1
infoLabel.BorderSizePixel = 0
infoLabel.Position = UDim2.fromScale(0.324, 0.5)
infoLabel.Size = UDim2.fromScale(0.675, 0.7)
infoLabel.ZIndex = 5
infoLabel.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
infoLabel.RichText = true
infoLabel.Text = "Seconds Until Dread: ???"
infoLabel.TextColor3 = COLOR_TEXT_DIM
infoLabel.TextScaled = true
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top

local infoCorner = Instance.new("UICorner", infoLabel)
infoCorner.CornerRadius = UDim.new(0, 8)

local infoPad = Instance.new("UIPadding", infoLabel)
infoPad.PaddingBottom = UDim.new(-0.1, 0)
infoPad.PaddingTop = UDim.new(-0.2, 0)

-- Clock tracking
pcall(function()
    local Clock = ReplicatedStorage.GameData.Clock
    Clock:GetAttributeChangedSignal("Seconds"):Connect(function()
        local seconds = 0
        seconds += ((Clock:GetAttribute("Hours") or 11) - 11) * 3600
        seconds += (Clock:GetAttribute("Minutes") or 0) * 60
        seconds += math.floor(Clock:GetAttribute("Seconds") or 0)
        local divident = seconds / 3600
        seconds = math.floor(Clock.Parent.RoomTimerMax.Value * (1 - divident))
        infoLabel.Text = "Seconds Until Dread: " .. seconds
    end)
end)

-- Toggle panel via chat command
local command = Instance.new("TextChatCommand")
command.PrimaryAlias = "/secretpanel"
command.SecondaryAlias = "/p2"
command.Enabled = true
command.AutocompleteVisible = true
command.Parent = TextChatService

command.Triggered:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

closeButton.MouseButton1Down:Connect(function()
    MainFrame.Visible = false
end)

-- Clone topbar button
pcall(function()
    local button = LocalPlayer.PlayerGui.TopbarUI.ButtonsLeft:WaitForChild("PanelButton", 5)
    if button then
        local secretButton = button:Clone()
        secretButton.Parent = button.Parent
        secretButton:RemoveTag("AdminButton")
        secretButton.Name = "PanelButton_Sigma"
        secretButton.BackgroundColor3 = COLOR_DANGER
        secretButton.IconImage.ImageColor3 = C(252, 19, 0)
        secretButton.Visible = true
        secretButton.MouseButton1Down:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    end
end)

-- ============================================
-- PAGE SYSTEM
-- ============================================

local LastPage = nil

local function CreateTabButton(image: string)
    local container = Instance.new("CanvasGroup")
    container.BackgroundColor3 = COLOR_ACCENT
    container.Size = UDim2.fromScale(1.15, 1)
    container.Name = "TabButton"

    local ratio = Instance.new("UIAspectRatioConstraint", container)
    ratio.AspectRatio = 1.11

    local corner = Instance.new("UICorner", container)
    corner.CornerRadius = UDim.new(0.15, 0)

    local grad = Instance.new("UIGradient", container)
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.863, 0),
        NumberSequenceKeypoint.new(0.873, 1),
        NumberSequenceKeypoint.new(1, 1)
    })

    local pad = Instance.new("UIPadding", container)
    pad.PaddingRight = UDim.new(0.1, 0)

    local button = Instance.new("ImageButton", container)
    button.Name = "Button"
    button.BackgroundColor3 = COLOR_ACCENT
    button.Size = UDim2.fromScale(1, 1)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Image = ""

    local icon = Instance.new("ImageLabel", button)
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.BorderSizePixel = 0
    icon.Position = UDim2.fromScale(0.5, 0.5)
    icon.AnchorPoint = Vector2.one / 2
    icon.Size = UDim2.fromScale(0.85, 0.85)
    icon.Image = image
    icon.ImageColor3 = COLOR_ACCENT_DARK
    icon.ScaleType = Enum.ScaleType.Fit

    return container
end

local function CreateCollapsable()
    local frame = Instance.new("Frame")
    frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Size = UDim2.fromScale(1, 0)

    local list = Instance.new("UIListLayout", frame)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 4)

    local headerBtn = Instance.new("ImageButton", frame)
    headerBtn.Name = "SettingHeader"
    headerBtn.BackgroundColor3 = COLOR_ACCENT
    headerBtn.BackgroundTransparency = 0.5
    headerBtn.LayoutOrder = -1
    headerBtn.BorderColor3 = Color3.new()
    headerBtn.Size = UDim2.fromScale(1, 0.06)
    headerBtn.SizeConstraint = Enum.SizeConstraint.RelativeXX

    local hCorner = Instance.new("UICorner", headerBtn)
    hCorner.CornerRadius = UDim.new(0, 8)

    local collapseIcon = Instance.new("ImageLabel", headerBtn)
    collapseIcon.Name = "CollapseIcon"
    collapseIcon.AnchorPoint = Vector2.new(1, 0.5)
    collapseIcon.BackgroundTransparency = 1
    collapseIcon.BorderSizePixel = 0
    collapseIcon.Position = UDim2.fromScale(0.99, 0.5)
    collapseIcon.Size = UDim2.fromScale(0.6, 0.6)
    collapseIcon.Image = "rbxassetid://18805592459"
    collapseIcon.ImageColor3 = COLOR_ACCENT

    local cRatio = Instance.new("UIAspectRatioConstraint", collapseIcon)
    cRatio.AspectRatio = 1.2

    local title = Instance.new("TextLabel", headerBtn)
    title.Name = "Title"
    title.AnchorPoint = Vector2.new(0, 0.5)
    title.BackgroundTransparency = 1
    title.BorderSizePixel = 0
    title.Position = UDim2.fromScale(0.01, 0.5)
    title.Size = UDim2.fromScale(1, 0.7)
    title.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    title.RichText = true
    title.ZIndex = 5
    title.Text = "SECTION"
    title.TextColor3 = COLOR_ACCENT
    title.TextSize = 50
    title.TextScaled = true
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Top

    local tCorner = Instance.new("UICorner", title)
    tCorner.CornerRadius = UDim.new(0, 8)

    local tPad = Instance.new("UIPadding", title)
    tPad.PaddingBottom = UDim.new(-0.1, 0)
    tPad.PaddingTop = UDim.new(-0.2, 0)

    return frame
end

local function SetContainerCollapsed(container, collapsed)
    for _, child in container:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "SettingHeader" then
            child.Visible = not collapsed
        end
    end
    container.SettingHeader.CollapseIcon.Image = collapsed and "rbxassetid://18805592459" or "rbxassetid://18807229936"
end

local function CreateContainer(name: string, parent)
    local collapsable = CreateCollapsable()
    collapsable.LayoutOrder = NextOrder()
    collapsable.SettingHeader.Title.Text = name
    collapsable.Name = name
    if parent then
        collapsable.Parent = parent
    end
    local collapsed = false
    SetContainerCollapsed(collapsable, collapsed)
    collapsable.SettingHeader.Activated:Connect(function()
        collapsed = not collapsed
        SetContainerCollapsed(collapsable, collapsed)
    end)
    collapsable.UIListLayout:AddTag("AdminPanelFixPadding")
    return collapsable
end

local function CreatePageUI()
    local scroll = Instance.new("ScrollingFrame")
    scroll.AnchorPoint = Vector2.new(0.5, 1)
    scroll.BackgroundColor3 = C(255, 255, 255)
    scroll.BackgroundTransparency = 1
    scroll.Position = UDim2.fromScale(0.5, 0.98)
    scroll.Size = UDim2.fromScale(0.965, 0.89)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.CanvasSize = UDim2.fromScale(0, 0)
    scroll.ScrollBarImageColor3 = COLOR_ACCENT
    scroll.ScrollBarImageTransparency = 0.5
    scroll.ScrollBarThickness = 16
    scroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    scroll.Selectable = false
    scroll.SelectionOrder = 1

    local list = Instance.new("UIListLayout", scroll)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 8)

    local pad = Instance.new("UIPadding", scroll)
    pad.PaddingRight = UDim.new(0.01, 0)

    return scroll
end

local PageMethods = {}
PageMethods.__index = PageMethods

function PageMethods:AddElements(elements)
    for _, el in elements do
        table.insert(self.Elements, el)
        if self.Scrolling.Visible then
            el.LayoutOrder = #self.Elements
            el.Parent = self.Scrolling
        end
    end
end

function PageMethods:Show()
    for i, el in self.Elements do
        el.LayoutOrder = i
        el.Parent = self.Scrolling
    end
    self.Scrolling.Visible = true
end

function PageMethods:Hide()
    for _, el in self.Elements do
        el.Parent = nil
    end
    self.Scrolling.Visible = false
end

local function CreatePage(name: string, image: string)
    local pageUI = CreatePageUI()
    pageUI.UIListLayout:AddTag("AdminPanelFixPadding")
    pageUI.Parent = MainFrame.Pages
    pageUI.Visible = false
    pageUI.Name = name

    local page = setmetatable({
        Scrolling = pageUI,
        Elements = {}
    }, PageMethods)

    local tab = CreateTabButton(image)
    tab.Button.Icon.Image = image
    tab.Button.Activated:Connect(function()
        if LastPage then
            LastPage:Hide()
        end
        LastPage = page
        page:Show()
    end)

    tab.Parent = MainFrame.TabButtons

    if #MainFrame.Pages:GetChildren() == 1 then
        LastPage = page
        page:Show()
    end

    return page
end

-- ============================================
-- INPUT TYPES
-- ============================================

local Inputs = {}

function Inputs.Base()
    return {
        Parameters = {},
        Active = true,
        RequiresConfirmation = false,
        LayoutOrder = NextOrder(),
        SetConfirmation = function(self)
            self.RequiresConfirmation = true
            return self
        end,
        AddParameter = function(self, param)
            table.insert(self.Parameters, param)
            return self
        end
    }
end

-- Button
local function CreateButtonUI()
    local container = Instance.new("Frame")
    container.BackgroundColor3 = C(255, 183, 147)
    container.BackgroundTransparency = 0.35
    container.BorderColor3 = Color3.new()
    container.Position = UDim2.fromScale(0, 0.125)
    container.Size = UDim2.fromScale(1, 0.08)
    container.SizeConstraint = Enum.SizeConstraint.RelativeXX

    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local grad = Instance.new("UIGradient", container)
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1)
    })

    local pad = Instance.new("UIPadding", container)
    pad.PaddingLeft = UDim.new(0.01, 0)
    pad.PaddingRight = UDim.new(0.007, 0)

    local btn = Instance.new("TextButton", container)
    btn.Name = "Button"
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.Active = true
    btn.AutomaticSize = Enum.AutomaticSize.X
    btn.BackgroundColor3 = COLOR_ACCENT
    btn.BackgroundTransparency = 0
    btn.LayoutOrder = 4
    btn.Position = UDim2.fromScale(0.5, 0.5)
    btn.Size = UDim2.fromScale(0.5, 1)
    btn.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    btn.Text = "EXECUTE"
    btn.TextColor3 = C(39, 20, 17)
    btn.TextScaled = true
    btn.TextWrapped = true

    local bCorner = Instance.new("UICorner", btn)
    bCorner.CornerRadius = UDim.new(0.5, 1)

    local bPad = Instance.new("UIPadding", btn)
    bPad.PaddingBottom = UDim.new(0.05, 0)
    bPad.PaddingTop = UDim.new(0.05, 0)

    return container
end

function Inputs.Button(actionId, parent, label, callback)
    callback = callback or function() print("Pressed Button") end
    local input = Inputs.Base()
    input.ActionID = actionId

    local btn = CreateButtonUI()
    btn.LayoutOrder = input.LayoutOrder
    btn.Button.Text = (label or actionId):upper()
    btn.Name = actionId
    btn.Parent = parent
    btn.Button.Activated:Connect(callback)
    input.UI = btn

    return input
end

-- ButtonStack
local function CreateButtonStackUI(isButton: boolean)
    if isButton then
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = COLOR_ACCENT
        btn.BackgroundTransparency = 0.7
        btn.AutomaticSize = Enum.AutomaticSize.X
        btn.BorderColor3 = Color3.new()
        btn.Position = UDim2.fromScale(1, 0.5)
        btn.Size = UDim2.fromScale(0, 0.06)
        btn.SizeConstraint = Enum.SizeConstraint.RelativeXX
        btn.LayoutOrder = 4
        btn.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        btn.Text = "???"
        btn.TextColor3 = COLOR_ACCENT
        btn.TextScaled = true
        btn.TextWrapped = true

        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local pad = Instance.new("UIPadding", btn)
        pad.PaddingLeft = UDim.new(0.05, 0)
        pad.PaddingRight = UDim.new(0.05, 0)

        return btn
    else
        local container = Instance.new("Frame")
        container.BackgroundColor3 = COLOR_ACCENT
        container.BackgroundTransparency = 0.9
        container.BorderColor3 = Color3.new()
        container.Position = UDim2.fromScale(0, 0.125)
        container.Size = UDim2.fromScale(1, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y

        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

        local pad = Instance.new("UIPadding", container)
        pad.PaddingLeft = UDim.new(0.02, 0)
        pad.PaddingRight = UDim.new(0.02, 0)
        pad.PaddingBottom = UDim.new(0.02, 0)
        pad.PaddingTop = UDim.new(0.02, 0)

        local list = Instance.new("UIListLayout", container)
        list.Padding = UDim.new(0, 4)
        list.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
        list.VerticalAlignment = Enum.VerticalAlignment.Center
        list.HorizontalAlignment = Enum.HorizontalAlignment.Center

        return container
    end
end

local ButtonStackMethods = {}
ButtonStackMethods.__index = ButtonStackMethods

function Inputs.ButtonStack(name, parent)
    local stack = setmetatable(Inputs.Base(), ButtonStackMethods)
    local ui = CreateButtonStackUI(false)
    ui.LayoutOrder = stack.LayoutOrder
    ui.Name = name
    ui.Parent = parent
    stack.UI = ui
    return stack
end

function ButtonStackMethods:AddButton(actionId, label, color, callback)
    callback = callback or function() print("Button Clicked") end
    local input = Inputs.Base()
    input.ActionID = actionId
    input.Active = true

    local btn = CreateButtonStackUI(true)
    btn.LayoutOrder = self.LayoutOrder
    btn.Text = label or actionId

    local h, s, v = (color or btn.BackgroundColor3):ToHSV()
    btn.BackgroundColor3 = Color3.fromHSV(h, math.clamp(s * 2, 0, 1), v * 0.8)
    btn.TextColor3 = color or btn.TextColor3
    btn.Parent = self.UI
    btn.Activated:Connect(callback)
    input.UI = btn
    return input
end

-- Switch (Toggle)
local function CreateSwitchUI()
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = COLOR_ACCENT
    frame.BackgroundTransparency = 0.9
    frame.BorderColor3 = Color3.new()
    frame.Position = UDim2.fromScale(0, 0.125)
    frame.Size = UDim2.fromScale(1, 0.06)
    frame.SizeConstraint = Enum.SizeConstraint.RelativeXX

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local pad = Instance.new("UIPadding", frame)
    pad.PaddingLeft = UDim.new(0.01, 0)
    pad.PaddingRight = UDim.new(0.007, 0)

    local toggleBtn = Instance.new("ImageButton", frame)
    toggleBtn.Name = "Button"
    toggleBtn.AnchorPoint = Vector2.new(1, 0.5)
    toggleBtn.BackgroundColor3 = C(204, 147, 121)
    toggleBtn.BackgroundTransparency = 0.35
    toggleBtn.Position = UDim2.fromScale(0.995, 0.5)
    toggleBtn.Size = UDim2.fromScale(1.92, 0.8)
    toggleBtn.SizeConstraint = Enum.SizeConstraint.RelativeYY
    toggleBtn.ZIndex = 1302

    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    local switch = Instance.new("TextLabel", toggleBtn)
    switch.Name = "Switch"
    switch.AnchorPoint = Vector2.new(0.5, 0.5)
    switch.BackgroundColor3 = COLOR_ACCENT
    switch.Position = UDim2.fromScale(0.8, 0.5)
    switch.Size = UDim2.fromScale(1, 1)
    switch.SizeConstraint = Enum.SizeConstraint.RelativeYY
    switch.ZIndex = 1307
    switch.Text = ""
    switch.TextTransparency = 1

    Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

    local label = Instance.new("TextLabel", frame)
    label.Name = "ActionName"
    label.AnchorPoint = Vector2.new(0, 0.5)
    label.AutomaticSize = Enum.AutomaticSize.X
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.LayoutOrder = 3
    label.Position = UDim2.fromScale(0, 0.5)
    label.Size = UDim2.fromScale(0, 0.8)
    label.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    label.RichText = true
    label.ZIndex = 5
    label.Text = "Toggle"
    label.TextColor3 = COLOR_ACCENT
    label.TextSize = 50
    label.TextScaled = true
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top

    return frame
end

local SwitchMethods = {}
SwitchMethods.__index = SwitchMethods

function SwitchMethods:Read()
    return self.Value
end

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function ApplySwitchState(switch, state, callback)
    if switch.Value == state then return end
    switch.Value = state

    TweenService:Create(switch.UI.Button, tweenInfo, {
        BackgroundTransparency = state and 0.35 or 0.9
    }):Play()

    TweenService:Create(switch.UI.Button.Switch, tweenInfo, {
        BackgroundColor3 = state and COLOR_ACCENT or C(121, 86, 74),
        Position = state and UDim2.fromScale(0.8, 0.5) or UDim2.fromScale(0.2, 0.5)
    }):Play()

    if callback then callback(state) end
end

function Inputs.Switch(actionId, parent, default, callback)
    callback = callback or function() print("toggled") end
    local switch = setmetatable(Inputs.Base(), SwitchMethods)
    switch.ActionID = actionId

    local ui = CreateSwitchUI()
    ui.ActionName.Text = actionId
    ui.LayoutOrder = switch.LayoutOrder
    ui.Name = actionId
    ui.Parent = parent
    switch.UI = ui

    ApplySwitchState(switch, default)
    ui.Button.Activated:Connect(function()
        ApplySwitchState(switch, not switch.Value, callback)
    end)

    return switch
end

-- Text Input
local function CreateTextUI()
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = COLOR_ACCENT
    frame.BackgroundTransparency = 0.9
    frame.BorderColor3 = Color3.new()
    frame.Position = UDim2.fromScale(0, 0.125)
    frame.Size = UDim2.fromScale(1, 0.06)
    frame.SizeConstraint = Enum.SizeConstraint.RelativeXX

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local pad = Instance.new("UIPadding", frame)
    pad.PaddingLeft = UDim.new(0.01, 0)
    pad.PaddingRight = UDim.new(0.007, 0)

    local textBox = Instance.new("TextBox", frame)
    textBox.Name = "TextBox"
    textBox.AnchorPoint = Vector2.new(1, 0.5)
    textBox.BackgroundColor3 = COLOR_ACCENT
    textBox.BackgroundTransparency = 0.5
    textBox.ClearTextOnFocus = false
    textBox.Position = UDim2.fromScale(1, 0.5)
    textBox.Size = UDim2.fromScale(0.3, 0.8)
    textBox.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    textBox.ZIndex = 4
    textBox.PlaceholderColor3 = C(208, 181, 154)
    textBox.PlaceholderText = "Input"
    textBox.Text = ""
    textBox.TextColor3 = COLOR_ACCENT
    textBox.TextScaled = true
    textBox.TextWrapped = true

    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", frame)
    label.Name = "ActionName"
    label.AnchorPoint = Vector2.new(0, 0.5)
    label.AutomaticSize = Enum.AutomaticSize.X
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.LayoutOrder = 3
    label.Position = UDim2.fromScale(0, 0.5)
    label.Size = UDim2.fromScale(0, 0.8)
    label.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    label.RichText = true
    label.ZIndex = 5
    label.Text = "Toggle"
    label.TextColor3 = COLOR_ACCENT
    label.TextSize = 50
    label.TextScaled = true
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top

    return frame
end

local TextMethods = {}
TextMethods.__index = TextMethods

function TextMethods:Read()
    return self.Value
end

function Inputs.Text(actionId, parent, default, placeholder, callback)
    callback = callback or function(text) print("Text is now", text) end
    local input = setmetatable(Inputs.Base(), TextMethods)
    input.ActionID = actionId

    local ui = CreateTextUI()
    ui.LayoutOrder = input.LayoutOrder
    ui.ActionName.Text = actionId
    ui.Name = actionId
    if placeholder then
        ui.TextBox.PlaceholderText = placeholder
    end
    ui.Parent = parent
    input.UI = ui
    input.Value = default

    ui.TextBox.FocusLost:Connect(function()
        input.Value = ui.TextBox.Text
        callback(input.Value)
    end)

    return input
end

-- ============================================
-- SAVED FOLDER
-- ============================================

local SavedFolder = Instance.new("Folder", ReplicatedStorage)
SavedFolder.Name = "_HackerGUI_Saved"

-- Auto-save workspace objects
workspace.ChildAdded:Connect(function(obj)
    obj:Clone().Parent = SavedFolder
end)

workspace.CurrentRooms.ChildAdded:Connect(function(obj)
    obj:Clone().Parent = SavedFolder
end)

-- Stream vote client
pcall(function()
    if ReplicatedStorage.FloorReplicated.ClientRemote:WaitForChild("StreamVoteClientFunction", 5) then
        ReplicatedStorage.FloorReplicated.ClientRemote.StreamVoteClientFunction.Remote.OnClientEvent:Connect(function(module)
            if not SavedFolder:FindFirstChild(module.Name) then
                module:Clone().Parent = SavedFolder
            end
        end)
    end
end)

-- ============================================
-- PAGE 1: Decompilition
-- ============================================

local decompPage = CreatePage("Decompilition", "rbxassetid://96164691124017")

-- Decomp Tools
local decompToolsContainer = CreateContainer("Decomp Tools", decompPage.Scrolling)

Inputs.Button("DecompileGame", decompToolsContainer, "Decompile Game", function()
    if RunService:IsStudio() then
        warn("Studio mode - decompile unavailable")
    else
        local SaveInstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/saveinstance.luau", true), "saveinstance")()
        SaveInstance({ NilInstances = true, IsolateLocalPlayer = true })
    end
end)

Inputs.Button("DecompileWorkspace", decompToolsContainer, "Decompile Workspace Only", function()
    if RunService:IsStudio() then
        warn("Studio mode - decompile unavailable")
    else
        local SaveInstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/saveinstance.luau", true), "saveinstance")()
        SaveInstance({ NilInstances = true, IsolateLocalPlayer = true, OnlyWorkspace = true })
    end
end)

Inputs.Button("DecompileSaved", decompToolsContainer, "Decompile Saved Folder", function()
    if RunService:IsStudio() then
        warn("Studio mode - decompile unavailable")
    else
        local SaveInstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/saveinstance.luau", true), "saveinstance")()
        SaveInstance(SavedFolder)
    end
end)

-- Auto Settings
local decompAutoContainer = CreateContainer("Auto Settings", decompPage.Scrolling)

local autoDecompile = false
Inputs.Switch("Auto Decompile", decompAutoContainer, false, function(value)
    autoDecompile = value
end)

local autoSaveRooms = false
Inputs.Switch("Auto Save Rooms", decompAutoContainer, false, function(value)
    autoSaveRooms = value
end)

SavedFolder.ChildAdded:Connect(function()
    if autoDecompile then
        task.wait()
        local SaveInstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/saveinstance.luau", true), "saveinstance")()
        SaveInstance(SavedFolder)
    end
end)

-- Explorer Tools
local decompExplorerContainer = CreateContainer("Explorer Tools", decompPage.Scrolling)

local dexOpened = false
Inputs.Button("OpenDex", decompExplorerContainer, "Open Dex Explorer", function()
    if dexOpened then
        return Caption("Dex is already running!")
    end
    dexOpened = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zzerexx/Dex/refs/heads/master/main.lua"))()
end)

Inputs.Button("OpenDexAlt", decompExplorerContainer, "Open Dex (Alt URL)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/Backup-Dex-Explorer/main/main.lua"))()
end)

-- ClientRemote modules
local clientRemoteContainer = CreateContainer("ClientRemote Modules", decompPage.Scrolling)

LocalPlayer.ChildAdded:Connect(function(child)
    if child.Name == "ClientRemote" then
        local remoteStack = Inputs.ButtonStack("ClientRemote", clientRemoteContainer)

        local function AddModule(mod)
            if not mod:IsA("ModuleScript") then return end
            remoteStack:AddButton(mod.Name, mod.Name, nil, function()
                task.spawn(require(mod), LocalPlayer.Character)
            end)
        end

        child.ChildAdded:Connect(AddModule)
        for _, c in child:GetChildren() do
            AddModule(c)
        end
    end
end)

-- ============================================
-- PAGE 2: Visuals
-- ============================================

local visualsPage = CreatePage("Visuals", "rbxassetid://113075964705926")

-- ESP / Highlights
local espContainer = CreateContainer("ESP / Highlights", visualsPage.Scrolling)

local espEnabled = false
local espDoors = false
local espEntities = false
local espItems = false
local espObjectives = false
local espClosets = false
local espOther = false
local espPrompts = false
local entityAlert = false
local espObjects = {}

Inputs.Switch("Enable ESP", espContainer, false, function(value)
    espEnabled = value
    if not value then
        for _, obj in espObjects do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        espObjects = {}
    end
end)

Inputs.Switch("ESP Doors", espContainer, false, function(value)
    espDoors = value
end)

Inputs.Switch("ESP Entities", espContainer, false, function(value)
    espEntities = value
end)

Inputs.Switch("ESP Items", espContainer, false, function(value)
    espItems = value
end)

Inputs.Switch("ESP Objectives", espContainer, false, function(value)
    espObjectives = value
end)

Inputs.Switch("ESP Closets", espContainer, false, function(value)
    espClosets = value
end)

Inputs.Switch("ESP Other", espContainer, false, function(value)
    espOther = value
end)

Inputs.Switch("ESP Prompts", espContainer, false, function(value)
    espPrompts = value
end)

Inputs.Switch("Entity Alert", espContainer, false, function(value)
    entityAlert = value
end)

-- Known entity names in Doors
local ENTITY_NAMES = {
    ["Rush"] = true, ["Ambush"] = true, ["Seek"] = true, ["Figure"] = true,
    ["Screech"] = true, ["Eyes"] = true, ["Halt"] = true, ["Hide"] = true,
    ["Timothy"] = true, ["Jack"] = true, ["Shadow"] = true, ["Dupe"] = true,
    ["Blitz"] = true, ["Lookman"] = true, ["Glitch"] = true, ["Void"] = true,
    ["Snare"] = true, ["Dread"] = true, ["Guiding Light"] = true, ["Curious Light"] = true,
    ["El Goblino"] = true, ["Bob"] = true, ["Witch"] = true, ["Mouth"] = true,
    ["Glimmer"] = true, ["Peek"] = true, ["Lurk"] = true, ["Stare"] = true,
    ["Hound"] = true, ["Keep"] = true, ["Duke"] = true, ["Retch"] = true,
    ["Clumsy"] = true, ["Entity"] = true,
    ["RushMoving"] = true, ["AmbushMoving"] = true, ["SeekMoving"] = true,
    ["RushNew"] = true, ["AmbushNew"] = true, ["Giggle"] = true, ["Grumble"] = true,
}

-- Entities that require hiding in wardrobe (auto-hide only triggers for these)
-- Auto-hide only triggers for these active/moving entity variants (not template/base models)
local DANGEROUS_ENTITIES = {
    ["RushMoving"] = true, ["AmbushMoving"] = true, ["SeekMoving"] = true,
    ["RushNew"] = true, ["AmbushNew"] = true,
}

-- Helper: create BillboardGui with name on top and distance on bottom
local function CreateESPBillboard(model, color, displayName)
    local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not primaryPart or not hrp then return nil end

    local dist = math.floor((primaryPart.Position - hrp.Position).Magnitude)
    local bb = Instance.new("BillboardGui")
    bb.Name = "ESP_Billboard"
    bb.Size = UDim2.fromOffset(200, 60)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.MaxDistance = 600
    bb.Adornee = primaryPart
    bb.Parent = model

    -- Name label (top)
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.fromScale(1, 0.5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = displayName or model.Name
    nameLabel.TextColor3 = color
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.Oswald
    nameLabel.Parent = bb

    -- Distance label (bottom)
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.fromScale(1, 0.5)
    distLabel.Position = UDim2.fromScale(0, 0.5)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = tostring(dist) .. "m"
    distLabel.TextColor3 = C(255, 255, 255)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Oswald
    distLabel.Parent = bb

    return bb
end

-- Helper: create highlight + billboard for a model
local function AddESP(model, color, displayName)
    local hl = Instance.new("Highlight")
    hl.Name = "ESP_HL"
    hl.FillColor = color
    hl.FillTransparency = 0.8
    hl.OutlineColor = C(255, 255, 255)
    hl.Parent = model
    table.insert(espObjects, hl)

    local bb = CreateESPBillboard(model, color, displayName)
    if bb then table.insert(espObjects, bb) end
end

-- ESP loop
task.spawn(function()
    while task.wait(0.5) do
        if not espEnabled then continue end

        for _, obj in espObjects do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        espObjects = {}

        local currentRooms = workspace:FindFirstChild("CurrentRooms")

        -- ESP Doors
        if espDoors and currentRooms then
            for _, room in currentRooms:GetChildren() do
                for _, child in room:GetChildren() do
                    if child:IsA("Model") and (child.Name == "Door" or child.Name == "DoorNormal") then
                        -- Check if door is open via HingeConstraint.CurrentAngle
                        local hinge = child:FindFirstChild("HingeConstraint")
                        local isOpen = false
                        if hinge and hinge:IsA("HingeConstraint") then
                            isOpen = math.abs(hinge.CurrentAngle) > 5
                        end

                        if not isOpen then
                            local color = (child.Name == "Door") and C(0, 255, 0) or C(255, 255, 0)
                            -- Door name: "Door (RoomID)" using RoomID attr or parent room name
                            local roomID = child:GetAttribute("RoomID")
                            local doorLabel = roomID and ("Door (" .. tostring(roomID) .. ")") or ("Door (" .. room.Name .. ")")
                            AddESP(child, color, doorLabel)
                        end
                    end
                end
            end
        end

        -- ESP Entities
        if espEntities then
            for _, obj in workspace:GetDescendants() do
                if obj:IsA("Model") and (ENTITY_NAMES[obj.Name] or obj:GetAttribute("IsEntity")) then
                    AddESP(obj, C(255, 0, 0), obj.Name)
                end
            end
        end

        -- ESP Items (all items from PanelClient, excluding Objectives and Other)
        if espItems then
            local ITEMS_NAMES = {
                -- LIGHT
                ["Flashlight"] = true, ["Lighter"] = true, ["Candle"] = true,
                ["Lantern"] = true, ["Glowsticks"] = true, ["Straplight"] = true,
                ["Shakelight"] = true, ["Bulklight"] = true, ["Flares"] = true,
                -- HEALING
                ["Vitamins"] = true, ["BandagePack"] = true, ["AloeVera"] = true,
                -- UTILITY
                ["Lockpick"] = true, ["Crucifix"] = true, ["SkeletonKey"] = true,
                ["Multitool"] = true, ["Shears"] = true, ["LaserPointer"] = true,
                ["AlarmClock"] = true, ["PaperPlane"] = true, ["PocketMirror"] = true,
                ["TipJar"] = true, ["Compass"] = true, ["Leftovers"] = true,
                ["BatteryPack"] = true, ["Briefcase"] = true, ["HoneyPot"] = true,
                -- FOOD
                ["Bread"] = true, ["Cheese"] = true, ["Donut"] = true,
                ["Pizza"] = true, ["Smoothie"] = true, ["GweenSoda"] = true,
                ["WaterCup"] = true,
                -- MAGICAL (non-rift)
                ["StarBottle"] = true, ["StarJug"] = true, ["StarVial"] = true,
                ["Lotus"] = true, ["LotusPetal"] = true,
                -- BATTLE
                ["BigPropTool"] = true, ["BigBomb"] = true, ["Bomb"] = true,
                ["BoxingGloves"] = true, ["GoldGun"] = true, ["Knockbomb"] = true,
                ["Nanner"] = true, ["NannerPeel"] = true, ["SnakeBox"] = true,
                ["StopSign"] = true,
                -- EVENTS (non-objective)
                ["Candy"] = true, ["CandyBag"] = true, ["HolyGrenade"] = true,
                -- ESSENTIAL (non-objective)
                ["FihFlakes"] = true, ["HonchoCoffee"] = true, ["SallyToy"] = true,
                -- ADMIN
                ["KnockbackStick"] = true, ["Scanner"] = true, ["CartToGo"] = true,
            }
            for _, obj in workspace:GetDescendants() do
                if obj:IsA("Model") and ITEMS_NAMES[obj.Name] then
                    AddESP(obj, C(0, 200, 255), obj.Name)
                end
            end
        end

        -- ESP Objectives (specific item names)
        if espObjectives then
            local OBJECTIVE_NAMES = {
                ["ArchivesTicket"] = true, ["GeneratorFuse"] = true,
                ["LibraryHintPaper"] = true, ["HintBook"] = true,
                ["KeyBackdoor"] = true, ["KeyElectrical"] = true,
                ["KeyIron"] = true, ["Key"] = true,
                ["LibraryHintPaperHard"] = true, ["KeyRetro"] = true,
            }
            for _, obj in workspace:GetDescendants() do
                if obj:IsA("Model") and OBJECTIVE_NAMES[obj.Name] then
                    AddESP(obj, C(255, 100, 255), obj.Name)
                end
            end
        end

        -- ESP Closets (Wardrobes, etc.)
        if espClosets then
            for _, obj in workspace:GetDescendants() do
                if obj:IsA("Model") then
                    local loadMod = obj:GetAttribute("LoadModule")
                    if loadMod == "Wardrobe" or obj.Name:lower():match("wardrobe") or obj.Name:lower():match("closet") then
                        AddESP(obj, C(255, 165, 0), obj.Name)
                    end
                end
            end
        end

        -- ESP Other (RiftSpawn and Rift items only)
        if espOther then
            local OTHER_NAMES = {
                ["RiftSpawn"] = true, ["RiftJar"] = true, ["RiftSmoothie"] = true,
                ["RiftCandle"] = true,
            }
            for _, obj in workspace:GetDescendants() do
                if obj:IsA("Model") then
                    local isRift = obj:GetAttribute("RiftSpawn") or obj.Name == "RiftSpawn"
                    local isOther = OTHER_NAMES[obj.Name]
                    local isRiftItem = obj.Name:lower():match("rift")
                    if isRift or isOther or isRiftItem then
                        AddESP(obj, C(180, 180, 255), obj.Name)
                    end
                end
            end
        end

        -- ESP Prompts (highlight objects with ProximityPrompts)
        if espPrompts then
            for _, obj in workspace:GetDescendants() do
                if obj:IsA("ProximityPrompt") then
                    local parent = obj.Parent
                    if parent and parent:IsA("BasePart") then
                        local model = parent.Parent
                        if model and model:IsA("Model") and not model:FindFirstChild("ESP_HL") then
                            local promptName = obj.ActionText ~= "" and obj.ActionText or obj.ObjectText
                            AddESP(model, C(100, 255, 100), "Prompt: " .. promptName)
                        end
                    end
                end
            end
        end
    end
end)

-- Entity Alert loop
local lastAlert = {}
task.spawn(function()
    while task.wait(0.5) do
        if not entityAlert then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        local screechOn = char:GetAttribute("ScreechOn")
        local giggled = char:GetAttribute("Giggled")
        local stunned = char:GetAttribute("Stunned")
        if screechOn and not lastAlert.screech then
            Caption("? SCREECH DETECTED - Look around!")
            lastAlert.screech = true
        elseif not screechOn then
            lastAlert.screech = false
        end
        if giggled and not lastAlert.giggle then
            Caption("? GIGGLE DETECTED - Look behind you!")
            lastAlert.giggle = true
        elseif not giggled then
            lastAlert.giggle = false
        end
        if stunned and not lastAlert.stun then
            Caption("? STUNNED - You are stunned!")
            lastAlert.stun = true
        elseif not stunned then
            lastAlert.stun = false
        end
        -- Check for nearby entities by scanning workspace
        for _, obj in workspace:GetDescendants() do
            if obj:IsA("Model") and (ENTITY_NAMES[obj.Name] or obj:GetAttribute("IsEntity")) then
                local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if pp then
                    local dist = math.floor((pp.Position - hrp.Position).Magnitude)
                    if dist < 200 and not lastAlert[obj.Name] then
                        Caption("? ENTITY: " .. obj.Name .. " (" .. dist .. "m)")
                        lastAlert[obj.Name] = true
                    elseif dist >= 200 then
                        lastAlert[obj.Name] = false
                    end
                end
            end
        end
    end
end)

-- Visual Settings
local visualContainer = CreateContainer("Visual Settings", visualsPage.Scrolling)

local fullbrightSaved = {}
local fullbrightCC = nil
Inputs.Switch("Fullbright", visualContainer, false, function(value)
    if value then
        -- Brighten visuals using post-processing only (no physical lights added to every part)
        -- This is performance-friendly and doesn't permanently alter game lighting
        fullbrightSaved.ExposureCompensation = game.Lighting.ExposureCompensation
        fullbrightSaved.GlobalShadowsIntensity = game.Lighting.GlobalShadowsIntensity
        game.Lighting.ExposureCompensation = 3
        game.Lighting.GlobalShadowsIntensity = 0
        -- Add ColorCorrection for extra brightness (purely visual post-processing effect)
        fullbrightCC = Instance.new("ColorCorrectionEffect")
        fullbrightCC.Name = "FullbrightCC"
        fullbrightCC.Brightness = 0.15
        fullbrightCC.Contrast = 0.05
        fullbrightCC.Parent = game.Lighting
    else
        -- Restore original visual settings
        if fullbrightSaved.ExposureCompensation then
            game.Lighting.ExposureCompensation = fullbrightSaved.ExposureCompensation
        end
        if fullbrightSaved.GlobalShadowsIntensity then
            game.Lighting.GlobalShadowsIntensity = fullbrightSaved.GlobalShadowsIntensity
        end
        if fullbrightCC then
            fullbrightCC:Destroy()
            fullbrightCC = nil
        end
    end
end)

local noFogSaved = nil
Inputs.Switch("No Fog", visualContainer, false, function(value)
    if value then
        noFogSaved = game.Lighting.FogEnd
        game.Lighting.FogEnd = 100000
    else
        game.Lighting.FogEnd = noFogSaved or 200
    end
end)

Inputs.Switch("Remove Shadows", visualContainer, false, function(value)
    for _, obj in workspace:GetDescendants() do
        if obj:IsA("BasePart") then
            obj.CastShadow = not value
        end
    end
end)

Inputs.Switch("Night Vision", visualContainer, false, function(value)
    if value then
        game.Lighting.Brightness = 10
        game.Lighting.ClockTime = 12
        game.Lighting.FogEnd = 100000
        game.Lighting.FogStart = 100000
        game.Lighting.GlobalShadowsIntensity = 0
        game.Lighting.EnvironmentDiffuseScale = 0
        game.Lighting.EnvironmentSpecularScale = 0
    else
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 0
        game.Lighting.FogEnd = 200
        game.Lighting.FogStart = 0
        game.Lighting.GlobalShadowsIntensity = 1
        game.Lighting.EnvironmentDiffuseScale = 1
        game.Lighting.EnvironmentSpecularScale = 1
    end
end)

Inputs.Switch("Crosshair Toggle", visualContainer, true, function(value)
    pcall(function()
        local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
        if mainUI then
            local mainFrame = mainUI:FindFirstChild("MainFrame")
            if mainFrame then
                local crosshair = mainFrame:FindFirstChild("Crosshair")
                if crosshair then
                    crosshair.Visible = value
                end
            end
        end
    end)
end)

-- Screen Effects
local screenEffectsContainer = CreateContainer("Screen Effects", visualsPage.Scrolling)

local noVignette = false
Inputs.Switch("No Vignette", screenEffectsContainer, false, function(value)
    noVignette = value
end)

local noJumpscare = false
Inputs.Switch("Anti-Jumpscare", screenEffectsContainer, false, function(value)
    noJumpscare = value
end)

local noFlash = false
Inputs.Switch("No Screen Flash", screenEffectsContainer, false, function(value)
    noFlash = value
end)

local noGlitch = false
Inputs.Switch("No Glitch Effects", screenEffectsContainer, false, function(value)
    noGlitch = value
end)

Inputs.Button("RemoveAllEffects", screenEffectsContainer, "Remove All Screen Effects", function()
    pcall(function()
        local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
        if not mainUI then return end
        local mainFrame = mainUI:FindFirstChild("MainFrame")
        if mainFrame then
            for _, child in mainFrame:GetChildren() do
                if child:IsA("ImageLabel") and child.Name:match("Vignette") then
                    child.Visible = false
                end
            end
            local flash = mainFrame:FindFirstChild("FlashFrame")
            if flash then flash.Visible = false end
            local glitch = mainFrame:FindFirstChild("GlitchScreen")
            if glitch then glitch.Visible = false end
        end
        local jsFrame = mainUI:FindFirstChild("Jumpscare")
        if jsFrame then jsFrame.Visible = false end
        local death = mainUI:FindFirstChild("Death")
        if death then death.Visible = false end
        Caption("All screen effects removed!")
    end)
end)

-- Screen effects cleanup loop
task.spawn(function()
    while task.wait(0.3) do
        local mainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
        if not mainUI then continue end
        local mainFrame = mainUI:FindFirstChild("MainFrame")
        if mainFrame then
            if noVignette then
                for _, child in mainFrame:GetChildren() do
                    if child:IsA("ImageLabel") and child.Name:match("Vignette") then
                        child.Visible = false
                    end
                end
            end
            if noFlash then
                local flash = mainFrame:FindFirstChild("FlashFrame")
                if flash then flash.Visible = false end
                local white = mainFrame:FindFirstChild("WhiteVignette")
                if white then white.Visible = false end
            end
            if noGlitch then
                local glitch = mainFrame:FindFirstChild("GlitchScreen")
                if glitch then glitch.Visible = false end
                local glitchEff = mainFrame:FindFirstChild("GlitchEffect")
                if glitchEff then glitchEff.Visible = false end
                local glitchTrial = mainFrame:FindFirstChild("GlitchTrial")
                if glitchTrial then glitchTrial.Visible = false end
            end
        end
        if noJumpscare then
            local jsFrame = mainUI:FindFirstChild("Jumpscare")
            if jsFrame then jsFrame.Visible = false end
            local foolJs = mainUI:FindFirstChild("FoolJumpscare")
            if foolJs then foolJs.Visible = false end
            local foolsJs = mainUI:FindFirstChild("FoolsJumpscare")
            if foolsJs then foolsJs.Visible = false end
            local death = mainUI:FindFirstChild("Death")
            if death then death.Visible = false end
        end
    end
end)

-- Camera
local cameraContainer = CreateContainer("Camera", visualsPage.Scrolling)

Inputs.Text("FOV", cameraContainer, "70", "70", function(value)
    local num = tonumber(value)
    if num then
        workspace.CurrentCamera.FieldOfView = math.clamp(num, 1, 120)
    end
end)

Inputs.Button("ResetFOV", cameraContainer, "Reset FOV", function()
    workspace.CurrentCamera.FieldOfView = 70
    local mg = GetMainGame()
    if mg then
        mg.fovspring = 90
        mg.fovtarget = 70
    end
end)

Inputs.Text("FOVSpring", cameraContainer, "90", "FOV Spring (game)", function(value)
    local num = tonumber(value)
    if num then
        local mg = GetMainGame()
        if mg then
            mg.fovspring = math.clamp(num, 1, 170)
        end
    end
end)

Inputs.Switch("Camera Lock", cameraContainer, false, function(value)
    local mg = GetMainGame()
    if mg then
        mg.camlock = value and workspace.CurrentCamera.CFrame or nil
    end
end)

-- ============================================
-- PAGE 3: Game
-- ============================================

local gamePage = CreatePage("Game", "rbxassetid://113075964705926")

-- Player Mods
local playerContainer = CreateContainer("Player Mods", gamePage.Scrolling)

Inputs.Text("SpeedBoost", playerContainer, "0", "0", function(value)
    local num = tonumber(value)
    if num then
        local char = LocalPlayer.Character
        if char then
            char:SetAttribute("SpeedBoost", num)
        end
    end
end)

Inputs.Switch("Enable Jump", playerContainer, false, function(value)
    local char = LocalPlayer.Character
    if char then
        char:SetAttribute("CanJump", value)
    end
end)

Inputs.Switch("Jump Once (High)", playerContainer, false, function(value)
    local char = LocalPlayer.Character
    if char then
        char:SetAttribute("JumpOnce", value)
    end
end)

local infJumpConn = nil
Inputs.Switch("Inf Jump", playerContainer, false, function(value)
    if value then
        if infJumpConn then infJumpConn:Disconnect() end
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if infJumpConn then
            infJumpConn:Disconnect()
            infJumpConn = nil
        end
    end
end)

Inputs.Switch("God Mode", playerContainer, false, function(value)
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if value then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            else
                hum.MaxHealth = 100
                hum.Health = 100
            end
        end
    end
end)

Inputs.Button("Respawn", playerContainer, "Respawn Character", function()
    LocalPlayer:LoadCharacter()
end)

-- Movement Mods (uses game's built-in systems, anticheat-safe)
local movementContainer = CreateContainer("Movement Mods", gamePage.Scrolling)

local noclipActive = false

local function setCharacterCollision(char, canCollide)
    if not char then return end
    for _, partName in {"Collision", "CollisionCrouch", "HumanoidRootPart", "CollisionPart"} do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            part.CanCollide = canCollide
        end
    end
end

local function noclipOverride()
    local char = LocalPlayer.Character
    if not char then return end
    -- Force CanCollide = false every frame AFTER the game's movement code (which runs at RenderStep priority 101)
    -- We bind at Enum.RenderPriority.Camera.Value (200) which is higher, so we override after the game sets it
    for _, partName in {"Collision", "CollisionCrouch", "HumanoidRootPart", "CollisionPart"} do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

Inputs.Switch("Noclip/Fly", movementContainer, false, function(value)
    local mg = GetMainGame()
    if mg then
        mg.noclip = value
        if value then
            Caption("Noclip ON - WASD:move Space/E:up Ctrl/Q:down Shift:boost F/R:speed")
            noclipActive = true
            -- Bind to RenderStep at priority higher than 101 (game's movement loop) to override CanCollide
            pcall(function()
                RunService:UnbindFromRenderStep("NoclipOverride")
            end)
            RunService:BindToRenderStep("NoclipOverride", Enum.RenderPriority.Camera.Value, noclipOverride)
        else
            Caption("Noclip OFF")
            noclipActive = false
            pcall(function()
                RunService:UnbindFromRenderStep("NoclipOverride")
            end)
            -- Re-enable collision
            local char = LocalPlayer.Character
            if char then
                local collision = char:FindFirstChild("Collision")
                if collision then collision.CanCollide = true end
                local collisionCrouch = char:FindFirstChild("CollisionCrouch")
                if collisionCrouch then collisionCrouch.CanCollide = false end
            end
        end
    else
        Caption("Main_Game module not found!")
    end
end)

-- Self-contained Freecam implementation
local freecamActive = false
local freecamData = {
    cameraType = nil,
    cameraCFrame = nil,
    cameraFOV = nil,
    pos = Vector3.zero,
    look = Vector2.zero,
    speed = 50,
}

-- Touch state for mobile freecam support
local freecamTouch = {
    lookId = nil,
    lookPos = Vector2.zero,
    prevLookPos = nil,
    moveId = nil,
    moveStart = Vector2.zero,
    movePos = Vector2.zero,
}
local freecamTouchConns = {}

local function freecamRender(dt)
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    -- Handle look input (mouse for desktop, touch for mobile)
    local lookX, lookY = 0, 0
    local mouseDelta = UserInputService:GetMouseDelta()
    lookX = mouseDelta.X * 0.2
    lookY = mouseDelta.Y * 0.2
    -- Touch look (mobile - right side of screen drag)
    if freecamTouch.lookId then
        if freecamTouch.prevLookPos then
            local touchDelta = freecamTouch.lookPos - freecamTouch.prevLookPos
            lookX = touchDelta.X * 0.3
            lookY = touchDelta.Y * 0.3
        end
        freecamTouch.prevLookPos = freecamTouch.lookPos
    else
        freecamTouch.prevLookPos = nil
    end
    freecamData.look = freecamData.look + Vector2.new(lookX, lookY)
    freecamData.look = Vector2.new(
        freecamData.look.X % 360,
        math.clamp(freecamData.look.Y, -80, 80)
    )
    
    -- Calculate camera CFrame from look angles
    local rotCFrame = CFrame.fromOrientation(
        math.rad(freecamData.look.Y),
        math.rad(freecamData.look.X),
        0
    )
    
    -- Movement input (keyboard + touch)
    local moveVector = Vector3.zero
    local moveKeys = {
        [Enum.KeyCode.W] = Vector3.new(0, 0, -1),
        [Enum.KeyCode.S] = Vector3.new(0, 0, 1),
        [Enum.KeyCode.A] = Vector3.new(-1, 0, 0),
        [Enum.KeyCode.D] = Vector3.new(1, 0, 0),
        [Enum.KeyCode.Space] = Vector3.new(0, 1, 0),
        [Enum.KeyCode.E] = Vector3.new(0, 1, 0),
        [Enum.KeyCode.LeftControl] = Vector3.new(0, -1, 0),
        [Enum.KeyCode.Q] = Vector3.new(0, -1, 0),
    }
    
    for key, dir in pairs(moveKeys) do
        if UserInputService:IsKeyDown(key) then
            moveVector = moveVector + dir
        end
    end
    
    -- Touch movement (mobile virtual thumbstick - left side of screen)
    if freecamTouch.moveId then
        local touchDelta = freecamTouch.movePos - freecamTouch.moveStart
        local deadzone = 15
        if touchDelta.Magnitude > deadzone then
            local maxDist = 80
            local clampedX = math.clamp(touchDelta.X / maxDist, -1, 1)
            local clampedY = math.clamp(touchDelta.Y / maxDist, -1, 1)
            moveVector = moveVector + Vector3.new(clampedX, 0, -clampedY)
        end
    end
    
    -- Speed boost
    local speedMult = 1
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        speedMult = 3
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.F) or UserInputService:IsKeyDown(Enum.KeyCode.R) then
        speedMult = 6
    end
    
    -- Apply movement relative to camera rotation
    if moveVector.Magnitude > 0 then
        moveVector = moveVector.Unit
        local worldMove = rotCFrame:VectorToWorldSpace(moveVector)
        freecamData.pos = freecamData.pos + worldMove * freecamData.speed * speedMult * dt
    end
    
    -- Set camera
    camera.CFrame = CFrame.new(freecamData.pos) * rotCFrame
end

Inputs.Switch("Freecam", movementContainer, false, function(value)
    local camera = workspace.CurrentCamera
    if not camera then
        Caption("No camera found!")
        return
    end
    
    if value then
        -- Save camera state
        freecamData.cameraType = camera.CameraType
        freecamData.cameraCFrame = camera.CFrame
        freecamData.cameraFOV = camera.FieldOfView
        freecamData.pos = camera.CFrame.Position
        
        -- Extract look angles from current camera CFrame
        local rx, ry, rz = camera.CFrame:ToEulerAnglesYXZ()
        freecamData.look = Vector2.new(math.deg(ry), math.deg(-rx))
        
        -- Detach camera
        camera.CameraType = Enum.CameraType.Scriptable
        
        freecamActive = true
        pcall(function()
            RunService:UnbindFromRenderStep("DoorsPanelFreecam")
        end)
        RunService:BindToRenderStep("DoorsPanelFreecam", Enum.RenderPriority.Camera.Value + 1, freecamRender)
        
        -- Connect touch events for mobile freecam
        local viewportX = camera.ViewportSize.X
        freecamTouchConns[1] = UserInputService.TouchStarted:Connect(function(input, processed)
            if not freecamActive or processed then return end
            if input.Position.X < viewportX / 2 then
                if not freecamTouch.moveId then
                    freecamTouch.moveId = input.InputId
                    freecamTouch.moveStart = input.Position
                    freecamTouch.movePos = input.Position
                end
            else
                if not freecamTouch.lookId then
                    freecamTouch.lookId = input.InputId
                    freecamTouch.lookPos = input.Position
                    freecamTouch.prevLookPos = input.Position
                end
            end
        end)
        freecamTouchConns[2] = UserInputService.TouchMoved:Connect(function(input, processed)
            if not freecamActive then return end
            if input.InputId == freecamTouch.lookId then
                freecamTouch.lookPos = input.Position
            elseif input.InputId == freecamTouch.moveId then
                freecamTouch.movePos = input.Position
            end
        end)
        freecamTouchConns[3] = UserInputService.TouchEnded:Connect(function(input, processed)
            if input.InputId == freecamTouch.lookId then
                freecamTouch.lookId = nil
                freecamTouch.prevLookPos = nil
            elseif input.InputId == freecamTouch.moveId then
                freecamTouch.moveId = nil
            end
        end)
        
        Caption("Freecam ON - WASD/touch-left:move Space/E:up Ctrl/Q:down Shift:boost F/R:speed touch-right:look")
    else
        freecamActive = false
        pcall(function()
            RunService:UnbindFromRenderStep("DoorsPanelFreecam")
        end)
        
        -- Disconnect touch events
        for _, conn in freecamTouchConns do
            if conn then conn:Disconnect() end
        end
        freecamTouchConns = {}
        freecamTouch.lookId = nil
        freecamTouch.moveId = nil
        freecamTouch.prevLookPos = nil
        
        -- Restore camera
        if freecamData.cameraType then
            camera.CameraType = freecamData.cameraType
        end
        if freecamData.cameraFOV then
            camera.FieldOfView = freecamData.cameraFOV
        end
        
        Caption("Freecam OFF")
    end
end)

Inputs.Switch("Hide Players", movementContainer, false, function(value)
    local mg = GetMainGame()
    if mg then
        mg.hideplayers = value and -2 or 0
    end
end)

Inputs.Switch("Free Mouse", movementContainer, false, function(value)
    local mg = GetMainGame()
    if mg then
        mg.freemouse = value
    end
end)

Inputs.Switch("Disable Movement", movementContainer, false, function(value)
    local mg = GetMainGame()
    if mg then
        mg.disableMovement = value
    end
end)

Inputs.Switch("Stop Camera", movementContainer, false, function(value)
    local mg = GetMainGame()
    if mg then
        mg.stopcam = value
    end
end)

-- Teleport (may be blocked by anticheat)
local teleportContainer = CreateContainer("Teleport (Anticheat Warning)", gamePage.Scrolling)

Inputs.Button("TP Forward", teleportContainer, "Teleport Forward", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -50)
        end
    end
end)

Inputs.Button("TP Up", teleportContainer, "Teleport Up", function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
        end
    end
end)

local tpRoomNum = ""
Inputs.Text("RoomNumber", teleportContainer, "", "Room #", function(value)
    tpRoomNum = value
end)

Inputs.Button("TPToRoom", teleportContainer, "TP To Room", function()
    local num = tonumber(tpRoomNum)
    if num then
        local rooms = workspace:FindFirstChild("CurrentRooms")
        if rooms then
            local room = rooms:FindFirstChild(num)
            if room then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = room:GetPivot() + Vector3.new(0, 5, 0)
                    end
                end
            end
        end
    end
end)

Inputs.Button("TPToNextDoor", teleportContainer, "TP To Next Door", function()
    local current = LocalPlayer:GetAttribute("CurrentRoom")
    if not current then return Caption("No current room") end
    local nextNum = tonumber(current) + 1
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if not rooms then return Caption("No CurrentRooms found") end
    local room = rooms:FindFirstChild(nextNum)
    if not room then return Caption("Room " .. tostring(nextNum) .. " not found") end
    -- Find the door in the next room
    for _, child in room:GetChildren() do
        if child:IsA("Model") and (child.Name == "Door" or child.Name == "DoorNormal") then
            local hinge = child:FindFirstChild("HingeConstraint")
            local isOpen = false
            if hinge and hinge:IsA("HingeConstraint") then
                isOpen = math.abs(hinge.CurrentAngle) > 5
            end
            if not isOpen then
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local doorPart = child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart")
                        if doorPart then
                            hrp.CFrame = doorPart.CFrame * CFrame.new(0, 0, -5)
                            Caption("Teleported to Door in Room " .. tostring(nextNum))
                        end
                    end
                end
                return
            end
        end
    end
    Caption("No closed door found in Room " .. tostring(nextNum))
end)

Inputs.Button("TPNearestWardrobe", teleportContainer, "TP To Nearest Wardrobe", function()
    local char = LocalPlayer.Character
    if not char then return Caption("No character") end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return Caption("No HumanoidRootPart") end
    local nearestWardrobe = nil
    local nearestDist = math.huge
    for _, obj in workspace:GetDescendants() do
        if obj:IsA("Model") then
            local loadMod = obj:GetAttribute("LoadModule")
            if loadMod == "Wardrobe" or obj.Name:lower():match("wardrobe") or obj.Name:lower():match("closet") then
                local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if pp then
                    local dist = (pp.Position - hrp.Position).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearestWardrobe = obj
                    end
                end
            end
        end
    end
    if nearestWardrobe then
        local pp = nearestWardrobe.PrimaryPart or nearestWardrobe:FindFirstChildWhichIsA("BasePart")
        if pp then
            hrp.CFrame = pp.CFrame * CFrame.new(0, 0, -3)
            Caption("Teleported to wardrobe " .. nearestWardrobe.Name .. " (" .. math.floor(nearestDist) .. "m)")
        end
    else
        Caption("No wardrobe found")
    end
end)

-- Rooms Info
local roomsContainer = CreateContainer("Rooms Info", gamePage.Scrolling)

Inputs.Button("ListAllRooms", roomsContainer, "List All Rooms", function()
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if not rooms then
        return Caption("No CurrentRooms found")
    end
    local list = {}
    for _, room in rooms:GetChildren() do
        local rawName = room:GetAttribute("RawName") or "Unknown"
        local style = room:GetAttribute("RoomStyle") or "Unknown"
        local hiding = room:GetAttribute("HidingRoom") and "Yes" or "No"
        local maxHide = room:GetAttribute("MaxHidingSpots") or 0
        table.insert(list, string.format("Room %s | %s | Style: %s | Hiding: %s | Spots: %d", room.Name, rawName, style, hiding, maxHide))
    end
    Caption(table.concat(list, "\n"))
end)

Inputs.Button("ShowCurrentRoom", roomsContainer, "Show Current Room", function()
    local roomNum = LocalPlayer:GetAttribute("CurrentRoom")
    if roomNum then
        local rooms = workspace:FindFirstChild("CurrentRooms")
        local room = rooms and rooms:FindFirstChild(roomNum)
        local roomName = "Unknown"
        local style = "Unknown"
        if room then
            roomName = room:GetAttribute("RawName") or "Unknown"
            style = room:GetAttribute("RoomStyle") or "Unknown"
        end
        Caption(string.format("Room %s | %s | Style: %s", tostring(roomNum), roomName, style))
    else
        Caption("No room data available")
    end
end)

Inputs.Button("ShowRoomDetails", roomsContainer, "Show Room Details (by #)", function()
    local num = tonumber(tpRoomNum)
    if not num then
        return Caption("Enter a room number in the Teleport Room # field first")
    end
    local rooms = workspace:FindFirstChild("CurrentRooms")
    local room = rooms and rooms:FindFirstChild(num)
    if not room then
        return Caption("Room " .. tostring(num) .. " not found")
    end
    local rawName = room:GetAttribute("RawName") or "Unknown"
    local style = room:GetAttribute("RoomStyle") or "Unknown"
    local hiding = room:GetAttribute("HidingRoom") and "Yes" or "No"
    local maxHide = room:GetAttribute("MaxHidingSpots") or 0
    local totalHide = room:GetAttribute("TotalHidingSpots") or 0
    local weight = room:GetAttribute("Weight") or 0
    local padding = room:GetAttribute("RoomPadding") or 0
    local childCount = #room:GetChildren()
    Caption(string.format("Room %d\nRawName: %s\nStyle: %s\nHidingRoom: %s\nMaxHidingSpots: %d\nTotalHidingSpots: %d\nWeight: %d\nPadding: %d\nChildren: %d", num, rawName, style, hiding, maxHide, totalHide, weight, padding, childCount))
end)

Inputs.Button("TPNextRoom", roomsContainer, "TP To Next Room", function()
    local current = LocalPlayer:GetAttribute("CurrentRoom")
    if not current then return Caption("No current room") end
    local nextNum = tonumber(current) + 1
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if rooms then
        local room = rooms:FindFirstChild(nextNum)
        if room then
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = room:GetPivot() + Vector3.new(0, 5, 0)
                    Caption("Teleported to Room " .. tostring(nextNum))
                end
            end
        else
            Caption("Room " .. tostring(nextNum) .. " not found")
        end
    end
end)

Inputs.Button("TPPrevRoom", roomsContainer, "TP To Previous Room", function()
    local current = LocalPlayer:GetAttribute("CurrentRoom")
    if not current then return Caption("No current room") end
    local prevNum = math.max(0, tonumber(current) - 1)
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if rooms then
        local room = rooms:FindFirstChild(prevNum)
        if room then
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = room:GetPivot() + Vector3.new(0, 5, 0)
                    Caption("Teleported to Room " .. tostring(prevNum))
                end
            end
        else
            Caption("Room " .. tostring(prevNum) .. " not found")
        end
    end
end)

-- Auto Hide (auto-wardrobe when entity detected)
local autoHideContainer = CreateContainer("Auto Hide", gamePage.Scrolling)

local autoHide = false
Inputs.Switch("Auto Hide in Wardrobe", autoHideContainer, false, function(value)
    autoHide = value
    if value then
        Caption("Auto Hide ON - Will hide in nearest wardrobe when entity detected")
    else
        Caption("Auto Hide OFF")
    end
end)

local autoHideRange = 50
Inputs.Text("AutoHideRange", autoHideContainer, "50", "Wardrobe Range (studs)", function(value)
    local num = tonumber(value)
    if num then autoHideRange = num end
end)

-- Auto Hide loop
task.spawn(function()
    while task.wait(0.3) do
        if not autoHide then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        local hiding = char:GetAttribute("Hiding")
        if hiding then continue end -- already hiding
        -- Check for nearby dangerous entities (only those that require hiding in wardrobe)
        local entityNearby = false
        for _, obj in workspace:GetDescendants() do
            if obj:IsA("Model") and DANGEROUS_ENTITIES[obj.Name] then
            local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if pp and (pp.Position - hrp.Position).Magnitude < 100 then
                entityNearby = true
                break
            end
            end
        end
        if not entityNearby then continue end
        -- Find nearest wardrobe
        local nearestWardrobe = nil
        local nearestDist = math.huge
        for _, obj in workspace:GetDescendants() do
            if obj:IsA("Model") then
                local loadMod = obj:GetAttribute("LoadModule")
                if loadMod == "Wardrobe" or obj.Name:lower():match("wardrobe") or obj.Name:lower():match("closet") then
                    local pp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if pp then
                        local dist = (pp.Position - hrp.Position).Magnitude
                        if dist < nearestDist and dist <= autoHideRange then
                            nearestDist = dist
                            nearestWardrobe = obj
                        end
                    end
                end
            end
        end
        if nearestWardrobe then
            -- Find the ProximityPrompt on the wardrobe and trigger it
            for _, descendant in nearestWardrobe:GetDescendants() do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        descendant:InputHoldBegin()
                        task.wait(0.1)
                        descendant:InputHoldEnd()
                    end)
                    Caption("Auto Hide: Hiding in wardrobe " .. nearestWardrobe.Name)
                    break
                end
            end
        end
    end
end)

-- Game Info
local gameInfoContainer = CreateContainer("Game Info", gamePage.Scrolling)

Inputs.Button("ShowGold", gameInfoContainer, "Show Gold", function()
    local gold = LocalPlayer:GetAttribute("Gold")
    Caption("Gold: " .. tostring(gold or 0))
end)

Inputs.Button("ShowRevives", gameInfoContainer, "Show Revives", function()
    local revives = LocalPlayer:GetAttribute("Revives")
    Caption("Revives: " .. tostring(revives or 0))
end)

Inputs.Button("ShowAllAttrs", gameInfoContainer, "Show All Player Attrs", function()
    local attrs = LocalPlayer:GetAttributes()
    local parts = {}
    for k, v in pairs(attrs) do
        table.insert(parts, k .. " = " .. tostring(v))
    end
    if #parts == 0 then
        Caption("No player attributes found")
    else
        Caption(table.concat(parts, "\n"))
    end
end)

-- Player Status (real-time character attribute monitor)
local playerStatusContainer = CreateContainer("Player Status", gamePage.Scrolling)

local statusEnabled = false
Inputs.Switch("Status Monitor", playerStatusContainer, false, function(value)
    statusEnabled = value
end)

-- Status monitor loop
task.spawn(function()
    while task.wait(0.5) do
        if not statusEnabled then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local parts = {}
        if hum then
            table.insert(parts, string.format("Health: %d/%d", math.floor(hum.Health), math.floor(hum.MaxHealth)))
            table.insert(parts, string.format("WalkSpeed: %.1f", hum.WalkSpeed))
            table.insert(parts, string.format("JumpPower: %.1f", hum.JumpPower))
        end
        local oxygen = char:GetAttribute("Oxygen")
        if oxygen then table.insert(parts, string.format("Oxygen: %d", oxygen)) end
        local crouching = char:GetAttribute("Crouching")
        if crouching then table.insert(parts, "State: Crouching") end
        local hiding = char:GetAttribute("Hiding")
        if hiding then table.insert(parts, "State: Hiding") end
        local stunned = char:GetAttribute("Stunned")
        if stunned then table.insert(parts, "State: Stunned") end
        local sliding = char:GetAttribute("Sliding")
        if sliding then table.insert(parts, "State: Sliding") end
        local underwater = char:GetAttribute("Underwater")
        if underwater then table.insert(parts, "State: Underwater") end
        local alive = char:GetAttribute("Alive")
        if alive ~= nil then table.insert(parts, "Alive: " .. tostring(alive)) end
        local speedBoost = char:GetAttribute("SpeedBoost")
        if speedBoost and speedBoost ~= 0 then table.insert(parts, string.format("SpeedBoost: %.1f", speedBoost)) end
        local speedBoostExtra = char:GetAttribute("SpeedBoostExtra")
        if speedBoostExtra and speedBoostExtra ~= 0 then table.insert(parts, string.format("SpeedBoostExtra: %.1f", speedBoostExtra)) end
        local speedBoostBehind = char:GetAttribute("SpeedBoostBehind")
        if speedBoostBehind and speedBoostBehind ~= 0 then table.insert(parts, string.format("SpeedBoostBehind: %.1f", speedBoostBehind)) end
        local doorsOpened = char:GetAttribute("DoorsOpened")
        if doorsOpened then table.insert(parts, "DoorsOpened: " .. tostring(doorsOpened)) end
        local subdoorsOpened = char:GetAttribute("SubdoorsOpened")
        if subdoorsOpened then table.insert(parts, "SubdoorsOpened: " .. tostring(subdoorsOpened)) end
        local deathCause = char:GetAttribute("DeathCause")
        if deathCause then table.insert(parts, "DeathCause: " .. tostring(deathCause)) end
        local deathReason = char:GetAttribute("DeathReason")
        if deathReason then table.insert(parts, "DeathReason: " .. tostring(deathReason)) end
        local inventoryCap = char:GetAttribute("InventoryCap")
        if inventoryCap then table.insert(parts, "InventoryCap: " .. tostring(inventoryCap)) end
        local journalOut = char:GetAttribute("JournalOut")
        if journalOut then table.insert(parts, "JournalOut: " .. tostring(journalOut)) end
        Caption(table.concat(parts, "\n"))
    end
end)

-- Game Stats
local gameStatsContainer = CreateContainer("Game Stats", gamePage.Scrolling)

Inputs.Button("ShowStats", gameStatsContainer, "Show Game Stats", function()
    local parts = {}
    pcall(function()
        local rdm = require(ReplicatedStorage:WaitForChild("ReplicaDataModule"))
        if rdm and rdm.data and rdm.data.Stats then
            local stats = rdm.data.Stats
            for k, v in pairs(stats) do
                if type(v) == "number" then
                    table.insert(parts, k .. ": " .. tostring(v))
                elseif type(v) == "table" then
                    for sk, sv in pairs(v) do
                        if type(sv) == "number" and sv > 0 then
                            table.insert(parts, k .. "." .. sk .. ": " .. tostring(sv))
                        end
                    end
                end
            end
        end
    end)
    pcall(function()
        local gameStats = ReplicatedStorage:FindFirstChild("GameStats")
        if gameStats then
            local playerStats = gameStats:FindFirstChild("Player_" .. LocalPlayer.Name)
            if playerStats then
                for _, child in playerStats:GetDescendants() do
                    if child:IsA("IntValue") and child.Value > 0 then
                        table.insert(parts, child.Name .. ": " .. tostring(child.Value))
                    end
                end
            end
        end
    end)
    pcall(function()
        local seed = ReplicatedStorage.GameData.GameSeed.Value
        table.insert(parts, "Seed: " .. tostring(seed))
    end)
    if #parts == 0 then
        Caption("No stats available")
    else
        Caption(table.concat(parts, "\n"))
    end
end)

Inputs.Button("ShowSeed", gameStatsContainer, "Show Game Seed", function()
    pcall(function()
        local seed = ReplicatedStorage.GameData.GameSeed.Value
        Caption("Game Seed: " .. tostring(seed))
    end)
end)

Inputs.Button("ShowKnobs", gameStatsContainer, "Show Knobs", function()
    pcall(function()
        local rdm = require(ReplicatedStorage:WaitForChild("ReplicaDataModule"))
        if rdm and rdm.data and rdm.data.Knobs then
            local parts = {}
            for k, v in pairs(rdm.data.Knobs) do
                table.insert(parts, k .. " = " .. tostring(v))
            end
            if #parts > 0 then
                Caption(table.concat(parts, "\n"))
            else
                Caption("No knobs data")
            end
        else
            Caption("No knobs data available")
        end
    end)
end)

-- Remotes (useful game remote events)
local remotesContainer = CreateContainer("Game Remotes", gamePage.Scrolling)

Inputs.Button("ToggleJournal", remotesContainer, "Toggle Journal", function()
    pcall(function()
        local remotes = ReplicatedStorage:WaitForChild("RemotesFolder", 3)
        local tj = remotes and remotes:FindFirstChild("ToggleJournal")
        if tj then
            tj:FireServer()
        else
            Caption("ToggleJournal remote not found")
        end
    end)
end)

Inputs.Button("FireCaption", remotesContainer, "Send Caption Message", function()
    pcall(function()
        local remotes = ReplicatedStorage:WaitForChild("RemotesFolder", 3)
        local cap = remotes and remotes:FindFirstChild("CaptionClient")
        if cap then
            cap:Fire("Hacker Panel says hi!")
        else
            Caption("CaptionClient remote not found")
        end
    end)
end)

Inputs.Button("FireCamLock", remotesContainer, "Camera Lock Toggle", function()
    pcall(function()
        local remotes = ReplicatedStorage:WaitForChild("RemotesFolder", 3)
        local cl = remotes and remotes:FindFirstChild("CamLock")
        if cl then
            cl:FireServer()
        else
            Caption("CamLock remote not found")
        end
    end)
end)

-- Auto Prompt
local autoPromptContainer = CreateContainer("Auto Prompt", gamePage.Scrolling)

local autoPrompt = false
Inputs.Switch("Auto Prompt", autoPromptContainer, false, function(value)
    autoPrompt = value
end)

local promptRange = 20
Inputs.Text("PromptRangeVal", autoPromptContainer, "20", "Range (studs)", function(value)
    local num = tonumber(value)
    if num then promptRange = num end
end)

task.spawn(function()
    while task.wait(0.5) do
        if not autoPrompt then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        for _, obj in workspace:GetDescendants() do
            if obj:IsA("ProximityPrompt") and obj.Enabled then
                local parent = obj.Parent
                if parent and parent:IsA("BasePart") then
                    local dist = (parent.Position - hrp.Position).Magnitude
                    if dist <= promptRange then
                        pcall(function()
                            obj:InputHoldBegin()
                            task.wait(0.1)
                            obj:InputHoldEnd()
                        end)
                    end
                end
            end
        end
    end
end)

-- ============================================
-- PAGE 4: Other
-- ============================================

local otherPage = CreatePage("Other", "rbxassetid://113075964705926")

-- Loadstring
local loadstringContainer = CreateContainer("Loadstring", otherPage.Scrolling)

local scriptText = ""
Inputs.Text("Script", loadstringContainer, "", "print()", function(value)
    scriptText = value
end)

local loadstringButtons = Inputs.ButtonStack("Buttons", loadstringContainer)

loadstringButtons:AddButton("Dex", "Open Dex", C(150, 201, 255), function()
    if dexOpened then
        return Caption("Dex is already running!")
    end
    dexOpened = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zzerexx/Dex/refs/heads/master/main.lua"))()
end)

Inputs.Button("RunLoadstring", loadstringContainer, "Run Script", function()
    pcall(loadstring(scriptText))
end)

-- Bypass
local bypassContainer = CreateContainer("Bypass", otherPage.Scrolling)

local devBypassActive = false
local panelClientClone = nil

local function cleanupAdminPanelUI()
    local doorsAdmin = LocalPlayer.PlayerGui:FindFirstChild("DoorsAdmin")
    if not doorsAdmin then return end
    local container = doorsAdmin:FindFirstChild("Container")
    if not container then return end
    local pages = container:FindFirstChild("Pages")
    local tabButtons = container:FindFirstChild("TabButtons")
    if pages then
        for _, child in pages:GetChildren() do
            child.Parent = nil
        end
    end
    if tabButtons then
        for _, child in tabButtons:GetChildren() do
            if child:IsA("GuiObject") or child:IsA("CanvasGroup") then
                child.Parent = nil
            end
        end
    end
end

Inputs.Switch("Dev Bypass", bypassContainer, false, function(value)
    devBypassActive = value
    if value then
        -- Set ServerAdmin attribute to 5 (dev level)
        LocalPlayer:SetAttribute("ServerAdmin", 5)

        -- Get admin panel references
        local doorsAdmin = LocalPlayer.PlayerGui:FindFirstChild("DoorsAdmin")
        if not doorsAdmin then
            Caption("DoorsAdmin not found!")
            return
        end
        local adminPanel = doorsAdmin:FindFirstChild("AdminPanel")
        if not adminPanel then
            Caption("AdminPanel not found!")
            return
        end

        -- Disable original PanelClient
        local original = adminPanel:FindFirstChild("PanelClient")
        if original then
            original.Disabled = true
        end

        -- Clean up existing pages and tab buttons
        cleanupAdminPanelUI()

        task.wait(0.2)

        -- Clone PanelClient and run it with new attribute
        if original then
            panelClientClone = original:Clone()
            panelClientClone.Name = "PanelClient_Bypass"
            panelClientClone.Disabled = false
            panelClientClone.Parent = adminPanel
        end

        Caption("Dev Bypass ON - ServerAdmin = 5")
    else
        -- Remove ServerAdmin attribute
        LocalPlayer:SetAttribute("ServerAdmin", nil)

        -- Destroy the clone
        if panelClientClone then
            panelClientClone.Disabled = true
            panelClientClone.Parent = nil
            panelClientClone = nil
        end

        -- Clean up pages and tab buttons
        cleanupAdminPanelUI()

        task.wait(0.2)

        -- Re-enable original PanelClient
        local doorsAdmin = LocalPlayer.PlayerGui:FindFirstChild("DoorsAdmin")
        if doorsAdmin then
            local adminPanel = doorsAdmin:FindFirstChild("AdminPanel")
            if adminPanel then
                local original = adminPanel:FindFirstChild("PanelClient")
                if original then
                    original.Disabled = false
                end
            end
        end

        Caption("Dev Bypass OFF")
    end
end)

-- Misc
local miscContainer = CreateContainer("Misc", otherPage.Scrolling)

Inputs.Button("Rejoin", miscContainer, "Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

Inputs.Button("CopyJobId", miscContainer, "Copy Job ID", function()
    if setclipboard then
        setclipboard(game.JobId)
        Caption("Job ID copied!")
    else
        Caption("Job ID: " .. game.JobId)
    end
end)

Inputs.Button("CopyPlaceId", miscContainer, "Copy Place ID", function()
    if setclipboard then
        setclipboard(tostring(game.PlaceId))
        Caption("Place ID copied!")
    else
        Caption("Place ID: " .. tostring(game.PlaceId))
    end
end)

Inputs.Button("ServerInfo", miscContainer, "Show Server Info", function()
    local info = string.format("PlaceId: %d\nJobId: %s\nPlayers: %d", game.PlaceId, game.JobId, #Players:GetPlayers())
    Caption(info)
end)
