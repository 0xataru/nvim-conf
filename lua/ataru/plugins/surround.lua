-- nvim-surround keymaps (all default, no custom config)
--
-- NORMAL MODE:
--   ys{motion}{char}  - add surround        e.g. ysiw"  -> "word",  ysip<div> -> <div>paragraph</div>
--   yss{char}         - surround whole line  e.g. yss)   -> (line)
--   ds{char}          - delete surround      e.g. ds"    -> removes surrounding quotes
--   cs{old}{new}      - change surround      e.g. cs"'   -> "text" -> 'text',  cs"<em> -> <em>text</em>
--
-- VISUAL MODE:
--   S{char}           - surround selection
--   gS{char}          - surround selection with newlines
--
-- INSERT MODE:
--   <C-g>s{char}      - insert surround pair and place cursor inside
--   <C-g>S{char}      - same but with newlines

return {
    "kylechui/nvim-surround",
    event = { "BufreadPre", "BufNewFile" },
    version = "*",
    config = true,
}
