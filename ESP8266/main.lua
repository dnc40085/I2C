id=0
    sda=GPIOToPin(2)
    scl=GPIOToPin(0)
XX=0
ZZ=0
    -- initialize i2c, set pin1 as sda, set pin2 as scl
    i2c.setup(id,sda,scl,i2c.SLOW)

    -- user defined function: read from reg_addr content of dev_addr
    function read_reg(dev_addr, reg_addr, LEN)
      i2c.start(id)
      i2c.address(id, dev_addr ,i2c.TRANSMITTER)
      i2c.write(id,"ESP8266 ")
      i2c.write(id,reg_addr)
      i2c.stop(id)
      i2c.start(id)
      i2c.address(id, dev_addr,i2c.RECEIVER)
      c=i2c.read(id,LEN)
	  i2c.stop(id)
      return c
    end

    -- get content of register 0xAA of device 0x77
    --while true do 
	XX=0
	tmr.alarm(6, 1000, 1, function() 
	reg = read_reg(0x0F, XX, 8);
	reg=string.match(reg, "%w+%s+%d+") 
	print(XX.." "..reg);
	XX = XX+1;
	if XX==100 then XX=0; end 
	end)
	tmr.alarm(5, 10000, 0, function() 
		tmr.stop(6)
	end)
	--end
    