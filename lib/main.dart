import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/repository/hot.dart';
import 'package:flutter_netflix_clone/repository/original.dart';
import 'package:flutter_netflix_clone/repository/preview.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Preview()),
        ChangeNotifierProvider(builder: (_) => Original()),
        ChangeNotifierProvider(builder: (_) => Hot()),
      ],
      child: Consumer<Preview>(builder: (context, preview, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.black,
          ),
          home: NetflixMainPage(),
        );
      }),
    );
  }
}

class NetflixMainPage extends StatefulWidget {
  @override
  _NetflixMainPageState createState() => _NetflixMainPageState();
}

class _NetflixMainPageState extends State<NetflixMainPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final preview = Provider.of<Preview>(context);
    final original = Provider.of<Original>(context);
    final hot = Provider.of<Hot>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset('assets/Netflix_Logo_RGB.png', fit: BoxFit.cover),
        ),
        bottomNavigationBar: Theme(
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('홈')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('검색')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.computer), title: Text('공개 예정')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.save_alt), title: Text('저장한 콘텐츠 목록')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu), title: Text('더 보기')),
            ],
          ),
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image.network(
                      'https://static1.showtimes.com/poster/660x980/riverdale-netflix-131772.jpg',
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          stops: [0.6, 1.0],
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '뱀파이어',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '1980년대',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '실화 바탕',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '응원해 주고 싶은 캐릭터',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '내가 찜한 콘텐츠',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                onPressed: () {},
                              ),
                              RaisedButton(
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.play_arrow),
                                    Text('재생')
                                  ],
                                ),
                                onPressed: () {},
                              ),
                              FlatButton(
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '정보',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '미리 보기',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (var i = 0; i < preview.previews.length; i++)
                    Padding(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(preview.previews[i]['thumbnail']),
                        ),
                      ),
                      padding: const EdgeInsets.all(4),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '지금 뜨는 콘텐츠',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (var i = 0; i < hot.hots.length; i++)
                    Padding(
                      child: Image.network(
                        hot.hots[i]['thumbnail'],
                        width: 140,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                      padding: const EdgeInsets.all(4),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Netflix 오리지널 >',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (var i = 0; i < original.originals.length; i++)
                    Padding(
                      child: Image.network(
                        original.originals[i]['thumbnail'],
                        width: 140,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      padding: const EdgeInsets.all(4),
                    ),
                ],
              ),
            ),
            Text(
              'TV 드라마',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (var i = 1; i < 10; i++)
                    Padding(
                      child: Image.network(
                        'https://static1.showtimes.com/poster/660x980/riverdale-netflix-131772.jpg',
                        width: 140,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                      padding: const EdgeInsets.all(4),
                    ),
                ],
              ),
            ),
          ],
        ));
    ;
  }
}
