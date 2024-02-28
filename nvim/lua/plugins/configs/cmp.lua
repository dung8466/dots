local icons = require "core.icons"
local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(opts)
      luasnip.lsp_expand(opts.body)
    end,
  },
  conpletion = {
    completeopt = 'menu,menuone,noinsert',
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = {
      scrolloff = vim.go.scrolloff,
      border = "rounded",
    },
    documentation = {
      border = "rounded",
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, item)
      local kind = item.kind
      item.kind = icons.kind[kind]
      item.menu = kind:gsub("(%l)(%u)", "%1 %2"):lower()

      return item
    end,
  },
  sources = {
    { name = "path", max_item_count = 20 },
    {
      name = "nvim_lsp",
      max_item_count = 80,
    },
    {
      name = "buffer",
      max_item_count = 20,
      option = {
        get_bufnrs = function()
          return vim.tbl_map(function(win)
            return vim.api.nvim_win_get_buf(win)
          end, vim.api.nvim_list_wins())
        end,
      },
    },
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}
