PORT_ID = 1
# mruby特有の初期化
@logger = Nucleo::Serial.new(PORT_ID)
@clock = Nucleo::Clock.new()
loop = Nucleo::Sample1.new()
@logger.syslog("$$ main task initialize: #{Nucleo::TASK1_ID}")
task1_que = Nucleo::DataQue.new(Nucleo::DATA_QUE1_ID)

# タスクの起動
Nucleo::Task.active(Nucleo::TASK1_ID)
#Nucleo::Task.active(1)
@logger.syslog("$$ main task task1 active")
#TODO Nucleo::Task.active(Nucleo::TASK2_ID)
#TODO log("$$ main task task2 active")
#TODO Nucleo::Task.active(Nucleo::TASK3_ID)
#TODO log("$$ main task task3 active")

command = 0
i = 0
@task_no = 1

while true
  command = @logger.read_byte(PORT_ID)
  @logger.syslog("read: #{command}")
#  case command.chr  #TODO mruby-string-ext を追加するとload irep error になる
  case command
  when 81 #Q Quit
    @logger.syslog("main: Q")
    break
  when 101, 115, 83, 100, 121, 89, 122, 90 #e, s, S, d, y, Y, z, Z
    @logger.syslog("main:esSdyYzZ")
    case @task_no
    when Nucleo::TASK1_ID
      task1_que.force_send(command)
#      @logger.syslog("que1: #{command}")
#TODO    when Nucleo::TASK2_ID
#TODO    when Nucleo::TASK3_ID
    else
    end
  when 66 #B
    @logger.syslog("main: B")
#TODO    Nucleo::Task.stop_alarm(Nucleo::ALMHDR1)
  when 98 #b
    @logger.syslog("main: b")
#TODO  Nucleo::Task.start_alarm(Nucleo::ALMHDR1, 5000)
when 108 #l
    @logger.syslog("main: l")
#TODO      Nucleo::Task.stop_alarm(@task_no)
  when 86 #V 高分解能タイマを読むテスト。mrubyではひとまず実装しない
    @logger.syslog("main: V")
  when 120 #x
    @logger.syslog("main: x")
#TODO      Nucleo::Task.raise_termination(@task_no)
  when 110 #m
    @logger.syslog("main: m")
#TODO      Nucleo::Task.resume(@task_no)
  when 113 #q 発行したシステムコールを表示しない #mrubyでは実装しない
    @logger.syslog("main: q")
  when 114 #r
    @logger.syslog("main: r")
#TODO      Nucleo::Task.rotate_ready_queue(Nucleo::HIGH_PRIORITY)
#TODO      Nucleo::Task.rotate_ready_queue(Nucleo::MID_PRIORITY)
#TODO      Nucleo::Task.rotate_ready_queue(Nucleo::LOW_PRIORITY)
  when 119 #w
    @logger.syslog("main: w")
    Nucleo::Task.wakeup(@task_no)
  when 49 #1
    @logger.syslog("main: 1")
    @task_no = Nucleo::TASK1_ID
  when 50 #2
    @logger.syslog("main: 2")
#TODO    @task_no = Nucleo::TASK2_ID
  when 51 #3
    @logger.syslog("main: 3")
#TODO    @task_no = Nucleo::TASK3_ID
  when 97 #a
    @logger.syslog("main: a :#{@task_no}")
    Nucleo::Task.active(@task_no)
  when 65 #A
    @logger.syslog("main: A")
#TODO      result = Nucleo::Task.cancel_activetion(@task_no)
#TODO      if result >= 0
#TODO        @logger.syslog("can_act(#{@task_no}) returns #{result}")
#TODO      end
  when 116 #t
    @logger.syslog("main: t")
#TODO      Nucleo::Task.terminate(@task_no)
  when 62 #>
    @logger.syslog("main: >")
#TODO      Nucleo::Task.change_priority(@task_no, Nucleo::HIGH_PRIORITY)
  when 61 #=
    @logger.syslog("main: =")
#TODO      Nucleo::Task.change_priority(@task_no, Nucleo::MID_PRIORITY)
  when 60 #<
    @logger.syslog("main: <")
#TODO      Nucleo::Task.change_priority(@task_no, Nucleo::LOW_PRIORITY)
  when 500 #dummy
    @logger.syslog("dummy")
  when 71 #G
    @logger.syslog("main: G")
#TODO      priority = Nucleo::Task.get_priority(@task_no)
#TODO      @logger.syslog("getpri: #{priority} \r\n")
  when 87 #W
    @logger.syslog("command: W")
#TODO      err = Nucleo::Task.cancel_wakeup(@task_no)
#TODO      if err >=0
#TODO        @logger.syslog("can_wup#{@task_no} returns#{err}\r\n")
#TODO      end
  when 117 #u
    @logger.syslog("main: u")
#TODO      Nucleo::Task.suspend(@task_no)
  when 501 #dummy
    @logger.syslog("dummy")
  when 99 #c
    @logger.syslog("main: c")
#TODO    Nucleo::Task.start_cyclic(Nucleo::CYCHDR1)
  when 67 #C
    @logger.syslog("main: C")
#TODO    Nucleo::Task.stop_cyclic(Nucleo::CYCHDR1)
  #  when "\003" #TODO
  else
    @logger.syslog("Unknown: #{command}")
  end
end
