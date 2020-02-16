-- helper functions for practice.lua
--

-- scales, 2 is a tone, 1 is a semitone
scales = {
  ["major"] = {2,2,1,2,2,2,1}, -- ionian
  ["dorian"] = {2,1,2,2,2,1,2},
  ["phrygian"] = {1,2,2,2,1,2,2},
  ["lydian"] = {2,2,2,1,2,2,1},
  ["mixolydian"] = {2,2,1,2,2,1,2},
  ["minor"] = {2,1,2,2,1,2,2}, -- aeolian
  ["locrian"] = {1,2,2,1,2,2,2},
  ["pentatonic major"] = {2,2,3,2,3},
  ["pentatonic minor"] = {3,2,2,3,2}
}

function set_mode(mode)
  if mode == 1
    then scales = {
    ["major"] = {2,2,1,2,2,2,1}, -- ionian
    ["minor"] = {2,1,2,2,1,2,2}, -- aeolian
    }
    mode_string = "major/minor"
  elseif mode == 2
    then scales = {
    ["ionian"] = {2,2,1,2,2,2,1},   -- major
    ["dorian"] = {2,1,2,2,2,1,2},
    ["phrygian"] = {1,2,2,2,1,2,2},
    ["lydian"] = {2,2,2,1,2,2,1},
    ["mixolydian"] = {2,2,1,2,2,1,2},
    ["aeolian"] = {2,1,2,2,1,2,2},  -- minor
    ["locrian"] = {1,2,2,1,2,2,2}
    }
    mode_string = "modes"
  elseif mode == 3
    then scales = {
    ["pentatonic major"] = {2,2,3,2,3},
    ["pentatonic minor"] = {3,2,2,3,2}
    }
    mode_string = "pentatonic"
  end
  return scales, mode_string
end



  

-- define notes
chrom_sharps = {[0]='C',[1]='C#',[2]='D',[3]='D#',[4]='E',
[5]='F',[6]='F#',[7]='G',[8]='G#',[9]='A',[10]='A#',[11]='B'}

chrom_flats = {[0]='C',[1]='Db',[2]='D',[3]='Eb',[4]='E',
[5]='F',[6]='Gb',[7]='G',[8]='Ab',[9]='A',[10]='Bb',[11]='B'}

-- iterate table by value, return key
function get_key_for_value( t, value )
  for k,v in pairs(t) do
    if v==value then return k end
  end
  return nil
end

-- returns table with notes in scale from root
function get_notes(root, scale)
  -- add root as first entry in table
  local notes = {root}
  -- find index in chrom_sharps
  index = get_key_for_value(chrom_sharps, root)
  -- add entry from chrom_sharps according to interval in scale
  for i = 1, #scale do
    index = math.fmod(index + scale[i], 12)
    table.insert(notes, chrom_sharps[index])
  end
  return notes
end

-- choose random item from table, return key and value
function math.randomchoice(t) --Selects a random item from a table
    local keys = {}
    for key, value in pairs(t) do
        keys[#keys+1] = key --Store keys in another table
    end
    index = keys[math.random(1, #keys)]
    return index, t[index]
end

-- get which notes should be highlighted on the keyboard based on chosen root and scale
function highlighted(chosen_note, chosen_scale)
  local note = chosen_note + 1 -- correct for C = index 1
  local notes = {note} 
  for i=1, #chosen_scale do
    note = note + chosen_scale[i]
    table.insert(notes, note)
  end
  return notes -- returns table with indexes to highlight in piano
end

-- check if a value is in an array table
function table.contains(table, element)
  for i, value in ipairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
  
-- returns table with note indices in scale from root
function get_notes_index(root, scale)
  -- add root as first entry in table
  local notes = {root}
  -- find index in chrom_sharps
  index = get_key_for_value(chrom_sharps, root)
  -- add entry from chrom_sharps according to interval in scale
  for i = 1, #scale do
    index = math.fmod(index + scale[i], 12)
    table.insert(notes, chrom_sharps[index])
  end
  return notes
end

-- rerolls root and scale
function reroll()
  if math.random(1,2) == 1
    then return "sharp", math.random(0,11), math.randomchoice(scales)
  else return "flat", math.random(0,11), math.randomchoice(scales)
  end
end
