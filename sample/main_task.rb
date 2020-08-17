PORT_ID = 1
# mruby特有の初期化
@logger = Nucleo::Serial.new(PORT_ID)
@clock = Nucleo::Clock.new()
loop = Nucleo::Sample1.new()
@logger.syslog("$$ main task initialize\r\n")
task1_que = Nucleo::DataQue.new(Nucleo::DATA_QUE1_ID)

# タスクの起動
Nucleo::Task.active(Nucleo::TASK1_ID)
#Nucleo::Task.active(1)
@logger.syslog("$$ main task task1 active\r\n")
#Nucleo::Task.active(Nucleo::TASK2_ID)
#log("$$ main task task2 active\r\n")
#Nucleo::Task.active(Nucleo::TASK3_ID)
#log("$$ main task task3 active\r\n")
#while true
#  command = @logger.read_byte(PORT_ID)
#  @logger.syslog("read: #{command}\r\n")
#end

command = 0
i = 0
@task_no = 1

while true
  command = @logger.read_byte(PORT_ID)
  @logger.syslog("read: #{command}\r\n")
#  case command.chr  #TODO mruby-string-ext を追加するとload irep error になる
  case command
  when 81 #Q Quit
    @logger.syslog("main: Q\r\n")
    break
#  when "e", "s", "S", "d", "y", "Y", "z", "Z" #e, s, S, d, y, Y, z, Z
  when 101, 115, 83, 100, 121, 89, 122, 90 #e, s, S, d, y, Y, z, Z
    @logger.syslog("main:esSdyYzZ\r\n")
    case @task_no
    when 1
      task1_que.force_send(command)
#      @logger.syslog("que1: #{command}\r\n")
    when 2
    when 3
    else
    end
#    Nucleo::SharedMemory[@task_no] = command
#    Nucleo::SharedMemory[1] = 1
=begin
when 66 #B
    @logger.syslog("main: B \r\n")
#    syslog(LOG_INFO, "#stp_alm(ALMHDR1)");
#    SVC_PERROR(stp_alm(ALMHDR1));
    Nucleo::Task.stop_alarm(Nucleo::ALMHDR1)
  when 98 #b
    @logger.syslog("main: b \r\n")
#    syslog(LOG_INFO, "#sta_alm(ALMHDR1, 5000000)");
#    SVC_PERROR(sta_alm(ALMHDR1, 5000000));
  Nucleo::Task.start_alarm(Nucleo::ALMHDR1, 5000)
when 108 #l
    @logger.syslog("main: l \r\n")
#    syslog(LOG_INFO, "#rel_wai(%d)", tskno);
#    SVC_PERROR(rel_wai(tskid));
    if @task_no != 0
      Nucleo::Task.stop_alarm(@task_no)
    end
  when 86 #V 高分解能タイマを読むテスト。mrubyではひとまず実装しない
    @logger.syslog("main: V \r\n")
#    hrtcnt1 = fch_hrt();
#    consume_time(1000LU);
#    hrtcnt2 = fch_hrt();
#    syslog(LOG_NOTICE, "hrtcnt1 = %tu, hrtcnt2 = %tu",
#              (uint32_t) hrtcnt1, (uint32_t) hrtcnt2);
  when 120 #x
    @logger.syslog("main: x \r\n")
#    syslog(LOG_INFO, "#ras_ter(%d)", tskno);
#    SVC_PERROR(ras_ter(tskid));
    if @task_no != 0
      Nucleo::Task.raise_termination(@task_no)
    end
  when 110 #m
    @logger.syslog("main: n \r\n")
#    syslog(LOG_INFO, "#rsm_tsk(%d)", tskno);
#    SVC_PERROR(rsm_tsk(tskid));
    if @task_no != 0
      Nucleo::Task.resume(@task_no)
    end
  when 113 #q
    @logger.syslog("main: q \r\n")
#    SVC_PERROR(syslog_msk_log(LOG_UPTO(LOG_NOTICE),
#    LOG_UPTO(LOG_EMERG)));
  when 114 #r
    @logger.syslog("main: r \r\n")
#    syslog(LOG_INFO, "#rot_rdq(three priorities)");
#    SVC_PERROR(rot_rdq(HIGH_PRIORITY));
#    SVC_PERROR(rot_rdq(MID_PRIORITY));
#    SVC_PERROR(rot_rdq(LOW_PRIORITY));
      Nucleo::Task.rotate_ready_queue(Nucleo::HIGH_PRIORITY)
      Nucleo::Task.rotate_ready_queue(Nucleo::MID_PRIORITY)
      Nucleo::Task.rotate_ready_queue(Nucleo::LOW_PRIORITY)
  when 119 #w
    @logger.syslog("main: w \r\n")
