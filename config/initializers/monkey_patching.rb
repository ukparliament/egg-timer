Dir["#{Rails.root}/lib/monkey_patching/*.rb"].each do |file|
  require file
end