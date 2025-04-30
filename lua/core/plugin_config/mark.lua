require("marks").setup {
  mappings = {
    set_next = "m,",
    next = "m]",
    preview = "m:",
    set_bookmark0 = "m0",
    set_bookmark9 = "m9",
    prev = false, -- pass false to disable only this default mapping
  },
  bookmark_0 = {
    sign = "⚑",
    virt_text = "here",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
  bookmark_9 = {
    sign = "",
    virt_text = "ref",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
}
