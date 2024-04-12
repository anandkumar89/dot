local vim  = vim 
vim.fn['vimtex#options#init']()
vim.fn['vimtex#text_obj#init_buffer']()
vim.fn['vimtex#init']()

require('cmp_zotcite').setup({
	filetypes = {"markdown"},
})

vim.cmd([[
set wrap
]])

vim.g.vim_markdown_frontmatter = 1
vim.g.markdown_fenced_languages =  {'tex', 'python', 'julia'}


obsidianConfig = {
  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  ---@param url string
  follow_url_func = function(url)
    vim.fn.jobstart({"open", url})  -- Mac OS
  end,

  -- Optional, sort search results by "path", "modified", "accessed", or "created" `:ObsidianQuickSwitch` 
  sort_by = "modified",
  sort_reversed = true,

  -- Optional, The valid options are:"current", "vsplit" , "hsplit" 
  open_notes_in = "current",

    ui = {
    enable = true,  -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    checkboxes = {
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      ["S"] = { char = "", hl_group = "ObsidianTilde" },
      ["!"] = { char = "󰀧", hl_group = "ObsidianTilde" },
    },
    bullets = { char = "", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },
}
