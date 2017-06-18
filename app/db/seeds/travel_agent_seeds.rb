require_relative("../../models/travel_agent.rb")

# Good images
# https://publicdomainvectors.org/en/free-clipart/Lobster-vector-image/1402.html

def make_travel_agents()

  agents = []

  agents[0] = TravelAgent.new({
    "name" => "Solace Travel",
    "description" => "Solace Travel aims to help people to plan perfect trips. " +
    "With an array of awards to our name we will provide you with excelent " +
    "customer service, the best prices, and a perfect holiday." +
    " Lorem ipsum dolor sit amet, consectetur " +
    "adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore " +
    "magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco " +
    "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in " +
    "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla " +
    "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa " +
    "qui officia deserunt mollit anim id est laborum.",
    "logo_url" => "https://publicdomainvectors.org/photos/logo-33-publicdomainvectors.jpg"
  })

  agents[1] = TravelAgent.new({
    "name" => "Oasis Lobster",
    "description" => "Oasis Lobster is an independent Travel Agency and Tour " +
    "Operator. We specialise in Ocean, River and Coastal holidays worldwide. " +
    "We also offer tours, flights, city breaks as well as package, honeymoon and " +
    "safari holidays." +
    " Lorem ipsum dolor sit amet, consectetur " +
    "adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore " +
    "magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco " +
    "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in " +
    "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla " +
    "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa " +
    "qui officia deserunt mollit anim id est laborum.",
    "logo_url" => "https://publicdomainvectors.org/photos/johnny_automatic_lobster.png"
  })

  agents[2] = TravelAgent.new({
    "name" => "All Star",
    "description" => "At All Star we are holiday experts with years of " +
    "experience. We can find the perfect escape for you, no matter what you’re " +
    "looking for. We have it all at great prices." +
    " Lorem ipsum dolor sit amet, consectetur " +
    "adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore " +
    "magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco " +
    "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in " +
    "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla " +
    "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa " +
    "qui officia deserunt mollit anim id est laborum.",
    "logo_url" => "https://publicdomainvectors.org/photos/shokunin_businessman_on_phone.png"
  })

  agents[3] = TravelAgent.new({
    "name" => "Poly Fresh",
    "description" => "Got an idea for a dream holiday but don't know how to go " +
    "about booking it?. Just tell us what you are looking for and Poly Fresh will " +
    "find the perfect trip for you. We'll arrange your flights and ensure " +
    "everything to booked securly. Contact us today." +
    " Lorem ipsum dolor sit amet, consectetur " +
    "adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore " +
    "magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco " +
    "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in " +
    "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla " +
    "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa " +
    "qui officia deserunt mollit anim id est laborum.",
    "logo_url" => "https://publicdomainvectors.org/photos/Gerald_G_KU_viola_glabella.png"
  })

  return agents

end
