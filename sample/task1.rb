PORT_ID = 1
logger = Nucleo::Serial.new(PORT_ID)
logger.syslog("##-- task1 active\r\n")
loop = Nucleo::Sample1.new()
que = Nucleo::DataQue.new(Nucleo::DATA_QUE1_ID)
counter = 0
command = 0
while true
  counter += 1
  command = que.receive_polling
  logger.syslog("task1 is running #{counter} : #{command}.  |")
#  Nucleo::Sample1.consume_time_task_loop
  loop.consume_time_task_loop
#  command = Nucleo::SharedMemory[1]
#  Nucleo::SharedMemory[1] = 0

  if command
    case command
    when 101 #e
#      logger.syslog("tsk1:e ext_tsk\r\n")
      # ext_tsk
#      Nucleo::Task.exit()
    when 115 #s
#      logger.syslog("tsk1:s slp_tsk\r\n")
      # slp_tsk
#      Nucleo::Task.sleep()
    when 83 #S
#      logger.syslog("tsk1:S tslp_tsk(10000000)\r\n")
      # tslp_tsk(10000000)
#      Nucleo::Task.sleep(10000)
    when 100 #d
#      logger.syslog("tsk1:d dly_tsk(10000000)\r\n")
      # dly_tsk(10000000)
#      Nucleo::Task.delay(10000)
    when 121 #y
#      logger.syslog("tsk1:y dis_ter\r\n")
      # dis_ter
#      Nucleo::Task.disable_terminate()
    when 89 #Y
#      logger.syslog("tsk1:Y ena_ter\r\n")
      # ena_ter
#      Nucleo::Task.enable_terminate()
    else
      #NucleoではCPUEXXC1未定義のためz,Zもなし
#      logger.syslog("Unknown tsk1: #{command}\r\n")
    end
  else
#    logger.syslog("tsk1: Nil\r\n")
    loop.consume_time_task_loop
  end
#    Nucleo::Task.delay(100000)
GC.start
end
