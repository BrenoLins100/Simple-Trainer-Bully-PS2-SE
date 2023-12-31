local showingCoords = false
local noPunishment = false
local infiniteAmmo = false
local infiniteHealth = false
local snowWeather = false

local currentChapt = ChapterGet()

local mainMenuPos = 1
local modelMenuPos = 1
local vehMenuPos = 1
local styleMenuPos = 1
local weapMenuPos = 1
local weapPedMenuPos = 1
local telePortPos = 1
local clothPosMenu = 1
local outftMenuPos = 1
local miscMenuPos = 1

main = function()
  Wait(500) -- Wait 0.5 seconds. This is needed for some scenarios.
  -- Setup code goes here.


  TextPrintString("Mod by Breno Lins, youtube.com/@brenolins2598",10,1)
  TextPrintString("Press to open the menu: ".."~L1~".. "+".. "~dleft~",10,2)
  

  
  --AreaRegisterAreaScript(22, "AreaScripts/Island3.lua") -- carregando area de teste
  --AreaRegisterAreaScript(31, "AreaScripts/TestArea.lua") -- carregando area de teste
  --AreaRegisterAreaScript(37,"AreaScripts/Funhouse.lua")

  F_LoadAllAnim()

  repeat
    -- Constantly running code goes here.

    DisablePunishmentSystem(noPunishment)
    PedSetFlag(gPlayer, 24, infiniteAmmo)
    PedSetFlag(gPlayer, 30, infiniteHealth)


    if noPunishment then
      PlayerSetPunishmentPoints(0)
    end

    if showingCoords then
      local x,y,z = PlayerGetPosXYZ()
      TextPrintString("Current coordinates:".. "\n" .. "X:".. string.format("%.2f%",x) .. "Y:".. string.format("%.2f%",y) .. "Z:".. string.format("%.2f%",z), 1,2)
    end

    Wait(0) -- Waits 0 seconds. Seems pointless but leave this in!

    if IsButtonBeingPressed(0,0) and IsButtonBeingPressed(10,0) then
      mainMenu()
    end

  until not Alive
end


