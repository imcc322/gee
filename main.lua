-- @Author: 作者QQ381990860
-- @Date:   2021-08-13 19:47:31
-- @Last Modified by:   作者QQ381990860
-- @Last Modified time: 2023-03-26 07:06:47



__gge.safecall = function (func,...)
    local args = { ... };
    local ret = {xpcall(function() return func(unpack(args)) end, __gge.traceback)}
    if ret[1] and ret[2] then
        return unpack(ret, 2)
    end
    return false
end
错误日志 = ""
错误数目 = 0
__S服务 = require("ggeserver")()
DebugMode =__gge.isdebug or false
require("lfs")
ServerDirectory= DebugMode and string.match(lfs.currentdir(), "^(.*)\\") ..[[\服务端\]] or lfs.currentdir()..[[\]]

math.randomseed(os.clock()*1000)
cjson = require("cjson")
__S服务:置工作线程数量(500)
__S服务:置预投递数量(500)
__N连接数 = 0
__C客户信息 = {}
UserData = {}
-----------------------------
运行测试时间 =0
当前时间=os.time()
保存时间=os.date("%H",当前时间).."时"..os.date("%M",当前时间).."分"..os.date("%S",当前时间).."秒 "
f函数 = require("ffi函数")
ffi = require("ffi")
查看数据={}
操作账号 = ""

ServerConfig = {
    时间 = os.time(),
    版本 = f函数.读配置(ServerDirectory .. "config.ini", "mainconfig", "ver") + 0,
    角色id = f函数.读配置(ServerDirectory .. "config.ini", "mainconfig", "id") + 0,
    限制等级 = f函数.读配置(ServerDirectory .. "config.ini", "mainconfig", "lv") + 0,
    key=f函数.读配置(ServerDirectory .. "config.ini", "mainconfig", "key"),
    银子获得率 = 1,
    经验获得率 = 2,
    假人时间= os.time()
}
保存参数 = {起始 = os.time(), 间隔 = 30}--保存间隔5分钟
ServerConfig.启动时间 = os.time()
ServerConfig.分钟 = os.date("%M", os.time())
ServerConfig.小时 = os.date("%H", os.time())



-- ServerConfig.key="Y4MBVyrYZJJfEQLnUax+AA=="



-- mysql = require "luasql.mysql"
-- local env  = mysql.mysql()
--  local conn = env:connect('test','root','123456')
--  print(env,conn)
-- status,errorString = conn:execute([[CREATE TABLE sample3 (id INTEGER, name TEXT)]])
--  print(status,errorString )
-- status,errorString = conn:execute([[INSERT INTO sample3 values('12','Raj')]])
--  print(status,errorString )
-- cursor,errorString = conn:execute([[select * from sample3]])
--  print(cursor,errorString)
-- row = cursor:fetch ({}, "a")
--  while row do
--    print(string.format("Id: %s, Name: %s", row.id, row.name))
--    row = cursor:fetch (row, "a")
--  end
--  -- close everything
--  cursor:close()
--  conn:close()
--  env:close()

function 发送游戏公告(公告内容)
     __S服务:发送(连接id, 99997,1, 公告内容)

end
Network = require("Script/System/Network")()
TeamControl = require("Script/TeamControl")()
Chat = require("Script/Chat")()
RoleControl= require("Script/Role/RoleControl")()
ItemControl = require("Script/Item/ItemControl")()
EquipmentControl=require("Script/Equipment/EquipmentControl")()
摆摊处理类 = require("Script/Stall")()
TaskControl =require("Script/Task/TaskControl")()
GMTool= require("Script/System/GMTool")()
DialogueControl = require("Script/Dialogue/DialogueControl")()
DialogueEvent=require("Script/Dialogue/DialogueEvent")()
FightGet=require("Script/Fight/FightGet")()
商会处理类 = require("Script/Chamber")()
GameActivities = require("Script/Activities/GameActivities")()
帮派竞赛 = require("Script/Activities/Gang")()
MapControl=require("Script/MapControl")()
心跳间隔 = os.time()
bb数据列表 = {}
商会关闭 = false
比武大会数据 = {}
MoneyLog={}
协程列表={}
任务数据 = {}
require("Script/Monster/Monster_race")



