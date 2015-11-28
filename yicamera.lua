conteo = 0
gpio.mode(1,gpio.INPUT)
gpio.mode(0,gpio.OUTPUT)
gpio.write(0,gpio.HIGH)
wifi.setmode(wifi.STATION)
wifi.sta.config("yicamera","11111111")
permiso = '{"msg_id":257,"token":0}'
print(permiso)
tomarFoto = '{"msg_id":769,"token":1}'
cliente = net.createConnection(net.TCP,0)
cliente:on("receive", function(a,v) 
print("receive ")
print("esto es v ")
print(v) 
conteo =2
end ) 

tmr.alarm(0,2000,1,function()
if(conteo == 0) then
if(wifi.sta.getip() ~= nil) then 
print(wifi.sta.getip())
conteo =1
end-- ip not equal nil
end--conteo == 0
if(conteo == 1)then
print("enviando permiso")
cliente:connect(7878,"192.168.42.1")
cliente:send(permiso)
end--conteo ==1
end)

tmr.alarm(1,10,1,function()

if(conteo == 2) then
if(gpio.read(1) == 0) then
gpio.write(0,gpio.LOW)
print("enviando orden de captura")
cliente:send(tomarFoto)
tmr.delay(500000)
else
gpio.write(0,gpio.HIGH)
end--gpio read
end--conteo == 2
end)
