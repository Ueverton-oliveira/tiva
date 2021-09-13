json.professionals do
  json.array! @professionals, :id, :name, :description, :email, :cell_phone
end
