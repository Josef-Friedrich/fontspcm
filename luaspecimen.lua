function dirtree(dir)
  assert(dir and dir ~= "", "directory parameter is missing or empty")
  if string.sub(dir, -1) == "/" then
    dir=string.sub(dir, 1, -2)
  end

  local function yieldtree(dir)
    for entry in lfs.dir(dir) do
      if not entry:match("^%.") then
        entry=dir.."/"..entry
          if not lfs.isdir(entry) then
            coroutine.yield(entry,lfs.attributes(entry))
          end
          if lfs.isdir(entry) then
            yieldtree(entry)
          end
      end
    end
  end

  return coroutine.wrap(function() yieldtree(dir) end)
end

function fontsampler(dir)
  local t = {}
  local w = {}
  local p = {}

  for path in dirtree(dir) do
    if path:match(".otf","-4") then

      f = fontloader.open(path)

      --table.insert(t, f.fullname)


      w[f.weight] = path
      t[f.familyname] = w

      output =
        -- "Fullname: " .. f.fullname .. "; " ..
        "Familyname: " .. f.familyname .. "; " ..
        -- "Fontname: " .. f.fontname .. "; " ..
        -- "Italic: " .. f.italicangle .. "; " ..
        "Weight: " .. f.weight .. "; "

      -- tex.print(output)
      -- tex.print("\\fonttable{" .. f.fontname .. "}{" .. output  .. "}")

    end
  end

  for familyname,w in pairs(t) do
    tex.print("\\section{" .. familyname .. "}")
    for weight, path in pairs(w) do
      tex.print("\\subsection{" .. weight .. "}")
      tex.print(path)

    end
  end

end


function glyphs(path)

  local f = fontloader.open(path)

  local i = 0
  while (i < f.glyphmax) do

     local g = f.glyphs[i]

     if g then

      local chr = fontchar(g.name)
      local content = [[
      \noindent\parbox[t][0.75cm][c]{1cm}{\centerline{\Large %s}}

      \noindent\parbox[t][0.75cm][c]{1cm}{\centerline{\tiny\fontfamily{lmtt}\selectfont %s}}
      ]]

      content = string.format(content, chr, g.name)

      local frame = [[\fbox{\parbox[b][1.5cm][t]{1cm}{%s}}
      ]]

      output = string.format(frame, content)

      tex.print(output)

     end

     i = i + 1
  end

  fontloader.close(f)

end

function fontchar(chr)
  local chr = luaotfload.aux.slot_of_name(font.current(), chr, false)
  if chr and type(chr) == "number" then
    return string.format([[\char"%X]], chr)
  end
end
