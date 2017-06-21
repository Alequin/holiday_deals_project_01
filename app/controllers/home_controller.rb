require("sinatra")
require("sinatra/contrib/all") if(development?())

#INDEX
get("/index")do
  erb(:index)
end