function mainMenu()

  local options = {
    {name = "Model Selector", func = ModelSelector},
    {name = "Vehicle Spawner",func = VehicleSpawner},
    {name = "Style Selector",func = StyleSelector},
    {name = "Weapon Menu",func = WeaponMenu},
    {name = "Teleport", func = TeleTransporte},
    {name = "Clothing Menu", func = ClotheMenu},
    {name = "Add Money", func = AddMoney},
    {name = "Misc", func = MiscMenu}
  }
  
  local s = mainMenuPos +1
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
      mainMenuPos = s
    end

    local itemsPerPage = 8
    local currentPage = math.ceil(s/itemsPerPage)
    local loopStart = (currentPage -1) * itemsPerPage +1
    local loopEnd = math.min(currentPage * itemsPerPage, table.getn(options))

    
   -- TextPrintString("Simple Trainer v1 By Breno Lins \n\n "..s.."--"..options[s].name,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Close menu: ~R3~  " .. "\nSimple Trainer beta v1.0 By Breno Lins",1,2)

    local menuString = ""
    local menuOptCont = ""

    for j = loopStart, loopEnd do 
      menuString = menuString .. (j == s and "--" or "") ..options[j].name .. (j == s and "--" or "") .. "\n" 
      menuOptCont = s .. "/" .. j 
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
 

function ModelSelector()

  local options = {
    {model = "player" ,name = "Jimmy" ,style = "Player"},
    {model = "DOgirl_Zoe_EG" ,name = "Zoe" ,style = "GS_Female_A"},
    {model = "NDGirl_Beatrice" ,name = "Beatrice" ,style = "GS_Female_A"},
    {model = "NDH1a_Algernon" ,name = "Algernon" ,style = "N_Striker_B"},
    {model = "NDH1_Fatty" ,name = "Fatty" ,style = "N_Striker_A"},
    {model = "ND2nd_Melvin" ,name = "Melvin" ,style = "N_Striker_A"},
    {model = "NDH2_Thad" ,name = "Thad" ,style = "N_Ranged_A"},
    {model = "NDH3_Bucky" ,name = "Bucky" ,style = "N_Ranged_A"},
    {model = "NDH2a_Cornelius" ,name = "Cornelius" ,style = "N_Ranged_A"},
    {model = "NDLead_Earnest" ,name = "Earnest" ,style = "N_Ranged_A"},
    {model = "NDH3a_Donald" ,name = "Donald" ,style = "N_Ranged_A"},
    {model = "JKH1_Damon" ,name = "Damon" ,style = "J_Striker_A"},
    {model = "JKH1a_Kirby" ,name = "Kirby" ,style = "J_Striker_A"},
    {model = "JKGirl_Mandy" ,name = "Mandy" ,style = "GS_Female_A"},
    {model = "JKH2_Dan" ,name = "Dan" ,style = "J_Striker_A"},
    {model = "JKH2a_Luis" ,name = "Luis" ,style = "J_Grappler_A"},
    {model = "JKH3_Casey" ,name = "Casey" ,style = "J_Melee_A"},
    {model = "JKH3a_Bo" ,name = "Bo" ,style = "J_Melee_A"},
    {model = "JKlead_Ted" ,name = "Ted" ,style = "J_Striker_A"},
    {model = "JK2nd_Juri" ,name = "Juri" ,style = "J_Grappler_A"},
    {model = "GR2nd_Peanut" ,name = "Peanut" ,style = "G_Striker_A"},
    {model = "GRH2A_Hal" ,name = "Hal" ,style = "G_Grappler_A"},
    {model = "GRlead_Johnny" ,name = "Johnny" ,style = "G_Striker_A"},
    {model = "GRH1_Lefty" ,name = "Lefty" ,style = "G_Melee_A"},
    {model = "GRGirl_Lola" ,name = "Lola" ,style = "GS_Female_A"},
    {model = "GRH3_Lucky" ,name = "Lucky" ,style = "G_Striker_A"},
    {model = "GRH1a_Vance" ,name = "Vance" ,style = "G_Melee_A"},
    {model = "GRH3a_Ricky" ,name = "Ricky" ,style = "G_Striker_A"},
    {model = "GRH2_Norton" ,name = "Norton" ,style = "G_Grappler_A"},
    {model = "PRH1_Gord" ,name = "Gord" ,style = "P_Striker_A"},
    {model = "PRH1a_Tad" ,name = "Tad" ,style = "P_Striker_A"},
    {model = "PRH2a_Chad" ,name = "Chad" ,style = "P_Grappler_A"},
    {model = "PR2nd_Bif" ,name = "Bif" ,style = "P_Striker_A"},
    {model = "PRH3_Justin" ,name = "Justin" ,style = "P_Striker_B"},
    {model = "PRH2_Bryce" ,name = "Bryce" ,style = "P_Grappler_A"},
    {model = "PRH2_Bryce_OBOX" ,name = "Bryce" ,style = "P_Striker_A"},
    {model = "PRlead_Darby" ,name = "Darby" ,style = "P_Striker_A"},
    {model = "PRGirl_Pinky" ,name = "Pinky" ,style = "GS_Female_A"},
    {model = "GN_Asiangirl" ,name = "Angie" ,style = "GS_Female_A"},
    {model = "PRH3a_Parker" ,name = "Parker" ,style = "P_Striker_B"},
    {model = "DOH2_Jerry" ,name = "Jerry" ,style = "DO_Grappler_A"},
    {model = "DOH1a_Otto" ,name = "Otto" ,style = "DO_Striker_A"},
    {model = "DOH2a_Leon" ,name = "Leon" ,style = "DO_Striker_A"},
    {model = "DOH1_Duncan" ,name = "Duncan" ,style = "DO_Striker_A"},
    {model = "DOH3_Henry" ,name = "Henry" ,style = "DO_Grappler_A"},
    {model = "DOH3a_Gurney" ,name = "Gurney" ,style = "DO_Grappler_A"},
    {model = "DO2nd_Omar" ,name = "Omar" ,style = "DO_Striker_A"},
    {model = "DOGirl_Zoe" ,name = "Zoe" ,style = "GS_Female_A"},
    {model = "PF2nd_Max" ,name = "Max" ,style = "Authority"},
    {model = "PFH1_Seth" ,name = "Seth" ,style = "Authority"},
    {model = "PFH2_Edward" ,name = "Edward" ,style = "Authority"},
    {model = "PFlead_Karl" ,name = "Karl" ,style = "Authority"},
    {model = "TO_Orderly" ,name = "Theo" ,style = "LE_Orderly_A"},
    {model = "TE_HallMonitor" ,name = "MissPeabody" ,style = "TE_Female_A"},
    {model = "TE_GymTeacher" ,name = "MrBurton" ,style = "Authority"},
    {model = "TE_Janitor" ,name = "MrLuntz" ,style = "CV_Male_A"},
    {model = "TE_English" ,name = "MrGalloway" ,style = "Authority"},
    {model = "TE_Cafeteria" ,name = "Edna" ,style = "Authority"},
    {model = "TE_Secretary" ,name = "MissWinston" ,style = "TE_Female_A"},
    {model = "TE_Nurse" ,name = "MrsMcRae" ,style = "TE_Female_A"},
    {model = "TE_MathTeacher" ,name = "MrHuntingdon" ,style = "Authority"},
    {model = "TE_Librarian" ,name = "MrsCarvin" ,style = "TE_Female_A"},
    {model = "TE_Art" ,name = "MsPhillips" ,style = "TE_Female_A"},
    {model = "TE_Biology" ,name = "MrSlawter" ,style = "Authority"},
    {model = "TE_Principal" ,name = "DrCrabblesnitch" ,style = "Authority"},
    {model = "GN_Littleblkboy" ,name = "Sheldon" ,style = "GS_Male_A"},
    {model = "GN_SexyGirl" ,name = "Christy" ,style = "GS_Female_A"},
    {model = "GN_Littleblkgirl" ,name = "Gloria" ,style = "GS_Female_A"},
    {model = "GN_Hispanicboy" ,name = "Pedro" ,style = "GS_Male_A"},
    {model = "GN_Greekboy" ,name = "Constantinos" ,style = "GS_Male_A"},
    {model = "GN_Fatboy" ,name = "Ray" ,style = "GS_Fat_A"},
    {model = "GN_Boy01" ,name = "Ivan" ,style = "GS_Male_A"},
    {model = "GN_Boy02" ,name = "Trevor" ,style = "GS_Male_A"},
    {model = "GN_Fatgirl" ,name = "Eunice" ,style = "GS_Fat_A"},
    {model = "DOlead_Russell" ,name = "Russell" ,style = "B_Striker_A"},
    {model = "TO_Business1" ,name = "DrBambillo" ,style = "CV_Male_A"},
    {model = "TO_Business2" ,name = "MrSullivan" ,style = "CV_Male_A"},
    {model = "TO_BusinessW1" ,name = "MsKopke" ,style = "CV_Female_A"},
    {model = "TO_BusinessW2" ,name = "MsRushinski" ,style = "CV_Female_A"},
    {model = "TO_RichW1" ,name = "MsIsaacs" ,style = "CV_Female_A"},
    {model = "TO_RichW2" ,name = "BethanyJones" ,style = "CV_Female_A"},
    {model = "TO_Fireman" ,name = "ORourke" ,style = "CV_Male_A"},
    {model = "TO_Cop" ,name = "OfficerMonson" ,style = "Authority"},
    {model = "TO_Comic" ,name = "ZackOwens" ,style = "CV_Male_A"},
    {model = "GN_Bully03" ,name = "Trent" ,style = "B_Striker_A"},
    {model = "TO_Bikeowner" ,name = "TobiasMason" ,style = "CV_Male_A"},
    {model = "TO_Hobo" ,name = "MrGrant" ,style = "CV_Male_A"},
    {model = "Player_Mascot" ,name = "Mascot" ,style = "J_Mascot"},
    {model = "TO_GroceryOwner" ,name = "MrOh" ,style = "CV_Male_A"},
    {model = "GN_Sexygirl_UW" ,name = "Christy" ,style = "GS_Female_A"},
    {model = "DOLead_Edgar" ,name = "Edgar" ,style = "DO_Striker_A"},
    {model = "JK_LuisWrestle" ,name = "Luis" ,style = "J_Grappler_A"},
    {model = "JKGirl_MandyUW" ,name = "Mandy" ,style = "GS_Female_A"},
    {model = "PRGirl_PinkyUW" ,name = "Pinky" ,style = "GS_Female_A"},
    {model = "NDGirl_BeatriceUW" ,name = "Beatrice" ,style = "GS_Female_A"},
    {model = "GRGirl_LolaUW" ,name = "Lola" ,style = "GS_Female_A"},
    {model = "TO_Cop2" ,name = "OfficerWilliams" ,style = "Authority"},
    {model = "Player_OWres" ,name = "Jimmy" ,style = "Player"},
    {model = "GN_Bully02" ,name = "Davis" ,style = "B_Striker_A"},
    {model = "TO_RichM1" ,name = "MrBreckindale" ,style = "CV_Male_A"},
    {model = "TO_RichM2" ,name = "MrDoolin" ,style = "CV_Male_A"},
    {model = "GN_Bully01" ,name = "Troy" ,style = "B_Striker_A"},
    {model = "TO_FireOwner" ,name = "Nate" ,style = "CV_Male_A"},
    {model = "TO_CSOwner_2" ,name = "MrCarmichael" ,style = "CV_Male_A"},
    {model = "TO_CSOwner_3" ,name = "NickyCharles" ,style = "CV_Male_A"},
    {model = "TE_Chemistry" ,name = "MrWatts" ,style = "Authority"},
    {model = "TO_Poorwoman" ,name = "MissAbby" ,style = "CV_OLD"},
    {model = "TO_MotelOwner" ,name = "Mihailovich" ,style = "CV_Male_A"},
    {model = "JKKirby_FB" ,name = "Kirby" ,style = "J_Striker_A"},
    {model = "JKTed_FB" ,name = "Ted" ,style = "J_Striker_A"},
    {model = "JKDan_FB" ,name = "Dan" ,style = "J_Striker_A"},
    {model = "JKDamon_FB" ,name = "Damon" ,style = "J_Striker_A"},
    {model = "TO_Carny02" ,name = "Freeley" ,style = "CV_Male_A"},
    {model = "TO_Carny01" ,name = "Dorsey" ,style = "CV_Male_A"},
    {model = "TO_CarnyMidget" ,name = "Hector" ,style = "CV_Male_A"},
    {model = "TO_Poorman2" ,name = "Osbourne" ,style = "CV_Male_A"},
    {model = "PRH2A_Chad_OBOX" ,name = "Chad" ,style = "P_Striker_A"},
    {model = "PRH3_Justin_OBOX" ,name = "Justin" ,style = "P_Striker_A"},
    {model = "PRH3a_Parker_OBOX" ,name = "Parker" ,style = "P_Striker_A"},
    {model = "TO_BarberRich" ,name = "MariaTheresa" ,style = "CV_Female_A"},
    {model = "GenericWrestler" ,name = "Bob" ,style = "GS_Male_A"},
    {model = "ND_FattyWrestle" ,name = "Fatty" ,style = "GS_Male_A"},
    {model = "TO_Industrial" ,name = "Chuck" ,style = "CV_Male_A"},
    {model = "TO_Associate" ,name = "Ian" ,style = "CV_Male_A"},
    {model = "TO_Asylumpatient" ,name = "Fenwick" ,style = "DO_Striker_A"},
    {model = "TE_Autoshop" ,name = "Neil" ,style = "Authority"},
    {model = "TO_Mailman" ,name = "MrSvenson" ,style = "CV_Male_A"},
    {model = "TO_Tattooist" ,name = "Denny" ,style = "CV_Male_A"},
    {model = "TE_Assylum" ,name = "MrGalloway" ,style = "Authority"},
    {model = "Nemesis_Gary" ,name = "Gary" ,style = "B_Striker_A"},
    {model = "TO_Oldman2" ,name = "Krakauer" ,style = "CV_OLD"},
    {model = "TO_BarberPoor" ,name = "MrMoratti" ,style = "CV_Male_A"},
    {model = "PR2nd_Bif_OBOX" ,name = "Bif" ,style = "P_Striker_A"},
    {model = "Peter" ,name = "Peter" ,style = "GS_Male_A"},
    {model = "TO_RichM3" ,name = "MrSmith" ,style = "CV_Male_A"},
    {model = "Rat_Ped" ,name = "Rat" ,style = "AN_Rat"},
    {model = "GN_LittleGirl_2" ,name = "Melody" ,style = "GS_Female_A"},
    {model = "GN_LittleGirl_3" ,name = "Karen" ,style = "GS_Female_A"},
    {model = "GN_WhiteBoy" ,name = "Gordon" ,style = "GS_Male_A"},
    {model = "TO_FMidget" ,name = "Brandy" ,style = "GS_Male_A"},
    {model = "Dog_Pitbull" ,name = "Pitbull" ,style = "AN_DOG"},
    {model = "GN_SkinnyBboy" ,name = "Lance" ,style = "GS_Male_A"},
    {model = "TO_Carnie_female" ,name = "Crystal" ,style = "CV_Female_A"},
    {model = "TO_Business3" ,name = "MrMartin" ,style = "CV_Male_A"},
    {model = "GN_Bully04" ,name = "Ethan" ,style = "B_Striker_A"},
    {model = "GN_Bully05" ,name = "Wade" ,style = "B_Striker_A"},
    {model = "GN_Bully06" ,name = "Tom" ,style = "B_Striker_A"},
    {model = "TO_Business4" ,name = "MrRamirez" ,style = "CV_Male_A"},
    {model = "TO_Business5" ,name = "MrHuntingdon" ,style = "CV_Male_A"},
    {model = "DO_Otto_asylum" ,name = "Otto" ,style = "DO_Striker_A"},
    {model = "TE_History" ,name = "MrWiggins" ,style = "Authority"},
    {model = "TO_Record" ,name = "Floyd" ,style = "CV_Male_A"},
    {model = "DO_Leon_Assylum" ,name = "Leon" ,style = "DO_Striker_A"},
    {model = "DO_Henry_Assylum" ,name = "Henry" ,style = "DO_Striker_A"},
    {model = "NDH1_FattyChocolate" ,name = "Fatty" ,style = "N_Striker_A"},
    {model = "TO_GroceryClerk" ,name = "Stan" ,style = "CV_Male_A"},
    {model = "TO_Handy" ,name = "Handy" ,style = "CV_OLD"},
    {model = "TO_Orderly2" ,name = "Gregory" ,style = "LE_Orderly_A"},
    {model = "GN_Hboy_Ween" ,name = "Pedro" ,style = "GS_Male_A"},
    {model = "Nemesis_Ween" ,name = "Gary" ,style = "B_Striker_A"},
    {model = "GRH3_Lucky_Ween" ,name = "Lucky" ,style = "G_Striker_A"},
    {model = "NDH3a_Donald_ween" ,name = "Donald" ,style = "N_Ranged_A"},
    {model = "PRH3a_Parker_Ween" ,name = "Parker" ,style = "P_Striker_B"},
    {model = "JKH3_Casey_Ween" ,name = "Casey" ,style = "J_Melee_A"},
    {model = "Peter_Ween" ,name = "Peter" ,style = "GS_Male_A"},
    {model = "GN_AsianGirl_Ween" ,name = "Angie" ,style = "GS_Female_A"},
    {model = "PRGirl_Pinky_Ween" ,name = "Pinky" ,style = "GS_Female_A"},
    {model = "JKH1_Damon_ween" ,name = "Damon" ,style = "J_Striker_A"},
    {model = "GN_WhiteBoy_Ween" ,name = "Gordon" ,style = "GS_Male_A"},
    {model = "GN_Bully01_Ween" ,name = "Ivan" ,style = "B_Striker_A"},
    {model = "GN_Boy02_Ween" ,name = "Trevor" ,style = "B_Striker_A"},
    {model = "PR2nd_Bif_OBOX_D1" ,name = "Bif" ,style = "P_Striker_A"},
    {model = "GRH1a_Vance_Ween" ,name = "Vance" ,style = "G_Melee_A"},
    {model = "NDH2_Thad_Ween" ,name = "Thad" ,style = "N_Ranged_A"},
    {model = "PRGirl_Pinky_BW" ,name = "Pinky" ,style = "GS_Female_A"},
    {model = "DOlead_Russell_BU" ,name = "Russell" ,style = "B_Striker_A"},
    {model = "PRH1a_Tad_BW" ,name = "Tad" ,style = "P_Striker_A"},
    {model = "PRH2_Bryce_BW" ,name = "Bryce" ,style = "P_Grappler_A"},
    {model = "PRH3_Justin_BW" ,name = "Justin" ,style = "P_Striker_B"},
    {model = "GN_Asiangirl_CH" ,name = "Angie" ,style = "GS_Female_A"},
    {model = "GN_Sexygirl_CH" ,name = "Christy" ,style = "GS_Female_A"},
    {model = "PRGirl_Pinky_CH" ,name = "Pinky" ,style = "GS_Female_A"},
    {model = "TO_NH_Res_01" ,name = "MrBuba" ,style = "CV_OLD"},
    {model = "TO_NH_Res_02" ,name = "MrGordon" ,style = "CV_OLD"},
    {model = "TO_NH_Res_03" ,name = "MrsLisburn" ,style = "CV_OLD"},
    {model = "NDH1_Fatty_DM" ,name = "Fatty" ,style = "N_Striker_A"},
    {model = "TO_PunkBarber" ,name = "Betty" ,style = "CV_Male_A"},
    {model = "FightingMidget_01" ,name = "Lightning" ,style = "P_Striker_A"},
    {model = "FightingMidget_02" ,name = "Zeke" ,style = "G_Striker_A"},
    {model = "TO_Skeletonman" ,name = "Alfred" ,style = "CV_Male_A"},
    {model = "TO_Beardedwoman" ,name = "Paris" ,style = "CV_Female_A"},
    {model = "TO_CarnieMermaid" ,name = "Courtney" ,style = "CV_Female_A"},
    {model = "TO_Siamesetwin2" ,name = "Delilah" ,style = "CV_Female_A"},
    {model = "TO_Paintedman" ,name = "Drew" ,style = "CV_Male_A"},
    {model = "TO_GN_Workman" ,name = "Castillo" ,style = "CV_Male_A"},
    {model = "DOLead_Edgar_GS" ,name = "Edgar" ,style = "DO_Striker_A"},
    {model = "DOH3a_Gurney_GS" ,name = "Gurney" ,style = "DO_Grappler_A"},
    {model = "DOH2_Jerry_GS" ,name = "Jerry" ,style = "DO_Grappler_A"},
    {model = "DOH2a_Leon_GS" ,name = "Leon" ,style = "DO_Striker_A"},
    {model = "GRH2a_Hal_GS" ,name = "Hal" ,style = "G_Grappler_A"},
    {model = "GRH2_Norton_GS" ,name = "Norton" ,style = "G_Grappler_A"},
    {model = "GR2nd_Peanut_GS" ,name = "Peanut" ,style = "G_Striker_A"},
    {model = "GRH1a_Vance_GS" ,name = "Vance" ,style = "G_Melee_A"},
    {model = "JKH3a_Bo_GS" ,name = "Bo" ,style = "J_Melee_A"},
    {model = "JKH1_Damon_GS" ,name = "Damon" ,style = "J_Striker_A"},
    {model = "JK2nd_Juri_GS" ,name = "Juri" ,style = "J_Grappler_A"},
    {model = "JKH1a_Kirby_GS" ,name = "Kirby" ,style = "J_Striker_A"},
    {model = "NDH1a_Algernon_GS" ,name = "Algernon" ,style = "N_Striker_B"},
    {model = "NDH3_Bucky_GS" ,name = "Bucky" ,style = "N_Ranged_A"},
    {model = "NDH2_Thad_GS" ,name = "Thad" ,style = "N_Ranged_A"},
    {model = "PRH3a_Parker_GS" ,name = "Parker" ,style = "P_Striker_B"},
    {model = "PRH3_Justin_GS" ,name = "Justin" ,style = "P_Striker_B"},
    {model = "PRH1a_Tad_GS" ,name = "Tad" ,style = "P_Striker_A"},
    {model = "PRH1_Gord_GS" ,name = "Gord" ,style = "P_Striker_A"},
    {model = "NDLead_Earnest_EG" ,name = "Earnest" ,style = "N_Ranged_A"},
    {model = "JKlead_Ted_EG" ,name = "Ted" ,style = "J_Striker_A"},
    {model = "GRlead_Johnny_EG" ,name = "Johnny" ,style = "G_Johnny"},
    {model = "PRlead_Darby_EG" ,name = "Darby" ,style = "P_Striker_A"},
    {model = "Dog_Pitbull2" ,name = "Pitbull" ,style = "AN_DOG"},
    {model = "Dog_Pitbull3" ,name = "Pitbull" ,style = "AN_DOG"},
    {model = "TE_CafeMU_W" ,name = "Edna" ,style = "Authority"},
    {model = "TO_Millworker" ,name = "McInnis" ,style = "CV_Male_A"},
    {model = "TO_Dockworker" ,name = "Johnson" ,style = "CV_Male_A"},
    {model = "NDH2_Thad_PJ" ,name = "Thad" ,style = "N_Ranged_A"},
    {model = "GN_Lblkboy_PJ" ,name = "Sheldon" ,style = "GS_Male_A"},
    {model = "GN_Hboy_PJ" ,name = "Pedro" ,style = "GS_Male_A"},
    {model = "GN_Boy01_PJ" ,name = "Ivan" ,style = "GS_Male_A"},
    {model = "GN_Boy02_PJ" ,name = "Trevor" ,style = "GS_Male_A"},
    {model = "TE_Gym_Incog" ,name = "MrBurton" ,style = "Authority"},
    {model = "JK_Mandy_Towel" ,name = "Mandy" ,style = "GS_Female_A"},
    {model = "JK_Bo_FB" ,name = "Bo" ,style = "J_Melee_A"},
    {model = "JK_Casey_FB" ,name = "Casey" ,style = "J_Melee_A"},
    {model = "PunchBag" ,name = "PunchBag" ,style = "PunchBagBS"},
    {model = "TO_Cop3" ,name = "OfficerMonson" ,style = "Authority"},
    {model = "GN_GreekboyUW" ,name = "Constantinos" ,style = "GS_Male_A"},
    {model = "TO_Construct01" ,name = "McInnis" ,style = "CV_Male_A"},
    {model = "TO_Construct02" ,name = "McInnis" ,style = "CV_Male_A"},
    {model = "TO_Cop4" ,name = "OfficerWilliams" ,style = "Authority"},
    {model = "PRH2_Bryce_OBOX_D1" ,name = "Bryce" ,style = "P_Striker_A"},
    {model = "PRH2_Bryce_OBOX_D2" ,name = "Bryce" ,style = "P_Striker_A"},
    {model = "PRH2A_Chad_OBOX_D1" ,name = "Chad" ,style = "P_Striker_A"},
    {model = "PRH2A_Chad_OBOX_D2" ,name = "Chad" ,style = "P_Striker_A"},
    {model = "PR2nd_Bif_OBOX_D2" ,name = "Bif" ,style = "P_Striker_A"},
    {model = "PRH3_Justin_OBOX_D1" ,name = "Justin" ,style = "P_Striker_A"},
    {model = "PRH3_Justin_OBOX_D2" ,name = "Justin" ,style = "P_Striker_A"},
    {model = "PRH3a_Prkr_OBOX_D1" ,name = "Parker" ,style = "P_Striker_A"},
    {model = "PRH3a_Prkr_OBOX_D2" ,name = "Parker" ,style = "P_Striker_A"},
  }

  --salvando posicao do memu
  local s = modelMenuPos

  repeat

    local modelsString = ""
    local itemsCount = 0
  
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
      modelsString = modelsString .. (j == s and "--" or "") ..options[j].name .. (j==s and "--" or "").. "\n" 
      itemsCount = s .. "/" .. table.getn(options)
    end
    TextPrintString("Models:" .. itemsCount .. "\n\n" .. modelsString,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)

    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
      modelMenuPos = s
    end

    Wait(0)

    if IsButtonBeingPressed(3,0) then
    menuPos = s
     PlayerSwapModel(options[s].model)
     PedSetActionTree(gPlayer,"/Global/" .. options[s].style, "Act/Anim/".. options[s].style ..".act")
     PedSetInfiniteSprint(gPlayer, true)
     --TextPrintString("/Global/"..options[s].style .."/Act/Anim/".. options[s].style .. ".act",4,2)
    end


  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")


end

function StyleSelector()
  local options = {
    {name = "Player", style = "Player"},
    {name = "1_03_Davis", style = "1_03_Davis"},
    {name = "AN_DOG", style = "AN_DOG"},
    {name = "Authority", style = "Authority"},
    {name = "B_Striker_A", style = "B_Striker_A"},
    {name = "BOSS_Darby", style = "BOSS_Darby"},
    {name = "BOSS_Russell", style = "BOSS_Russell"},
    {name = "CV_Drunk", style = "CV_Drunk"},
    {name = "CV_Female_A", style = "CV_Female_A"},
    {name = "CV_Male_A", style = "CV_Male_A"},
    {name = "CV_OLD", style = "CV_OLD"},
    {name = "Crazy_Basic", style = "Crazy_Basic"},
    {name = "DO_Edgar", style = "DO_Edgar"},
    {name = "DO_Grappler_A", style = "DO_Grappler_A"},
    {name = "DO_Melee_A", style = "DO_Melee_A"},
    {name = "DO_Striker_A", style = "DO_Striker_A"},
    {name = "G_Grappler_A", style = "G_Grappler_A"},
    {name = "G_Johnny", style = "G_Johnny"},
    {name = "G_Melee_A", style = "G_Melee_A"},
    {name = "G_Ranged_A", style = "G_Ranged_A"},
    {name = "G_Striker_A", style = "G_Striker_A"},
    {name = "GS_Fat_A", style = "GS_Fat_A"},
    {name = "GS_Female_A", style = "GS_Female_A"},
    {name = "GS_Male_A", style = "GS_Male_A"},
    {name = "Hobo_Blocker", style = "Hobo_Blocker"},
    {name = "J_Damon", style = "J_Damon"},
    {name = "J_Grappler_A", style = "J_Grappler_A"},
    {name = "J_Mascot", style = "J_Mascot"},
    {name = "J_Melee_A", style = "J_Melee_A"},
    {name = "J_Striker_A", style = "J_Striker_A"},
    {name = "J_Ted", style = "J_Ted"},
    {name = "LE_Orderly_A", style = "LE_Orderly_A"},
    {name = "N_Earnest", style = "N_Earnest"},
    {name = "N_Ranged_A", style = "N_Ranged_A"},
    {name = "N_Striker_A", style = "N_Striker_A"},
    {name = "N_Striker_B", style = "N_Striker_B"},
    {name = "Nemesis", style = "Nemesis"},
    {name = "P_Bif", style = "P_Bif"},
    {name = "P_Grappler_A", style = "P_Grappler_A"},
    {name = "P_Striker_A", style = "P_Striker_A"},
    {name = "P_Striker_B", style = "P_Striker_B"},
    {name = "PunchBagBS", style = "PunchBagBS"},
    {name = "Russell_102", style = "Russell_102"},
    {name = "TE_Female_A", style = "TE_Female_A"},
    {name = "TE_Secretary", style = "TE_Secretary"}, 
    {name = "TO_Siamese", style = "TO_Siamese"},
  }
  local s = styleMenuPos
  repeat

    local stylesString = ""
    local itemsCount = 0

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

    for j = loopStart,loopEnd do
      stylesString = stylesString .. (s == j and "--" or "") .. options[j].name ..(s == j and "--" or "") .. "\n"
      itemsCount = s .. "/" .. table.getn(options)
    end

    TextPrintString("Styles:"..itemsCount .. "\n\n" .. stylesString,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)

    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
      styleMenuPos = s
    end
    Wait(0)
    if IsButtonBeingPressed(3,0) then
      PedSetActionTree(gPlayer,"/Global/" .. options[s].style,"Act/Anim/".. options[s].style ..".act")
    end
  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")
end
 
function TeleTransporte()
  local options = {
   -- {areaId = 0 xyz = {188.08, -60.44, 23.27}, areaName = "SchoolTop"},
    {areaId = 0, xyz = {0.00, 0.00, 0.00}, areaName = "Main Map"},
    {araeId = 0,  xyz = {272.4 ,300.9 ,1.2}, areaName = "Beach"},
    {areaId = 0, xyz = {-4.4 ,-214.0 ,1.0}, areaName = "Near Observatory"},
    {areaId = 0, xyz = {53.7 ,-582.3 ,32.4}, areaName = "Outside Chem Plant"},
    {areaId = 0, xyz = {73.6 ,-542.8 ,2.7}, areaName = "Near HEM-O Building"},
    {areaId = 0, xyz = {57.0 ,-312.1 ,4.3}, areaName = "Asylum Outside"},
    {areaId = 0, xyz = {647.7 ,83.4 ,8.5 }, areaName = "Dike"},
    {areaId = 0, xyz = {634.2 ,161.4 ,19.9}, areaName = "Graveyard"},
    {areaId = 0, xyz = {536.0 ,374.3 ,17.1}, areaName = "Mini Asylum"},
    {areaId = 0, xyz = {438.5 ,389.2 ,17.2}, areaName = "Park"},
    {areaId = 0, xyz = {443.5 ,505.9 ,22.9 }, areaName = "Tad's House"},
    {areaId = 0, xyz = {271.0 ,-72.9 ,5.9 }, areaName = "Bullworth Academy"},
    {areaId = 0, xyz = {135.5 ,-131.7 ,6.8}, areaName = "Harrington's Yard"},
    {areaId = 0, xyz = {164.1 ,-73.8 ,14.8}, areaName = "School Mini Rooftop"},
    {areaId = 0, xyz = {186.5 ,-3.0 ,5.4}, areaName = "Parking Lot"},
    {areaId = 0, xyz = {-27.9 ,-73.7 ,1.0 }, areaName = "School Field"},
    {areaId = 2, xyz = {-628.28, -312.97, 0.00}, areaName = "School Hallways"},
    {areaId = 4, xyz = {-599.08, 325.00, 34.22}, areaName = "Chemistry Lab"},
    {areaId = 5, xyz = {-701.37, 214.76, 31.55}, areaName = "Principal"},
    {areaId = 6, xyz = {-711.12, 312.25, 33.38}, areaName = "Bio Lab"},
    {areaId = 8, xyz = {-730.91, -56.17, 9.89}, areaName = "Janitors Room"},
    {areaId = 9, xyz = {-786.53, 202.86, 90.13}, areaName = "Library"},
    {areaId = 13, xyz = {-622.60, -72.63, 59.61}, areaName = "Pool"},
    {areaId = 14, xyz = {-502.28, 310.96, 31.41}, areaName = "Boys Dorm"},
    {areaId = 15, xyz = {-560.40, 315.86, -1.95}, areaName = "Classroom"},
    {areaId = 15, xyz = {-515.408, 315.862, -1.95074}, areaName = "Beta Comic Store 1"},
    {areaId = 15, xyz = {-490.40802, 315.862, -1.95074}, areaName = "Beta Comic Store 2"},
    {areaId = 15, xyz = {-470.40802, 315.862, -1.95074}, areaName = "Beta Comic Store 3"},
    {areaId = 16, xyz = {-655.90, 81.57, 9.99}, areaName = "Trailer"},
    {areaId = 17, xyz = {-537.39, 375.90, 14.03}, areaName = "Art Room"},
    {areaId = 18, xyz = {-427.33, 364.87, 80.84}, areaName = "Auto Shop"},
    {areaId = 19, xyz = {-778.50, 294.50, 77.47}, areaName = "Auditorium"},
    {areaId = 20, xyz = {-755.68, 96.27, 30.80}, areaName = "Chem Plant"},
    {areaId = 22, xyz = {-45.10, -1.05, 26.07}, areaName = "Island 3"},
    {areaId = 23, xyz = {-654.19, 227.29, -0.39}, areaName = "Staff Room"},
    {areaId = 26, xyz = {-572.13, 387.32, 0.07}, areaName = "Grocery Store"},
    {areaId = 27, xyz = {-723.70, 371.16, 294.41}, areaName = "Boxing Ring"},
    {areaId = 29, xyz = {-785.62, 379.38, 0.00}, areaName = "Rich Area Bike Shop"},
    {areaId = 30, xyz = {-724.71, 14.51, 0.00}, areaName = "Nerd Hideout"},
    {areaId = 31, xyz = {-17.64, -44.54, 14.54}, areaName = "Test Area"},
    {areaId = 32, xyz = {-567.37, 133.24, 46.15}, areaName = "Prep House"},
    {areaId = 33, xyz = {-707.84, 259.35, 0.00}, areaName = "Rich Area Clothing Store"},
    {areaId = 34, xyz = {-647.37, 257.80, 0.93}, areaName = "Poor Area Clothing Store"},
    {areaId = 35, xyz = {-439.02, 318.77, -7.90}, areaName = "Girls Dorm"},
    {areaId = 36, xyz = {-544.59, -49.03, 31.00}, areaName = "Tenements"},
    {areaId = 37, xyz = {-712.556, -537.923, 9.35246}, areaName = "Fun House 1"},
    {areaId = 37, xyz = {-746.428, -538.773, 7.9198}, areaName = "Fun House 2"},
    {areaId = 37, xyz = {-752.677, -527.682, 24.5883}, areaName = "Fun House 3"},
    {areaId = 37, xyz = {-723.806, -401.365, 12.4154}, areaName = "Fun House 4"},
    {areaId = 37, xyz = {-709.757, -414.219, 10.7562}, areaName = "Fun House 5"},
    {areaId = 37, xyz = {-783.762, -475.494, 15.5488}, areaName = "Fun House 6"},
    {areaId = 37, xyz = {-766.544, -503.099, 24.719}, areaName = "Fun House 7"},
    {areaId = 37, xyz = {-703.757, -414.219, 9.7562}, areaName = "Fun House 8"},
    {areaId = 38, xyz = {-735.31, 422.98, 2.00}, areaName = "Asylum"},
    {areaId = 39, xyz = {-655.66, 124.12, 2.99}, areaName = "Barber"},
    {areaId = 40, xyz = {-694.96, 75.75, 20.25}, areaName = "Observatory"},
    {areaId = 42, xyz = {-310.60, 496.36, 1.00}, areaName = "Outdoor Go-Kart Track"},
    {areaId = 43, xyz = {-736.5 ,-624.6 ,3.2}, areaName = "Junkyard"},
    {areaId = 43, xyz = {-753.54, -606.70, 6.75}, areaName = "Junkyard Crane"},
    {areaId = 44, xyz = {-755.12, 382.59, 0.00}, areaName = "Record Store"},
    {areaId = 45, xyz = {-793.77, 90.9668, 9.96795}, areaName = "Carnival 1"},
    {areaId = 45, xyz = {-790.818, 73.9668, 9.96795}, areaName = "Carnival 2"},
    {areaId = 45, xyz = {-811.818, 73.9668, 9.96795}, areaName = "Carnival 3"},
    {areaId = 45, xyz = {-831.818, 73.9668, 9.96795}, areaName = "Carnival 4"},
    {areaId = 45, xyz = {-850.818, 73.9668, 9.96795}, areaName = "Carnival 5"},
    {areaId = 45, xyz = {-869.818, 73.9668, 9.96795}, areaName = "Carnival 6"},
    {areaId = 45, xyz = {-890.818, 73.9668, 9.96795}, areaName = "Carnival 7"},
    {areaId = 46, xyz = {-766.53, 21.18, 2.95}, areaName = "Hair Salon"},
    {areaId = 50, xyz = {-792.76, 47.74, 6.69}, areaName = "Carnival Souvenir Shop"},
    {areaId = 51, xyz = {-88.38, 68.73, 26.63}, areaName = "Arcade Track 1"},
    {areaId = 52, xyz = {-36.88, 38.91, 0.45}, areaName = "Arcade Track 2"},
    {areaId = 53, xyz = {-39.78, 62.38, 62.15}, areaName = "Arcade Track 3"},
    {areaId = 54, xyz = {-672.29, -169.27, 0.06}, areaName = "Warehouse"},
    {areaId = 55, xyz = {-469.43, -77.54, 9.07}, areaName = "Freak Show"},
    {areaId = 55, xyz = {-455.709, -66.7441, 9.06174}, areaName = "Skeleton"},
    {areaId = 55, xyz = {-440.709, -54.744102, 9.06174}, areaName = "Paris Fat Lady"},
    {areaId = 55, xyz = {-450.859, -36.1411, 9.80341}, areaName = "Siamese"},
    {areaId = 55, xyz = {-463.267, -47.8286, 9.80341}, areaName = "Midget Fight"},
    {areaId = 55, xyz = {-477.043, -38.299, 9.80341}, areaName = "Tatoo Guy"},
    {areaId = 55, xyz = {-486.37, -50.4066, 9.80341}, areaName = "Mermaid"},
    {areaId = 56, xyz = {-664.98, 390.62, 2.43}, areaName = "Poor Area Haircut"},
    {areaId = 57, xyz = {-655.29, 246.27, 15.22}, areaName = "Dropout Hideout"},
    {areaId = 58, xyz = {-724.55, 351.33, 2.51}, areaName = "Nerd Hideout"},
    {areaId = 59, xyz = {-748.85, 348.84, 3.51}, areaName = "Jock Hideout"},
    {areaId = 60, xyz = {-773.40, 351.50, 6.41}, areaName = "Beach Clubhouse"},
    {areaId = 61, xyz = {-691.91, 344.91, 3.29}, areaName = "Greaser Hideout"},
    {areaId = 62, xyz = {-775.55, 634.97, 29.11}, areaName = "BMX Track"},
  }
  local s = telePortPos
  repeat

    local areasString = ""
    local teleMenuCont = ""
  
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
    local loopStart = (currentPage - 1) * itemsPerPage +1
    local loopEnd = math.min(currentPage*itemsPerPage, table.getn(options))

    for j = loopStart,loopEnd do 
      areasString = areasString .. (j == s and "--" or "")..options[j].areaName .. (j == s and "--" or "") .. "\n"
      teleMenuCont = s .. "/" .. table.getn(options)
    end
    TextPrintString("Areas:" .. teleMenuCont .. "\n\n" .. areasString,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)
    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
      telePortPos = s
    end
    Wait(0)
    if IsButtonBeingPressed(3,0) then
      --TextPrintString(tostring(options[i].areaId).. tostring(options[i].xyz[3]), 1,2)
      Wait(0)
      AreaTransitionXYZ(options[s].areaId, options[s].xyz[1],options[s].xyz[2],options[s].xyz[3],false)
    end
    until IsButtonBeingPressed(14,0)
    SoundPlay2D("WrongBtn")
  end

  function ClotheMenu()

    Wait(0)

    options = {
      {name = "Clothe Selector", func = ClotheSelector},
      {name = "Outift Selector", func = OutfitSelector},
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

      for i, opc in ipairs(options) do
        menuString = menuString ..  (s == i and "--" or " " )   .. i .. "-" .. opc.name .. "\n"
        menuOptCont = s .. "/" .. i
      end

      TextPrintString(menuString,1,1)
      TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)

      if IsButtonBeingPressed(3,0) then
        SoundPlay2D("RightBtn")
        options[s].func()
      end
      Wait(0)
      until IsButtonBeingPressed(14,0)
      SoundPlay2D("WrongBtn")
  end

  function ClotheSelector()
    local options = {
      {model="R_Jacket1",style=1},
      {model="R_Jacket2",style=1},
      {model="R_Jacket5",style=1},
      {model="R_Sweater1",style=1},
      {model="R_Sweater2",style=1},
      {model="R_Sweater3",style=1},
      {model="R_Sweater4",style=1},
      {model="R_Sweater5",style=1},
      {model="R_SSleeves1",style=1},
      {model="R_SSleeves2",style=1},
      {model="R_SSleeves4",style=1},
      {model="R_SSleeves5",style=1},
      {model="R_SSleeves6",style=1},
      {model="R_LSleeves1",style=1},
      {model="R_LSleeves2",style=1},
      {model="R_LSleeves4",style=1},
      {model="R_LSleeves5",style=1},
      {model="R_Watch1",style=2},
      {model="R_Watch2",style=2},
      {model="R_Watch3",style=2},
      {model="R_Watch4",style=2},
      {model="R_Wristband1",style=3},
      {model="R_Wristband2",style=3},
      {model="R_Wristband3",style=3},
      {model="R_Wristband4",style=3},
      {model="R_Pants1",style=4},
      {model="R_Pants2",style=4},
      {model="R_Pants3",style=4},
      {model="R_Pants4",style=4},
      {model="R_Pants5",style=4},
      {model="R_Shorts1",style=4},
      {model="R_Shorts2",style=4},
      {model="R_Shorts3",style=4},
      {model="R_Shorts4",style=4},
      {model="R_Shorts5",style=4},
      {model="R_Sneakers1",style=5},
      {model="R_Sneakers2",style=5},
      {model="R_Sneakers3",style=5},
      {model="R_Sneakers4",style=5},
      {model="R_Sneakers5",style=5},
      {model="R_Sneakers6",style=5},
      {model="R_Boots1",style=5},
      {model="R_Boots2",style=5},
      {model="R_Boots3",style=5},
      {model="R_Hat1",style=0},
      {model="R_Hat2",style=0},
      {model="R_Hat3",style=0},
      {model="R_Hat4",style=0},
      {model="R_Hat5",style=0},
      {model="R_Hat6",style=0},
      {model="R_TopHat",style=0},
      {model="S_Jacket3",style=1},
      {model="S_Jacket4",style=1},
      {model="S_Sweater1",style=1},
      {model="S_Sweater2",style=1},
      {model="S_Sweater5",style=1},
      {model="S_LSleeves1",style=1},
      {model="S_LSleeves2",style=1},
      {model="S_LSleeves3",style=1},
      {model="S_LSleeves4",style=1},
      {model="S_Wristband1",style=2},
      {model="S_Wristband2",style=3},
      {model="S_Wristband3",style=3},
      {model="S_Wristband4",style=2},
      {model="S_Wristband5",style=3},
      {model="S_Wristband6",style=2},
      {model="S_Pants1",style=4},
      {model="S_Pants3",style=4},
      {model="S_Shorts1",style=4},
      {model="S_Shorts2",style=4},
      {model="S_Shorts3",style=4},
      {model="S_Shorts4",style=4},
      {model="S_Shorts5",style=4},
      {model="S_Shorts6",style=4},
      {model="S_Sneakers1",style=5},
      {model="S_Sneakers2",style=5},
      {model="S_BHat1",style=0},
      {model="S_BHat2",style=0},
      {model="S_BHat3",style=0},
      {model="S_Sunvisor1",style=0},
      {model="S_Sunvisor2",style=0},
      {model="S_Sunvisor3",style=0},
      {model="P_Army1",style=0},
      {model="P_Army2",style=0},
      {model="P_Army3",style=0},
      {model="P_Jacket1",style=1},
      {model="P_Jacket2",style=1},
      {model="P_Jacket3",style=1},
      {model="P_Jacket4",style=1},
      {model="P_Jacket5",style=1},
      {model="P_Jacket6",style=1},
      {model="P_Sweater1",style=1},
      {model="P_Sweater2",style=1},
      {model="P_Sweater3",style=1},
      {model="P_Sweater4",style=1},
      {model="P_Sweater5",style=1},
      {model="P_Sweater6",style=1},
      {model="P_Sweater7",style=1},
      {model="P_Sweater8",style=1},
      {model="P_SSleeves1",style=1},
      {model="P_SSleeves2",style=1},
      {model="P_SSleeves3",style=1},
      {model="P_SSleeves4",style=1},
      {model="P_SSleeves5",style=1},
      {model="P_SSleeves6",style=1},
      {model="P_SSleeves7",style=1},
      {model="P_SSleeves8",style=1},
      {model="P_SSleeves9",style=1},
      {model="P_SSleeves10",style=1},
      {model="P_SSleeves11",style=1},
      {model="P_SSleeves12",style=1},
      {model="P_SSleeves13",style=1},
      {model="P_SSleeves14",style=1},
      {model="P_SSleeves15",style=1},
      {model="P_LSleeves1",style=1},
      {model="P_LSleeves2",style=1},
      {model="P_LSleeves3",style=1},
      {model="P_LSleeves4",style=1},
      {model="P_LSleeves5",style=1},
      {model="P_LSleeves6",style=1},
      {model="P_LSleeves7",style=1},
      {model="P_LSleeves8",style=1},
      {model="P_LSleeves9",style=1},
      {model="P_LSleeves10",style=1},
      {model="P_Watch1",style=2},
      {model="P_Wristband1",style=3},
      {model="P_Wristband2",style=3},
      {model="P_Wristband3",style=3},
      {model="P_Wristband4",style=3},
      {model="P_Wristband5",style=3},
      {model="P_Wristband6",style=3},
      {model="P_Wristband7",style=3},
      {model="P_Wristband8",style=3},
      {model="P_Pants1",style=4},
      {model="P_Pants2",style=4},
      {model="P_Pants3",style=4},
      {model="P_Pants4",style=4},
      {model="P_Pants5",style=4},
      {model="P_Pants6",style=4},
      {model="P_Pants7",style=4},
      {model="P_Sneakers1",style=5},
      {model="P_Sneakers2",style=5},
      {model="P_Sneakers3",style=5},
      {model="P_Sneakers4",style=5},
      {model="P_Sneakers5",style=5},
      {model="P_Sneakers6",style=5},
      {model="P_Sneakers7",style=5},
      {model="P_Sneakers8",style=5},
      {model="P_Sneakers9",style=5},
      {model="P_Sneakers10",style=5},
      {model="P_Sneakers11",style=5},
      {model="P_Sneakers12",style=5},
      {model="P_Sneakers13",style=5},
      {model="P_Sneakers14",style=5},
      {model="P_Sneakers15",style=5},
      {model="P_Sneakers16",style=5},
      {model="P_Sneakers17",style=5},
      {model="P_Sneakers18",style=5},
      {model="P_Sneakers19",style=5},
      {model="P_Boots1",style=5},
      {model="P_Boots2",style=5},
      {model="P_Boots3",style=5},
      {model="P_Boots4",style=5},
      {model="P_BHat1",style=0},
      {model="P_BHat2",style=0},
      {model="P_BHat3",style=0},
      {model="P_BHat4",style=0},
      {model="P_BHat5",style=0},
      {model="P_BHat6",style=0},
      {model="P_Bandana1",style=0},
      {model="P_Bandana2",style=0},
      {model="P_Bandana3",style=0},
      {model="B_Jacket1",style=1},
      {model="B_Jacket2",style=1},
      {model="B_Jacket3",style=1},
      {model="B_Jacket6",style=1},
      {model="B_Sweater2",style=1},
      {model="B_Sweater3",style=1},
      {model="B_Sweater4",style=1},
      {model="B_SSleeves1",style=1},
      {model="B_SSleeves2",style=1},
      {model="B_SSleeves3",style=1},
      {model="B_LSleeves2",style=1},
      {model="B_LSleeves3",style=1},
      {model="B_LSleeves4",style=1},
      {model="B_Jersey1",style=1},
      {model="B_Jersey3",style=1},
      {model="B_Jersey4",style=1},
      {model="B_Jersey5",style=1},
      {model="B_Jersey6",style=1},
      {model="B_Jersey7",style=1},
      {model="B_Jersey8",style=1},
      {model="B_Jersey9",style=1},
      {model="B_Jersey10",style=1},
      {model="B_BigWatch",style=2},
      {model="B_Wristband1",style=3},
      {model="B_Wristband2",style=3},
      {model="B_Wristband3",style=3},
      {model="B_Wristband4",style=3},
      {model="B_Wristband5",style=3},
      {model="B_Wristband6",style=3},
      {model="B_Pants1",style=4},
      {model="B_Pants2",style=4},
      {model="B_Pants3",style=4},
      {model="B_Pants4",style=4},
      {model="B_Pants6",style=4},
      {model="B_Pants7",style=4},
      {model="B_Pants8",style=4},
      {model="B_Shorts1",style=4},
      {model="B_Shorts2",style=4},
      {model="B_Shorts3",style=4},
      {model="B_Shorts4",style=4},
      {model="B_Shorts5",style=4},
      {model="B_Shorts6",style=4},
      {model="B_Shorts7",style=4},
      {model="B_Sneakers1",style=5},
      {model="B_Sneakers2",style=5},
      {model="B_Sneakers3",style=5},
      {model="B_Sneakers4",style=5},
      {model="B_Sneakers5",style=5},
      {model="B_Sneakers6",style=5},
      {model="B_Sneakers8",style=5},
      {model="B_Sneakers9",style=5},
      {model="B_Sneakers10",style=5},
      {model="B_Sneakers11",style=5},
      {model="B_Sneakers12",style=5},
      {model="B_Sneakers13",style=5},
      {model="B_Boots1",style=5},
      {model="B_Boots2",style=5},
      {model="B_Boots3",style=5},
      {model="B_Boots4",style=5},
      {model="B_Boots5",style=5},
      {model="B_BHat1",style=0},
      {model="B_BHat2",style=0},
      {model="B_BHat3",style=0},
      {model="B_BHat4",style=0},
      {model="B_BHat5",style=0},
      {model="B_BHat6",style=0},
      {model="B_Bucket1",style=0},
      {model="B_Bucket2",style=0},
      {model="B_Various1",style=0},
      {model="B_Various2",style=0},
      {model="B_Various3",style=0},
      {model="B_Various4",style=0},
      {model="B_Various5",style=0},
      {model="B_Hunter1",style=0},
      {model="B_Hunter2",style=0},
      {model="B_Hunter3",style=0},
    }
    local s = clothPosMenu
    repeat
  
      local clothesString = ""
      clothOptCont = ""
  
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
        clothesString = clothesString .. (j == s and "--" or "")..options[j].model .. (j == s and "--" or "") .. "\n" 
        clothOptCont = s .. "/" .. table.getn(options)
      end
      TextPrintString("Clothes:" .. clothOptCont .. "\n\n" ..  clothesString,1,1)
      TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)
  
      if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
        SoundPlay2D("NavUp")
        clothPosMenu = s
      end
  
      Wait(0)
      if IsButtonBeingPressed(3,0) then
       --TextPrintString(options[s].sid,1,2)
       ClothingSetPlayer(options[s].style, options[s].model)
       ClothingBuildPlayer()
      end
  
    until IsButtonBeingPressed(14,0)
    SoundPlay2D("WrongBtn")
  end

  function OutfitSelector()
    local options = {
      {model = "Uniform", name = "School Uniform"},
      {model = "Boxing", name = "Boxing Complete"},
      {model = "Boxing NG", name ="Boxing"},
      {model = "Wrestling", name ="Wrestling Uniform"},
      {model = "Mascot", name ="Mascot"},
      {model = "MascotNoHead", name ="Mascot (No Head)"},
      {model = "Orderly",  name ="Orderly Uniform"},
      {model = "Halloween", name = "Halloween"},
      {model = "PJ", name ="Pajamas"},
      {model = "Prison", name ="Prisoner"},
      {model = "Grotto Master", name ="Grotto Master"},
      {model = "Gnome",name ="Gnome"},
      {model = "Fast Food",name ="Fast Food uniform"},
      {model = "Gold Suit",name ="Gold Suit"},
      {model = "BMX Champion",name ="BMX"},
      {model = "Gym Strip",name ="Gym strip"},
      {model = "Ninja_BLK",name ="Black Ninja"},
      {model = "Ninja_WHT",name ="Green Ninja"},
      {model = "Ninja_RED",name ="Red Ninja"},
    }
    local s = outftMenuPos
    repeat
  
      local clothesString = ""
      local outftOptCont = ""
  
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
        clothesString = clothesString .. (j == s and "--" or "")..options[j].name .. (j == s and "--" or "") .. "\n" 
        outftOptCont = s .. "/" .. table.getn(options)
      end
      TextPrintString("Outfits:" .. outftOptCont .. "\n\n" .. clothesString,1,1)
      TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)
  
      if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
        SoundPlay2D("NavUp")
        outftMenuPos = s
      end
  
      Wait(0)
      if IsButtonBeingPressed(3,0) then
       --TextPrintString(options[s].model,1,2)
       ClothingSetPlayerOutfit(options[s].model)
       ClothingBuildPlayer()
      end
  
    until IsButtonBeingPressed(14,0)
    SoundPlay2D("WrongBtn")
  end

