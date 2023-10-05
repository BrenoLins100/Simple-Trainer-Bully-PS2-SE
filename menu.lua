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
    {name = "Tele Transporte", func = TeleTransporte}
  }
  
  local s = 1
  repeat
    if IsButtonBeingPressed(0,0) and s > 1 then
      s = s - 1
    elseif IsButtonBeingPressed(1,0) and s < table.getn(options) then
      s = s + 1
    end
    TextPrintString("Simple Trainer v1 By Breno Lins \n \n"..s.."--"..options[s].name,1,1)
    if IsButtonBeingPressed(3,0) then
      options[s].func()
    end
    if IsButtonBeingPressed(8,0) then
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
  PlayerSetPosXYZArea(-701.37, 214.76, 31.55, 5)
  Wait(10000)
  PlayerSetPosXYZArea(-628.28, -312.97, 0.00,2)
while AreaIsLoading() do
	Wait(0)
end
TextPrintString("Teleporte feito com sucesso!", 1, 1)
end


 -- verificando se e a primeira vez que o script é chamado

local dirige = false
 
function VehicleSpawner()

  local options = {
    {name = "Bmx Race", id = 272 },
    {name = "Bike retro", id= 273},
    {name = "Moto policial", id= 275},
    {name = "Cortador de grama", id = 284},
    {name = "Viatura policial", id = 295}
  }
  -- pegando coordenadas x,y,z do jimmy
  local x,y,z = PlayerGetPosXYZ()
  local i = 1
  repeat
    if IsButtonBeingPressed(0,0) and i > 1 then
      i = i - 1
    elseif IsButtonBeingPressed(1,0) and i < table.getn(options) then
      i = i + 1
    end
    TextPrintString(i.. "-" .. options[i].name, 1,1 )
    Wait(0)
    if IsButtonBeingPressed(3,0) then

      -- caso a funcao que permite o jogador ja esteja ativa previamente.
      if dirige then
        TextPrintString("Já dirige!",4,2) -- remover isso depois (log)
      else 
        dirige = true
        TextPrintString("Permitindo jogador dirigir!",4,2)
        PedSetFlag(gPlayer, 42, true)
      end

       -- criando veiculo x-5 -> para que o veiculo nao nasça em cima do jimmy
       VehicleCreateXYZ(options[i].id, x-5, y, z)
    end
  until IsButtonBeingPressed(14,0)

  --TextPrintString("X:"..x.. "Y:" ..y.. "Z:" .. z,5,2)
end
 
function CoordsShow()
    local x,y,z = PlayerGetPosXYZ()
    TextPrintString("X:"..x.. "Y:" ..y.. "Z:" .. z,5,2)
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
