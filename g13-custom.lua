function OnEvent(event, arg)
  -- init bindings
  if (binding == nil) then
    space_modifier = 22 -- The 'G' of space/modifier
    binding = {};
    binding[1] = {};
    binding[1][1] = {0x01};
    binding[1][2] = {0x19,0x24};
    binding[1][3] = {0x11,0x32};
    binding[1][4] = {0x13,0x30};
    binding[1][5] = {0x1e,0x22};
    binding[1][6] = {0x18,0x21};
    binding[1][7] = {0x0e,0x153};
    binding[1][8] = {0x0f,"M2"};
    binding[1][9] = {0x20,0x2f};
    binding[1][10] = {0x14,0x2e};
    binding[1][11] = {0x23,0x26};
    binding[1][12] = {0x12,0x2c};
    binding[1][13] = {0x16,0x10};
    binding[1][14] = {0x33,0x34};
    binding[1][15] = {0x2a};
    binding[1][16] = {0x1f,0x15};
    binding[1][17] = {0x31,0x2d};
    binding[1][18] = {0x17,0x25};
    binding[1][19] = {0x1c,"M3"};
    binding[1][20] = {0x1d};
    binding[1][21] = {0x138,0x38};
    binding[2] = {};
    binding[2][1] = {0x01};
    binding[2][2] = {0x0c};
    binding[2][3] = {0x137};
    binding[2][4] = {0x46};
    binding[2][5] = {0x146,0x2b};
    binding[2][6] = {0x1a};
    binding[2][7] = {0x0e,0x153};
    binding[2][8] = {0x0f,"M1"};
    binding[2][9] = {0x0d};
    binding[2][10] = {0x1b,0x152};
    binding[2][11] = {0x28,0x147};
    binding[2][12] = {0x35,0x149};
    binding[2][13] = {0x56};
    binding[2][14] = {};
    binding[2][15] = {0x2a};
    binding[2][16] = {};
    binding[2][17] = {0x14f};
    binding[2][18] = {0x27,0x151};
    binding[2][19] = {0x1c,"M3"};
    binding[2][20] = {0x1d};
    binding[2][21] = {0x138,0x38};
    binding[3] = {};
    binding[3][1] = {0x01};
    binding[3][2] = {0x4a,0x135};
    binding[3][3] = {0x47,0x41};
    binding[3][4] = {0x48,0x42};
    binding[3][5] = {0x49,0x43};
    binding[3][6] = {0x52,0x44};
    binding[3][7] = {0x0e,0x153};
    binding[3][8] = {0x0f,"M1"};
    binding[3][9] = {0x4e,0x37};
    binding[3][10] = {0x4b,0x3e};
    binding[3][11] = {0x4c,0x3f};
    binding[3][12] = {0x4d,0x40};
    binding[3][13] = {0x53,0x57};
    binding[3][14] = {0x58};
    binding[3][15] = {0x2a};
    binding[3][16] = {0x4f,0x3b};
    binding[3][17] = {0x50,0x3c};
    binding[3][18] = {0x51,0x3d};
    binding[3][19] = {0x1c,"M2"};
    binding[3][20] = {0x1d};
    binding[3][21] = {0x138,0x38};
  end

  -- Default modifier value.
  if (keyModifier == nil) then
    keyModifier = 1;
  end
  mkey = GetMKeyState();
  
  if (mustPressSpace == nil) then
    mustPressSpace = false;
  end
  
  if (arg == space_modifier) then
    if (event == "G_PRESSED") then 
      keyModifier = 2;
      mustPressSpace = true;
    elseif (event == "G_RELEASED") then 
      keyModifier = 1;
      -- If mustPressSpace is still true here, it means we want to press space.
      if (mustPressSpace) then PressAndReleaseKey(0x39); end
    end
  elseif (arg >= 1 and arg <= 22) then
    boundKey = binding[mkey][arg][keyModifier]; -- getting the key from bindings.
    if (boundKey ~= nil) then
      if (event == "G_PRESSED") then
        -- if the binding starts with 'M', we switch state
        if (string.sub(boundKey, 1, 1) == 'M') then
          SetMKeyState(tonumber(string.sub(boundKey, 2, 2)));
        else
          PressKey(boundKey);
        end
        -- We used the modifier, it means we don't want to press space.
        mustPressSpace = false;
      elseif (event == "G_RELEASED") then
        -- We blindly release both keys (If not a MSwitch).
        if (binding[mkey][arg][1] ~= nil and string.sub(binding[mkey][arg][1], 1, 1) ~= 'M') then
          ReleaseKey(binding[mkey][arg][1]);
        end
        if (binding[mkey][arg][2] ~= nil and string.sub(binding[mkey][arg][2], 1, 1) ~= 'M') then
          ReleaseKey(binding[mkey][arg][2]);
        end
      end
    end
  end
end
