local fzf = require("fzf-lua")

local data = {
  {"Item 1", "k1", "v1", "Preview for item 1\nMore lines..."},
  {"Item 2", "k2", "v2", "This is item 2 preview\nSecond line"},
  {"Item 3", "k3", "v3", "Item 3 has some info\nLine 2\nLine 3"},
}

-- Format function
local function format_entry(item)
  return string.format("%s [%s] = %s", item[1], item[2], item[3])
end

-- Return full entries list
local function get_entries()
  local entries = {}
  for _, item in ipairs(data) do
    table.insert(entries, format_entry(item))
  end
  return entries
end

-- Find preview for a given entry string
local function preview_fn(entry)
  for _, item in ipairs(data) do
    if format_entry(item) == entry then
      return item[4]
    end
  end
  return "No preview"
end

-- Grep entries by matching query against preview data
local function grep_entries(query)
  local results = {}
  for _, item in ipairs(data) do
    if item[4]:lower():find(query:lower(), 1, true) then
      table.insert(results, format_entry(item))
    end
  end
  return results
end

-- Picker state
local grep_mode = false

-- Main picker
function my_picker()
  fzf.fzf_exec(get_entries(), {
    prompt = "Select> ",
    previewer = { builtin = { wrap = true, }, },
    preview = preview_fn,
    actions = {
      ["default"] = function(selected)
        vim.notify("You picked: " .. selected[1])
      end,
      -- Ctrl-g to toggle mode
      ["ctrl-g"] = function(_, opts)
        grep_mode = not grep_mode
        local msg = grep_mode and "Switched to GREP mode" or "Switched to FILTER mode"

        -- Restart fzf with new behavior
		my_picker()
      end,
    }
  })
end

vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua my_picker()<CR>", { noremap = true, silent = true })

