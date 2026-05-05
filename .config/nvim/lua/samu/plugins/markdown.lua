return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        bullet = {
        -- Replaces '-'|'+'|'*' of 'list_item'.
        -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
        -- Output is evaluated depending on the type.
        -- | function   | `value(context)`                                    |
        -- | string     | `value`                                             |
        -- | string[]   | `cycle(value, context.level)`                       |
        -- | string[][] | `clamp(cycle(value, context.level), context.index)` |
        icons = {  '󰻂', '󰻃', '󰻂', '󰻃' },
        },
    },
}
