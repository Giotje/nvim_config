local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
   b.formatting.prettierd.with { filetypes = { "html", "markdown", "css"} },
   b.formatting.deno_fmt,

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   --javascript 
   b.formatting.prettier.with({filetypes= {"javascript", "javascriptreact", "json", "yaml"}}),
   b.diagnostics.eslint.with({filetypes={"javascript","javascriptreact", "json", "yaml"}}),

   --php 
   b.formatting.phpcbf,
   b.diagnostics.php,

   --rust
   b.formatting.rustfmt.with({filetypes={"rust"}}),

   b.formatting.black.with({filetypes={"python"}}),
   b.diagnostics.pylint.with({filetypes={"python"}})
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,

      -- format on save
      on_attach = function(client)
         if client.resolved_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
         end
      end,
   }
end

return M
