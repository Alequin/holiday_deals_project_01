require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("controllers/home_controller.rb")

get("/")do
  redirect to("/index")
end