-- variavel global usada no VehicleSpawner()
local dirige = false
 
function VehicleSpawner()

  local options = {
    {name = "Bmx Race", id = 248},
    {name = "Retro", id = 249},
    {name = "Crap BMX", id = 250},
    {name = "Bike Cop", id = 251},
    {name = "Scooter", id = 252},
    {name = "Bike", id = 253},
    {name = "Custom Bike", id = 254},
    {name = "Ban Bike", id = 255},
    {name = "Mountain Bike", id = 256},
    {name = "Old Bike", id = 257},
    {name = "Racer", id = 258},
    {name = "Aqua Bike", id = 259},
    {name = "Lawn Mower", id = 260},
    {name = "Arcade 3", id = 261},
    {name = "Taxi Cab", id = 262},
    {name = "Arcade 2", id = 263},
    {name = "Dozer", id = 264},
    {name = "Go Cart", id = 265},
    {name = "Limo", id = 266},
    {name = "Delivery Truck", id = 267},
    {name = "Foreign", id = 268},
    {name = "Cargo Green", id = 269},
    {name = "70 Wagon", id = 270},
    {name = "Police Car", id = 271},
    {name = "Domestic", id = 272},
    {name = "Truck", id = 273},
    {name = "Arcade 1", id = 274},
  }

  local s = vehMenuPos
  local VehCont = 0
  repeat

    -- pegando coordenadas x,y,z do jimmy
    local x,y,z = PlayerGetPosXYZ()

    local veiculos = VehicleFindInAreaXYZ(x, y, z, 999)
    local vehMenu = ""
    local vehOptCont = ""
    

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
      vehMenuPos = s
    end
   
    local itemsPorPagina = 5
    local paginaAtual = math.ceil(s / itemsPorPagina)
    local inicio = (paginaAtual -1) * itemsPorPagina +1
    local fim = math.min(paginaAtual * itemsPorPagina, table.getn(options))

    for j = inicio, fim do
      vehMenu = vehMenu ..  (j == s and "--" or "").. options[j].name ..  (j == s and "--" or "") .. "\n"  
      vehOptCont = s .. "/" .. table.getn(options)                     
    end
    TextPrintString("Vehicles:" .. vehOptCont .. "\n\n" .. vehMenu,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)

    Wait(0)
    if IsButtonBeingPressed(3,0) then
      VehCont = VehCont + 1
      -- caso a funcao que permite o jogador ja esteja ativa previamente.
      if dirige then
        --TextPrintString("Veículo criado!\n".."Veiculos criados:".. VehCont,4,2) -- remover isso depois (log)
      else 
        dirige = true
       -- TextPrintString("Permitindo jogador dirigir!\n veiculo criado.",4,2)
        PedSetFlag(gPlayer, 42, true)
      end

      if VehCont == 15 then
        --TextPrintString("Limite de veículos atingido!\n Limpando area...",4,2)
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

  --print(string.format("%.2f", 472.0723232))
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
        menuString = menuString ..  (s == i and "--" or " " )   .. i .. "-" .. opc.name .. (s == i and "--" or " " )  .."\n"
        menuOptCont = s .. "/" .. i
      end
  
      TextPrintString(menuString,1,1)
      TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~",1,2)
  
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
    {name = "yardstick", id = 277}, 
    {name = "bat", id = 278},  
    {name = "cherryb", id = 279},
    {name = "baseball", id = 280},
    {name = "slingshot", id = 281},
    {name = "marble", id = 282},
    {name = "spudg", id = 283},
    {name = "supersling", id = 284},
    {name = "brocketlauncher", id = 285},
    {name = "brocket", id = 286},
    {name = "stinkbomb", id = 287},
    {name = "apple", id = 288}, 
    {name = "brick", id = 289},
    {name = "eggproj", id = 290},
    {name = "snowball", id = 291},
    {name = "yardstick_DMG", id = 292},
    {name = "lid", id = 293},
    {name = "potato", id = 294},
    {name = "bat_DMG", id = 295},
    {name = "newsroll", id = 298},
    {name = "spraycan", id = 299},
    {name = "sledgehammer", id = 302},
    {name = "fireexting", id = 304},
    {name = "bbagbottle", id = 305},
    {name = "WCamera", id = 306},
    {name = "SocBall", id = 307},
    {name = "SnwBallB", id = 308},
    {name = "Wftball", id = 309},
    {name = "Wfrisbee", id = 313},
    {name = "cricket_DMG", id = 314},
    {name = "chemical", id = 315},
    {name = "Wdish", id = 316},
    {name = "pompom", id = 319},
    {name = "wtrpipe", id = 320},
    {name = "garbpick", id = 321},
    {name = "WHatSVase", id = 323},
    {name = "W_DeadRat", id = 324},
    {name = "Wtray", id = 326},
    {name = "BagMrbls", id = 327},
    {name = "flask", id = 328},
    {name = "chem_stir", id = 329},
    {name = "PlantPot", id = 331},
    {name = "cricket", id = 335},
    {name = "Banana", id = 336},
    {name = "Flowerbund", id = 337},
    {name = "Psheild", id = 338},
    {name = "teddybear", id = 341},
    {name = "SnowShwl (bug)", id = 342},
    {name = "kickme", id = 350},
    {name = "JBroom", id = 355},
    {name = "WBalloon", id = 361},
    {name = "wtrpipeD", id = 362},
    {name = "CHShieldA", id = 365},
    {name = "CHShieldB", id = 366},
    {name = "CHShieldC", id = 367},
    {name = "WHatVase", id = 368},
    {name = "PooBag", id = 377},
    {name = "SK8Board", id = 415},
  }
  local s = weapMenuPos
  repeat

    local weaponsString = ""
    local weapOptCont = ""

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
      weaponsString = weaponsString .. (j == s and "--" or "")..options[j].name .. (j == s and "--" or "") .. "\n" 
      weapOptCont = s .. "/" .. table.getn(options)
    end
    TextPrintString("Weapons:" .. weapOptCont .. "\n\n" .. weaponsString,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~",1,2)
    

    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
      weapMenuPos = s
    end

    Wait(0)
    if IsButtonBeingPressed(3,0) then
      PedSetWeapon(gPlayer,options[s].id,999)
    end

  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")
end

function SetPedWeapon()

  local options = {
    {name = "yardstick", id = 277}, 
    {name = "bat", id = 278},  
    {name = "cherryb", id = 279},
    {name = "baseball", id = 280},
    {name = "slingshot", id = 281},
    {name = "marble", id = 282},
    {name = "spudg", id = 283},
    {name = "supersling", id = 284},
    {name = "brocketlauncher", id = 285},
    {name = "brocket", id = 286},
    {name = "stinkbomb", id = 287},
    {name = "apple", id = 288}, 
    {name = "brick", id = 289},
    {name = "eggproj", id = 290},
    {name = "snowball", id = 291},
    {name = "yardstick_DMG", id = 292},
    {name = "lid", id = 293},
    {name = "potato", id = 294},
    {name = "bat_DMG", id = 295},
    {name = "newsroll", id = 298},
    {name = "spraycan", id = 299},
    {name = "sledgehammer", id = 302},
    {name = "fireexting", id = 304},
    {name = "bbagbottle", id = 305},
    {name = "WCamera", id = 306},
    {name = "SocBall", id = 307},
    {name = "SnwBallB", id = 308},
    {name = "Wftball", id = 309},
    {name = "Wfrisbee", id = 313},
    {name = "cricket_DMG", id = 314},
    {name = "chemical", id = 315},
    {name = "Wdish", id = 316},
    {name = "pompom", id = 319},
    {name = "wtrpipe", id = 320},
    {name = "garbpick", id = 321},
    {name = "WHatSVase", id = 323},
    {name = "W_DeadRat", id = 324},
    {name = "Wtray", id = 326},
    {name = "BagMrbls", id = 327},
    {name = "flask", id = 328},
    {name = "chem_stir", id = 329},
    {name = "PlantPot", id = 331},
    {name = "cricket", id = 335},
    {name = "Banana", id = 336},
    {name = "Flowerbund", id = 337},
    {name = "Psheild", id = 338},
    {name = "teddybear", id = 341},
    {name = "SnowShwl (bug)", id = 342},
    {name = "kickme", id = 350},
    {name = "JBroom", id = 355},
    {name = "WBalloon", id = 361},
    {name = "wtrpipeD", id = 362},
    {name = "CHShieldA", id = 365},
    {name = "CHShieldB", id = 366},
    {name = "CHShieldC", id = 367},
    {name = "WHatVase", id = 368},
    {name = "PooBag", id = 377},
    {name = "SK8Board", id = 415},
  }

  local s = weapPedMenuPos

  repeat

    local weaponsPedString = ""
    local weapOptCont = ""
    
  
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
      local loopStart = (currentPage-1) * itemsPerPage + 1
      local loopEnd = math.min(currentPage * itemsPerPage, table.getn(options))

      for j = loopStart, loopEnd do 
        weaponsPedString = weaponsPedString .. (j == s and "--" or "")..options[j].name .. (j == s and "--" or "") .. "\n" 
        weapOptCont = s .. "/" .. table.getn(options)
      end
      TextPrintString("Weapons:" .. weapOptCont .. "\n\n" .. weaponsPedString,1,1)
      TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)

      if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
        SoundPlay2D("NavUp")
        weapPedMenuPos = s 
      end
      Wait(0)
      if IsButtonBeingPressed(3,0) then
      local targetPed = PedGetTargetPed(gPlayer) -- pedreste sobre a mira
      if PedIsValid(targetPed) then -- verifica se o ped é valido
        --TextPrintString(tostring(TARGET),1,2) --log
        PedSetWeapon(targetPed, options[s].id, 999)
      else
        TextPrintString("Ivalid Ped.",1,2)
      end
    end
  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")
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
    TextPrintString("Money amount:".."$"..tostring(number) .. "\n\n  [+] ~dright~ [-] ~dleft~ [Confirm] ~ddown~ [Back] ~R3~" ,1,2)
    Wait(0)
  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")
