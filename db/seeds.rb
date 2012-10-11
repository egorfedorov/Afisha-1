# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.create ( [
    {:name => 'event1' },
    {:name => 'event2' } ,
    {:name => 'event3' }

             ])
Item.create([
    {:title =>'item1' },
    {:title =>'item2' },
    {:title =>'item3' }
            ])

Place.create([
    {:name =>'place1' },
    {:name =>'place2' },
    {:name =>'place3' }
            ])
Category.create([
    {:name =>'Category1', :type=>1 },
    {:name =>'Category2', :type=>2},
    {:name =>'Category3', :type=>3},
         ])
Type.create([
    {:name =>'events'},
    {:name =>'items'},
    {:name =>'places'},
         ])

