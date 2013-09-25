json.array!(@items) do |item|
  json.extract! item, :kind, :height, :emergency_exit, :openable
  json.url item_url(item, format: :json)
end
