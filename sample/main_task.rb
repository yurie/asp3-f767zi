def log(msg)
  @logger.write(msg)
end
  
@logger = Nucleo::Log.new()
@sleep = Nucleo::Task.new()
@clock = Nucleo::Clock.new()
log("$$ main task initialize\r\n")

# Nucleo::Task.active(Nucleo::TASK1_ID)
# log("$$ main task task1 active\r\n")
# log("$$ main task 1\r\n")

i = 0
while true
  start = @clock.now()
  Nucleo::Task.delay(1000)
#  i = i + 1
#  log("$$ main task : #{i}\r\n")
  i = @clock.now()
#  log("$$ main task : #{i}\r\n")
log("$$ start delay : #{start}\r\n")
log("$$ end delay : #{i}\r\n")

#  i2 = 0
#  while true
#    break if i2 == 300000
#    i2 += 1
#  end
#  F401re::Task.wakeup(Nucleo::TASK1_ID)
end
