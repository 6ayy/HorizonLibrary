getgenv().UI = "HorizonUI"

-- Game Services
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Horizon Bar Interface Management
local HorizonBarUI = Instance.new("ScreenGui")

HorizonBarUI.Name = getgenv().UI
if gethui():FindFirstChild(getgenv().UI) then
    gethui():FindFirstChild(getgenv().UI).Parent = nil
end

HorizonBarUI.Parent = gethui()

-- Color Palette
local ColorPalette = {
    Black = Color3.fromRGB(0, 0, 0),
    Dark = Color3.fromRGB(25, 25, 25),
    Gray = Color3.fromRGB(185, 185, 185),
    DarkGray = Color3.fromRGB(50, 50, 50),
    White = Color3.fromRGB(255, 255, 255),
    Blue = Color3.fromRGB(0, 115, 215)
}

-- Storage
local Storage = {
    Icons = {
        DownArrowHead = "rbxassetid://14290444235",
        Click = "rbxassetid://11243256070",
        WhitelistStatus = "rbxassetid://14333382642",
        Time = "rbxassetid://14358459327",
        Ping = "rbxassetid://14334409497",
        Version = "rbxassetid://14334419052",
        Execution = "rbxassetid://14358439491",
        Money = "rbxassetid://14358718160"
    },
    Images = {}
}

-- Create Function
local function Create(Object_Type, Object_Properties)
    -- Creating Object
    local Object = Instance.new(Object_Type)
    -- Setting Object Properties
    for Property, Value in next, Object_Properties do
        Object[Property] = Value
    end
    -- Return Object
    return Object
end

-- Tween Function
local function CreateTween(Object, Tween_Duration, Tween_Easing_Style, Tween_Properties)
    -- Tween Info
    local TweenInfo = TweenInfo.new(Tween_Duration, Tween_Easing_Style)
    -- Creating Tween
    local Tween = TweenService:Create(Object, TweenInfo, Tween_Properties)
    -- Playing Tween
    Tween:Play()
end

-- Bubble Effect
local function BubbleEffect(Bubble_Object)

    -- Mouse
    local Mouse = Players.LocalPlayer:GetMouse()

    local RelativeX = Mouse.X - Bubble_Object.AbsolutePosition.X
    local RelativeY = Mouse.Y - Bubble_Object.AbsolutePosition.Y

    -- Bubble Frame
    local BubbleFrame = Create("Frame", {
        Parent = Bubble_Object,
        Name = "BubbleFrame",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 0,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, RelativeX, 0, RelativeY),
        Rotation = 0,
        Size = UDim2.new(0, 0, 0, 0),
        Visible = true,
        ClipsDescendants = false
    })

    -- Bubble Frame UICorner
    local BubbleFrame_UICorner = Create("UICorner", {
        Parent = BubbleFrame,
        CornerRadius = UDim.new(1, 0)
    })

    -- Bubble Tween
    CreateTween(BubbleFrame, 0.6, Enum.EasingStyle.Exponential, {
        Size = UDim2.new(0, 150, 0, 150),
        Position = UDim2.new(0, RelativeX - 75, 0, RelativeY - 75),
        BackgroundTransparency = 1
    })

    delay(0.5, function()
        -- Destroy Bubble Frame
        BubbleFrame:Destroy()
    end)
end

-- Shadow Function
local function Shadow(ShadowProperties)
    -- Shadow Frame
    local ShadowFrame = Create("Frame", {
        Parent = ShadowProperties.Parent,
        Name = "ShadowFrame",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 1,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Rotation = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = true,
        ClipsDescendants = false
    })

    -- Shadow Frame UICorner
    local ShadowFrame_UICorner = Create("UICorner", {
        Parent = ShadowFrame,
        CornerRadius = UDim.new(0, ShadowProperties.CornerRadius)
    })

    -- Shadow Frame UIStroke
    local ShadowFrame_UIStroke = Create("UIStroke", {
        Parent = ShadowFrame,
        Color = ColorPalette.Black,
        Thickness = ShadowProperties.Thickness,
        Transparency = ShadowProperties.Transparency
    })
end

-- Gradient Function
local function Gradient(GradientProperties)
    -- Gradient Frame
    local GradientFrame = Create("Frame", {
        Parent = GradientProperties.Parent,
        Name = "GradientFrame",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 0,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Rotation = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = true,
        ClipsDescendants = false
    })

    -- Gradient Frame UICorner
    local GradientFrame_UICorner = Create("UICorner", {
        Parent = GradientFrame,
        CornerRadius = UDim.new(0, GradientProperties.CornerRadius)
    })

    -- Gradient Frame UIGradient
    local GradientFrame_UIGradient = Create("UIGradient", {
        Parent = GradientFrame,
        Color = GradientProperties.Color,
        Rotation = GradientProperties.Rotation,
        Transparency = GradientProperties.Transparency
    })
end

-- Draggable Function
local function Draggable(Window, Inset)
    -- User Input Service
    local UserInputService = game:GetService("UserInputService")
    -- Dragging Variable
    local Window_Dragging = false

    -- Offsets
    local OffsetX, OffsetY

    -- Input Began
    UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            local MousePosition = UserInputService:GetMouseLocation()
            local MousePositionX = MousePosition.X
            local MousePositionY = MousePosition.Y - 36
            if MousePositionX >= Window.AbsolutePosition.X and MousePositionX <= Window.AbsolutePosition.X +
                Window.AbsoluteSize.X and MousePositionY >= Window.AbsolutePosition.Y and MousePositionY <=
                Window.AbsolutePosition.Y + Inset then
                Window_Dragging = true
                OffsetX = MousePositionX - Window.AbsolutePosition.X
                OffsetY = MousePositionY - Window.AbsolutePosition.Y
            end
        end
    end)

    -- Input Ended
    UserInputService.InputEnded:Connect(function(Input, GameProcessed)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Window_Dragging = false
        end
    end)

    -- Dragging Function
    game:GetService("RunService").RenderStepped:Connect(function()
        if Window_Dragging then
            local MousePosition = UserInputService:GetMouseLocation()
            local MousePositionX = MousePosition.X
            local MousePositionY = MousePosition.Y - 36
            TweenService:Create(Window, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                Position = UDim2.new(0, MousePositionX - OffsetX, 0, MousePositionY - OffsetY)
            }):Play()
        end
    end)
end

-- HorizonBarLibrary 
local HorizonBarLibrary = {}

