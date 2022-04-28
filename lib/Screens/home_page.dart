import 'package:flutter/material.dart';

import '../Services/shared_preferences.dart';
import '../music_player.dart';

enum Language { Hindi, English, Malyalam }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String valueChoose = 'Hindi';
  PrefServices prefService = PrefServices();

  List listItem = ["Hindi", "English", "Malyalam"];
  // String lyrics = ;
  @override
  Widget build(BuildContext context) {
    final Map routeArg = ModalRoute.of(context)?.settings.arguments as Map;
    var a = routeArg['name'];
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 100,
                            child: Image.asset(
                              'assets/Meditation_Practice-modified.png',
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.orange,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Text(
                                  'Pranam',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  a.toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    DropdownButton(
                      hint: Text('Select'),
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue.toString();
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                    TextButton(
                      onPressed: () {
                        prefService.removeCache();
                        print('Hi');
                        Navigator.of(context).pushNamed('/splash');
                      },
                      child: Text('Logout'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                        primary: Colors.white,
                        minimumSize: const Size(350, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      // child: const Card(
                      //   color: Colors.orange,
                      //   child: const Text(
                      //     'Logout',
                      //     style: TextStyle(color: Colors.white),
                    ),
                  ]),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Satvamev Jayate'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  height: 20,
                  child: Text(
                    'Audio Clip',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Card(
                  elevation: 4,
                  color: Color(0xFFFDD835),
                  child: SingleChildScrollView(
                    child: MusicPlayer(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                  child: Text(
                    'Lyrics',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: const Color(0xFFFDD835),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            ''' सत्त्वमेव जयते !  सत्त्वमेव जयते !  सत्त्वमेव जयते !''',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const Text(
                            '''      
प्रेम और पवित्रता के भण्डार,
ओ परमात्मा !

आप इस सृष्टि को जैसी चाहते हो, वैसी ही सुन्दर और पवित्र यह सृष्टि बनी रहे।

इसलिए सर्वत्र शुभता के साम्राज्य का स्थापित होना और हर अशुभता का नाश होना जरुरी है।

इसीलिए प्रभुजी ! मेरी इतनी सी आरझु है की,
=> विश्व के सभी सज्जन स्थिर सत्त्व के स्वामी बने।
=> विश्व के सभी सज्जन आपसी मनमुटाव को छोड़कर संगठित बनें ओर शुभता के साम्राज्य की स्थापना के लिए सक्रिय बनें ।
=> विश्व के सभी दुर्जनों के मन की दुष्टता दूर हो । वे भी पवित्र बनें
,वे भी पवित्र बनें।

सत्त्वमेव जयते !  सत्त्वमेव जयते !  सत्त्वमेव जयते !
''',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: const Color(0xFFFDD835),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            '''सत्त्वमेव जयते''',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const Text(
                            'सृष्टि के हित के लिए एक मानस संग्राम',
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const Text(
                            '''
        
विश्वभर में छाई हुई आर्थिक, राजकीय, सामाजिक
पारिवारिक,शारीरिक, मानसिक और वैचारिक
विषमताएँ  ऐसे ही आ गीरी नहि है। 
अपितु यह विषमताएँ महदंश में मानवसर्जित या तो
मानवप्रेरीत है।

आज दुर्जनो का दानवीय बल समग्र मानवजाति के उपर हावी हो चुका है। ये लोग अपने क्रूर स्वार्थ और अनंत लोभ के लिए
प्रत्यक्ष या परोक्ष रूप से मानवजाति को किसी भी तरह का नुकसान पहुंचा सकते है और पहुंचा ही रहे है।

यह अधम वृत्ति राजनेताए और बड़े उद्योगपतिओं से लेकर सर्वत्र नज़र आती है।

इस स्थिति का वास्तविक कारण यह है कि, दुर्जनो के दानवीय बल के सामने सज्जनों का सत्त्व मूक बन गया है। वस्तुतः सज्जन भीतर से निर्माल्य - निःसत्त्व बन चुके है। उन्हें डर है कि, कहिं वे खुद ही दुर्जनो की दुष्टता का शिकार न बन जाए । बस !  भेड़-बकरी की
भाषा बोलते हुए सिंह की जमात के बीच लोमड़ियां नाच रही हैं।
इतिहास साक्षी है कि ,दुर्जनों के हरेक आक्रमण के सामने सज्जन संगठित होकर, सारी ताकत लगाकर सक्रिय प्रतिकार करते आए है । जब कि आज सज्जन निष्क्रिय हो चुके हैं, या तो आपस में लड़ रहे है। फलत: दुर्जनो को कोई रोकनेवाला न रहा है।

यदि सज्जनों में फिर से सत्त्व जाग्रत हो, यदि सज्जन दुर्जनो के दानवीय बल के सामने संगठित हो जाए, यदि सृष्टि के हित और सुख की रक्षा के लिए सज्जनें सक्रिय हो जाए, तो विश्वास रखना, दुनिया अचानक से बदल जाएगी।

सज्जनों के सत्त्व के प्रकाश में दुर्जनों के भीतरी अंधकार को पीगलना ही होगा । दुर्जन नही, दुर्जनता नष्ट हो जाएगी। फिरसे सृष्टि पर सत्य, शुभता और सौन्दर्य का आधिपत्य होगा।

बस ! इसी श्रद्धा के बल पर हमने ' सत्त्वमेव जयते' नाम से दुर्जनता के सामने मानस युद्ध छेड़ दीया है। आपकी- हमारी सिर्फ एक मिनट की शुभभावनाएँ की ऊर्जा से विश्व के अणु-परमाणु को पावन कर देगी। विश्वास रखें ।

वह दिन नजदीक है कि जब, विश्व के करोड़ो
लोग सुबह- रात ९:०० बजे (स्टा-टा.)सिर्फ एक मिनट के लिए एक साथ सात्त्विक- शुभ ऊर्जाबल के अभ्युदय के लिए तत्पर होंगे ।

हा ! एक दिन ' सत्त्वमेव जयते' ऐप दुनिया में
सज्जनता का प्रमाणपत्र बन जाएगा।

आइये ! आप भी हमारे साथ जुड़े । आपके हुरेक स्नेही- स्वजनों को भी प्रेरीत करें।

सत्त्वमेव जयते

स्वप्नदृष्टा : सत्त्वशील सज्जन
एप्प सर्जक : सत्त्वशील सज्जन
स्वर : सत्त्वशील सज्जन
म्युजिक : सत्त्वशील सज्जन
आयकोन : सत्त्वशील सज्जन
        ''',
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                  child: Text(
                    'Meaning',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 4,
                  color: const Color(0xFFFDD835),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            " सत्त्व का मतलब क्या होता है ?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const Text(
                            '''

सत्त्व ही तो जिन्दगी है दोस्त ! जिसके पास सत्त्व  नहिं है, वो अगर जायन्ट कंपनी का मालिक भी बन जाए तो भी वो अंदर से तो फकीर ही है । और यदि तुम गरीब होते हुए भी अचल  सत्त्व के स्वामी हो, तो तुम इस दुनिया के बेताज बादशाह हो |

स्वार्थ किसी का छीन सकता है, और  सत्त्व कुछ भी कुरबान कर सकता है । सत्त्व को कभी पैसे, पोस्ट या प्रोपर्टी की लालच से खरीदा नहिं जा सकता है ।  सत्त्व किसी सुख-सुविधा का गुलाम भी नहिं हो सकता है। वह आज़ाद है, बेडाग है, अमर है। सत्त्व के मन चारित्र्य की पवित्रता और नीतिमत्ता ही सर्वस्व है

यदि आपको यह पर्सनालिटी पसंद आई है, तो सत्त्वमेव जयते आपको सहाय कर सकता है।
        ''',
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