end


-- Misc Menu

function MiscMenu()

  local options = {
    {name = "Show current coordinates" .. (showingCoords and "[ON]" or "[OFF]") , func = ShowCoords},
    {name = "Disable Punishment" .. (noPunishment and "[ON]" or "[OFF]"), func = DisablePunishment },
    {name = "Infinite ammo" .. (infiniteAmmo and "[ON]" or "[OFF]"), func = SetInfiniteAmmo },
    {name = "Inifinite health" .. (infiniteHealth and "[ON]" or "[OFF]"), func = SetInfiniteHealth },
    {name = "Snow Weather".. (snowWeather and "[ON]" or "[OFF]"), func = SetSnowWeather }
  }


  local s = miscMenuPos

  repeat

    local miscString = ""

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
    local loopStart = (currentPage - 1) * itemsPerPage + 1
    local loopEnd = math.min(currentPage * itemsPerPage, table.getn(options))

    for j = loopStart, loopEnd do 
      miscString = miscString .. (j==s and "--" or "")..options[j].name .. (j==s and "--" or "").. "\n"
    end
    TextPrintString(miscString,1,1)
    TextPrintString("Navigation: [up]~dleft~ [down]~dright~ \n  Confirm: ~ddown~ \n  Back: ~R3~ ",1,2)

    if IsButtonBeingPressed(0,0) or IsButtonBeingPressed(1,0) then
      SoundPlay2D("NavUp")
      miscMenuPos = s
    end

    Wait(0)

    if IsButtonBeingPressed(3,0) then
      SoundPlay2D("RightBtn")
      options[s].func()
    end

  until IsButtonBeingPressed(14,0)
  SoundPlay2D("WrongBtn")

