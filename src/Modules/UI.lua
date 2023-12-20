--[[
    Tower Defense X Autostrategy - Modules/UI.lua
    InsulatorGMan
    Version 1.0.0
]] local UI = {}
UI.__index = UI

UI.Theme = {
    ['Default'] = {
        ['Pallete'] = {
            ['Elevation'] = {
                [-1] = Color3.fromHex('#151515'),
                [0] = Color3.fromHex('#171717'),
                [1] = Color3.fromHex('#1A1A1A'),
                [2] = Color3.fromHex('#1D1D1D'),
                [3] = Color3.fromHex('#202020')
            },
            ['Text'] = {
                [-1] = Color3.fromHex('#7C7C7C'),
                [0] = Color3.fromHex('#AAAAAA'),
                [1] = Color3.fromHex('#CACACA'),
                [2] = Color3.fromHex('#E3E3E3'),
                [3] = Color3.fromHex('#FFFFFF')
            }
        },
        ['Elements'] = {
            ['BaseWidgetBackground'] = UI.Theme.Default.Pallete.Elevation['-1'],
            ['WidgetTitleBackground'] = UI.Theme.Default.Pallete.Elevation['3'],
            ['WidgetTitleText'] = UI.Theme.Default.Pallete.Text['3'],
            ['Container'] = UI.Theme.Default.Pallete.Elevation['0'],
            ['ContainerText'] = UI.Theme.Default.Pallete.Text['1'],
            ['SecondaryContainer'] = UI.Theme.Default.Pallete.Elevation['1'],
            ['ContainedButton'] = UI.Theme.Default.Pallete.Text['2'],
            ['ContainedButtonText'] = UI.Theme.Default.Pallete.Elevation['-1']
        }
    }
}

-- // Make the root widget
function UI:MakeWidget(title, size)
    local ScreenGui = Instance.new('ScreenGui')
    local WidgetRootFrame = Instance.new('Frame')
    local WidgetTitleBackgroundFrame = Instance.new('Frame')
    local WidgetTitleTextLabel = Instance.new('TextLabel')

    WidgetRootFrame.Size = UDim2.new(0, size[0], 0, 50)
    WidgetRootFrame.BackgroundColor3 = UI.Theme.Default.Elements
                                           .BaseWidgetBackground
    WidgetRootFrame.BorderSizePixel = 0
    WidgetTitleBackgroundFrame.Size = UDim2.new(0, size[0], 0, size[1])
    WidgetTitleBackgroundFrame.BorderSizePixel = 0
    WidgetTitleBackgroundFrame.BackgroundColor3 =
        UI.Theme.Default.Elements.WidgetTitleBackground

    WidgetRootFrame.Parent = ScreenGui
    WidgetTitleBackgroundFrame.Parent = WidgetRootFrame
    WidgetTitleTextLabel.Parent = WidgetTitleBackgroundFrame

    return WidgetRootFrame
end

return UI
