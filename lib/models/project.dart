class Project {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String subtitle;
  final List<String> images;
  final List<String> videos;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.subtitle,
    required this.images,
    required this.videos,
  });
}

// Sample Data
final List<Project> tatweerProjects = [
  Project(
      id: "1",
      title: "Salt North Coast",
      subtitle: "EXPERIENCE THE SALT LIFE",
      description:
          "Imagine a breezy summer destination, soaked in the North Coast’s sizzling sun where blue skies, pristine sea views, scenic pools and crystal-clear lagoons stretch out as far as you can see. Rolling out on 294.5 acres, Salt is a sunny state of mind, seasoning your vacation with infinite water-front possibilities, thanks to a private beachfront on 850 meters, oozing with joyful experiences, above and below turquoise waters. Salt is a world of its own, offering a world-class marina to dock your boat, a spirited commercial zone where water-front F&B concepts lap captivating views and a -5 star Bungalow Hotel & Serviced apartments concept inspiring a laid-back lifestyle. Relaxation lovers are also invited to lose themselves in world-class hospitality, indulging in impeccable accommodation, soothing spa treatments and rejuvenating massages, anytime of the day. Boasting every ingredient essential to perfect memorable summer days, Salt’s unrivaled host of amenities is in short, memories in the making, powered by a hand-picked community of like-minded neighbors.",
      imagePath: "assets/images/projects/salt/salt-project.png",
      images: [
        "assets/images/projects/salt/salt-1.png",
        "assets/images/projects/salt/salt-2.png",
        "assets/images/projects/salt/salt-3.png"
      ],
      videos: []),
  Project(
    id: "2",
    title: "Rivers",
    description: "Implementing solar and wind energy projects.",
    subtitle: "Exclusivity Flows West",
    imagePath: "assets/images/projects/rivers/rivers-logo.jpg",
    images: [
      "assets/images/projects/rivers/rivers-1.jpg",
      "assets/images/projects/rivers/rivers-2.jpg",
      "assets/images/projects/rivers/rivers-3.jpg"
    ],
    videos: [
      "https://tatweermisr.com/videos/gallery-videos/TM-Rivers-Video3.mp4"
    ],
  ),
  Project(
    id: "3",
    title: "BloomFields",
    description:
        "Rolling out on 415 acres of land, Bloomfields is the most charming and interconnected green town in Mostakbal City. Always on the rise, and in search for fresh bold ideas, the development surrounds you with sweeping views over lush sun-kissed parks, open-air galleries, top-notch education, a burgeoning cultural scene, as well as world-class facilities, and a sustainable lifestyle inspired by the best integrated ecosystems in the world. Designed to offer something just for everyone, Bloomfields is Tatweer Misr's prime innovative project in Cairo that's set to become Egypt's hotbed for startups, entrepreneurs, as well as makers and doers who wish to execute flawlessly at home, in the office or at the gym. Boasting one-of-a-kind functions, and top-notch amenities at every doorstep, Bloomfields is carefully planned to make life easier, and more enjoyable without having to commute.",
    subtitle: "the heart of it all",
    imagePath: "assets/images/projects/bloomfields/bloomfields-logo.jpg",
    images: [
      "assets/images/projects/bloomfields/bloomfields-1.jpg",
      "assets/images/projects/bloomfields/bloomfields-2.jpg",
      "assets/images/projects/bloomfields/bloomfields-1.jpg"
    ],
    videos: ["https://youtu.be/wO6qPWaLO34"],
  ),
  Project(
    id: "4",
    title: "IL MONTE GALALA",
    description:
        "Created and master planned in collaboration with world-renowned Italian architect Gianluca Peluffo and Partners, IL Monte Galala - Sokhna takes luxury living in Egypt to new heights. Inspired by Portofino’s spellbinding surroundings, this year-round mountain-top community with its lush landscapes and idyllic beach lifestyle sets a global benchmark for luxury living, sustainability and unrivalled hospitality, earning it the best “Residential Low Rise Project” Award by Cityscape Global. Spanning over 2.24 million m2  to lap a pristine 1.4 km shoreline, the project introduces the world’s first and largest mountain-top lagoon built in partnership with world-renowned Crystal Lagoons® . Designed to offer an abundance of colourful experiences at different heights, IL Monte Galala has also collaborated with internationally acclaimed BCI Studio to offer an interactive world of retail and leisure zones, catering to residents’ every desire. From Egypt’s first Adventure Park, an inspiring mountain-top art zone and world-class hotels and spas to a soul-soothing desert park, a state-of-the-art old town and an interactive sports hub, IL Monte Galala - Sokhna won the African Property award for the year 2018, guaranteeing to add a fun and exciting flare to your life.",
    subtitle: "a coastal universeon the rocks",
    imagePath: "assets/images/projects/ilmontegalala/Il-monte-galala-logo.jpg",
    images: [],
    videos: [],
  ),
  Project(
      id: "5",
      title: "Fokka Bay",
      description:
          "Wake up to a joyous mosaic of 12 island clusters, beckoning paradise-surroundings; fringed by 7 km of white sandy beaches, and soaked in Crystal Lagoons® all around. Expertly conceived in partnership with world-renowned Italian architects Gianluca Peluffo and Partners, Fouka Bay is the place to socialise, relax and repose, as you experience a unique profusion of tropical island life in the North Coast. Fouka Bay brings to fruition a special blend of beachfront simplicity, and true exclusivity, so that you can enjoy a front-row seat onto Ras El Hekma’s virgin coastline. Awarded 2018 Top Mediterranean Resort in Development by The Mediterranean Resort & Hotel Real Estate Forum, Fouka Bay was crowned  as an outstanding mixed -use resort showcasing dedication, innovation and expertise in tourism and hospitality across the Mediterranean region. Every home at Fouka Bay is crafted around your relaxation, and enjoyment. The development’s latest addition; The House Hotel & Residence is an exclusive invitation to enjoy the luxury of living in a beachfront serviced apartment while enjoying exciting water-sport activities, world-class dining experiences, and year- round entertainment with your loved ones.",
      imagePath: "assets/images/projects/fokkabay/fouka-bay-logo.jpg",
      subtitle: "the waterfront life",
      images: [
        "assets/images/projects/fokkabay/fb-1.jpeg",
        "assets/images/projects/fokkabay/fb-2.jpg",
        "assets/images/projects/fokkabay/fb-3.jpg"
      ],
      videos: []),
  Project(
      id: "6",
      title: "D-Bay",
      description:
          "D-Bay is a true testament to reshaping your summer experience and way of life. Taking waterfront homes to the next level, your every moment, memory, and view is cascading blue",
      imagePath: "assets/images/projects/d-bay/d-bay-logo.jpg",
      subtitle: "Discover D-Bay Sahel",
      images: [
        "assets/images/projects/d-bay/d-bay-1.jpg",
        "assets/images/projects/d-bay/d-bay-2.jpg",
        "assets/images/projects/d-bay/d-bay-3.jpg"
      ],
      videos: [
        "https://youtu.be/MY_Y83ZF4M8"
      ])
];
