-- Abas nativas: cada aba continua sendo uma janela independente.
local tabs = {}

hl.config({
    group = {
        auto_group = true,
        drag_into_group = 2,
        group_on_movetoworkspace = false,
        insert_after_current = true,
        col = {
            border_active = "rgba(9580bfff)",
            border_inactive = "rgba(302b3aff)",
            border_locked_active = "rgba(b7a1e5ff)",
            border_locked_inactive = "rgba(403355ff)",
        },
        groupbar = {
            enabled = true,
            disable_when_only = false,
            stacked = false,
            render_titles = true,
            font_family = "Noto Sans",
            font_size = 11,
            font_weight_active = "bold",
            height = 22,
            indicator_height = 2,
            gaps_in = 1,
            gaps_out = 0,
            rounding = 0,
            gradient_rounding = 0,
            gradients = true,
            blur = false,
            scrolling = true,
            middle_click_close = false,
            text_color = "rgba(f5f5f5ff)",
            text_color_inactive = "rgba(bbb3c9ff)",
            col = {
                active = "rgba(635178ff)",
                inactive = "rgba(17141cff)",
                locked_active = "rgba(77618fff)",
                locked_inactive = "rgba(25202eff)",
            },
        },
    },
})

function tabs.collect_same_app(window)
    local current = window or hl.get_active_window()
    if not current or not current.workspace or current.class == "" then
        return
    end
    if current.group and current.group.locked then
        return
    end
    local candidates = {}
    for _, other in ipairs(hl.get_workspace_windows(current.workspace)) do
        if other.address ~= current.address and other.class == current.class
            and other.mapped and not other.group then
            table.insert(candidates, other)
        end
    end
    -- Só altera o layout quando há outra janela para reunir.
    if #candidates == 0 then
        return
    end
    if not current.group then
        hl.dispatch(hl.dsp.group.toggle({ window = current }))
    end
    local group = current.group
    if not group then
        return
    end
    for _, other in ipairs(candidates) do
        group:add(other)
    end
    hl.dispatch(hl.dsp.focus({ window = current }))
end

function tabs.detach(window)
    local current = window or hl.get_active_window()
    if current and current.group then
        current.group:remove(current)
    end
end

hl.bind("SUPER + CTRL + G", hl.dsp.group.toggle())
hl.bind("SUPER + CTRL + SHIFT + G", function() tabs.collect_same_app() end)
hl.bind("SUPER + CTRL + TAB", hl.dsp.group.next())
hl.bind("SUPER + CTRL + SHIFT + TAB", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + U", function() tabs.detach() end)
hl.bind("SUPER + CTRL + SHIFT + L", hl.dsp.group.lock({ action = "toggle" }))

return tabs
