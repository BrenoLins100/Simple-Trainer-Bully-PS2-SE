-- Compile to ArcRace1.lur
function MissionSetup()
  AreaTransitionXYZ(0,270,-110,6)
  F_LoadAllAnim()
end
 
function main()
  
  local options = {
    {name = "Spawnar veiculos",func = VehicleSpawner},
    {name = "Style Selector",func = StyleSelector},
    {name = "Weapon Menu",func = WeaponMenu},
    {name = "Tele Transporte", func = TeleTransporte},
    {name = "Add Money", func = AddMoney}
  }
  
  local s = 1
  repeat
    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    elseif IsButtonBeingPressed(1,0) and s == table.getn(options) then
      s = s - table.getn(options) + 1
    elseif IsButtonBeingPressed(0,0) and s == 1 then
      s = table.getn(options) 
    end
    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp") 
    end
    
    TextPrintString("Simple Trainer v1 By Breno Lins \n\n "..s.."--"..options[s].name,1,1)
   -- TextPrintString("Navigation: ~dleft~ ~dright~ \n  Confirm: ~ddown~ \n  Back: ~LOOK_BACK~  ",4,2)

    local menuString = ""
    local menuOptCont = ""

    for i,opc in ipairs(options) do
      menuString = menuString ..  (s == i and "->" or " " )   .. i .. "-" .. opc.name .. "\n"
      menuOptCont = s .. "/" .. i
    end

    TextPrintString(menuString,1,1)

    if IsButtonBeingPressed(3,0) then
      SoundPlay2D("RightBtn")
      options[s].func()
    end
    -- script text rainbow scooter
    if IsButtonBeingPressed(8,0) then
      Wait(0)
      --ClothingSetPlayer(1,"R_Jacket1")
      --ClothingBuildPlayer()
      
      if PlayerIsInAnyVehicle() then
        local veiculos = VehicleFindInAreaXYZ(x, y, z, 999)
        local modelId = 0
      

        for i, veh in ipairs(veiculos) do
          
          modelId = VehicleGetModelId(veh)
          if modelId == 276 then
           repeat
            Wait(1000)
            VehicleSetColor(veh,math.random(0,99))
            --EffectCreate("GymFire",PlayerGetPosXYZ())
            --EffectKill("GymFire")
           until not PlayerIsInAnyVehicle()
          else 
            TextPrintString("You must be on scooter to use this!",4,2)
          end
        end
      end

    end
    if IsButtonBeingPressed(7,0) then
      InfiniteAmmo()
    end
    Wait(0)
  until false
end
 
local infAmmo = false

function InfiniteAmmo()
 
  if infAmmo == false then
    infAmmo = true
    TextPrintString("ON",4,2)
    PedSetFlag(gPlayer, 24, true)
  else
    infAmmo = false
    TextPrintString("OFF",4,2)
    PedSetFlag(gPlayer, 24, false)
  end
end

function StyleSelector()
  local options = {
    {name = "Russell",root = "/Global/BOSS_Russell",file = "Act/Anim/BOSS_Russell.act"},
    {name = "Greaser striker",root = "/Global/G_Striker_A",file = "Act/Anim/G_Striker_A.act"},
    {name = "Preppy 1",root = "/Global/P_Striker_A",file = "Act/Anim/P_Striker_A.act"}
  }
  local s = 1
  repeat
    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    end
    TextPrintString(s.."--"..options[s].name,1,1)
    Wait(0)
    if IsButtonBeingPressed(3,0) then
      PedSetActionTree(gPlayer,options[s].root,options[s].file)
    end
  until IsButtonBeingPressed(14,0)
end
 
function TeleTransporte()
  local options = {
    {areaId = 2, xyz = {-628.4, -312.5, -0.0}, areaName = "School"},
    {areaId = 5, xyz = {-701.37, 214.76, 31.55}, areaName = "Principal's" },
    {areaId = 0, xyz = {164.1 ,-73.8 ,14.8}, areaName = "School Mini Roottop"},
    {areaId = 43, xyz = {-736.5 ,-624.6 ,3.2}, areaName ="Junk Yard"}
    -- adicionar mais areas....
  }
  local i = 1
  repeat
    if IsButtonBeingPressed(0,0) and i > 1 then
      i = i - 1
    elseif IsButtonBeingPressed(1,0) and i < table.getn(options) then
      i = i + 1
    end
    TextPrintString(i.."-"..options[i].areaName,1,1)
    Wait(0)
    if IsButtonBeingPressed(3,0) then
      --TextPrintString(tostring(options[i].areaId).. tostring(options[i].xyz[3]), 1,2)
      Wait(0)
      AreaTransitionXYZ(options[i].areaId, options[i].xyz[1],options[i].xyz[2],options[i].xyz[3],false)
    end
    until IsButtonBeingPressed(14,0)
  end

