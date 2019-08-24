require_relative('models/member')
require_relative('models/lesson')
require 'date'

lesson = Lesson.find(7)

time_array = lesson.start_time.split(':')
date_val = Date.parse(lesson.lesson_date)
time_val = Time.new(date_val.year, date_val.month, date_val.mday, time_array[0].to_i, time_array[1].to_i)
binding.pry
p 'done'
