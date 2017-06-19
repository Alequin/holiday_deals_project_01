require("sinatra")
require("sinatra/contrib/all") if(development?())

get("/add_to_page") do
  erb(:"add_to_page/index")
end