-- variavel global usada no VehicleSpawner()
local dirige = false
 
function VehicleSpawner()

  local options = {
    {name = "Bmx Race", id = 272},
    {name = "Retro", id = 273},
    {name = "Crap BMX", id = 274},
    {name = "Bike Cop", id = 275},
    {name = "Scooter", id = 276},
    {name = "Bike", id = 277},
    {name = "Custom Bike", id = 278},
    {name = "Ban Bike", id = 279},
    {name = "Mountain Bike", id = 280},
    {name = "Old Bike", id = 281},
    {name = "Racer", id = 282},
    {name = "Aqua Bike", id = 283},
    {name = "Lawn Mower", id = 284},
    {name = "Arcade 3", id = 285},
    {name = "Taxi Cab", id = 286},
    {name = "Arcade 2", id = 287},
    {name = "Dozer", id = 288},
    {name = "Go Cart", id = 289},
    {name = "Limo", id = 290},
    {name = "Delivery Truck", id = 291},
    {name = "Foreign", id = 292},
    {name = "Cargo Green", id = 293},
    {name = "70 Wagon", id = 294},
    {name = "Police Car", id = 295},
    {name = "Domestic", id = 296},
    {name = "Truck", id = 297},
    {name = "Arcade 1", id = 298},
  }

  local s = 1
  local VehCont = 0
  repeat

    -- pegando coordenadas x,y,z do jimmy
    local x,y,z = PlayerGetPosXYZ()

    local veiculos = VehicleFindInAreaXYZ(x, y, z, 999)
    local vehMenu = ""
    

    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    elseif IsButtonBeingPressed(1,0) and s == table.getn(options) then
      s = s - table.getn(options) + 1
    elseif IsButtonBeingPressed(0,0) and s == 1 then
      s = table.getn(options)
    end
    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
    end
   
    local itemsPorPagina = 13
    local paginaAtual = math.ceil(s / itemsPorPagina)
    local inicio = (paginaAtual -1) * itemsPorPagina +1
    local fim = math.min(paginaAtual * itemsPorPagina, table.getn(options))

    for j = inicio, fim do
      vehMenu = vehMenu ..  (j == s and "->" or "").. options[j].name .. "\n"                       
    end
    TextPrintString(vehMenu,1,1)

    Wait(0)
    if IsButtonBeingPressed(3,0) then
      VehCont = VehCont + 1
      -- caso a funcao que permite o jogador ja esteja ativa previamente.
      if dirige then
        TextPrintString("Veículo criado!\n".."Veiculos criados:".. VehCont,4,2) -- remover isso depois (log)
      else 
        dirige = true
        TextPrintString("Permitindo jogador dirigir!\n veiculo criado.",4,2)
        PedSetFlag(gPlayer, 42, true)
      end

      if VehCont == 15 then
        TextPrintString("Limite de veículos atingido!\n Limpando area...",4,2)
        for i, veh in ipairs(veiculos) do
          VehicleDelete(veh)
        end
        VehCont = 0
      end
       -- criando veiculo x-5 -> para que o veiculo nao nasça em cima do jimmy
       VehicleCreateXYZ(options[s].id, x-5, y, z)
    end
  until IsButtonBeingPressed(14,0)

  SoundPlay2D("WrongBtn")

  --TextPrintString("X:"..x.. "Y:" ..y.. "Z:" .. z,5,2)
end