end

function ShowCoords()

  showingCoords = not showingCoords
  MiscMenu()

end


function DisablePunishment()
  noPunishment = not noPunishment
  TextPrintString("You must close all menus while playing to disable punishment.",2,3)
  DisablePunishmentSystem(noPunishment)
  PlayerSetPunishmentPoints(0)
  Wait(3000)
  MiscMenu()
end

function SetInfiniteAmmo()
  infiniteAmmo = not infiniteAmmo
  --TextPrintString("You must close the menu to apply.",2,2)
  PedSetFlag(gPlayer, 24, infiniteAmmo)
  Wait(0)
  MiscMenu()
end

function SetInfiniteHealth()
  infiniteHealth = not infiniteHealth
  PedSetFlag(gPlayer, 30, infiniteHealth)
  Wait(0)
  MiscMenu()
end


function SetSnowWeather()

  snowWeather = not snowWeather
  Wait(100)

  if snowWeather then
    ChapterSet(2)
    AreaLoadSpecialEntities("Christmas",true)
  end

  if not snowWeather then
    ChapterSet(currentChapt)
    AreaLoadSpecialEntities("Christmas",false)
  end

  Wait(0)

  MiscMenu()

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

    -- funhouse scripts
    --LoadAnimationGroup("Area_Funhouse")
    --LoadAnimationGroup("4_04_FunhouseFun")
