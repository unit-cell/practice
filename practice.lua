-- practice
-- scale practice quiz!

include("lib/helpers")

function init()

  piano_keys = {
    [1]={10,40},[3]={15,40},[5]={20,40},[6]={25,40},[8]={30,40},[10]={35,40},[12]={40,40},  -- white keys
    [13]={45,40},[15]={50,40},[17]={55,40},[18]={60,40},[20]={65,40},[22]={70,40},[24]={75,40},
    [2]={12,35},[4]={17,35},[7]={27,35},[9]={32,35},[11]={37,35},                           -- black keys
    [14]={47,35},[16]={52,35},[19]={62,35},[21]={67,35},[23]={72,35}  
  }
  
  -- width and height of piano keys (rectangles)
  key_w = 3
  key_h = 3
  
  enc_position = 0
  mode = 1      -- startup mode
  max_modes = 3 -- max number of modes
  scales, mode_string = set_mode(mode)
  accidental, chosen_note, chosen_scale_name, chosen_scale = reroll() -- roll for root, scale, and sharp/flat
  
  hide = true -- hide the piano until k2 is pressed
end

-- screen
function redraw()
  screen.clear()
  screen.level(15)
  screen.move(10,20)
  if accidental == "sharp" 
    then screen.text(chrom_sharps[chosen_note] .. " " .. chosen_scale_name)
    else screen.text(chrom_flats[chosen_note] .. " " .. chosen_scale_name)
  end
  screen.stroke()
  screen.level(1)
  screen.move(10,60)
  screen.text(mode_string)
  screen.move(70,60)
  screen.text("reveal/reroll")
  highlights = highlighted(chosen_note, chosen_scale)
  if hide == false then
    for i=1, #piano_keys do
      screen.level(1)
      screen.rect(piano_keys[i][1], piano_keys[i][2], key_w, key_h)
      if table.contains(highlights, i)
        then screen.level(15)
      end
      screen.stroke()
    end
  end
  screen.update()
end 

-- keys
function key(n,z)
  if n == 3 then
    if z == 1 then
      accidental, chosen_note, chosen_scale_name, chosen_scale = reroll() -- roll for root, scale, and sharp/flat
      hide = true
      redraw()
    end
  elseif n == 2 then
    if z == 1 then
      hide = false
      redraw()
    end
  end
end

-- encoders
function enc(n,d)
  if n == 2 then
    enc_position = enc_position + d 
    if math.fmod(enc_position, 6) == 3 then                                   -- choose modulo to set encoder sensitivity
      if mode < max_modes then mode = mode + 1
      else mode = 1
      end
      scales, mode_string = set_mode(mode)                       -- keep scrolling through modes, fmod(enc_position, #modes + 1)
      accidental, chosen_note, chosen_scale_name, chosen_scale = reroll() -- roll for root, scale, and sharp/flat
      hide = true
      redraw()
    end
  end
end