#    syslog(LOG_INFO, "#wup_tsk(%d)", tskno);
#    SVC_PERROR(wup_tsk(tskid));
    if @task_no != 0
      Nucleo::Task.wakeup(@task_no)
    end
  when 49 #1
    @logger.syslog("main: 1\r\n")
    @task_no = 1
  when 50 #2
    @logger.syslog("main: 2\r\n")
    @task_no = 2
  when 51 #3
    @logger.syslog("main: 3\r\n")
    @task_no = 3
  when 97 #a
    @logger.syslog("main: a \r\n")
    # ack_tsk(@task_no)
#    syslog(LOG_INFO, "#act_tsk(%d)", tskno);
#    SVC_PERROR(act_tsk(tskid));
    if @task_no != 0
      Nucleo::Task.active(@task_no)
    end
  when 65 #A
    @logger.syslog("main: A \r\n")
    # can_act
#    syslog(LOG_INFO, "#can_act(%d)", tskno);
#    SVC_PERROR(ercd = can_act(tskid));
#    if (ercd >= 0) {
#      syslog(LOG_NOTICE, "can_act(%d) returns %d", tskno, ercd);
#    }
    if @task_no != 0
      Nucleo::Task.cancel_activetion(@task_no)
    end
  when 116 #t
    @logger.syslog("main: t \r\n")
#    syslog(LOG_INFO, "#ter_tsk(%d)", tskno);
#    SVC_PERROR(ter_tsk(tskid));
    if @task_no != 0
      Nucleo::Task.terminate(@task_no)
    end
  when 62 #>
    @logger.syslog("main: > \r\n")
#    syslog(LOG_INFO, "#chg_pri(%d, HIGH_PRIORITY)", tskno);
#    SVC_PERROR(chg_pri(tskid, HIGH_PRIORITY));
    if @task_no != 0
      Nucleo::Task.change_priority(@task_no, Nucleo::HIGH_PRIORITY)
    end
  when 61 #=
    @logger.syslog("main: = \r\n")
#    syslog(LOG_INFO, "#chg_pri(%d, MID_PRIORITY)", tskno);
#    SVC_PERROR(chg_pri(tskid, MID_PRIORITY));
    if @task_no != 0
      Nucleo::Task.change_priority(@task_no, Nucleo::MID_PRIORITY)
    end
  when 60 #<
    @logger.syslog("main: < \r\n")
#    syslog(LOG_INFO, "#chg_pri(%d, LOW_PRIORITY)", tskno);
#    SVC_PERROR(chg_pri(tskid, LOW_PRIORITY));
    if @task_no != 0
      Nucleo::Task.change_priority(@task_no, Nucleo::LOW_PRIORITY)
    end
  when 500 #dummy
    @logger.syslog("dummy \r\n")
  when 71 #G
    @logger.syslog("main: G \r\n")
#    syslog(LOG_INFO, "#get_pri(%d, &tskpri)", tskno);
#    SVC_PERROR(ercd = get_pri(tskid, &tskpri));
#    if (ercd >= 0) {
#      syslog(LOG_NOTICE, "priority of task %d is %d", tskno, tskpri);
#    }
    if @task_no != 0
      priority = Nucleo::Task.get_priority(@task_no)
      @logger.syslog("getpri: #{priority} \r\n")
    end
  when 87 #W
    @logger.syslog("command: W \r\n")
#    syslog(LOG_INFO, "#can_wup(%d)", tskno);
#    SVC_PERROR(ercd = can_wup(tskid));
#    if (ercd >= 0) {
#      syslog(LOG_NOTICE, "can_wup(%d) returns %d", tskno, ercd);
#    }
    if @task_no != 0
      err = Nucleo::Task.cancel_wakeup(@task_no)
      if err >=0
        @logger.syslog("can_wup#{@task_no} returns#{err}\r\n")
      end
    end
  when 117 #u
    @logger.syslog("main: u \r\n")
#    syslog(LOG_INFO, "#sus_tsk(%d)", tskno);
#    SVC_PERROR(sus_tsk(tskid));
    if @task_no != 0
      Nucleo::Task.suspend(@task_no)
    end
  when 501 #dummy
    @logger.syslog("dummy \r\n")
  when 99 #c
    @logger.syslog("main: c \r\n")
#    syslog(LOG_INFO, "#sta_cyc(CYCHDR1)");
#    SVC_PERROR(sta_cyc(CYCHDR1));
    Nucleo::Task.start_cyclic(Nucleo::CYCHDR1)
  when 67 #C
    @logger.syslog("main: C \r\n")
#    syslog(LOG_INFO, "#stp_cyc(CYCHDR1)");
#    SVC_PERROR(stp_cyc(CYCHDR1));
    Nucleo::Task.stop_cyclic(Nucleo::CYCHDR1)
=end
  #  when "\003" //TODO
  else
#    @logger.syslog("else\r\n")
    @logger.syslog("Unknown: #{command}")
  end
end
