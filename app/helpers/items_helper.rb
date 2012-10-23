module ItemsHelper


def schedule(item)
  hash = {}
  item.events.each do |e|
   date =   e.date_begin.to_date
     hash[date] << e
  end
    hash
end




end
