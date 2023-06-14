-- keymap
function keymap(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = false}) end
function keymap_r(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = true }) end
function keymap_s(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = false, silent = true }) end
function keymap_rs(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = true, silent = true }) end
