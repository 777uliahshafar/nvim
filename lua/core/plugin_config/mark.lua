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
    virt_text = "todo",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
  bookmark_9 = {
    sign = "",
    virt_text = "Very important",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
  bookmark_8 = {
    sign = "",
    virt_text = "Important",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
  bookmark_7 = {
    sign = "",
    virt_text = "Petty",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = true,
  },
}
