-- delay time in seconds
delay_time = 0.5
-- feedback level
feedback_level = 0.5

function init()
  -- clear buffer
  softcut.buffer_clear()

  -- enable voice 1
  softcut.enable(1, 1)
  -- set voice 1 to buffer 1
  softcut.buffer(1, 1)
  -- set voice 1 level to 1.0
  softcut.level(1, 1.0)
  -- voice 1 enable loop
  softcut.loop(1, 1)
  -- set voice 1 loop start to 0
  softcut.loop_start(1, 0)
  -- set voice 1 loop end to delay_time
  softcut.loop_end(1, delay_time)
  -- set voice 1 position to 0
  softcut.position(1, 0)
  -- set voice 1 rate to 1.0
  softcut.rate(1, 1.0)
  -- enable voice 1 play
  softcut.play(1, 1)

  -- route audio input to voice 1
  softcut.level_input_cut(1, 1, 1.0)
  softcut.level_input_cut(2, 1, 1.0)
  -- set voice 1 record level
  softcut.rec_level(1, 1.0)
  -- start recording
  softcut.rec(1, 1)

  -- route voice 1 output to voice 1 input with feedback level
  softcut.level_cut_cut(1, 1, feedback_level)

  -- enable softcut output
  softcut.play(1, 1)
  softcut.play(2, 1)

  -- route input to main output
  softcut.level_cut_out(1, 1, 1.0)
  softcut.level_cut_out(2, 2, 1.0)
end

function enc(n, delta)
  if n == 2 then
    delay_time = util.clamp(delay_time + delta * 0.01, 0.01, 5.0)
    softcut.loop_end(1, delay_time)
  elseif n == 3 then
    feedback_level = util.clamp(feedback_level + delta * 0.01, 0.0, 0.99)
    softcut.level_cut_cut(1, 1, feedback_level)
  end
  redraw()
end

function redraw()
  screen.clear()
  screen.move(10, 30)
  screen.text("delay time: "..delay_time)
  screen.move(10, 50)
  screen.text("feedback level: "..feedback_level)
  screen.update()
end
