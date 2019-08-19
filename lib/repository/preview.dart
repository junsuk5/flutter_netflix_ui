import 'package:flutter/foundation.dart';

class Preview with ChangeNotifier {
  var _previews = [
    {
      'thumbnail':
          'https://static1.showtimes.com/poster/660x980/riverdale-netflix-131772.jpg',
    },
    {
      'thumbnail':
          'https://images-na.ssl-images-amazon.com/images/I/61ljrN7zmoL._SY606_.jpg',
    },
    {
      'thumbnail':
          'https://i1.wp.com/bloody-disgusting.com/wp-content/uploads/2018/09/haunting-of-hill-house-poster.jpg?ssl=1',
    },
    {
      'thumbnail':
          'https://ih0.redbubble.net/image.724456558.2420/flat,550x550,075,f.u11.jpg',
    },
    {
      'thumbnail':
          'http://cdn.collider.com/wp-content/uploads/2019/04/thriller-netflix-movie-poster.png',
    },
  ];

  get previews => _previews;

}
