-- Modify which-key registration (Use this with mappings.lua)
-- Add bindings which show up as group name
return {
  n = {
    -- second key is the prefix, <leader> prefixes
    ["<leader>"] = {
      -- third key is the key to bring up next level and its displayed
      -- group name in which-key top level menu
      ["b"] = { name = "Buffer" },
      ["c"] = { name = "Git Conflict" },
      ["j"] = { name = "Hop" },
      ["r"] = { name = "Recent/Session" },
      ["t"] = { name = "Trouble/ToggleTerm" },
    },

    ["c"] = {
      ["a"] = { name = "Outer" },
      ["i"] = { name = "Inner" },
      ["m"] = { name = "Word Segment" },
    },

    ["d"] = {
      ["a"] = { name = "Outer" },
      ["i"] = { name = "Inner" },
      ["m"] = { name = "Word Segment" },
    },

    ["g"] = {
      ["a"] = { name = "Text Case" },
    },
  },
}
