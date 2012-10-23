module ItemsHelper


def schedule(item)
  hash = {}
  item.events.each do |e|
   date =   e.date_begin.to_date
   place = e.place
   hash.merge! {date}
   hash[date].merge! {place.name}
     #hash[date][place.name] << e.date_begin.to_s
  end
    hash
end




end

