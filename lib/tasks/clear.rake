#coding=utf-8
desc "Удаление "
task :clear => :environment do |t, arg|

  Event.all.each do |e|
  e.destroy
  end
  Item.all.each do |e|
  e.destroy
  end
  Place.all.each do |e|
  e.destroy
  end
  Room.all.each do |e|
  e.destroy
  end
Contact.all.each do |e|
  e.destroy
  end







end