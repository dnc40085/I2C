tmr.delay(50000) -- this delay is to give NodeMCU a chance to finish printing it's version info
uart.setup(0,921600,8,0,1,1);
memoryUsed = function() print("\nLua is currently using " .. (collectgarbage("count")*1024).. " bytes of memory"); end

GPIOToPin = function(GPIO)
G2P_T = {[0]=3,[1]=10,[2]=4,[3]=9,[4]=2,[5]=1,[9]=11,[10]=12,[12]=6,[13]=7,[14]=5,[15]=8,[16]=0}; -- table to convert gpio to pin
return (G2P_T[GPIO])
end
if file.open("LLbin.lua") then --This part is for LuaLoader v0.83 it can be erased with no problem
	LLbin = function(F) dofile("LLbin.lua"); LLbin(F); end; 
end;
if true then  --If false, script ends here
wifi.setmode(wifi.STATION);
wifi.sta.config("YOUR SSID","YOUR PASSWORD")
count=0
wait_wifi = function()
count = count + 1
wifi_ip = wifi.sta.getip()
if wifi_ip == nil and count < 20 then
tmr.alarm(0, 1000,0,wait_wifi)
elseif count >= 20 then
wifi_connected = false
print("Wifi connect timed out.")
else
wifi_connected = true
print("Got IP "..wifi_ip.."\n")
collectgarbage()
if file.open("main.lua") then dofile("main.lua"); print("\nReady!\r\n"); memoryUsed();  else print("main.lua not present"); print("\nReady!"); end
wait_wifi=nil
init=nil
count=nil
end
end
wait_wifi()
else
print("\nReady!\r\n")
 end
collectgarbage()

