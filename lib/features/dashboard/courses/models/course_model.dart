class CourseListModel {
  final String title;
  final String description;
  final String image;
  final String price;
  final String rating;
  final String totalContent;
  final List<Videos> urls;

  CourseListModel({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.totalContent,
    required this.urls,
  });
}

class Videos {
  final String title;
  final String url;

  Videos({required this.title, required this.url});
}

List<CourseListModel> courseList = [
  CourseListModel(
    title: "Flutter Development",
    description: "Demo Discription",
    image:
        "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
    price: "1200",
    rating: '5',
    totalContent: '3',
    urls: [
      Videos(
          title: "Flutter Tutorial 1",
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      Videos(
          title: "Flutter Tutorial 2",
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
    ],
  ),
  CourseListModel(
    title: "Flutter Development",
    description: "Demo Discription",
    image:
        "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
    price: "1200",
    rating: '5',
    totalContent: '3',
    urls: [
      Videos(
          title: "Flutter Tutorial 1",
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      Videos(
          title: "Flutter Tutorial 2",
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
    ],
  ),
  CourseListModel(
    title: "Flutter Development",
    description: "Demo Discription",
    image:
        "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
    price: "1200",
    rating: '5',
    totalContent: '3',
    urls: [
      Videos(
          title: "Flutter Tutorial 1",
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
      Videos(
          title: "Flutter Tutorial 2",
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
    ],
  )
];
