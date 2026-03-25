vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Append next line without losing cursor position' })

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center after move up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center after move down' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center after search down' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center after search up' })

vim.keymap.set('x', '<leader>p', '"_dP', { desc = '[P]aste without losing selection' })

vim.keymap.set('n', '<leader>d', '"_d', { desc = '[D]elete without losing selection' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = '[D]elete without losing selection' })

-- [[ Remap window movement keys to insert in terminals, expect when we execute another command ]] --

local window_moving_commands = {
  vim.keycode '<C-H>',
  vim.keycode '<C-M-H>',
  vim.keycode '<C-J>',
  vim.keycode '<C-M-J>',
  vim.keycode '<C-K>',
  vim.keycode '<C-M-K>',
  vim.keycode '<C-L>',
  vim.keycode '<C-M-L>',
  vim.keycode '<C-W>',
  vim.keycode ':',
  vim.keycode '<leader>',
}

local function move_focus_window(direction)
  vim.cmd.wincmd(direction)
  vim.cmd.redraw()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype ~= 'terminal' then return end
  local key = vim.fn.getcharstr()
  if vim.tbl_contains(window_moving_commands, key) then
    vim.api.nvim_feedkeys(key, 'tx!', true)
    vim.cmd.redraw()
  else
    -- Enter insert mode when we stop moving windows.
    vim.cmd.startinsert()
    vim.api.nvim_feedkeys(key, 't', true)
  end
end

vim.api.nvim_create_autocmd({ 'WinEnter' }, {
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd.startinsert()
    else
      vim.cmd.stopinsert()
    end
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  callback = function(ctx)
    vim.cmd.stopinsert()
    vim.api.nvim_create_autocmd('TermEnter', {
      command = 'stopinsert',
      buffer = ctx.buf,
    })
  end,
  nested = true,
})

vim.keymap.set('n', '<C-h>', function() move_focus_window 'h' end, { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', function() move_focus_window 'l' end, { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', function() move_focus_window 'j' end, { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', function() move_focus_window 'k' end, { desc = 'Move focus to the upper window' })
