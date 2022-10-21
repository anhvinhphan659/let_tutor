class Teacher {
  String name;
  String nationality;
  int vote;
  int star;
  String image;
  List<String> tags;
  String description;
  String national_img;
  Teacher(
      {this.name = "",
      this.nationality = "",
      this.vote = 0,
      this.star = 0,
      this.image = "",
      this.tags = const [],
      this.description = "",
      this.national_img = ""});
}

List<Teacher> sampleTeachers = [
  Teacher(
      name: "Keegan",
      nationality: "France",
      vote: 58,
      star: 5,
      image:
          'https://api.app.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1627913015850.00',
      tags: [
        "Tiếng anh ch công việc",
        "Giao tiếp",
        "Tiếng anh cho trẻ em ",
        "IELTS",
        "TOEIC"
      ],
      description:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/fr.svg"),
  Teacher(
      name: "Adelia Rice",
      tags: ["", "", "", ""],
      description: "Odit est ratione et dolorem tenetur illum.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/bolivia.svg"),
  Teacher(
      name: "Adelia Rice",
      tags: ["", "", "", ""],
      description: "Odit est ratione et dolorem tenetur illum.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/bolivia.svg"),
  Teacher(
      name: "Adelia Rice",
      tags: ["", "", "", ""],
      description: "Odit est ratione et dolorem tenetur illum.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/bolivia.svg"),
  Teacher(
      name: "Adelia Rice",
      tags: ["", "", "", ""],
      description: "Odit est ratione et dolorem tenetur illum.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/bolivia.svg"),
  Teacher(
      name: "Adelia Rice",
      tags: ["", "", "", ""],
      description: "Odit est ratione et dolorem tenetur illum.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/bolivia.svg"),
  Teacher(
      name: "Adelia Rice",
      tags: ["", "", "", ""],
      description: "Odit est ratione et dolorem tenetur illum.",
      national_img:
          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/bolivia.svg"),
];
