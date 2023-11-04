class IntroContent {
  String image;
  String title;
  String description;
  IntroContent(
      {required this.image, required this.title, required this.description});
}

List<IntroContent> contents = [
  IntroContent(
    image: "assets/to-do-image.jpeg",
    title: "Organization",
    description:
        "People join to swiftly make infrastructure improvements in response to user and government reports, fostering community improvement!",
  ),
  IntroContent(
    image: "assets/announcement-image.jpeg",
    title: "Standard User",
    description:
        "We encourage our users such as yourself to report on the infrastructural needs in your area, thereby playing a pivotal role in enhancing our city's infrastructure!",
  ),
  IntroContent(
    image: "assets/travel.jpeg",
    title: "Other Essentials",
    description:
        "In need of public transportation? Do you want to see which route can help you get to your destination the quickest? All these essentials have now been made available!",
  ),
];