end



 -- In most cases, you can ignore everything below here
F_AttendedClass = function()
  if IsMissionCompleated("3_08") and not IsMissionCompleated("3_08_PostDummy") then
    return 
  end
  SetSkippedClass(false)
  PlayerSetPunishmentPoints(0)
end
 
F_MissedClass = function()
  if IsMissionCompleated("3_08") and not IsMissionCompleated("3_08_PostDummy") then
    return 
  end
  SetSkippedClass(true)
  StatAddToInt(166)
end
 
F_AttendedCurfew = function()
  if not PedInConversation(gPlayer) and not MissionActive() then
    TextPrintString("You got home in time for curfew", 4)
  end
end
 
F_MissedCurfew = function()
  if not PedInConversation(gPlayer) and not MissionActive() then
    TextPrint("TM_TIRED5", 4, 2)
  end
end
 
F_StartClass = function()
  if IsMissionCompleated("3_08") and not IsMissionCompleated("3_08_PostDummy") then
    return 
  end
  F_RingSchoolBell()
  local l_6_0 = PlayerGetPunishmentPoints() + GetSkippingPunishment()
end
 
F_EndClass = function()
  if IsMissionCompleated("3_08") and not IsMissionCompleated("3_08_PostDummy") then
    return 
  end
  F_RingSchoolBell()
