json.array!(@colleges) do |college|
  json.extract! college, :name, :address, :city, :state, :zip_code, :website, :lat, :lon
  json.url college_url(college, format: :json)
end
