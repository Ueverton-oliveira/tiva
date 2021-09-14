json.schedules do
  json.array! @schedules, :id, :initial_date, :end_date, :initial_hour, :end_hour
end
