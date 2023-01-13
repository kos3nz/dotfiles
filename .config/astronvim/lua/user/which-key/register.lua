-- Modify which-key registration (Use this with mappings.lua)
-- Add bindings which show up as group name
return {
  n = {
    -- second key is the prefix, <leader> prefixes
    ["<leader>"] = {
      -- third key is the key to bring up next level and its displayed
      -- group name in which-key top level menu
      ["b"] = { name = "Buffer" },
      ["g"] = {
        ["f"] = { name = "Git Conflict" },
      },
      ["r"] = { name = "Snip Run" },
      ["x"] = { name = "Trouble" },
    },
  },
}