do-------重构-------------
  __gge.print(false,7,"-------------------------------------------------------------------------\n")
  CardData=ReadExcel("变身卡数据",ServerConfig.key)
  MapData=ReadExcel("地图数据",ServerConfig.key)
  TransferData=ReadExcel("传送圈数据",ServerConfig.key)
  LabelData=ReadExcel("称谓数据",ServerConfig.key)
  RefreshMonsterData=ReadExcel("刷新怪数据",ServerConfig.key)
  RefreshMonsterTime={}
  for k,v in pairs(RefreshMonsterData) do
       RefreshMonsterTime[k] ={v.刷新时间,v.日期}
  end
    ModelData=ReadExcel("模型数据",ServerConfig.key)
    SkillData=ReadExcel("技能数据",ServerConfig.key)
    ItemData=ReadExcel("物品数据",ServerConfig.key)
    NpcData=ReadExcel("NPC数据",ServerConfig.key)
    QuretionBank =ReadExcel("题库数据",ServerConfig.key)
    BBData=ReadExcel("召唤兽数据",ServerConfig.key)
    ShopData =ReadExcel("商城数据",ServerConfig.key)
    MonsterData=ReadExcel("怪物数据",ServerConfig.key)
    PropertyData=ReadExcel("灵饰特性数据",ServerConfig.key)
    LinkTask =ReadExcel("环任务数据",ServerConfig.key)
    WeaponModel=ReadExcel("光武拓印",ServerConfig.key)

    Reward =ReadExcel("首服奖励",ServerConfig.key)
    Config=ReadExcel("Config",ServerConfig.key)[f函数.读配置(ServerDirectory .. "config.ini", "mainconfig", "ft")+0]
    --内网
    -- Config.ip="10.138.80.4"
    LinkTaskDialogue={}
    LinkTaskClear={}
    LinkTaskEvent1={}
    LinkTaskEvent2={}
    LinkTaskEvent3={}
    for k,v in pairs(LinkTask) do
        LinkTaskDialogue[v.事件]=k
        LinkTaskClear["取消"..k]=k
        LinkTaskEvent1["给予道具("..k..")"]=k
        LinkTaskEvent2["打听消息("..k..")"]=k
        LinkTaskEvent3["开始挑战("..k..")"]=k
    end
    require("Script/System/ComomFunc")

    古玩数据 ={}
    merchandise={银子={},法宝={},祥瑞={},仙玉={},传音={},战锦={},孩子={},活动积分={},知了积分={},天罡积分={},单人积分={},成就积分={},特殊积分={},锦衣={},光环={},脚印={},活跃度={},比武积分={},副本积分={},地煞积分={},定制={},召唤兽={}}
   for key,value in  pairs(ShopData) do
      for k,v in  pairs(merchandise) do
          if value.分类 == k then
            table.insert(merchandise[k],key)
            break;
          end
      end
      if value.分类 == "定制" then
        ShopData[key].锦衣=value.名称
        ShopData[key].造型=value.技能
        ShopData[key].技能=nil
        ShopData[key].名称="GM定制礼包"
        ShopData[key].类型="定制锦衣"
      elseif value.分类 == "召唤兽" then
        ShopData[key] = AddPet(value.名称,value.技能,value.价格)
      else
        ShopData[key] =AddItem(value.名称,value.等级,value.技能,nil,value.价格,nil,value.图标,nil,value.限时)
      end
        ShopData[key].分类 = value.分类
   end

   local tempLottery=ReadExcel("抽奖数据",ServerConfig.key)
   Lottery={普通抽奖={},中等抽奖={},极品抽奖={}}
   for key,value in  pairs(tempLottery) do

      for k,v in  pairs(Lottery) do
          if value.分类 == k then
            table.insert(Lottery[k],value)
            break;
          end
      end

   end

  ShopControl = require("Script/ShopControl")()