function WeaponMenu()

  Wait(0)

  local options = {

    {name = "Weapon Selector", func = WeaponSelector},
    {name = "Ped Weapon Selector", func =  SetPedWeapon},
  }

  local s = 1
  repeat

    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    elseif IsButtonBeingPressed(1,0) and s == table.getn(options) then
      s = s - table.getn(options) + 1
    elseif IsButtonBeingPressed(0,0) and s == 1 then
      s = table.getn(options)
    end


    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
    end

    local menuString = ""
    local menuOptCont = ""
  
      for i,opc in ipairs(options) do
        menuString = menuString ..  (s == i and "->" or " " )   .. i .. "-" .. opc.name .. "\n"
        menuOptCont = s .. "/" .. i
      end
  
      TextPrintString(menuString,1,1)
  
      if IsButtonBeingPressed(3,0) then
        SoundPlay2D("RightBtn")
        options[s].func()
      end
      Wait(0)
  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")


end


function WeaponSelector()
  local options = {
    {name = "Apple",id = 310},
    {name = "Banana",id = 358},
    {name = "Baseball",id = 302},
    {name = "Basket Ball",id = 381},
    {name = "Bat",id = 300},
    {name = "Big Firework",id = 397},
    {name = "Books 1",id = 405},
    {name = "Books 2",id = 413},
    {name = "Books 3",id = 414},
    {name = "Books 4",id = 415},
    {name = "Books 5",id = 416},
    {name = "Brick",id = 311},
    {name = "Broom",id = 377},
    {name = "Camera",id = 328},
    {name = "Digital Camera",id = 426},
    {name = "Dead Rat",id = 346},
    {name = "Devil Fork",id = 409},
    {name = "Dish",id = 338},
    {name = "Egg",id = 312},
    {name = "Fists",id = -1},
    {name = "Fire Extinguisher",id = 326},
    {name = "Fire cracker",id = 301},
    {name = "Football",id = 331},
    {name = "Football (Bomb)",id = 400},
    {name = "Frisbee",id = 335},
    {name = "Gold Pipe",id = 418},
    {name = "Itchy Powder",id = 394},
    {name = "Kick Me",id = 372},
    {name = "Marbles",id = 349},
    {name = "News Roll",id = 320},
    {name = "Pinky Wand",id = 410},
    {name = "Plate",id = 355},
    {name = "Poison Gun",id = 395},
    {name = "Rocket Launcher",id = 307},
    {name = "Rubber Band",id = 325},
    {name = "Shield",id = 387},
    {name = "Metal Plate",id = 360},
    {name = "Skateboard",id = 437},
    {name = "Sledge Hammer",id = 324},
    {name = "Slingshot",id = 303},
    {name = "Snowball",id = 313},
    {name = "Snowball 2",id = 330},
    {name = "Soccer Ball",id = 329},
    {name = "Spray Can",id = 321},
    {name = "Spud Gun",id = 305},
    {name = "Stink Bomb",id = 309},
    {name = "Super Slingshot",id = 306},
    {name = "Super Spud Gun",id = 396},
    {name = "Trash Lid",id = 315},
    {name = "Umbrella",id = 404},
    {name = "Vase 1",id = 354},
    {name = "Vase 2",id = 353},
    {name = "Vase 3",id = 345},
    {name = "Water Baloon",id = 383},
    {name = "Water Pipe",id = 342},
    {name = "Whip",id = 411},
    {name = "Wood Paddle",id = 357},
    {name = "Wood Plank",id = 323},
    {name = "Yardstick",id = 299},
    {name = "Flashlight",id = 420},
    {name = "Tissue Roll",id = 403},
    {name = "Water Pipe 2",id = 402},
    {name = "Water Pipe 3",id = 401},
    {name = "Poo Bag",id = 399}
  }
  local s = 1
  repeat

    local weaponsString = ""

    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    elseif IsButtonBeingPressed(1,0) and s == table.getn(options) then
      s = s - table.getn(options) + 1
    elseif IsButtonBeingPressed(0,0) and s == 1 then
      s = table.getn(options)
    end

    local itemsPerPage = 5
    local currentPage = math.ceil(s/itemsPerPage)
    local loopStart = (currentPage -1) * itemsPerPage +1
    local loopEnd = math.min(currentPage * itemsPerPage, table.getn(options))

    for j = loopStart, loopEnd do 
      weaponsString = weaponsString .. (j == s and "->" or "")..options[j].name .. "\n" 
    end
    TextPrintString(weaponsString,1,1)

    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
    end

    Wait(0)
    if IsButtonBeingPressed(3,0) then
      PedSetWeapon(gPlayer,options[s].id,999)
    end


  until IsButtonBeingPressed(14,0)
end

