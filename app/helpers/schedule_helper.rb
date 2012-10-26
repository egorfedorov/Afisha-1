module ScheduleHelper


  def schedule(item)
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

  def schedule2(item)

    item.events.group_by{|e| e.date_begin.to_date}.map do |k,v|
      {k=> v.group_by{|e| e.place.name}.map{|k2, v2|
        {k2 => v2.map{|event| event.date_begin.strftime('%R')}} }
      }

    end
  end


end