-- Create Window Function
function HorizonBarLibrary:CreateWindow(WindowProperties)

    -- Window Properties
    local Window_Name = WindowProperties.Name
    local Window_Version = WindowProperties.Version

    -- Window
    local Window = Create("Frame", {
        Parent = HorizonBarUI,
        Name = "Window",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.Dark,
        BackgroundTransparency = 0,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -240, 0.5, -175),
        Rotation = 0,
        Size = UDim2.new(0, 500, 0, 372),
        Visible = true,
        ClipsDescendants = false
    })

    -- Draggable Functionality
    Draggable(Window, 40)

    -- Window UICorner
    local Window_UICorner = Create("UICorner", {
        Parent = Window,
        CornerRadius = UDim.new(0, 10)
    })

    -- Window UIStroke
    local Window_UIStroke = Create("UIStroke", {
        Parent = Window,
        Color = ColorPalette.White,
        Thickness = 1.5,
        Transparency = 0.8
    })

    -- Window Shadow Folder
    local WindowShadowFolder = Create("Folder", {
        Parent = Window,
        Name = "Shadow"
    })

    -- Window Shadow
    Shadow({
        Parent = WindowShadowFolder,
        Thickness = 1,
        Transparency = 0.95,
        CornerRadius = 10
    })

    Shadow({
        Parent = WindowShadowFolder,
        Thickness = 3,
        Transparency = 0.95,
        CornerRadius = 10
    })

    Shadow({
        Parent = WindowShadowFolder,
        Thickness = 5,
        Transparency = 0.95,
        CornerRadius = 10
    })

    Shadow({
        Parent = WindowShadowFolder,
        Thickness = 7,
        Transparency = 0.95,
        CornerRadius = 10
    })

    -- Window Gradient Folder
    local WindowGradientFolder = Create("Folder", {
        Parent = Window,
        Name = "Gradient"
    })

    -- Window Gradient
    Gradient({
        Parent = WindowGradientFolder,
        Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 80, 238)),
                                   ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 24, 24))},
        Rotation = 60,
        Transparency = NumberSequence.new {NumberSequenceKeypoint.new(0.00, 0.27),
                                           NumberSequenceKeypoint.new(0.44, 1.00),
                                           NumberSequenceKeypoint.new(1.00, 0.98)},
        CornerRadius = 10
    })

    Gradient({
        Parent = WindowGradientFolder,
        Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 80, 238)),
                                   ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 24, 24))},
        Rotation = 120,
        Transparency = NumberSequence.new {NumberSequenceKeypoint.new(0.00, 0.27),
                                           NumberSequenceKeypoint.new(0.44, 1.00),
                                           NumberSequenceKeypoint.new(1.00, 0.98)},
        CornerRadius = 10
    })

    -- Window Name 
    local WindowName = Create("TextLabel", {
        Parent = Window,
        Name = "Name",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 1,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 5),
        Rotation = 0,
        Size = UDim2.new(1, -75, 0, 25),
        Visible = true,
        ClipsDescendants = false,
        FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
        Text = Window_Name,
        TextColor3 = ColorPalette.White,
        TextSize = 16,
        TextStrokeColor3 = ColorPalette.Black,
        TextStrokeTransparency = 1,
        TextTransparency = 0,
        TextTruncate = Enum.TextTruncate.None,
        TextWrapped = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    -- Window Version
    local WindowVersion = Create("TextLabel", {
        Parent = WindowName,
        Name = "Version",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 0.9,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 145, 0, 0),
        Rotation = 0,
        Size = UDim2.new(0, 48, 0, 24),
        Visible = true,
        ClipsDescendants = false,
        FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
        Text = "V" .. Window_Version,
        TextColor3 = ColorPalette.White,
        TextSize = 14,
        TextStrokeColor3 = ColorPalette.Black,
        TextStrokeTransparency = 1,
        TextTransparency = 0,
        TextTruncate = Enum.TextTruncate.None,
        TextWrapped = false,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    -- Window Version UICorner
    local WindowVersion_UICorner = Create("UICorner", {
        Parent = WindowVersion,
        CornerRadius = UDim.new(0, 6)
    })

    -- Window Collapse Icon
    local WindowCollapseIcon = Create("ImageButton", {
        Parent = Window,
        Name = "Icon",
        AnchorPoint = Vector2.new(0, 0),
        AutoButtonColor = false,
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 1,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -35, 0, 5),
        Rotation = 0,
        Size = UDim2.new(0, 25, 0, 25),
        Visible = true,
        ClipsDescendants = false,
        Image = Storage.Icons.DownArrowHead,
        ImageColor3 = ColorPalette.White,
        ImageTransparency = 0,
        ScaleType = Enum.ScaleType.Stretch
    })

    -- Window Separator
    local WindowSeparator = Create("Frame", {
        Parent = Window,
        Name = "Separator",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 0.9,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 35),
        Rotation = 0,
        Size = UDim2.new(1, 0, 0, 2),
        Visible = true,
        ClipsDescendants = false
    })

    -- Main Container
    local MainContainer = Create("Frame", {
        Parent = Window,
        Name = "MainContainer",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 1,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 35),
        Rotation = 0,
        Size = UDim2.new(1, 0, 1, -35),
        Visible = true,
        ClipsDescendants = true
    })

    -- Window Status
    local Window_Status = false

    -- Window Collapse Icon Interaction
    WindowCollapseIcon.MouseButton1Down:Connect(function()
        if not Window_Status then
            CreateTween(WindowCollapseIcon, 0.5, Enum.EasingStyle.Exponential, {
                Rotation = 180
            })
            CreateTween(WindowSeparator, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 1
            })
            CreateTween(MainContainer, 0.35, Enum.EasingStyle.Exponential, {
                Size = UDim2.new(1, 0, 0, 50)
            })
            MainContainer.Visible = false
            CreateTween(Window, 0.5, Enum.EasingStyle.Exponential, {
                Size = UDim2.new(0, 500, 0, 40)
            })
            Window_Status = not Window_Status
        else
            CreateTween(WindowCollapseIcon, 0.5, Enum.EasingStyle.Exponential, {
                Rotation = 0
            })
            CreateTween(WindowSeparator, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.9
            })
            CreateTween(MainContainer, 0.35, Enum.EasingStyle.Exponential, {
                Size = UDim2.new(1, 0, 1, -35)
            })
            MainContainer.Visible = true
            CreateTween(Window, 0.5, Enum.EasingStyle.Exponential, {
                Size = UDim2.new(0, 500, 0, 372)
            })
            Window_Status = not Window_Status
        end
    end)

    -- Tab Button Container
    local TabButtonContainer = Create("Frame", {
        Parent = MainContainer,
        Name = "Container",
        AnchorPoint = Vector2.new(0, 0),
        AutomaticSize = Enum.AutomaticSize.None,
        BackgroundColor3 = ColorPalette.White,
        BackgroundTransparency = 0.9,
        BorderColor3 = ColorPalette.Black,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 10),
        Rotation = 0,
        Size = UDim2.new(0, 70, 1, -20),
        Visible = true,
        ClipsDescendants = false
    })

    -- Tab Button Container UICorner
    local TabButtonContainer_UICorner = Create("UICorner", {
        Parent = TabButtonContainer,
        CornerRadius = UDim.new(0, 6)
    })

    -- Tab Button Container UIListLayout
    local TabButtonContainer_UIListLayout = Create("UIListLayout", {
        Parent = TabButtonContainer,
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    -- Tab Button Container UIPadding
    local TabButtonContainer_UIPadding = Create("UIPadding", {
        Parent = TabButtonContainer,
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 0),
        PaddingRight = UDim.new(0, 0)
    })

    -- Tabs Folder
    local TabsFolder = Create("Folder", {
        Parent = MainContainer,
        Name = "Tabs"
    })

    -- Horizon Bar Window
    local Window = {}

    -- Create Console Tab Function
    function Window:CreateConsoleTab(ConsoleTabProperties)

        -- Console Tab Properties
        local ConsoleTab_Name = ConsoleTabProperties.Name
        local ConsoleTab_Icon = ConsoleTabProperties.Icon
        local FirstWindow = ConsoleTabProperties.FirstWindow

        -- Console Button Wrapper
        local ConsoleTabButtonWrapper = Create("Frame", {
            Parent = TabButtonContainer,
            Name = "Wrapper",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Console Tab Button Wrapper
        local ConsoleTabButtonWrapper_UIListLayout = Create("UIListLayout", {
            Parent = ConsoleTabButtonWrapper,
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Console Button
        local ConsoleTabButton = Create("Frame", {
            Parent = ConsoleTabButtonWrapper,
            Name = "Button",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.85,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Console Tab Button UICorner
        local ConsoleTabButton_UICorner = Create("UICorner", {
            Parent = ConsoleTabButton,
            CornerRadius = UDim.new(0, 6)
        })

        -- Console Tab Button Interact
        local ConsoleTabButtonInteract = Create("TextButton", {
            Parent = ConsoleTabButton,
            Name = "Interact",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "",
            TextColor3 = ColorPalette.Black,
            TextSize = 0,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Console Tab Button Icon
        local ConsoleTabButtonIcon = Create("ImageLabel", {
            Parent = ConsoleTabButton,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = false,
            Image = ConsoleTab_Icon,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Console Tab
        local ConsoleTab = Create("Frame", {
            Parent = TabsFolder,
            Name = "Tab",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 90, -1, -25),
            Rotation = 0,
            Size = UDim2.new(1, -100, 1, -20),
            Visible = true,
            ClipsDescendants = true
        })

        -- First Window
        if FirstWindow then
            ConsoleTab.Position = UDim2.new(0, 90, 0, 10)
        end

        -- Console Tab UICorner
        local ConsoleTab_UICorner = Create("UICorner", {
            Parent = ConsoleTab,
            CornerRadius = UDim.new(0, 6)
        })

        --  Console Container
        local ConsoleContainer = Create("ScrollingFrame", {
            Parent = ConsoleTab,
            Name = "ConsoleContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -80),
            Visible = true,
            ClipsDescendants = true,
            AutomaticCanvasSize = 2,
            CanvasPosition = Vector2.new(0, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarImageColor3 = ColorPalette.Black,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = true
        })

        -- Console Container UIListLayout
        local ConsoleContainer_UIListLayout = Create("UIListLayout", {
            Parent = ConsoleContainer,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Console Status Bar
        local ConsoleStatusBar = Create("Frame", {
            Parent = ConsoleTab,
            Name = "ConsoleStatusBar",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 1, -50),
            Rotation = 0,
            Size = UDim2.new(1, -20, 0, 40),
            Visible = true,
            ClipsDescendants = false
        })

        -- Console Status Bar UICorner
        local ConsoleStatusBar_UICorner = Create("UICorner", {
            Parent = ConsoleStatusBar,
            CornerRadius = UDim.new(0, 6)
        })

        -- Console Status 
        local ConsoleStatus = Create("Frame", {
            Parent = ConsoleStatusBar,
            Name = "ConsoleStatus",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.Blue,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 8, 0, 8),
            Rotation = 0,
            Size = UDim2.new(0, 60, 1, -16),
            Visible = true,
            ClipsDescendants = false
        })

        -- Console Status UICorner
        local ConsoleStatus_UICorner = Create("UICorner", {
            Parent = ConsoleStatus,
            CornerRadius = UDim.new(0, 4)
        })

        -- Console Status Label
        local ConsoleStatusLabel = Create("TextLabel", {
            Parent = ConsoleStatus,
            Name = "Label",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "Status",
            TextColor3 = ColorPalette.White,
            TextSize = 14,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Console Status Text
        local ConsoleStatusText = Create("TextLabel", {
            Parent = ConsoleStatusBar,
            Name = "Text",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 80, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, -80, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "Waiting for locations to open...",
            TextColor3 = ColorPalette.White,
            TextSize = 14,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Console Tab Button Mouse Enter Interaction
        ConsoleTabButtonInteract.MouseEnter:Connect(function()
            CreateTween(ConsoleTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.75
            })
        end)

        -- Console Tab Button Mouse Leave Interaction
        ConsoleTabButtonInteract.MouseLeave:Connect(function()
            CreateTween(ConsoleTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.85
            })
        end)

        -- Console Tab Button Interact
        ConsoleTabButtonInteract.MouseButton1Down:Connect(function()
            local Tabs = TabsFolder:GetChildren()
            for Index, Tab in next, Tabs do
                if Tab:IsA("Frame") and Tab ~= ConsoleTab then
                    CreateTween(Tab, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 90, -1, -25)
                    })
                end
            end
            ConsoleTab.Position = UDim2.new(0, 90, 1, 25)
            CreateTween(ConsoleTab, 0.5, Enum.EasingStyle.Exponential, {
                Position = UDim2.new(0, 90, 0, 10)
            })
        end)

        local Console = {}

        -- Set Console Status Function
        function Console:SetConsoleStatus(ConsoleStatusProperties)

            -- Console Status Properties
            local Status = ConsoleStatusProperties.Status

            ConsoleStatusText.Text = Status
        end

        -- Create Console Alert Function
        function Console:CreateConsoleAlert(ConsoleAlertProperties)

            -- Console Alert Properties
            local RobberyLocation = ConsoleAlertProperties.RobberyLocation
            local RobberyStatus = ConsoleAlertProperties.RobberyStatus

            -- Robbery Location Icons
            local RobberyLocationIcons = {
                ["Powerplant"] = "rbxassetid://14291151729",
                ["Jewelery Store"] = "rbxassetid://14291198522",
                ["Bank"] = "rbxassetid://14291211915",
                ["Museum"] = "rbxassetid://14291182235",
                ["Casino"] = "rbxassetid://14291221227",
                ["Tomb"] = "rbxassetid://14291280449",
                ["Gas Station"] = "rbxassetid://14291294183",
                ["Donut Shop"] = "rbxassetid://14291308561",
                ["Airdrop"] = "rbxassetid://14291273841",
                ["Cargo Plane"] = "rbxassetid://14295690525",
                ["Cargo Ship"] = "rbxassetid://14295685103",
                ["Cargo Train"] = "rbxassetid://14295675152"
            }

            -- Console Alert
            local ConsoleAlert = Create("Frame", {
                Parent = ConsoleContainer,
                Name = "ConsoleAlert",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 30),
                Visible = true,
                ClipsDescendants = false
            })

            -- Console Alert UICorner
            local ConsoleAlert_UICorner = Create("UICorner", {
                Parent = ConsoleAlert,
                CornerRadius = UDim.new(0, 4)
            })

            -- Console Alert Icon
            local ConsoleAlertIcon = Create("ImageLabel", {
                Parent = ConsoleAlert,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 7, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 16, 0, 16),
                Visible = true,
                ClipsDescendants = false,
                Image = RobberyLocationIcons[RobberyLocation],
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            })

            -- Console Alert Text 
            local ConsoleAlertText = Create("TextLabel", {
                Parent = ConsoleAlert,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 30, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -30, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "[" .. RobberyLocation .. "]: " .. RobberyStatus,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        end
        return Console
    end
    -- Create Locations Tab Function
    function Window:CreateLocationsTab(LocationsTabProperties)

        -- Locations Tab Properties
        local LocationsTab_Name = LocationsTabProperties.Name
        local LocationsTab_Icon = LocationsTabProperties.Icon
        local FirstWindow = LocationsTabProperties.FirstWindow

        -- Locations Button Wrapper
        local LocationsTabButtonWrapper = Create("Frame", {
            Parent = TabButtonContainer,
            Name = "Wrapper",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Locations Tab Button Wrapper
        local LocationsTabButtonWrapper_UIListLayout = Create("UIListLayout", {
            Parent = LocationsTabButtonWrapper,
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Locations Button
        local LocationsTabButton = Create("Frame", {
            Parent = LocationsTabButtonWrapper,
            Name = "Button",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.85,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Locations Tab Button UICorner
        local LocationsTabButton_UICorner = Create("UICorner", {
            Parent = LocationsTabButton,
            CornerRadius = UDim.new(0, 6)
        })

        -- Locations Tab Button Interact
        local LocationsTabButtonInteract = Create("TextButton", {
            Parent = LocationsTabButton,
            Name = "Interact",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "",
            TextColor3 = ColorPalette.Black,
            TextSize = 0,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Locations Tab Button Icon
        local LocationsTabButtonIcon = Create("ImageLabel", {
            Parent = LocationsTabButton,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = false,
            Image = LocationsTab_Icon,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Locations Tab
        local LocationsTab = Create("Frame", {
            Parent = TabsFolder,
            Name = "Tab",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 90, -1, -25),
            Rotation = 0,
            Size = UDim2.new(1, -100, 1, -20),
            Visible = true,
            ClipsDescendants = true
        })

        -- First Window
        if FirstWindow then
            LocationsTab.Position = UDim2.new(0, 90, 0, 10)
        end

        -- Locations Tab UICorner
        local LocationsTab_UICorner = Create("UICorner", {
            Parent = LocationsTab,
            CornerRadius = UDim.new(0, 6)
        })

        -- Locations Container
        local LocationsContainer = Create("ScrollingFrame", {
            Parent = LocationsTab,
            Name = "LocationsContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = true,
            AutomaticCanvasSize = 2,
            CanvasPosition = Vector2.new(0, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarImageColor3 = ColorPalette.Black,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = true
        })

        -- Locations Container UIListLayout
        local LocationsContainer_UIListLayout = Create("UIListLayout", {
            Parent = LocationsContainer,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Locations Tab Button Mouse Enter Interaction
        LocationsTabButtonInteract.MouseEnter:Connect(function()
            CreateTween(LocationsTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.75
            })
        end)

        -- Locations Tab Button Mouse Leave Interaction
        LocationsTabButtonInteract.MouseLeave:Connect(function()
            CreateTween(LocationsTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.85
            })
        end)

        -- Location Tab Button Interact
        LocationsTabButtonInteract.MouseButton1Down:Connect(function()
            local Tabs = TabsFolder:GetChildren()
            for Index, Tab in next, Tabs do
                if Tab:IsA("Frame") then
                    CreateTween(Tab, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 90, -1, -25)
                    })
                end
            end
            LocationsTab.Position = UDim2.new(0, 90, 1, 25)
            CreateTween(LocationsTab, 0.5, Enum.EasingStyle.Exponential, {
                Position = UDim2.new(0, 90, 0, 10)
            })
        end)

        -- Locations
        local Locations = {}

        -- Create Locations Toggle Function
        function Locations:CreateToggle(ToggleProperties)

            -- Toggle Properties
            local Robbery_Location = ToggleProperties.RobberyLocation
            local Toggle_Value = ToggleProperties.RobberyToggle

            -- Robbery Location Icons
            local RobberyLocationIcons = {
                ["Powerplant"] = "rbxassetid://14291151729",
                ["Jewelery Store"] = "rbxassetid://14291198522",
                ["Bank"] = "rbxassetid://14291211915",
                ["Museum"] = "rbxassetid://14291182235",
                ["Casino"] = "rbxassetid://14291221227",
                ["Tomb"] = "rbxassetid://14291280449",
                ["Gas Station"] = "rbxassetid://14291294183",
                ["Donut Shop"] = "rbxassetid://14291308561",
                ["Airdrop"] = "rbxassetid://14291273841",
                ["Cargo Plane"] = "rbxassetid://14295690525",
                ["Cargo Ship"] = "rbxassetid://14295685103",
                ["Cargo Train"] = "rbxassetid://14295675152"
            }

            -- Toggle
            local Toggle = Create("Frame", {
                Parent = LocationsContainer,
                Name = "Toggle",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = true
            })

            -- Toggle UICorner
            local Toggle_UICorner = Create("UICorner", {
                Parent = Toggle,
                CornerRadius = UDim.new(0, 6)
            })

            -- Toggle Interact
            local ToggleInteract = Create("TextButton", {
                Parent = Toggle,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Toggle Icon
            local ToggleIcon = Create("ImageLabel", {
                Parent = Toggle,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 9, 0, 9),
                Rotation = 0,
                Size = UDim2.new(0, 16, 0, 16),
                Visible = true,
                ClipsDescendants = false,
                Image = RobberyLocationIcons[Robbery_Location],
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            })

            -- Toggle Text
            local ToggleText = Create("TextLabel", {
                Parent = Toggle,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 34, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -34, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Robbery_Location,
                TextColor3 = ColorPalette.White,
                TextSize = 16,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Toggle Box 
            local ToggleBox = Create("Frame", {
                Parent = Toggle,
                Name = "ToggleBox",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.DarkGray,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -47, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 40, 0, 20),
                Visible = true,
                ClipsDescendants = false
            })

            -- Toggle Box UICorner
            local ToggleBox_UICorner = Create("UICorner", {
                Parent = ToggleBox,
                CornerRadius = UDim.new(1, 0)
            })

            -- Toggle Ball 
            local ToggleBall = Create("Frame", {
                Parent = ToggleBox,
                Name = "ToggleBall",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 3, 0, 3),
                Rotation = 0,
                Size = UDim2.new(0, 14, 0, 14),
                Visible = true,
                ClipsDescendants = false
            })

            -- Toggle Ball UICorner
            local ToggleBall_UICorner = Create("UICorner", {
                Parent = ToggleBall,
                CornerRadius = UDim.new(1, 0)
            })

            -- Toggle Value Configuration
            if Toggle_Value then
                CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(1, -17, 0, 3)
                })
                CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                    BackgroundColor3 = ColorPalette.Blue
                })
            end

            -- Toggle Interaction
            ToggleInteract.MouseButton1Down:Connect(function()
                BubbleEffect(Toggle)
                if not Toggle_Value then
                    CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(1, -17, 0, 3)
                    })
                    CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                        BackgroundColor3 = ColorPalette.Blue
                    })
                    Toggle_Value = not Toggle_Value
                else
                    CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 3, 0, 3)
                    })
                    CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                        BackgroundColor3 = ColorPalette.DarkGray
                    })
                    Toggle_Value = not Toggle_Value
                end
                local Success, Error = pcall(function()
                    ToggleProperties.Callback(Toggle_Value)
                end)
                if not Success then
                    print("[Horizon Bar Error]: " .. Error)
                end
            end)

        end
        return Locations
    end

    -- Create Miscellaneous Tab Function
    function Window:CreateMiscellaneousTab(MiscellaneousTabProperties)

        -- Miscellaneous Tab Properties
        local MiscellaneousTab_Name = MiscellaneousTabProperties.Name
        local MiscellaneousTab_Icon = MiscellaneousTabProperties.Icon
        local FirstWindow = MiscellaneousTabProperties.FirstWindow

        -- Miscellaneous Button Wrapper
        local MiscellaneousTabButtonWrapper = Create("Frame", {
            Parent = TabButtonContainer,
            Name = "Wrapper",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Miscellaneous Tab Button Wrapper
        local MiscellaneousTabButtonWrapper_UIListLayout = Create("UIListLayout", {
            Parent = MiscellaneousTabButtonWrapper,
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Miscellaneous Button
        local MiscellaneousTabButton = Create("Frame", {
            Parent = MiscellaneousTabButtonWrapper,
            Name = "Button",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.85,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Miscellaneous Tab Button UICorner
        local MiscellaneousTabButton_UICorner = Create("UICorner", {
            Parent = MiscellaneousTabButton,
            CornerRadius = UDim.new(0, 6)
        })

        -- Miscellaneous Tab Button Interact
        local MiscellaneousTabButtonInteract = Create("TextButton", {
            Parent = MiscellaneousTabButton,
            Name = "Interact",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "",
            TextColor3 = ColorPalette.Black,
            TextSize = 0,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Miscellaneous Tab Button Icon
        local MiscellaneousTabButtonIcon = Create("ImageLabel", {
            Parent = MiscellaneousTabButton,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = false,
            Image = MiscellaneousTab_Icon,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Miscellaneous Tab
        local MiscellaneousTab = Create("Frame", {
            Parent = TabsFolder,
            Name = "Tab",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 90, -1, -25),
            Rotation = 0,
            Size = UDim2.new(1, -100, 1, -20),
            Visible = true,
            ClipsDescendants = true
        })

        -- First Window
        if FirstWindow then
            MiscellaneousTab.Position = UDim2.new(0, 90, 0, 10)
        end

        -- Miscellaneous Tab UICorner
        local MiscellaneousTab_UICorner = Create("UICorner", {
            Parent = MiscellaneousTab,
            CornerRadius = UDim.new(0, 6)
        })

        -- Miscellaneous Container
        local MiscellaneousContainer = Create("ScrollingFrame", {
            Parent = MiscellaneousTab,
            Name = "MiscellaneousContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = true,
            AutomaticCanvasSize = 2,
            CanvasPosition = Vector2.new(0, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarImageColor3 = ColorPalette.Black,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = true
        })

        -- Miscellaneous Container UIListLayout
        local MiscellaneousContainer_UIListLayout = Create("UIListLayout", {
            Parent = MiscellaneousContainer,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Miscellaneous  Tab Button Mouse Enter Interaction
        MiscellaneousTabButtonInteract.MouseEnter:Connect(function()
            CreateTween(MiscellaneousTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.75
            })
        end)

        -- Miscellaneous Tab Button Mouse Leave Interaction
        MiscellaneousTabButtonInteract.MouseLeave:Connect(function()
            CreateTween(MiscellaneousTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.85
            })
        end)

        -- Miscellaneous Tab Button Interact
        MiscellaneousTabButtonInteract.MouseButton1Down:Connect(function()
            local Tabs = TabsFolder:GetChildren()
            for Index, Tab in next, Tabs do
                if Tab:IsA("Frame") then
                    CreateTween(Tab, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 90, -1, -25)
                    })
                end
            end
            MiscellaneousTab.Position = UDim2.new(0, 90, 1, 25)
            CreateTween(MiscellaneousTab, 0.5, Enum.EasingStyle.Exponential, {
                Position = UDim2.new(0, 90, 0, 10)
            })
        end)

        -- Miscellaneous 
        local Miscellaneous = {}

        -- Create Miscellaneous Section Function
        function Miscellaneous:CreateSection(SectionProperties)

            -- Section Properties
            local Section_Name = SectionProperties.Name

            -- Section
            local Section = Create("Frame", {
                Parent = MiscellaneousContainer,
                Name = "Section",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 20),
                Visible = true,
                ClipsDescendants = false
            })

            -- Section Name
            local SectionName = Create("TextLabel", {
                Parent = Section,
                Name = "Name",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Section_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        end

        -- Create Miscellaneous Button Function
        function Miscellaneous:CreateButton(ButtonProperties)

            -- Button Properties
            local Button_Name = ButtonProperties.Name

            -- Button
            local Button = Create("Frame", {
                Parent = MiscellaneousContainer,
                Name = "Button",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = true
            })

            -- Button UICorner
            local Button_UICorner = Create("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 6)
            })

            -- Button Interact
            local ButtonInteract = Create("TextButton", {
                Parent = Button,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Button Text
            local ButtonText = Create("TextLabel", {
                Parent = Button,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -80, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Button_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Button Icon
            local ButtonIcon = Create("ImageLabel", {
                Parent = Button,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -27, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 20, 0, 20),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.Click,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            })

            -- Button Interaction
            ButtonInteract.MouseButton1Down:Connect(function()
                local Success, Error = pcall(function()
                    BubbleEffect(Button)
                    ButtonProperties.Callback()
                end)
                if not Success then
                    print("[Horizon Bar Error]: " .. Error)
                end
            end)
        end

        -- Create Miscellaneous Toggle Function
        function Miscellaneous:CreateToggle(ToggleProperties)

            -- Toggle Properties
            local Toggle_Name = ToggleProperties.Name
            local Toggle_Value = ToggleProperties.Value

            -- Toggle
            local Toggle = Create("Frame", {
                Parent = MiscellaneousContainer,
                Name = "Toggle",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = true
            })

            -- Toggle UICorner
            local Toggle_UICorner = Create("UICorner", {
                Parent = Toggle,
                CornerRadius = UDim.new(0, 6)
            })

            -- Toggle Interact
            local ToggleInteract = Create("TextButton", {
                Parent = Toggle,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Toggle Text
            local ToggleText = Create("TextLabel", {
                Parent = Toggle,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -80, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Toggle_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Toggle Box 
            local ToggleBox = Create("Frame", {
                Parent = Toggle,
                Name = "ToggleBox",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.DarkGray,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -47, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 40, 0, 20),
                Visible = true,
                ClipsDescendants = false
            })

            -- Toggle Box UICorner
            local ToggleBox_UICorner = Create("UICorner", {
                Parent = ToggleBox,
                CornerRadius = UDim.new(1, 0)
            })

            -- Toggle Ball 
            local ToggleBall = Create("Frame", {
                Parent = ToggleBox,
                Name = "ToggleBall",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 3, 0, 3),
                Rotation = 0,
                Size = UDim2.new(0, 14, 0, 14),
                Visible = true,
                ClipsDescendants = false
            })

            -- Toggle Ball UICorner
            local ToggleBall_UICorner = Create("UICorner", {
                Parent = ToggleBall,
                CornerRadius = UDim.new(1, 0)
            })

            -- Toggle Value Configuration
            if Toggle_Value then
                CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(1, -17, 0, 3)
                })
                CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                    BackgroundColor3 = ColorPalette.Blue
                })
            end

            -- Toggle Interaction
            ToggleInteract.MouseButton1Down:Connect(function()
                BubbleEffect(Toggle)
                if not Toggle_Value then
                    CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(1, -17, 0, 3)
                    })
                    CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                        BackgroundColor3 = ColorPalette.Blue
                    })
                    Toggle_Value = not Toggle_Value
                else
                    CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 3, 0, 3)
                    })
                    CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                        BackgroundColor3 = ColorPalette.DarkGray
                    })
                    Toggle_Value = not Toggle_Value
                end
                local Success, Error = pcall(function()
                    ToggleProperties.Callback(Toggle_Value)
                end)
                if not Success then
                    print("[Horizon Bar Error]: " .. Error)
                end
            end)
        end

        -- Create Miscellaneous Slider Function 
        function Miscellaneous:CreateSlider(SliderProperties)

            -- Slider Properties
            local Slider_Name = SliderProperties.Name
            local Slider_Max = SliderProperties.Max
            local Slider_Min = SliderProperties.Min
            local Slider_Increment = SliderProperties.Increment
            local Slider_DecimalPrecision = SliderProperties.DecimalPrecision
            local Slider_CurrentValue = SliderProperties.CurrentValue

            -- Slider
            local Slider = Create("Frame", {
                Parent = MiscellaneousContainer,
                Name = "Slider",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = false
            })

            -- Slider UICorner
            local Slider_UICorner = Create("UICorner", {
                Parent = Slider,
                CornerRadius = UDim.new(0, 6)
            })

            -- Slider Interact
            local SliderInteract = Create("TextButton", {
                Parent = Slider,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Slider Text
            local SliderText = Create("TextLabel", {
                Parent = Slider,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -160, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Slider_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Slider Container
            local SliderContainer = Create("Frame", {
                Parent = Slider,
                Name = "SliderContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.DarkGray,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -156, 0, 6),
                Rotation = 0,
                Size = UDim2.new(0, 150, 0, 22),
                Visible = true,
                ClipsDescendants = false
            })

            -- Slider Container UICorner
            local SliderContainer_UICorner = Create("UICorner", {
                Parent = SliderContainer,
                CornerRadius = UDim.new(0, 6)
            })

            -- Slider Progress
            local SliderProgress = Create("Frame", {
                Parent = SliderContainer,
                Name = "SliderProgress",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Blue,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0.8, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            })

            -- Slider Progress UICorner
            local SliderProgress_UICorner = Create("UICorner", {
                Parent = SliderProgress,
                CornerRadius = UDim.new(0, 6)
            })

            -- Slider Container Text
            local SliderContainerText = Create("TextLabel", {
                Parent = SliderContainer,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Slider_CurrentValue,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            local Slider_Dragging = false

            -- Slider Input Began
            UserInputService.InputBegan:Connect(function(Input, GameProcessed)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local MousePosition = UserInputService:GetMouseLocation()
                    local MousePositionX = MousePosition.X
                    local MousePositionY = MousePosition.Y - 36
                    if MousePositionX >= SliderInteract.AbsolutePosition.X and MousePositionX <=
                        SliderInteract.AbsolutePosition.X + SliderInteract.AbsoluteSize.X and MousePositionY >=
                        SliderInteract.AbsolutePosition.Y and MousePositionY <= SliderInteract.AbsolutePosition.Y +
                        SliderInteract.AbsoluteSize.Y then
                        Slider_Dragging = true
                        CreateTween(SliderText, 0.5, Enum.EasingStyle.Exponential, {
                            Position = UDim2.new(-1, 0, 0, 0)
                        })
                        CreateTween(SliderContainer, 0.5, Enum.EasingStyle.Exponential, {
                            Position = UDim2.new(0, 6, 0, 6),
                            Size = UDim2.new(1, -12, 0, 22)
                        })
                    end
                end
            end)

            -- Slider Input Ended
            UserInputService.InputEnded:Connect(function(Input, GameProcessed)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Slider_Dragging = false
                    CreateTween(SliderText, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 10, 0, 0)
                    })
                    CreateTween(SliderContainer, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(1, -156, 0, 6),
                        Size = UDim2.new(0, 150, 0, 22)
                    })
                end
            end)

            -- Slider Function
            RunService.RenderStepped:Connect(function()
                if Slider_Dragging then
                    local MousePosition = UserInputService:GetMouseLocation()
                    local MousePositionX = MousePosition.X
                    local Value = math.clamp((MousePositionX - SliderInteract.AbsolutePosition.X) /
                                                 SliderInteract.AbsoluteSize.X, 0, 1)
                    local RoundedValue = math.round(Value * (Slider_Max - Slider_Min) / Slider_Increment) *
                                             Slider_Increment + Slider_Min
                    CreateTween(SliderProgress, 1, Enum.EasingStyle.Quint, {
                        Size = UDim2.new(Value, 0, 1, 0)
                    })
                    local FinalValue = tostring(string.format("%." .. Slider_DecimalPrecision .. "f", RoundedValue))
                    SliderContainerText.Text = FinalValue
                    local Success, Error = pcall(function()
                        SliderProperties.Callback(FinalValue)
                    end)
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end
            end)
        end

        -- Create Miscellaneous Guns Dropdown Function
        function Miscellaneous:CreateGunsDropdown(DropdownProperties)

            -- Dropdown Properties
            local Dropdown_Name = DropdownProperties.Name

            -- Guns
            local Guns = {"Pistol", "Shotgun", "AK47", "Uzi"}

            local GunIcons = {
                ["Pistol"] = "rbxassetid://14297605870",
                ["Shotgun"] = "rbxassetid://14297619072",
                ["AK47"] = "rbxassetid://14297611499",
                ["Uzi"] = "rbxassetid://14297635091"
            }

            -- Dropdown
            local Dropdown = Create("Frame", {
                Parent = MiscellaneousContainer,
                Name = "Dropdown",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = true
            })

            -- Dropdown UICorner
            local Dropdown_UICorner = Create("UICorner", {
                Parent = Dropdown,
                CornerRadius = UDim.new(0, 6)
            })

            -- Dropdown Interact
            local DropdownInteract = Create("TextButton", {
                Parent = Dropdown,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Dropdown Text
            local DropdownText = Create("TextLabel", {
                Parent = Dropdown,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -80, 0, 34),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Dropdown_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Dropdown Icon
            local DropdownIcon = Create("ImageLabel", {
                Parent = Dropdown,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -27, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 20, 0, 20),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.DownArrowHead,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            })

            -- Dropdown Container
            local DropdownContainer = Create("Frame", {
                Parent = Dropdown,
                Name = "DropdownContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 34),
                Rotation = 0,
                Size = UDim2.new(1, -20, 1, -34),
                Visible = false,
                ClipsDescendants = true
            })

            -- Dropdown Container UIListLayout
            local DropdownContainer_UIListLayout = Create("UIListLayout", {
                Parent = DropdownContainer,
                Padding = UDim.new(0, 11),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            local Dropdown_Status = false

            -- Dropdown Interaction
            DropdownInteract.MouseButton1Down:Connect(function()
                BubbleEffect(Dropdown)
                if not Dropdown_Status then
                    CreateTween(Dropdown, 0.5, Enum.EasingStyle.Exponential, {
                        Size = UDim2.new(1, 0, 0, 135)
                    })
                    CreateTween(DropdownIcon, 0.5, Enum.EasingStyle.Exponential, {
                        Rotation = 180
                    })
                    DropdownContainer.Visible = true
                    Dropdown_Status = not Dropdown_Status
                else
                    DropdownContainer.Visible = false
                    CreateTween(Dropdown, 0.5, Enum.EasingStyle.Exponential, {
                        Size = UDim2.new(1, 0, 0, 34)
                    })
                    CreateTween(DropdownIcon, 0.5, Enum.EasingStyle.Exponential, {
                        Rotation = 0
                    })
                    Dropdown_Status = not Dropdown_Status
                end
            end)

            for Index, Gun in next, Guns do

                -- Gun Option
                local GunOption = Create("Frame", {
                    Parent = DropdownContainer,
                    Name = "Gun",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 0.9,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(0, 82, 0, 82),
                    Visible = true,
                    ClipsDescendants = true
                })

                -- Gun Option UICorner
                local GunOption_UICorner = Create("UICorner", {
                    Parent = GunOption,
                    CornerRadius = UDim.new(0, 6)
                })

                -- Gun Option Icon
                local GunOptionIcon = Create("ImageLabel", {
                    Parent = GunOption,
                    Name = "Icon",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 20, 0, 20),
                    Rotation = 0,
                    Size = UDim2.new(1, -40, 1, -40),
                    Visible = true,
                    ClipsDescendants = false,
                    Image = GunIcons[Gun],
                    ImageColor3 = ColorPalette.White,
                    ImageTransparency = 0,
                    ScaleType = Enum.ScaleType.Stretch
                })

                -- Gun Option Interact
                local GunOptionInteract = Create("TextButton", {
                    Parent = GunOption,
                    Name = "Interact",
                    AnchorPoint = Vector2.new(0, 0),
                    AutomaticSize = Enum.AutomaticSize.None,
                    BackgroundColor3 = ColorPalette.White,
                    BackgroundTransparency = 1,
                    BorderColor3 = ColorPalette.Black,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Rotation = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = true,
                    ClipsDescendants = false,
                    FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                    Text = "",
                    TextColor3 = ColorPalette.Black,
                    TextSize = 0,
                    TextStrokeColor3 = ColorPalette.Black,
                    TextStrokeTransparency = 1,
                    TextTransparency = 0,
                    TextTruncate = Enum.TextTruncate.None,
                    TextWrapped = false,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                })

                -- Gun Option Interaction
                GunOptionInteract.MouseButton1Down:Connect(function()
                    CreateTween(GunOption, 0.2, Enum.EasingStyle.Exponential, {
                        BackgroundTransparency = 0.7
                    })
                    delay(0.2, function()
                        CreateTween(GunOption, 0.2, Enum.EasingStyle.Exponential, {
                            BackgroundTransparency = 0.9
                        })
                    end)
                    local Success, Error = pcall(function()
                        DropdownProperties.Callback(Gun)
                    end)
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end)
            end
        end
        return Miscellaneous
    end

    -- Create Settings Tab Function
    function Window:CreateSettingsTab(SettingsTabProperties)

        -- Settings Tab Properties
        local SettingsTab_Name = SettingsTabProperties.Name
        local SettingsTab_Icon = SettingsTabProperties.Icon
        local FirstWindow = SettingsTabProperties.FirstWindow

        -- Settings Button Wrapper
        local SettingsTabButtonWrapper = Create("Frame", {
            Parent = TabButtonContainer,
            Name = "Wrapper",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Settings Tab Button Wrapper
        local SettingsTabButtonWrapper_UIListLayout = Create("UIListLayout", {
            Parent = SettingsTabButtonWrapper,
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Settings Button
        local SettingsTabButton = Create("Frame", {
            Parent = SettingsTabButtonWrapper,
            Name = "Button",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.85,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- Settings Tab Button UICorner
        local SettingsTabButton_UICorner = Create("UICorner", {
            Parent = SettingsTabButton,
            CornerRadius = UDim.new(0, 6)
        })

        -- Settings Tab Button Interact
        local SettingsTabButtonInteract = Create("TextButton", {
            Parent = SettingsTabButton,
            Name = "Interact",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "",
            TextColor3 = ColorPalette.Black,
            TextSize = 0,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Settings Tab Button Icon
        local SettingsTabButtonIcon = Create("ImageLabel", {
            Parent = SettingsTabButton,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = false,
            Image = SettingsTab_Icon,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Settings Tab
        local SettingsTab = Create("Frame", {
            Parent = TabsFolder,
            Name = "Tab",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 90, -1, -25),
            Rotation = 0,
            Size = UDim2.new(1, -100, 1, -20),
            Visible = true,
            ClipsDescendants = true
        })

        -- First Window
        if FirstWindow then
            SettingsTab.Position = UDim2.new(0, 90, 0, 10)
        end

        -- Settings Tab UICorner
        local SettingsTab_UICorner = Create("UICorner", {
            Parent = SettingsTab,
            CornerRadius = UDim.new(0, 6)
        })

        -- Settings Container
        local SettingsContainer = Create("ScrollingFrame", {
            Parent = SettingsTab,
            Name = "SettingsContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = true,
            AutomaticCanvasSize = 2,
            CanvasPosition = Vector2.new(0, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarImageColor3 = ColorPalette.Black,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = true
        })

        -- Settings Container UIListLayout
        local SettingsContainer_UIListLayout = Create("UIListLayout", {
            Parent = SettingsContainer,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Settings Tab Button Mouse Enter Interaction
        SettingsTabButtonInteract.MouseEnter:Connect(function()
            CreateTween(SettingsTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.75
            })
        end)

        -- Settings Tab Button Mouse Leave Interaction
        SettingsTabButtonInteract.MouseLeave:Connect(function()
            CreateTween(SettingsTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.85
            })
        end)

        -- Settings Tab Button Interact
        SettingsTabButtonInteract.MouseButton1Down:Connect(function()
            local Tabs = TabsFolder:GetChildren()
            for Index, Tab in next, Tabs do
                if Tab:IsA("Frame") then
                    CreateTween(Tab, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 90, -1, -25)
                    })
                end
            end
            SettingsTab.Position = UDim2.new(0, 90, 1, 25)
            CreateTween(SettingsTab, 0.5, Enum.EasingStyle.Exponential, {
                Position = UDim2.new(0, 90, 0, 10)
            })
        end)

        -- Settings
        local Settings = {}

        -- Create Settings Section Function
        function Settings:CreateSection(SectionProperties)

            -- Section Properties
            local Section_Name = SectionProperties.Name

            -- Section
            local Section = Create("Frame", {
                Parent = SettingsContainer,
                Name = "Section",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 20),
                Visible = true,
                ClipsDescendants = false
            })

            -- Section Name
            local SectionName = Create("TextLabel", {
                Parent = Section,
                Name = "Name",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Section_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        end

        -- Create Settings Button Function
        function Settings:CreateButton(ButtonProperties)

            -- Button Properties
            local Button_Name = ButtonProperties.Name

            -- Button
            local Button = Create("Frame", {
                Parent = SettingsContainer,
                Name = "Button",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = true
            })

            -- Button UICorner
            local Button_UICorner = Create("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 6)
            })

            -- Button Interact
            local ButtonInteract = Create("TextButton", {
                Parent = Button,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Button Text
            local ButtonText = Create("TextLabel", {
                Parent = Button,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -80, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Button_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Button Icon
            local ButtonIcon = Create("ImageLabel", {
                Parent = Button,
                Name = "Icon",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -27, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 20, 0, 20),
                Visible = true,
                ClipsDescendants = false,
                Image = Storage.Icons.Click,
                ImageColor3 = ColorPalette.White,
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Stretch
            })

            -- Button Interaction
            ButtonInteract.MouseButton1Down:Connect(function()
                local Success, Error = pcall(function()
                    BubbleEffect(Button)
                    ButtonProperties.Callback()
                end)
                if not Success then
                    print("[Horizon Bar Error]: " .. Error)
                end
            end)
        end

        -- Create Settings Toggle Function
        function Settings:CreateToggle(ToggleProperties)

            -- Toggle Properties
            local Toggle_Name = ToggleProperties.Name
            local Toggle_Value = ToggleProperties.Value

            -- Toggle
            local Toggle = Create("Frame", {
                Parent = SettingsContainer,
                Name = "Toggle",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = true
            })

            -- Toggle UICorner
            local Toggle_UICorner = Create("UICorner", {
                Parent = Toggle,
                CornerRadius = UDim.new(0, 6)
            })

            -- Toggle Interact
            local ToggleInteract = Create("TextButton", {
                Parent = Toggle,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Toggle Text
            local ToggleText = Create("TextLabel", {
                Parent = Toggle,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -80, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Toggle_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Toggle Box 
            local ToggleBox = Create("Frame", {
                Parent = Toggle,
                Name = "ToggleBox",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.DarkGray,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -47, 0, 7),
                Rotation = 0,
                Size = UDim2.new(0, 40, 0, 20),
                Visible = true,
                ClipsDescendants = false
            })

            -- Toggle Box UICorner
            local ToggleBox_UICorner = Create("UICorner", {
                Parent = ToggleBox,
                CornerRadius = UDim.new(1, 0)
            })

            -- Toggle Ball 
            local ToggleBall = Create("Frame", {
                Parent = ToggleBox,
                Name = "ToggleBall",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 3, 0, 3),
                Rotation = 0,
                Size = UDim2.new(0, 14, 0, 14),
                Visible = true,
                ClipsDescendants = false
            })

            -- Toggle Ball UICorner
            local ToggleBall_UICorner = Create("UICorner", {
                Parent = ToggleBall,
                CornerRadius = UDim.new(1, 0)
            })

            -- Toggle Value Configuration
            if Toggle_Value then
                CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(1, -17, 0, 3)
                })
                CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                    BackgroundColor3 = ColorPalette.Blue
                })
            end

            -- Toggle Interaction
            ToggleInteract.MouseButton1Down:Connect(function()
                BubbleEffect(Toggle)
                if not Toggle_Value then
                    CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(1, -17, 0, 3)
                    })
                    CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                        BackgroundColor3 = ColorPalette.Blue
                    })
                    Toggle_Value = not Toggle_Value
                else
                    CreateTween(ToggleBall, 0.25, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 3, 0, 3)
                    })
                    CreateTween(ToggleBox, 0.25, Enum.EasingStyle.Exponential, {
                        BackgroundColor3 = ColorPalette.DarkGray
                    })
                    Toggle_Value = not Toggle_Value
                end
                local Success, Error = pcall(function()
                    ToggleProperties.Callback(Toggle_Value)
                end)
                if not Success then
                    print("[Horizon Bar Error]: " .. Error)
                end
            end)
        end

        -- Create Settings Slider Function
        function Settings:CreateSlider(SliderProperties)

            -- Slider Properties
            local Slider_Name = SliderProperties.Name
            local Slider_Max = SliderProperties.Max
            local Slider_Min = SliderProperties.Min
            local Slider_Increment = SliderProperties.Increment
            local Slider_DecimalPrecision = SliderProperties.DecimalPrecision
            local Slider_CurrentValue = SliderProperties.CurrentValue

            -- Slider
            local Slider = Create("Frame", {
                Parent = SettingsContainer,
                Name = "Slider",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = false
            })

            -- Slider UICorner
            local Slider_UICorner = Create("UICorner", {
                Parent = Slider,
                CornerRadius = UDim.new(0, 6)
            })

            -- Slider Interact
            local SliderInteract = Create("TextButton", {
                Parent = Slider,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Slider Text
            local SliderText = Create("TextLabel", {
                Parent = Slider,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -160, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Slider_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Slider Container
            local SliderContainer = Create("Frame", {
                Parent = Slider,
                Name = "SliderContainer",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.DarkGray,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -156, 0, 6),
                Rotation = 0,
                Size = UDim2.new(0, 150, 0, 22),
                Visible = true,
                ClipsDescendants = false
            })

            -- Slider Container UICorner
            local SliderContainer_UICorner = Create("UICorner", {
                Parent = SliderContainer,
                CornerRadius = UDim.new(0, 6)
            })

            -- Slider Progress
            local SliderProgress = Create("Frame", {
                Parent = SliderContainer,
                Name = "SliderProgress",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.Blue,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(0.8, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false
            })

            -- Slider Progress UICorner
            local SliderProgress_UICorner = Create("UICorner", {
                Parent = SliderProgress,
                CornerRadius = UDim.new(0, 6)
            })

            -- Slider Container Text
            local SliderContainerText = Create("TextLabel", {
                Parent = SliderContainer,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Slider_CurrentValue,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            local Slider_Dragging = false

            -- Slider Input Began
            UserInputService.InputBegan:Connect(function(Input, GameProcessed)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local MousePosition = UserInputService:GetMouseLocation()
                    local MousePositionX = MousePosition.X
                    local MousePositionY = MousePosition.Y - 36
                    if MousePositionX >= SliderInteract.AbsolutePosition.X and MousePositionX <=
                        SliderInteract.AbsolutePosition.X + SliderInteract.AbsoluteSize.X and MousePositionY >=
                        SliderInteract.AbsolutePosition.Y and MousePositionY <= SliderInteract.AbsolutePosition.Y +
                        SliderInteract.AbsoluteSize.Y then
                        Slider_Dragging = true
                        CreateTween(SliderText, 0.5, Enum.EasingStyle.Exponential, {
                            Position = UDim2.new(-1, 0, 0, 0)
                        })
                        CreateTween(SliderContainer, 0.5, Enum.EasingStyle.Exponential, {
                            Position = UDim2.new(0, 6, 0, 6),
                            Size = UDim2.new(1, -12, 0, 22)
                        })
                    end
                end
            end)

            -- Slider Input Ended
            UserInputService.InputEnded:Connect(function(Input, GameProcessed)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Slider_Dragging = false
                    CreateTween(SliderText, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 10, 0, 0)
                    })
                    CreateTween(SliderContainer, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(1, -156, 0, 6),
                        Size = UDim2.new(0, 150, 0, 22)
                    })
                end
            end)

            -- Slider Function
            RunService.RenderStepped:Connect(function()
                if Slider_Dragging then
                    local MousePosition = UserInputService:GetMouseLocation()
                    local MousePositionX = MousePosition.X
                    local Value = math.clamp((MousePositionX - SliderInteract.AbsolutePosition.X) /
                                                 SliderInteract.AbsoluteSize.X, 0, 1)
                    local RoundedValue = math.round(Value * (Slider_Max - Slider_Min) / Slider_Increment) *
                                             Slider_Increment + Slider_Min
                    CreateTween(SliderProgress, 1, Enum.EasingStyle.Quint, {
                        Size = UDim2.new(Value, 0, 1, 0)
                    })
                    local FinalValue = tostring(string.format("%." .. Slider_DecimalPrecision .. "f", RoundedValue))
                    SliderContainerText.Text = FinalValue
                    local Success, Error = pcall(function()
                        SliderProperties.Callback(FinalValue)
                    end)
                    if not Success then
                        print("[Horizon Bar Error]: " .. Error)
                    end
                end
            end)
        end

        -- Create Settings Input Function 
        function Settings:CreateInput(InputProperties)

            -- Input Properties
            local Input_Name = InputProperties.Name
            local Input_PlaceholderText = InputProperties.PlaceholderText

            -- Input
            local Input = Create("Frame", {
                Parent = SettingsContainer,
                Name = "Input",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.85,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 34),
                Visible = true,
                ClipsDescendants = false
            })

            -- Input UICorner
            local Input_UICorner = Create("UICorner", {
                Parent = Input,
                CornerRadius = UDim.new(0, 6)
            })

            -- Input Interact
            local InputInteract = Create("TextButton", {
                Parent = Input,
                Name = "Interact",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = "",
                TextColor3 = ColorPalette.Black,
                TextSize = 0,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Input Text
            local InputText = Create("TextLabel", {
                Parent = Input,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, -160, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = Input_Name,
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Input Box
            local InputBox = Create("TextBox", {
                Parent = Input,
                Name = "InputBox",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.DarkGray,
                BackgroundTransparency = 0,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(1, -156, 0, 6),
                Rotation = 0,
                Size = UDim2.new(0, 150, 0, 22),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Medium),
                PlaceholderText = Input_PlaceholderText,
                PlaceholderColor3 = ColorPalette.Gray,
                Text = "",
                TextColor3 = ColorPalette.White,
                TextSize = 14,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })

            -- Input Box UICorner
            local InputBox_UICorner = Create("UICorner", {
                Parent = InputBox,
                CornerRadius = UDim.new(0, 6)
            })

            -- Input Box Focused
            InputBox.Focused:Connect(function()
                CreateTween(InputText, 0.5, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(-1, 0, 0, 0)
                })
                CreateTween(InputBox, 0.5, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(0, 6, 0, 6),
                    Size = UDim2.new(1, -12, 0, 22)
                })
            end)

            -- Input Box Focus Lost
            InputBox.FocusLost:Connect(function()
                CreateTween(InputText, 0.5, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(0, 10, 0, 0)
                })
                CreateTween(InputBox, 0.5, Enum.EasingStyle.Exponential, {
                    Position = UDim2.new(1, -156, 0, 6),
                    Size = UDim2.new(0, 150, 0, 22)
                })
                local Success, Error = pcall(function()
                    InputProperties.Callback(InputBox.Text)
                end)
                if not Success then
                    print("[Horizon Bar Error]: " .. Error)
                end
            end)

        end
        return Settings
    end

    -- Create User Tab Function
    function Window:CreateUserTab(UserTabProperties)

        -- User Tab Properties
        local UserTab_Name = UserTabProperties.Name
        local UserTab_Icon = UserTabProperties.Icon
        local FirstWindow = UserTabProperties.FirstWindow

        -- User Button Wrapper
        local UserTabButtonWrapper = Create("Frame", {
            Parent = TabButtonContainer,
            Name = "Wrapper",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- User Tab Button Wrapper
        local UserTabButtonWrapper_UIListLayout = Create("UIListLayout", {
            Parent = UserTabButtonWrapper,
            Padding = UDim.new(0, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- User Button
        local UserTabButton = Create("Frame", {
            Parent = UserTabButtonWrapper,
            Name = "Button",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.85,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 54, 0, 54),
            Visible = true,
            ClipsDescendants = false
        })

        -- User Tab Button UICorner
        local UserTabButton_UICorner = Create("UICorner", {
            Parent = UserTabButton,
            CornerRadius = UDim.new(0, 6)
        })

        -- User Tab Button Interact
        local UserTabButtonInteract = Create("TextButton", {
            Parent = UserTabButton,
            Name = "Interact",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "",
            TextColor3 = ColorPalette.Black,
            TextSize = 0,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- User Tab Button Icon
        local UserTabButtonIcon = Create("ImageLabel", {
            Parent = UserTabButton,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -20),
            Visible = true,
            ClipsDescendants = false,
            Image = UserTab_Icon,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- User Tab
        local UserTab = Create("Frame", {
            Parent = TabsFolder,
            Name = "Tab",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 90, -1, -25),
            Rotation = 0,
            Size = UDim2.new(1, -100, 1, -20),
            Visible = true,
            ClipsDescendants = true
        })

        -- First Window
        if FirstWindow then
            UserTab.Position = UDim2.new(0, 90, 0, 10)
        end

        -- User Tab UICorner
        local UserTab_UICorner = Create("UICorner", {
            Parent = UserTab,
            CornerRadius = UDim.new(0, 6)
        })

        -- User Profile
        local UserProfile = Create("Frame", {
            Parent = UserTab,
            Name = "UserProfile",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10),
            Rotation = 0,
            Size = UDim2.new(1, -20, 0, 130),
            Visible = true,
            ClipsDescendants = false
        })

        -- User Profile UICorner
        local UserProfile_UICorner = Create("UICorner", {
            Parent = UserProfile,
            CornerRadius = UDim.new(0, 6)
        })

        -- User PFP
        local UserPFP = Create("ImageLabel", {
            Parent = UserProfile,
            Name = "PFP",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.Black,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 15, 0, 15),
            Rotation = 0,
            Size = UDim2.new(0, 100, 0, 100),
            Visible = true,
            ClipsDescendants = false,
            Image = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size420x420),
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- User PFP UICorner
        local UserPFP_UICorner = Create("UICorner", {
            Parent = UserPFP,
            CornerRadius = UDim.new(1, 0)
        })

        -- Username
        local Username = Create("TextLabel", {
            Parent = UserProfile,
            Name = "Username",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, -50, 0, 30),
            Rotation = 0,
            Size = UDim2.new(0, 225, 0, 25),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = Players.LocalPlayer.Name,
            TextColor3 = ColorPalette.White,
            TextSize = 22,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Display Name
        local DisplayName = Create("TextLabel", {
            Parent = UserProfile,
            Name = "DisplayName",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, -50, 0, 50),
            Rotation = 0,
            Size = UDim2.new(0, 225, 0, 25),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "@" .. Players.LocalPlayer.DisplayName,
            TextColor3 = ColorPalette.Gray,
            TextSize = 16,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- User Whitelist Status
        local UserWhitelistStatus = Create("Frame", {
            Parent = UserProfile,
            Name = "UserWhitelistStatus",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, -50, 0, 80),
            Rotation = 0,
            Size = UDim2.new(0, 110, 0, 30),
            Visible = true,
            ClipsDescendants = false
        })

        -- User Whitelist Status UICorner
        local UserWhitelistStatus_UICorner = Create("UICorner", {
            Parent = UserWhitelistStatus,
            CornerRadius = UDim.new(0, 6)
        })

        -- User Whitelist Status UIGradient
        local UserWhitelistStatus_UIGradient = Create("UIGradient", {
            Parent = UserWhitelistStatus,
            Rotation = 0,
            Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 189, 0)),
                                       ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 135, 0))}
        })

        -- User Whitelist Status Icon
        local UserWhitelistStatusIcon = Create("ImageLabel", {
            Parent = UserWhitelistStatus,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 5),
            Rotation = 0,
            Size = UDim2.new(0, 20, 0, 20),
            Visible = true,
            ClipsDescendants = false,
            Image = Storage.Icons.WhitelistStatus,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- User Whitelist Status Text
        local UserWhitelistStatusText = Create("TextLabel", {
            Parent = UserWhitelistStatus,
            Name = "Text",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 30, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, -30, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "PREMIUM",
            TextColor3 = ColorPalette.White,
            TextSize = 14,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Robbery Stats Container
        local RobberyStatsContainer = Create("Frame", {
            Parent = UserTab,
            Name = "RobberyStatsContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 150),
            Rotation = 0,
            Size = UDim2.new(1, -20, 0, 40),
            Visible = true,
            ClipsDescendants = false
        })

        -- Robbery Stats Container UIListLayout
        local RobberyStatsContainer_UIListLayout = Create("UIListLayout", {
            Parent = RobberyStatsContainer,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Execution Stats
        local ExecutionStats = Create("Frame", {
            Parent = RobberyStatsContainer,
            Name = "ExecutionStats",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 120, 1, 0),
            Visible = true,
            ClipsDescendants = false
        })

        -- Execution Stats UICorner
        local ExecutionStats_UICorner = Create("UICorner", {
            Parent = ExecutionStats,
            CornerRadius = UDim.new(0, 6)
        })

        -- Execution Stats Icon
        local ExecutionStatsIcon = Create("ImageLabel", {
            Parent = ExecutionStats,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 9, 0, 9),
            Rotation = 0,
            Size = UDim2.new(0, 22, 0, 22),
            Visible = true,
            ClipsDescendants = false,
            Image = Storage.Icons.Execution,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Execution Stats Text
        local ExecutionStatsText = Create("TextLabel", {
            Parent = ExecutionStats,
            Name = "Text",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 40, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, -40, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "0000",
            TextColor3 = ColorPalette.White,
            TextSize = 16,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Money Stats
        local MoneyStats = Create("Frame", {
            Parent = RobberyStatsContainer,
            Name = "MoneyStats",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 120, 1, 0),
            Visible = true,
            ClipsDescendants = false
        })

        -- Money Stats UICorner
        local MoneyStats_UICorner = Create("UICorner", {
            Parent = MoneyStats,
            CornerRadius = UDim.new(0, 6)
        })

        -- Money Stats Icon
        local MoneyStatsIcon = Create("ImageLabel", {
            Parent = MoneyStats,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 9, 0, 9),
            Rotation = 0,
            Size = UDim2.new(0, 22, 0, 22),
            Visible = true,
            ClipsDescendants = false,
            Image = Storage.Icons.Money,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Money Stats Text
        local MoneyStatsText = Create("TextLabel", {
            Parent = MoneyStats,
            Name = "Text",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 40, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, -40, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "0000",
            TextColor3 = ColorPalette.White,
            TextSize = 16,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Time Stats
        local TimeStats = Create("Frame", {
            Parent = RobberyStatsContainer,
            Name = "TimeStats",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(0, 120, 1, 0),
            Visible = true,
            ClipsDescendants = false
        })

        -- Time Stats UICorner
        local TimeStats_UICorner = Create("UICorner", {
            Parent = TimeStats,
            CornerRadius = UDim.new(0, 6)
        })

        -- Time Stats Icon
        local TimeStatsIcon = Create("ImageLabel", {
            Parent = TimeStats,
            Name = "Icon",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 9, 0, 9),
            Rotation = 0,
            Size = UDim2.new(0, 22, 0, 22),
            Visible = true,
            ClipsDescendants = false,
            Image = Storage.Icons.Time,
            ImageColor3 = ColorPalette.White,
            ImageTransparency = 0,
            ScaleType = Enum.ScaleType.Stretch
        })

        -- Time Stats Text
        local TimeStatsText = Create("TextLabel", {
            Parent = TimeStats,
            Name = "Text",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 40, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, -40, 1, 0),
            Visible = true,
            ClipsDescendants = false,
            FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
            Text = "0000",
            TextColor3 = ColorPalette.White,
            TextSize = 16,
            TextStrokeColor3 = ColorPalette.Black,
            TextStrokeTransparency = 1,
            TextTransparency = 0,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        })

        -- Credits 
        local Credits = Create("Frame", {
            Parent = UserTab,
            Name = "Credits",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 0.9,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 200),
            Rotation = 0,
            Size = UDim2.new(1, -20, 1, -210),
            Visible = true,
            ClipsDescendants = false
        })

        -- Credits UICorner
        local Credits_UICorner = Create("UICorner", {
            Parent = Credits,
            CornerRadius = UDim.new(0, 6)
        })

        -- Credits Container
        local CreditsContainer = Create("ScrollingFrame", {
            Parent = Credits,
            Name = "CreditsContainer",
            AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = ColorPalette.White,
            BackgroundTransparency = 1,
            BorderColor3 = ColorPalette.Black,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Rotation = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            ClipsDescendants = true,
            AutomaticCanvasSize = 2,
            CanvasPosition = Vector2.new(0, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarImageColor3 = ColorPalette.Black,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = true
        })

        -- Credits Container UIListLayout
        local CreditsContainer_UIListLayout = Create("UIListLayout", {
            Parent = CreditsContainer,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        -- Credits Container UIPadding
        local CreditsContainer_UIPadding = Create("UIPadding", {
            Parent = CreditsContainer,
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10)
        })

        -- User Tab Button Mouse Enter Interaction
        UserTabButtonInteract.MouseEnter:Connect(function()
            CreateTween(UserTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.75
            })
        end)

        -- User Tab Button Mouse Leave Interaction
        UserTabButtonInteract.MouseLeave:Connect(function()
            CreateTween(UserTabButton, 0.5, Enum.EasingStyle.Exponential, {
                BackgroundTransparency = 0.85
            })
        end)

        -- User Tab Button Interact
        UserTabButtonInteract.MouseButton1Down:Connect(function()
            local Tabs = TabsFolder:GetChildren()
            for Index, Tab in next, Tabs do
                if Tab:IsA("Frame") then
                    CreateTween(Tab, 0.5, Enum.EasingStyle.Exponential, {
                        Position = UDim2.new(0, 90, -1, -25)
                    })
                end
            end
            UserTab.Position = UDim2.new(0, 90, 1, 25)
            CreateTween(UserTab, 0.5, Enum.EasingStyle.Exponential, {
                Position = UDim2.new(0, 90, 0, 10)
            })
        end)

        local User = {}

        -- Create New Credit Function
        function User:CreateCredit(CreditProperties)

            -- Credit Properties
            local CreditText = CreditProperties.Text

            -- User Credits
            local UserCredits = Create("Frame", {
                Parent = CreditsContainer,
                Name = "UserCredits",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 0.9,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 0, 38),
                Visible = true,
                ClipsDescendants = false
            })

            -- User Credits UICorner
            local UserCredits_UICorner = Create("UICorner", {
                Parent = UserCredits,
                CornerRadius = UDim.new(0, 6)
            })

            -- User Credits Text
            local userCreditsText = Create("TextLabel", {
                Parent = UserCredits,
                Name = "Text",
                AnchorPoint = Vector2.new(0, 0),
                AutomaticSize = Enum.AutomaticSize.None,
                BackgroundColor3 = ColorPalette.White,
                BackgroundTransparency = 1,
                BorderColor3 = ColorPalette.Black,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Rotation = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = true,
                ClipsDescendants = false,
                FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold),
                Text = CreditText,
                TextColor3 = ColorPalette.White,
                TextSize = 16,
                TextStrokeColor3 = ColorPalette.Black,
                TextStrokeTransparency = 1,
                TextTransparency = 0,
                TextTruncate = Enum.TextTruncate.None,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        end

        -- Set User Script Execution Text
        function User:SetExecutionText(ExecutionTextProperties)
            -- Text
            local Text = ExecutionTextProperties.Text
            -- Setting Text
            ExecutionStatsText.Text = Text
        end

        -- Set User Money Text
        function User:SetMoneyText(MoneyTextProperties)
            -- Text
            local Text = MoneyTextProperties.Text
            -- Setting Text
            MoneyStatsText.Text = Text
        end

        -- Set User Time Elapsed Text
        function User:SetTimeText(TimeTextProperties)
            -- Text
            local Text = TimeTextProperties.Text
            -- Setting Text
            TimeStatsText.Text = Text
        end

        return User
    end
    return Window
end
return HorizonBarLibrary
