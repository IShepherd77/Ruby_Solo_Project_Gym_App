require_relative('../models/member')
require 'date'

Member.delete_all


member1 = Member.new({'forename' => 'Alan', 'surname' => 'Paterson', 'dob' => Date.new(1978,9,19), 'premium' => false, 'phone' => '07876505333', 'email' => 'alanP@test.com'})
member2 = Member.new({'forename' => 'Gordon', 'surname' => 'Moore', 'dob' => Date.new(1981,3,30), 'premium' => true, 'phone' => '07876505999', 'email' => 'gordonm@test.com'})


member1.save
member2.save
