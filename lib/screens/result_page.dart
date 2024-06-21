import 'package:flutter/material.dart';
import 'epoch_computation.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    FilterOut filterOut = FilterOut.fromJson(data);
    var fof = filterOut.feeds;

    if (filterOut.feeds == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: const Center(
          child: Text(
              'Not a single feed yet.'), // Show a loading indicator while navigating
        ),
      );
    } else {
      //filtered fetched datetime
      String? createddateString = filterOut.feeds?[0].createdAt
          ?.substring(0, filterOut.feeds![0].createdAt!.length - 1);

      EpochComputation timeData = computefunction(createddateString!);

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Result',
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            //Listview is used in case if used wants to see more of the past outputs
            child: ListView.builder(
              itemCount: filterOut.feeds!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Added on ${timeData.year}-${timeData.month}-${timeData.day}',
                    style: const TextStyle(fontSize: 25),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Temperature: ${fof![fof.length - index - 1].field7}°C',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Water level: ${fof[fof.length - index - 1].field6} cm',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Updated ${timeData.epochTimeMin} mins ago',
                        // 'Updated ${(timeData.epochTimeMin) / 60} hours & ${(timeData.epochTimeMin) % 60} ago',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}

//purpose of FilterOut & Feeds is to handle json object and convert it into dart object
class FilterOut {
  List<Feeds>? feeds;

  FilterOut({this.feeds});

  FilterOut.fromJson(Map<String, dynamic> json) {
    // if feeds property is found in json then it creates a new list of Feeds objects from the JSON data
    if (json['feeds'] != null) {
      feeds = <Feeds>[];
      json['feeds'].forEach((v) {
        feeds!.add(Feeds.fromJson(v));
      });
    }
  }
}

//a Feeds class is created and feed value is stored to deal with conversion of json into dart object
class Feeds {
  String? createdAt;
  int? entryId;
  String? field6;
  String? field7;

  Feeds({
    this.createdAt,
    this.entryId,
    this.field6,
    this.field7,
  });

  Feeds.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    entryId = json['entry_id'];
    field6 = json['field6'];
    field7 = json['field7'];
  }
}