function SetPedWeapon()

  local options = {
    {name = "yardstick", id = 299},
    {name = "bat", id = 300},
  }

  local i = 1
  repeat
    if IsButtonBeingPressed(0,0) and i > 1 then
      i = i - 1
    elseif IsButtonBeingPressed(1,0) and i < table.getn(options) then
      i = i + 1
    end
    TextPrintString(i.."-"..options[i].name,1,1)
    Wait(0)
    if IsButtonBeingPressed(3,0) then
      local targetPed = PedGetTargetPed(gPlayer) -- pedreste sobre a mira
      if PedIsValid(targetPed) then -- verifica se o ped é valido
        --TextPrintString(tostring(TARGET),1,2) --log
        PedSetWeapon(targetPed, options[i].id, 1)
      else
        TextPrintString("Pedreste invalido.",1,2)
      end
    end
  until IsButtonBeingPressed(14,0)
end


-- Funcao AddMoney

function AddMoney()
  local number = 0
  repeat
    local playerMoney = PlayerGetMoney()
    if IsButtonPressed(0,0) then
      SoundPlay2D("NavUp") 
      if number == 0 then
        number = 100000
      else
        number =  number - 100
      end
    elseif IsButtonPressed(1,0) then
      SoundPlay2D("NavUp") 
      if number == 100000 then
        number = 0
      else
        number =  number + 100
      end
    end
    if IsButtonBeingPressed(3,0) then
      if playerMoney == 10000000 then
        SoundPlay2D("WrongBtn")
        TextPrintString("Wallet full", 4,1)
      else
        SoundPlay2D("RightBtn")
        PlayerAddMoney(number*100)
      end
    end
    TextPrintString("Money amount:".."$"..tostring(number),1,2)
    Wait(0)
  until IsButtonBeingPressed(14,0)
end


function F_LoadAllAnim()
    LoadAnimationGroup("Authority")
    LoadAnimationGroup("Boxing")
    LoadAnimationGroup("B_Striker")
    LoadAnimationGroup("CV_Female")
    LoadAnimationGroup("CV_Male")
    LoadAnimationGroup("DO_Edgar")
    LoadAnimationGroup("DO_Grap")
    LoadAnimationGroup("DO_StrikeCombo")
    LoadAnimationGroup("DO_Striker")
    LoadAnimationGroup("F_Adult")
    LoadAnimationGroup("F_BULLY")
    LoadAnimationGroup("F_Crazy")
    LoadAnimationGroup("F_Douts")
    LoadAnimationGroup("F_Girls")
    LoadAnimationGroup("F_Greas")
    LoadAnimationGroup("F_Jocks")
    LoadAnimationGroup("F_Nerds")
    LoadAnimationGroup("F_OldPeds")
    LoadAnimationGroup("F_Pref")
    LoadAnimationGroup("F_Preps")
    LoadAnimationGroup("G_Grappler")
    LoadAnimationGroup("G_Johnny")
    LoadAnimationGroup("G_Striker")
    LoadAnimationGroup("Grap")
    LoadAnimationGroup("J_Damon")
    LoadAnimationGroup("J_Grappler")
    LoadAnimationGroup("J_Melee")
    LoadAnimationGroup("J_Ranged")
    LoadAnimationGroup("J_Striker")
    LoadAnimationGroup("LE_Orderly")
    LoadAnimationGroup("Nemesis")
    LoadAnimationGroup("N_Ranged")
    LoadAnimationGroup("N_Striker")
    LoadAnimationGroup("N_Striker_A")
    LoadAnimationGroup("N_Striker_B")
    LoadAnimationGroup("P_Grappler")
    LoadAnimationGroup("P_Striker")
    LoadAnimationGroup("PunchBag")
    LoadAnimationGroup("Qped")
    LoadAnimationGroup("Rat_Ped")
    LoadAnimationGroup("Russell")
    LoadAnimationGroup("Russell_Pbomb")
    LoadAnimationGroup("Straf_Dout")
    LoadAnimationGroup("Straf_Fat")
    LoadAnimationGroup("Straf_Female")
    LoadAnimationGroup("Straf_Male")
    LoadAnimationGroup("Straf_Nerd")
    LoadAnimationGroup("Straf_Prep")
    LoadAnimationGroup("Straf_Savage")
    LoadAnimationGroup("Straf_Wrest")
    LoadAnimationGroup("TE_Female")
end
