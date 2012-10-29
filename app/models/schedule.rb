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
      item = e.items.first
      date =   e.date_begin.to_date
      place = e.place
      room = e.room
      time = e.date_begin.strftime('%R')

      #item.each do |i|
      #    hash[date][i][place][room] << time
      #end

          hash[date][item][place][room] << time
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


end