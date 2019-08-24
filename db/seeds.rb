require_relative('../models/member')
require_relative('../models/lesson')
require 'date'

Member.delete_all


member1 = Member.new({'forename' => 'Alan', 'surname' => 'Paterson', 'dob' => Date.new(1978,9,19), 'premium' => false, 'phone' => '07876505333', 'email' => 'alanP@test.com'})
member2 = Member.new({'forename' => 'Gordon', 'surname' => 'Moore', 'dob' => Date.new(1981,3,30), 'premium' => true, 'phone' => '07876505999', 'email' => 'gordonm@test.com'})

member1.save
member2.save

lesson1 = Lesson.new({'name' => 'Dodgeball', 'capacity' => 20,'lesson_date' => Date.today, 'start_time' => Time.now, 'duration' => 60 })
lesson2 = Lesson.new({'name' => 'Yoga', 'capacity' => 30,'lesson_date' => Date.new(2019,10,31), 'start_time' => Time.new(2019,10,31,19,30), 'duration' => 45 })
lesson3 = Lesson.new({'name' => 'Circuit Training', 'capacity' => 15,'lesson_date' => Date.new(2019,11,2), 'start_time' => Time.new(2019,11,2,20), 'duration' => 30 })

lesson1.save
lesson2.save
lesson3.save
