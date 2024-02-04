import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulating a delay for demonstration purposes
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 600,
              height: 600,
            ),
            SizedBox(height: 20),
            Text(
              'Movie App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final List<Movie> movies = [
    Movie(
      title: 'Cruella',
      description:
      'Cruella, which is set in 1970s London amidst the punk rock revolution, follows a young grifter named Estella, a clever and creative girl determined to make a name for herself with her designs.',
      imagePath: 'assets/movie1.jpg',
    ),
    Movie(
      title: 'Modern Family',
      description:
      'Modern Family revolves around three different types of families (nuclear, blended, and same-sex) living in suburban Los Angeles, who are interrelated through wealthy businessman Jay Pritchett and his two children, Claire and Mitchell.',
      imagePath: 'assets/movie2.jpg',
    ),
    Movie(
      title: 'Paskal',
      description:
      'PASKAL (Pasukan Khas Laut) is an elite unit in the Royal Malaysian Navy. The movie follows the true events of PASKAL\'s Lieutenant Commander Arman Anwar and his team mission to rescue a tanker, MV Bunga Laurel, that was hijacked by Somalian Pirates in 2011.',
      imagePath: 'assets/movie3.jpg',
    ),
    Movie(
      title: 'Barbie',
      description:
      'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.',
      imagePath: 'assets/movie4.jpg',
    ),
    Movie(
      title: 'Sing',
      description:
      'Set in a world inhabited by anthropomorphic animals, the film focuses on a struggling theater owner who stages a singing competition in an effort to prevent his theater from entering foreclosure, as well as how the competition interferes with the personal lives of its contestants.',
      imagePath: 'assets/movie5.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Menu')),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movie: movies[index]),
                ),
              );
            },
            child: Card(
              elevation: 3,
              // Adjust the size of the Card here
              child: Container(
                width: 5, // Adjust the width as needed
                height: 5, // Adjust the height as needed
                child: Center(
                  child: Text(
                    movies[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              movie.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.asset(
              movie.imagePath,
              width: 300,
              height: 300,
              fit: BoxFit.contain, // Use BoxFit.contain instead of BoxFit.cover
            ),
            SizedBox(height: 20),
            Text(
              movie.description,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final String title;
  final String description;
  final String imagePath;

  Movie({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