end
连接id = 0
   MapDatad={}  ------------豆包
    for k,v in pairs(MapData) do
        if v.怪物 ~=nil  then
              MapDatad[#MapDatad+1]={}
              MapDatad[#MapDatad].地图=k
              MapDatad[#MapDatad].怪物=v.怪物
          end
    end



  function  doubao()
  local 临时信息=MapDatad[math.random(#MapDatad)]
  local 临时模型=取敌人信息(临时信息.怪物[math.random(1,#临时信息.怪物)]) return 临时模型
  end



    商店bb={}
    for n=1,10 do
    local 模型=doubao()
    商店bb[n]={模型=模型[2],价格=math.random(300*10000,900*10000)}
   end
自动抓鬼={}
临时任务 = table.loadstring( ReadFile("数据信息/" .. "任务数据.txt"))
商会数据 = table.loadstring( ReadFile("数据信息/" .. "商会数据.txt"))
自动抓鬼=table.loadstring(ReadFile("数据信息/" .. "自动抓鬼.txt"))
首服奖励 = table.loadstring( ReadFile("数据信息/" .. "首服奖励.txt"))
物品店数据= table.loadstring( ReadFile("数据信息/" .. "物品店数据.txt"))
唤兽店数据= table.loadstring( ReadFile("数据信息/" .. "唤兽店数据.txt"))
首席资源数据 = table.loadstring( ReadFile("数据信息/" .. "首席数据.txt"))
活动数据 =table.loadstring( ReadFile("数据信息/" .. "活动数据.txt"))
签到数据 =table.loadstring( ReadFile("数据信息/" .. "签到数据.txt"))
消息数据={}
帮派数据 = table.loadstring( ReadFile("数据信息/" .. "帮派数据.txt"))
Ranking = table.loadstring( ReadFile("数据信息/" .. "排行数据.txt"))
古玩数据 = table.loadstring( ReadFile("数据信息/" .. "古玩数据.txt"))
for n = 1, #临时任务 do
    任务数据[临时任务[n].加载id] = table.loadstring(table.tostring(临时任务[n]))
end
三界书院 = {答案 = "",开关 = false,结束 = 60,起始 = os.time(),间隔 = math.random(30, 90) * 60,名单 = {}}
昼夜参数=1

无间炼狱数据 = {间隔 = 60,起始 = os.time()}
游戏时辰 = {当前 = 1,刷新 = 120,起始 = os.time()}

服务器关闭 = {计时 = 60,开关 = false,起始 = os.time()}
道人数据 = {宝石 = 20,兽诀 = 10,内丹 = 20}
天罚数据表 = {}
商品存放={}
系统消息数据 = {}
幻域迷宫数据 = {}
摊位数据 = {}
游泳比赛数据 = {}
展示数据 = {}
交易数据 = {}
炼丹炉={时间=120}
炼丹查看={}
天梯匹配={}
快捷抓鬼次数={}
--------
首席争霸赛进场开关 = false
首席争霸赛战斗开关 = false
幻域迷宫开关 = false
飞贼开关 = false
比武大会进场开关 = false
比武大会开始开关 = false
门派闯关开关 = false
游戏比赛开关 =true
师门守卫刷新 = math.random(3600, 7200) + os.time()
华山论剑开关 = false

function 玩家全部下线()
    Save()
    for i=1,#UserData do
        if UserData[i]~=nil then
            __S服务:发送(UserData[i].连接id,99994,1, "77")
        end
    end
    for n, v in pairs(UserData) do
        if UserData[n] ~= nil then
            if UserData[n].战斗 ~= 0 then
                FightGet.战斗盒子[UserData[n].战斗]:强制结束战斗()
                FightGet.战斗盒子[UserData[n].战斗] = nil
            end
            if UserData[n].角色 ~= nil then
                Network:退出处理(n, 1)
            end
        end
    end
    os.exit()
end
function __S服务:启动成功()
    return 0
end
function __S服务:连接进入(ID, IP, PORT)
  __N连接数=0
if  IP~=Config.ip  then
   __S服务:断开连接(ID)
   return 0
  end
      __gge.print(true,7,string.format("网关连接\t\t\t-->"))
      __gge.print(false,7,"\t\t\t[")
      __gge.print(false,10,"成功")
      __gge.print(false,7,"]\n")
      __gge.print(false,7,"-------------------------------------------------------------------------\n")
        __C客户信息[ID] = {
            IP = IP,
            PORT = PORT
        }
   if 连接id==0 and IP==Config.ip  then
         连接id=ID
     end


end
function __S服务:连接退出(ID)
    if __C客户信息[ID] then
      __gge.print(true,7,string.format("网关连接\t\t\t-->"))
      __gge.print(false,7,"\t\t\t[")
      __gge.print(false,12,"失败")
      __gge.print(false,7,"]\n")
      __gge.print(false,7,"-------------------------------------------------------------------------\n")
        if Config.ip  == __C客户信息[ID].IP then
            连接id = 0
        end
    end
end
function __S服务:数据到达(ID, ...)
    运行测试时间 = os.clock()
    local arg = {...}
    if __C客户信息[ID] then
        Network:数据处理(arg[1], arg[2], ID, __C客户信息[ID].IP)
    end
end
function SendMessage(ID, Number, Msg)
      if Msg == nil or ID == nil then
        if  __gge.isdebug  then
             print("错误的数据源" .. Number,Msg,ID)
        end
         return
      end
      if type(Msg)=="table" then
         Msg =table.tostring(Msg)
      elseif type(Msg)=="number" then
         Msg =tostring(Msg)
      end
      __S服务:发送(连接id,Number,ID+0,Msg)
 end
function 清理任务信息()
    for n, v in pairs(任务数据) do
        if 任务数据[n].类型 ~= "秘红罗羹制" and 任务数据[n].类型 ~= "坐骑" and 任务数据[n].类型 ~= "任务链"and 任务数据[n].类型 ~= "打造" and 任务数据[n].类型 ~= "神器任务" then
                任务数据[n] = nil
        end
    end
end
function Save()
    local PCU = 0
    for n, v in pairs(UserData) do
        if v and not v.假人  then
            RoleControl:存档(v)
            PCU = PCU + 1
        end
    end
    __S服务:输出("-------------当前共有" .. PCU .. "个玩家在线-------------")
    __S服务:输出("用户数据保存成功……")
    临时任务 = {}
    for n, v in pairs(任务数据) do
        if 任务数据[n] ~= nil then
            if v.造型 then
                --任务数据[n] = nil
            else
                临时任务[#临时任务 + 1] = table.loadstring(table.tostring(任务数据[n]))
                临时任务[#临时任务].加载id = n
            end
        end
    end
    WriteFile("数据信息/" .. "自动抓鬼.txt",table.tostring(自动抓鬼))
    WriteFile("数据信息/" .. "排行数据.txt", table.tostring(Ranking))
     __S服务:输出("排行数据保存成功……")
    WriteFile("数据信息/" .. "商会数据.txt", table.tostring(商会数据))
    __S服务:输出("商会数据保存成功……")
      WriteFile("数据信息/" .. "首服奖励.txt", table.tostring(首服奖励))
    __S服务:输出("首服奖励保存成功……")
    WriteFile("数据信息/" .. "物品店数据.txt", table.tostring(物品店数据))
    __S服务:输出("物品店数据保存成功……")
    WriteFile("数据信息/" .. "唤兽店数据.txt", table.tostring(唤兽店数据))
    __S服务:输出("唤兽店数据保存成功……")


    WriteFile("数据信息/" .. "首席数据.txt", table.tostring(首席资源数据))
    __S服务:输出("首席数据保存成功……")
    WriteFile("数据信息/" .. "任务数据.txt", table.tostring(临时任务))
    __S服务:输出("任务数据保存成功……")
    WriteFile("数据信息/" .. "活动数据.txt", table.tostring(活动数据))
    __S服务:输出("活动数据保存成功……")
    WriteFile("数据信息/" .. "签到数据.txt", table.tostring(签到数据))
    __S服务:输出("签到数据保存成功……")
    WriteFile("数据信息/" .. "帮派数据.txt", table.tostring(帮派数据))
    __S服务:输出("帮派数据保存成功……")
        WriteFile("数据信息/" .. "古玩数据.txt", table.tostring(古玩数据))
    __S服务:输出("古玩数据保存成功……")
    当前时间 = os.time()
    保存时间 = os.date("%H", 当前时间) .. "时" .. os.date("%M", 当前时间) .. "分" .. os.date("%S", 当前时间) .. "秒 "
    __S服务:输出("错误数量 "..错误数目)
   if not file_exists([[log\]]..os.date("%Y-%m-%d")) then
       os.execute("mkdir "..ServerDirectory..[[log\]]..os.date("%Y-%m-%d"))
   end


    WriteFile(os.date("log/%Y-%m-%d/"..os.time()..".txt"),错误日志)
    错误日志 = ""
    错误数目 = 0
    临时任务 = {}
    __S服务:输出("错误日志已经记录……")
end
function MinuteFunc(time)
    ServerConfig.分钟 = time
    for k,v in pairs(RefreshMonsterTime) do
        if v[2] =="全天" or  v[2] ==os.date("%w") then
           for s,times in ipairs(v[1]) do
                if  times == tonumber(time)  then
                  TaskControl:LoadRefreshMonster(RefreshMonsterData[k],k)
                  break
                end
           end
        end
    end
        if 华山论剑开关 then
        GameActivities:天梯匹配处理()
         __S服务:输出("华山论剑匹配刷新")
     end
    if ServerConfig.小时 + 0 >= 12 and ServerConfig.小时 + 0 <= 17 and 三界书院.间隔 <= os.time() - 三界书院.起始 then
        三界书院.起始 = os.time()
        TaskControl:开启三界书院()
    end
    if time == "05" then
        TaskControl:刷新地妖星(id)
     if   os.date("%w") =="0" then
        if ServerConfig.小时 == "22" then
          TaskControl:刷出帮战宝箱()
          发送游戏公告("宝箱已经散落到帮战奖励地图中，10分钟后将关闭，请获胜帮派取地图中捡取宝箱")
          广播消息("#xt/#y/宝箱已经散落到帮战奖励地图中，10分钟后将关闭，请获胜帮派取地图中捡取宝箱")
        end
      end
    elseif time == "15" then
      if   os.date("%w") =="0" then
        if ServerConfig.小时 == "22" then
          帮派竞赛.宝箱开关=false
           MapControl:传送地图玩家(1380)
        end
      end
    elseif time == "30" then
      TaskControl:刷新天罡星()


     if   os.date("%w") =="0" then
        if ServerConfig.小时 == "19" then
          帮派竞赛.开关=true
          TaskControl:刷出帮战怪物()
          发送游戏公告("帮派竞赛开始，请各位帮战人员开战吧")
          广播消息("帮派竞赛开始，请各位帮战人员开战吧")
       end
        if ServerConfig.小时 == "20" then
            帮派竞赛:结束竞赛()
        end
      end
    elseif time == "35" then
       TaskControl:刷出天罡星69()
      TaskControl:刷出天罡星2()
      TaskControl:刷出天罡星3()
      TaskControl:刷出天罡星4()
      TaskControl:刷出天罡星5()
      TaskControl:刷出天罡星6()

    elseif time == "40" then
         if ServerConfig.小时 == "19" and   os.date("%w") ~="0"  then
            比武大会进场开关 = true
            发送游戏公告("比武大会活动即将开启，各位玩家现在可以通过长安城兰虎进入比武场。20分钟后将无法进入比武场。请参加活动的玩家提前进入比武场。")
        end
    elseif time == "50" then
        if ServerConfig.小时 == "18" and   os.date("%w") ~="0" then
            广播消息("#xt/#r/ 首席争霸赛活动已经开启入场，10分钟后将无法进入比赛地图。请各位玩家提前找本门派首席弟子进入比赛地图。")
            首席争霸赛进场开关 = true
            首席争霸赛战斗开关 = false
        end
    end
end
function 循环函数()
  FightGet:更新()
    TaskControl:更新()
    TimeUpdate()
    if os.time() - ServerConfig.启动时间 >= 1 then
        SecondFuc()
        ServerConfig.启动时间 = os.time()
    end
  if os.time() - ServerConfig.假人时间 >= 10 then
    if 假人移动 then
         local ls= 0;
        local co = coroutine.wrap(
          function()
              for n, v in pairs(UserData) do
                if v.假人  and math.random(100) < 70 then
                  if not UserData[n].摆摊  then
                    ls=ls+1
                      local 临时坐标= MapControl:Randomloadtion(UserData[n].地图)
                      MapControl:玩家移动请求(UserData[n].id, 临时坐标.x.."*-*"..临时坐标.y)
                       if ls ==30 then
                          ls =0
                          coroutine.yield()
                      end
                  end
                end
              end
              return true
          end)
        if not co() then
              协程列表["假人移动"] = co
        end
        ServerConfig.假人时间= os.time()
    end

 end
    if os.date("%X", os.time()) == os.date("%H", os.time()) .. ":00:00" then
        HourFunc(os.date("%H", os.time()))
    elseif ServerConfig.分钟 ~= os.date("%M", os.time()) and os.date("%S", os.time()) == "00" then
        MinuteFunc(os.date("%M", os.time()))
    end
    if 竞拍信息 then
        竞拍信息.剩余时间 = os.time() -竞拍信息.起始
            if os.time() -竞拍信息.起始 >= 60 then
                if 竞拍信息.竞拍id then
                    if UserData[竞拍信息.竞拍id] and  银子检查(竞拍信息.竞拍id,竞拍信息.竞拍价格)  then
                        RoleControl:扣除银子(UserData[竞拍信息.竞拍id],竞拍信息.竞拍价格,"物品竞拍")

                        RoleControl:添加银子(UserData[竞拍信息.id],竞拍信息.竞拍价格,"物品竞拍")
                        RoleControl:添加消费日志(UserData[竞拍信息.竞拍id],"以"..竞拍信息.竞拍价格.."价格竞拍获得"..竞拍信息.物品.名称)

                        local 临时格子 =  RoleControl:取可用道具格子(UserData[竞拍信息.竞拍id],"包裹")
                        local 临时道具 = ItemControl:取道具编号(竞拍信息.竞拍id)
                        local 临时数据 = table.tostring(竞拍信息.物品)
                        UserData[竞拍信息.竞拍id].物品[临时道具] = table.loadstring(临时数据)
                        UserData[竞拍信息.竞拍id].角色.道具.包裹[临时格子] = 临时道具
                        for n, v in pairs(UserData) do
                            SendMessage(UserData[n].连接id, 2032,"竞拍信息")
                            SendMessage(UserData[n].连接id,9,"#pm/#y/竞拍结束恭喜玩家#g/"..竞拍信息.竞拍名称.."#y/以#r/"..竞拍信息.竞拍价格.."#y的价格竞拍到了#g"..竞拍信息.物品.名称)
                        end

                    end
                 else
                    if UserData[竞拍信息.id] then
                        --RoleControl:添加系统消息(UserData[竞拍信息.id],  添加银子(竞拍信息.价格,"物品竞拍")
                        RoleControl:添加消费日志(UserData[竞拍信息.id],"以"..竞拍信息.价格.."价格竞拍取回"..竞拍信息.物品.名称)
                        local 临时格子 = RoleControl:取可用道具格子(UserData[竞拍信息.id],"包裹")
                        local 临时道具 = ItemControl:取道具编号(竞拍信息.id)
                        local 临时数据 = table.tostring(竞拍信息.物品)
                        UserData[竞拍信息.id].物品[临时道具] = table.loadstring(临时数据)
                        UserData[竞拍信息.id].角色.道具.包裹[临时格子] = 临时道具

                        for n, v in pairs(UserData) do
                            SendMessage(UserData[n].连接id, 2032,"竞拍信息")
                            SendMessage(UserData[n].连接id,9,"#pm/#y/竞拍结束玩家#g/"..竞拍信息.名称.."#y/竞拍价#r/"..竞拍信息.价格.."#y的#g"..竞拍信息.物品.名称.."无人竞拍物品已经归还")
                        end

                    end
                 end
                 竞拍信息=nil
            end
    end

end
tchs=os.exit

function HourFunc(time)
  if ServerConfig.小时 == time then
      return 0
  else
      ServerConfig.小时 = time
  end
  TaskControl:帮派扣费()
  if 取道人时间() then
      道人数据 = {宝石 = 10,兽诀 = 10,内丹 = 10}
      广播消息(9, "#xt/#r/傲来国神秘商人所出售的商品刷新了")
  end
  if time=="12" then
    MoneyLog={}
      if tonumber(os.date("%d")) ==1 then
        签到数据 ={}
      end
     活动数据={科举名单={},大雁塔数据={},嘉年华数据={},活跃度={},宝藏山名单={},平定安邦={},师门名单={},无限轮回={},群雄逐鹿={},蚩尤挑战={},抓鬼={},除暴安良={},押镖={},官职={},鬼王={},乌鸡={},车迟={},双倍={},每日答题={},打图={}}
    for n=1,100 do
       活动数据.大雁塔数据[n]={}
     end
   游泳比赛数据 = {}
   天罚数据表={}
   师门守卫刷新=math.random(3600,7200)+os.time()
   广播消息("#xt/#y/皇宫飞贼活动已经开放，各位玩家可前往长安城御林军左统领处领取任务")
   飞贼开关=true
  elseif time=="23" then
  广播消息("#xt/#y/皇宫飞贼活动已经结束。玩家将无法领取新的任务，未完成的任务仍然可以继续完成。")
   飞贼开关=false
  elseif time=="13" then
  广播消息("#xt/#y/皇宫飞贼活动已经结束。玩家将无法领取新的任务，未完成的任务仍然可以继续完成。")
   飞贼开关=false
  elseif time=="19" then
         if   os.date("%w") =="0" then
          帮派竞赛:开启竞赛()
        else
            GameActivities:开启首席争霸赛()
        end
  elseif time == "20" and  os.date("%w") ~="0" then
        TaskControl:开启门派闯关活动()
        发送游戏公告("比武大会活动已开启。各位比武场内的玩家可以通过Alt+A对对方发起攻击。")
       比武大会进场开关 = false
        比武大会开始开关 = true
        MapControl:重置比武大会玩家()
        if 首席争霸赛战斗开关 then
            GameActivities:结束首席争霸门派(1, 3, 0, 0)
        end
    elseif time == "21"  then
     if   os.date("%w") =="0" then
          帮派竞赛.迷宫开关=true
          帮派竞赛.准备迷宫开关=false
          发送游戏公告("帮派迷宫已经开始，请各位帮战人员开战吧")
          广播消息("帮派迷宫已经开始，请各位帮战人员开战吧")
      else
        TaskControl:结束门派闯关活动()
        发送游戏公告("比武大会活动已结束。玩家将无法发起攻击。奖励将在服务器下一次重启时消除，请尽快前往兰虎处领取奖励")
        比武大会开始开关 = false
      end

    elseif time == "22" then
        if   os.date("%w") =="0" then
        帮派竞赛:结束迷宫()
        end
        广播消息("#xt/#y/皇宫飞贼活动已经开放，各位玩家可前往长安城御林军左统领处领取任务")
        飞贼开关 = true
    end
end
function SecondFuc(t)
    for i,co in pairs(协程列表) do
        if co() then
            协程列表[i] = nil
        end
    end
    -- GameActivities:炼丹更新()
    if  竞拍信息 then
      for i=1,#竞拍信息.接受者 do
          if UserData[竞拍信息.接受者[i]] then
           SendMessage(UserData[竞拍信息.接受者[i]].连接id, 2029,竞拍信息)
          end
      end
    end
    if ServerConfig.小时 + 0 > 12 and ServerConfig.小时 + 0 < 22 and 师门守卫刷新 <= os.time() then
        师门守卫刷新 = math.random(3600, 7200) + os.time()

        TaskControl:刷出师门守卫()
    end
    if 三界书院.开关 and 三界书院.结束 <= os.time() - 三界书院.起始 then
        三界书院.开关 = false

        for n = 1, #三界书院.名单 do
            if UserData[三界书院.名单[n].id] ~= nil then
                RoleControl:添加银子(UserData[三界书院.名单[n].id],100000, 19)
            end
        end
        广播消息(9, "#xt/#y/正确答案：#r/" .. 三界书院.答案)
        if #三界书院.名单 == 0 then
            广播消息(9, "#xt/#y/真是遗憾，竟然无人可以回答正确。")
        else
            广播消息(9, "#xt/#y/知识就是金钱，每一位作答正确的玩家均获得10万两银子以作奖励。#g/" .. 三界书院.名单[1].名称 .. "#y/以#r/" .. 三界书院.名单[1].用时 .. "#y/秒惊人的飞速抢先作答正确，获得了额外的100万两银子、随机怪物卡片*1的奖励。")

            if UserData[三界书院.名单[1].id] ~= nil then
                  RoleControl:添加银子(UserData[三界书院.名单[1].id],1000000, 19)
                 local 卡片 ={"海星","狸","章鱼","大海龟","大蝙蝠","赌徒","海毛虫","护卫","巨蛙","强盗","山贼","树怪" ,"蛤蟆精","黑熊","狐狸精","花妖",
                         "老虎","羊头怪","骷髅怪","狼","牛妖","虾兵","小龙女","蟹将","野鬼","龟丞相","黑熊精","僵尸","马面","牛头","兔子怪","蜘蛛精","白熊",
                         "进阶白熊","古代瑞兽","进阶古代瑞兽","黑山老妖","进阶黑山老妖","蝴蝶仙子","进阶蝴蝶仙子","雷鸟人","进阶雷鸟人","地狱战神","进阶地狱战神",
                         "风伯","进阶风伯","天兵","进阶天兵","天将","进阶天将" ,"凤凰" ,"进阶凤凰","雨师","进阶雨师","蛟龙","进阶蛟龙","蚌精","进阶蚌精",
                         "进阶碧水夜叉","碧水夜叉","进阶鲛人","百足将军","进阶百足将军","锦毛貂精","进阶锦毛貂精","镜妖","进阶镜妖","泪妖","进阶泪妖","千年蛇魅",
                         "进阶千年蛇魅","如意仙子","进阶如意仙子","鼠先锋","进阶鼠先锋","星灵仙子","进阶星灵仙子","巡游天神","进阶巡游天神","野猪精","进阶野猪精",
                         "芙蓉仙子","进阶芙蓉仙子","进阶犀牛将军人形","犀牛将军人形","犀牛将军兽形","进阶犀牛将军兽形","阴阳伞","进阶阴阳伞","进阶巴蛇","巴蛇","进阶龙龟",
                         "龙龟","进阶大力金刚","大力金刚","进阶鬼将","鬼将","进阶红萼仙子","红萼仙子","葫芦宝贝","进阶葫芦宝贝","画魂","进阶画魂","机关鸟",
                         "进阶机关鸟","机关人","进阶机关人","机关兽","进阶机关兽","金饶僧" ,"进阶金饶僧","进阶净瓶女娲","净瓶女娲","连弩车","进阶连弩车","进阶灵鹤",
                         "灵鹤","进阶灵符女娲","灵符女娲","进阶律法女娲","律法女娲","琴仙","进阶琴仙","进阶踏云兽" ,"踏云兽","进阶雾中仙","雾中仙","进阶吸血鬼",
                         "吸血鬼","进阶噬天虎" ,"噬天虎","进阶炎魔神","炎魔神","进阶幽灵","幽灵" ,"进阶幽萤娃娃","幽萤娃娃","夜罗刹" ,"进阶夜罗刹","超级泡泡",
                         "超级大熊猫","进阶毗舍童子","毗舍童子","长眉灵猴","进阶长眉灵猴","进阶持国巡守","持国巡守","进阶混沌兽","混沌兽","金身罗汉","进阶金身罗汉",
                         "巨力神猿","进阶巨力神猿","狂豹人形","进阶狂豹人形","狂豹兽形","进阶狂豹兽形","曼珠沙华","进阶曼珠沙华" ,"猫灵人形","进阶猫灵人形","猫灵兽形","进阶猫灵兽形",
                         "藤蔓妖花","进阶藤蔓妖花","进阶蝎子精","蝎子精","修罗傀儡鬼","进阶修罗傀儡鬼","修罗傀儡妖","进阶修罗傀儡妖","增长巡守","进阶增长巡守",
                         "进阶真陀护法","真陀护法","蜃气妖","进阶蜃气妖","灵灯侍者","进阶灵灯侍者","般若天女","进阶般若天女"
                        }
                ItemControl:GiveItem(三界书院.名单[1].id,"怪物卡片",nil,卡片[math.random(#卡片)])
                SendMessage(UserData[三界书院.名单[1].id].连接id, 7, "#y/你获得了一张怪物卡片")
            end
        end
    end
  for n, v in pairs(UserData) do
      if UserData[n]~=nil  then
          if 自动抓鬼[n]~=nil then
        --   if 自动抓鬼[n].次数 = 0  then
          --  break
          --  end
               if 自动抓鬼[n].开关 and UserData[n].战斗==0  then
                   --  if 自动抓鬼[n].次数 ~= 0 then
                 if 自动抓鬼[n].次数 > 0  then
                     自动抓鬼[n].总计=自动抓鬼[n].总计+1

                     if 自动抓鬼[n].总计==5  then
                         --local  记录=UserData[n].道具:自动抓鬼(n)
                        --  if 记录==false then
                         --  发送数据(UserData[n].连接id, 7, "#y/背包里没有天眼通符,停止自动抓鬼。")
                        --   自动抓鬼[n].开关=false
                         --   break
                         -- end
                              local 地图范围={1501,1092,1070,1193,1140,1208,1040,1226,1142,1506}
                           -- local 地图= 地图坐标类(地图范围):取随机格子()
                               local 地图= 地图范围[math.random(1,#地图范围)]
                             local x= math.random(10,30)
                        local y= math.random(10,30)
                             MapControl:Jump(n,地图,x,y)
                          地图范围=nil
                          地图=nil
                          记录=nil
                          x=nil
                          y=nil
                     end
                     if 自动抓鬼[n].总计>=10  then
                        if UserData[n].战斗~=0  then
                           自动抓鬼[n].开关=false
                           发送数据(UserData[n].连接id, 7, "#y/战斗中,停止自动抓鬼。")
                        else
                             FightGet:进入处理(n,100052)
                        end
                        自动抓鬼[n].总计=0

                     end

                  -- elseif 自动抓鬼[n].时间<os.time()+0 then
                  --      自动抓鬼[n]=nil
                  end
              end
          end
      end
   end

    RunTimeFunc()
    if 服务器关闭.开关 then
        服务器关闭.计时 = 服务器关闭.计时 - 1
        __S服务:输出("服务器关闭倒计时：" .. 服务器关闭.计时)
        if 服务器关闭.计时 <= 60 and 服务器关闭.计时 > 0 then
            广播消息("#xt/#y/服务器将在#r/" .. 服务器关闭.计时 .. "#y/秒后关闭,请所有玩家立即下线。")
        elseif 服务器关闭.计时 <= 0 then
            玩家全部下线()
        end
    end
    --print("渲染","-当前内存",math.floor(collectgarbage("count")/1024).."MB")
     collectgarbage("collect")
end
function RunTimeFunc()
    增加在线时间()
    if os.time() - 保存参数.起始 >= 保存参数.间隔 * 60 then
        保存参数.起始 = os.time()
        Save()
    end
    if 无间炼狱数据.间隔 <= os.time() - 无间炼狱数据.起始 then
        无间炼狱数据.起始 = os.time()
        MapControl:无间炼狱奖励()
    end
end
function 输入函数(t)

end
function 退出函数()
    Save()
end
敏感词数据 = table.loadstring( ReadFile("数据信息/敏感词数据.txt"))
TaskControl:加载首席单位()
serPort=f函数.读配置(ServerDirectory .. "config.ini", "mainconfig", "serPort")+0

__S服务:启动( Config.ip ,serPort)
__S服务:置标题("启动端口："..serPort)
__gge.print(true,7,string.format("网关连接\t\t\t-->"))
__gge.print(false,7,"\t\t\t[")
__gge.print(false,13,"未连接")
__gge.print(false,7,"]\n")
__gge.print(false,7,"-------------------------------------------------------------------------\n")


-- x='math.sqrt'
-- print(loadstring('return '..x..'(...)')(25)) --> 5

-- local a1 =1
-- local a2=2
-- local a3= 3
-- local s =[[a1+a2+a3]]
-- a =loadstring("return "..s..'(...)')(a1,a2,a3)
-- print(a)
-- for k,v in pairs(package.loaded) do
--   print(k,v)
-- end
-- local a={
-- guai={1,2}}
-- print(cjson.encode(a))