end
 
F_StartMorning = function()
  F_UpdateTimeCycle()
end
 
F_EndMorning = function()
  F_UpdateTimeCycle()
end
 
F_StartLunch = function()
  if IsMissionCompleated("3_08") and not IsMissionCompleated("3_08_PostDummy") then
    F_UpdateTimeCycle()
    return 
  end
  F_UpdateTimeCycle()
end
 
F_EndLunch = function()
  F_UpdateTimeCycle()
end
 
F_StartAfternoon = function()
  F_UpdateTimeCycle()
end
 
F_EndAfternoon = function()
  F_UpdateTimeCycle()
end
 
F_StartEvening = function()
  F_UpdateTimeCycle()
end
 
F_EndEvening = function()
  F_UpdateTimeCycle()
end
 
F_StartCurfew_SlightlyTired = function()
  F_UpdateTimeCycle()
end
 
F_StartCurfew_Tired = function()
  F_UpdateTimeCycle()
end
 
F_StartCurfew_MoreTired = function()
  F_UpdateTimeCycle()
end
 
F_StartCurfew_TooTired = function()
  F_UpdateTimeCycle()
end
 
F_EndCurfew_TooTired = function()
  F_UpdateTimeCycle()
end
 
F_EndTired = function()
  F_UpdateTimeCycle()
end
 
F_Nothing = function()
end
 
F_ClassWarning = function()
  if IsMissionCompleated("3_08") and not IsMissionCompleated("3_08_PostDummy") then
    return 
  end
  local l_23_0 = math.random(1, 2)
end
 
F_UpdateTimeCycle = function()
  if not IsMissionCompleated("1_B") then
    local l_24_0 = GetCurrentDay(false)
    if l_24_0 < 0 or l_24_0 > 2 then
      SetCurrentDay(0)
    end
  end
  F_UpdateCurfew()
end
 
F_UpdateCurfew = function()
  local l_25_0 = shared.gCurfewRules
  if not l_25_0 then
    l_25_0 = F_CurfewDefaultRules
  end
  l_25_0()
end
 
F_CurfewDefaultRules = function()
  local l_26_0 = ClockGet()
  if l_26_0 >= 23 or l_26_0 < 7 then
    shared.gCurfew = true
  else
    shared.gCurfew = false
  end
end