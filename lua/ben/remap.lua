-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vertical movement with cursor center
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- open a terminal
vim.keymap.set('n', '<leader>m', function()
  vim.cmd.term()
  vim.fn.feedkeys 'i'
end, { desc = 'Open new Ter[m]inal' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- NOTE: I switch , and ; in normal mode to have consistent shift behavior in combination with f/F
vim.keymap.set('n', ';', ',', { desc = 'Swap: repeat find forward' })
vim.keymap.set('n', ',', ';', { desc = 'Swap: repeat find backward' })
vim.keymap.set('o', ';', ',', { desc = 'Swap: repeat find forward (operator-pending)' })
vim.keymap.set('o', ',', ';', { desc = 'Swap: repeat find backward (operator-pending)' })
vim.keymap.set('x', ';', ',', { desc = 'Swap: repeat find forward (visual)' })
vim.keymap.set('x', ',', ';', { desc = 'Swap: repeat find backward (visual)' })

-- Preserve behavior when repeating the last change with dot ('.')
vim.keymap.set('n', ';.', ',.', { desc = 'Swap ;. -> ,.' })
vim.keymap.set('n', ',.', ';.', { desc = 'Swap ,. -> ;.' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste over without remembering' })
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search Re[p]lace' })
