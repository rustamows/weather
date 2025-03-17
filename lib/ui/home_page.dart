import 'package:flutter/material.dart';
import 'package:weather/model/weather_models.dart';
import 'package:weather/repository/weather_repository.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  WeatherModel? weatherModel;
  WeatherRepository repository = WeatherRepository();
  @override
  void initState() {
    super.initState();
    getData();
  }
 getData()async{
  var weatherModel = await repository.getWeatherModel('osh');
  setState(() {
    this.weatherModel = weatherModel;
  });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'graphic.png',
                    fit: BoxFit.cover,
                  ))),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            // top: 350,
            child: Container(
              // padding: EdgeInsets.all(8),
              width: double.infinity,
              // height: 531,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${DateTime.now()}'),
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 14, 34, 15),
                               decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                                )
                               ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Osh'),
                                      Icon(Icons.location_on),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset('oblaka.png'),
                              Text('Sunny')
                            ],
                          ),
                          Text('${weatherModel?.main?.temp}C'),
                          Column(
                            children: [
                              Text('${weatherModel?.main?.tempMax}'),
                               Text('${weatherModel?.main?.tempMin}')
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset('water.png'),
                          Text(
                            '${weatherModel?.main?.humidity}',
                          ),
                          Text('Huminity')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('gogo.png'),
                          Text('${weatherModel?.main?.pressure}'),
                          Text('Pressure')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('dodo.png'),
                          Text('${weatherModel?.wind}'),
                          Text('Wind')
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset('botish.png'),
                          Text('${weatherModel?.sys?.sunrise}'),
                          Text('Sunrise')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('chikish.png'),
                          Text('${weatherModel?.sys?.sunset}'),
                          Text('Sunset'),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('kum.png'),
                          Text('${weatherModel?.timezone}'),
                          Text('Daytime'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 101,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 95,
                            height: 101,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Image.asset('kuyosh.png'),
                                Text('Mon, 21'),
                                Image.asset('group.png')
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
