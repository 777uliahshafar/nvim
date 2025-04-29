require("marks").setup {
  mappings = {
    set_next = "m,",
    next = "m]",
    preview = "m:",
    set_bookmark0 = "m0",
    prev = false, -- pass false to disable only this default mapping
  },
  bookmark_0 = {
    sign = "⚑",
    virt_text = "last edit",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
}
