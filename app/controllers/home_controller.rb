require("sinatra")
require("sinatra/contrib/all") if(development?())

get("/index")do
  erb(:index)
end
