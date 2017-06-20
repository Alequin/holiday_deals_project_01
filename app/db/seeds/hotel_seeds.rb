require_relative("../../models/hotel.rb")

# Good images
# https://publicdomainvectors.org/en/free-clipart/Lobster-vector-image/1402.html

def make_hotels()

  hotels = []

  hotels[0] = Hotel.new({
    "name" => "Diamond Hotel",
    "description" => "The Diamond Hotel is located in the heart of lively part " +
    "of the city and is only a short walk from extraordinary churches, buildings, " +
    "shops and monuments. Diamond Hotel is part of a lovingly restored 1800 " +
    "palace. On entering this charming hotel, you will immediately sense its " +
    "special atmosphere. Each detail has been passionately chosen and each room " +
    "deserves a visit. The style mixes valuable antiques and original artworks " +
    "with an unexpected eclectic contemporary twist. The entire hotel recalls " +
    "the ancient ‘Palazzi’ of times past where young European aristocrats lived " +
    "while discovering the beauty of the city.",
    "stars" => 5,
    "image_url" => "http://www.publicdomainpictures.net/pictures/140000/velka/moscow-kremlin-at-night.jpg"
  })

  hotels[1] = Hotel.new({
    "name" => "Soft Veil Hotel",
    "description" => "The Soft Veil Hotel is the right choice for visitors who " +
    "are searching for a relaxing environment and a convenient position from " +
    "which to explore. The hotel is arranged on three floors with a splendid " +
    "terrace on the first, where you can relax and enjoy the view. The rooms are " +
    "arranged on the first, second and third floors. On the top floor, there is " +
    "also a solarium available for the use. The buffet breakfast is served in " +
    "the lounge on the ground floor, and also outside on our little patio during " +
    "the summer months",
    "stars" => 4,
    "image_url" => "http://www.publicdomainpictures.net/pictures/70000/velka/hotel-lobby-1390867820xpC.jpg"
  })

  hotels[2] = Hotel.new({
    "name" => "Illustrious House Hotel & Spa",
    "description" => "Spas are an invention of nature. A natural world shrouded " +
    "by mountains, lakes and valleys where inner and outer peace are reflected. " +
    "At the Illustrious House Hotel & Spa we pride ourselves on the array of " +
    "services we offer, whether you are looking to achieve specific fitness " +
    "goals, participate in one of our group exercise classes, relax in pool or " +
    "pamper yourself. we will help you to re-discover your mind, body and soul. " +
    "We focus on you and believe that is essential to achieving inner peace and " +
    "happiness, so that one can fulfill the basic human needs for satisfaction " +
    "and invigoration.",
    "stars" => 5,
    "image_url" => "http://www.publicdomainpictures.net/pictures/80000/velka/crete-greece-health-spa-13926569788WS.jpg"
  })

  hotels[3] = Hotel.new({
    "name" => "Outlook Resort",
    "description" => "Set against a backdrop of majestic mountainous lava " +
    "fields the Outlook Resort is an unforgettable experience. Whether you are " +
    "seeking a quiet, soulful soak beneath the Northern Lights, a challenging " +
    "trek across an ancient glacier or a day of fly-fishing in plentiful icy " +
    "rivers Outlook Resort has what you need. We will take good care of you upon " +
    "your return after a day of adventures. Our rooms, Restaurants, Northern " +
    "Lights bar, Lava Spa and the magnificent views will help you recharge for " +
    "the next day.",
    "stars" => 5,
    "image_url" => "https://c1.staticflickr.com/4/3880/14934519700_4c101240e1_b.jpg"
  })

  hotels[4] = Hotel.new({
    "name" => "Marina Spring Hotel",
    "description" => "This property is 4 minutes walk from the beach. " +
    "Marina Spring Hotel offers 5 swimming pools, including a palm-lined " +
    "lagoon-style pool. The rooms feature seasonal air conditioning, satellite " +
    "TV and a private balcony. The hotel’s two themed buffet restaurants " +
    "serve international food, as well as local cuisine. There are also 2 snack " +
    "bars and during summer you can get a drink from the 2 poolside bars. " +
    "There is an entertainment programme for the whole family, including " +
    "live shows in the evening based on musicals, sports competitions and " +
    "workshops. There is also a miniclub and 2 children's pools.",
    "stars" => 3,
    "image_url" => "http://www.publicdomainpictures.net/pictures/30000/velka/pool-and-hotel.jpg"
  })

  hotels[5] = Hotel.new({
    "name" => "The Tavern",
    "description" => "From the outside it looks disturbing, horrible and " +
    "uninviting. Timber and huge, stone pillars make up most of the building's " +
    "outer structure. It's impossible to see through the dirty windows, but the " +
    "ominous atmosphere from within can be felt outside. On arrival to the " +
    "tavern you will be welcomed by horrific scents and aromas of what's " +
    "probably food, hopefully. Wooden beams support the upper floor and the " +
    "lanterns attached to them. The walls are loaded with pictures, though " +
    "dust and cobwebs obscure them. The tavern itself is almost completely " +
    "abanonded. The few people inside you'd like to stay away from, but whoever " +
    "they are, you begin to fear for your safety, it's probably best to find a " +
    "different place.",
    "stars" => 1,
    "image_url" => "https://upload.wikimedia.org/wikipedia/commons/f/f8/Egbert_van_Heemskerck_the_Younger_-_Interior_of_an_Inn.jpg"
  })

  return hotels

end
