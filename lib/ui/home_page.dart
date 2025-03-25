import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/forcast_model.dart';
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
  ForcastModel? forcastModel;
  TextEditingController cityController = TextEditingController(text: 'Osh');
  WeatherRepository repository = WeatherRepository();
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    // setState(() {
    //    weatherModel = null;
    //    forcastModel = null;
    // });
    var weather = await repository.getWeatherModel(cityController.text);
    var forcast = await repository.getForcastModel(cityController.text);
    print('---ee${weather?.toJson()}');
     setState(() {
     this.weatherModel = weather;
       this.forcastModel = forcast;
    });
     
  }

  @override
  Widget build(BuildContext context) {
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
        (weatherModel?.sys?.sunrise ?? 0) * 1000);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
        (weatherModel?.sys?.sunset ?? 0) * 1000);
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
                    'assets/graphic.png',
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
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Поиск'),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.black
                                        )
                                      ),
                                      child: TextField(
                                        controller: cityController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffix: Icon(Icons.location_on)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          getData();
                                          Navigator.pop(context);
                                        });
                                        
                                      },child: Container(
                                       margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 14, 85, 177),
                                          borderRadius: BorderRadius.circular(10)
                                        ),child: Text('Search'),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).padding.bottom,)
                                  ],
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 14, 34, 15),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                  )),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(cityController.text),
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
                              // Image.network(
                              //     'https://openweathermap.org/img/wn/${weatherModel?.weather?.first.icon}.png'),
                              Text(weatherModel?.weather?.first.main ?? '-')
                            ],
                          ),
                          Text(
                            '${weatherModel?.main?.temp!.round()}℃',
                            style: TextStyle(fontSize: 23),
                          ),
                          Column(
                            children: [
                              Text('${weatherModel?.main?.tempMax!.round()}℃'),
                              Text('${weatherModel?.main?.tempMin!.round()}℃')
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
                          Image.asset('assets/water.png'),
                          Text(
                            '${weatherModel?.main?.humidity}',
                          ),
                          Text('Huminity')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('assets/gogo.png'),
                          Text('${weatherModel?.main?.pressure}'),
                          Text('Pressure')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('assets/dodo.png'),
                          Text('${weatherModel?.wind?.speed}km/h'),
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
                          Image.asset('assets/chikish.png'),
                          Text('${DateFormat('HH:mm').format(sunrise)}AM'),
                          Text('Sunrise')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('assets/botish.png'),
                          Text('${DateFormat('HH:mm').format(sunset)}PM'),
                          Text('Sunset')
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('assets/kum.png'),
                          Text('${sunset.difference(sunrise).inHours}h'),
                          Text('Daytime'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 121,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: forcastModel?.list?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            width: 95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                                ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                'https://openweathermap.org/img/wn/${forcastModel?.list?[index].weather?.first.icon}.png'),
                                Text( 
                                   '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch((forcastModel?.list?[index].dt ?? 0)! * 1000))}'),
                                Text('${forcastModel?.list?[index].main?.temp!.round()}℃'),
                                // Text('${weatherModel?.main?.tempMin} C')
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
