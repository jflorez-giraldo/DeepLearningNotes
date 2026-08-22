local function file_stem(path)
  local filename = path:match("([^/\\]+)$") or path
  return filename:gsub("%.[^%.]+$", "")
end

local function normalize_offset(offset)
  if offset == nil or offset == "." then return "" end
  if offset ~= "" and not offset:match("/$") then return offset .. "/" end
  return offset
end

return {
  ["chapter-actions"] = function()
    if not quarto.doc.is_format("html") then return pandoc.Null() end
    local input_file = quarto.doc.input_file
    if input_file == nil then return pandoc.Null() end

    local chapter = file_stem(input_file)
    local offset = normalize_offset(quarto.project.offset)
    local notebook = offset .. "notebooks/" .. chapter .. ".ipynb"
    local colab = "https://colab.research.google.com/github/jflorez-giraldo/DeepLearningNotes/blob/main/notebooks/" .. chapter .. ".ipynb"
    local html = string.format([[
<div class="chapter-actions" aria-label="Recursos del capitulo">
  <a class="chapter-action" href="%s" download>Descargar notebook</a>
  <a class="chapter-action chapter-action-colab" href="%s" target="_blank" rel="noopener">Abrir en Colab</a>
</div>
]], notebook, colab)
    return pandoc.RawBlock("html", html)
  end
}
