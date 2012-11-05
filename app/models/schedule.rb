class Schedule

  # @param [Category] category
  def self.get_by_category(category)

    hash = Hash.new do |hash, key|
      hash[key]=Hash.new { |h, k| h[k]=Hash.new { |h2, k2| h2[k2]=Hash.new { |h3, k3| h3[k3]=[] } } }
    end

    items= Item.select(:id).joins(:categories).where(:categories_items=>{:category_id =>category.self_and_descendants})

    events =Event.includes(:place, :room ,{:items=>{:galleries=>:images}}).where{{:items=>id.in(items)}}
    #events =Event.includes(:place, :room ,:items).where(:items=>{id: items})
    #events =Event.includes(:place, :room ,:items).where(:items =>{id: items} )
    #events =Event.joins(:items).where(:items =>{id: items} )
    events.each do |e|
      item = e.items
      date =   e.date_begin.to_date
      place = e.place
      room = e.room
      time = e.date_begin.strftime('%R')

      item.each do |i|
          hash[date][i][place][room] << time
      end

          #hash[date][item][place][room] << time
    end
    return hash

  end







  def self.get_by_item(item)
      hash = Hash.new { |hash, key| hash[key]=Hash.new{|h,k| h[k]=Hash.new{|h2, k2| h2[k2]=[] } }}
      item.events.each do |e|
        date =   e.date_begin.to_date
        place = e.place
        room = e.room
        time = e.date_begin.strftime('%R')
        hash[date][place][room] << time
      end
      hash
  end

  # @param [Object] place
  def self.get_by_place_old(place)

    #events= Event.where(place_id:place)
    events= place.events.includes(:items)

    t1=events.group_by{|e| e.items.first.id }
    t1=t1.map do |k, v|
      {k => (v.group_by { |v| v.date_begin.to_date })}
    end

   t1.map do |v|
     v.map do |item, date|
     {item=> date.map do |date, events|
        {date=> events.map do |event|
           event.date_begin.strftime('%R')
         end }
       end }
     end
   end


  end

  def self.get_by_place(place)
    events= place.events.includes(:items, :room)
    #events= Event.where(place_id:place)
    hash = Hash.new { |hash, key| hash[key]=Hash.new{|h,k| h[k]=Hash.new{|h2, k2| h2[k2]=[] } }}
    events.each do |e|
      date =   e.date_begin.to_date
      item = e.items.first
      room = e.room.try :name
      time = e.date_begin.strftime('%R')
      hash[item][date][room] << time
    end
    hash

  end


end