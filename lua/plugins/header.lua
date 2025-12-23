return {
    "attilarepka/header.nvim",
    config = function()
        require("header").setup({
            allow_autocmds = true,
            file_name = false,
            -- author = "Piyush Raj",
            -- project = "header.nvim",
            date_created = true,
            date_created_fmt = "%Y-%m-%d %H:%M:%S",
            date_modified = true,
            date_modified_fmt = "%Y-%m-%d %H:%M:%S",
            line_separator = "------",
            use_block_header = false,
            -- copyright_text = {
            --     "Copyright (c) 2025 Piyush Raj",
            --     "All rights reserved."
            -- },
            license_from_file = false,
            author_from_git = true,
        })
    end,
}
