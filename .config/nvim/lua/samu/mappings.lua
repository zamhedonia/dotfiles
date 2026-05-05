local map = vim.keymap.set

-- ─── Window Navigation ──────────────────────────────────────────────────
map("n", "<leader>wh", "<C-w>h", { desc = "Switch [W]indow left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Switch [W]indow down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Switch [W]indow up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Switch [W]indow right" })

-- Arrow keys alternative
map("n", "<leader>w<Left>",  "<C-w>h", { desc = "Switch [W]indow left" })
map("n", "<leader>w<Down>",  "<C-w>j", { desc = "Switch [W]indow down" })
map("n", "<leader>w<Up>",    "<C-w>k", { desc = "Switch [W]indow up" })
map("n", "<leader>w<Right>", "<C-w>l", { desc = "Switch [W]indow right" })

-- ─── Formatting ─────────────────────────────────────────────────────────
map("n", "<leader>l", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "[F]ormat buffer" })

-- ─── Comment ────────────────────────────────────────────────────────────
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment selection", remap = true })

-- ─── Terminal ───────────────────────────────────────────────────────────
map("n", "tt", function()
    local height = math.floor(vim.o.lines / 2)
    vim.cmd("belowright split | resize " .. height .. " | terminal")
end, { desc = "Toggle terminal" })

-- ─── Clear Highlights ───────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- ─── Diagnostics ────────────────────────────────────────────────────────
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- ─── Markdown ---────────────────────────────────────────────────────────
map("n", "<leader>mp", "<cmd>PreviewMarkdownToggle<CR>", { desc = "Toggle Markdown Preview" })
