-- Compile to ArcRace1.lur
function MissionSetup()
  AreaTransitionXYZ(0,270,-110,6)
  F_LoadAllAnim()
end
 
function main()
  
  local options = {
    {name = "Spawnar veiculos",func = VehicleSpawner},
    {name = "Style Selector",func = StyleSelector},
    {name = "Weapon Selector",func = WeaponSelector},
    {name = "Tele Transporte", func = TeleTransporte},
    {name = "Setar arma de pedreste", func = SetPedWeapon}
  }
  
  local s = 1
  repeat
    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
      SoundPlay2D("NavUp") 
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
      SoundPlay2D("NavUp") 
    end
    TextPrintString("Simple Trainer v1 By Breno Lins \n \n"..s.."--"..options[s].name,1,1)
    TextPrintString("Navegar: ~dleft~ ~dright~ \n \n Confirmar: ~ddown~  ",4,2)
    if IsButtonBeingPressed(3,0) then
      SoundPlay2D("RightBtn")
      options[s].func()
    end
    if IsButtonBeingPressed(7,0) then
      SoundPlay2D("RightBtn")
      CoordsShow()
    end
    Wait(0)
  until false
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
 
function WeaponSelector()
  local options = {
    {name = "yardstick", id = 299},
    {name = "bat", id = 300},
  }
  local s = 1
  repeat
    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    end
    TextPrintString(s.."-"..options[s].name,1,1)
    Wait(0)
    if IsButtonBeingPressed(3,0) then
     -- PedSetWeapon(gPlayer,options[s].id,1)
     TextPrintString(tostring(IsItemAWeapon(options[s].id)),1,2) -- verificando se o item é uma arma
    end
  until IsButtonBeingPressed(14,0)
end

function TeleTransporte()
  local options = {
    {areaId = 2, xyz = {-628.4, -312.5, -0.0}, areaName = "School"},
    {areaId = 5, xyz = {-701.37, 214.76, 31.55}, areaName = "Principal's" },
    {areaId = 0, xyz = {164.1 ,-73.8 ,14.8}, areaName = "School Mini Roottop"} 
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

  local i = 1
  local VehCont = 0
  repeat

    -- pegando coordenadas x,y,z do jimmy
    local x,y,z = PlayerGetPosXYZ()

    local veiculos = VehicleFindInAreaXYZ(x, y, z, 999)

    if IsButtonBeingPressed(0,0) and i > 1 then
      i = i - 1
    elseif IsButtonBeingPressed(1,0) and i < table.getn(options) then
      i = i + 1
    end
    TextPrintString(i.. "-" .. options[i].name, 1,1 )
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
       VehicleCreateXYZ(options[i].id, x-5, y, z)
    end
  until IsButtonBeingPressed(14,0)

  --TextPrintString("X:"..x.. "Y:" ..y.. "Z:" .. z,5,2)
end
 
function CoordsShow()
    local x,y,z = PlayerGetPosXYZ()
    --TextPrintString("X:"..x.. "Y:" ..y.. "Z:" .. z,5,2)

    -- Imprimir os valores da tabela
   
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
