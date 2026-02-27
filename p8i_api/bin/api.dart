import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import '../lib/models/point_of_interest.dart';

// Mock data - replace with database later
final List<PointOfInterest> mockPOIs = [
  // Poble Sec area - Dog sitters
  PointOfInterest(
    id: '1',
    name: 'Maria\'s Pet Care',
    description: 'Experienced dog walker and pet sitter. Available weekdays.',
    latitude: 41.3733,
    longitude: 2.1644,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '2',
    name: 'Paws & Claws Service',
    description: 'Professional pet sitting for cats and small animals.',
    latitude: 41.3745,
    longitude: 2.1655,
    iconType: 'cat',
    petTypes: ['cat', 'ferret'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '3',
    name: 'Happy Tails Pet Sitting',
    description: 'Loving care for your pets while you\'re away. 24/7 available.',
    latitude: 41.3720,
    longitude: 2.1630,
    iconType: 'dog',
    petTypes: ['dog', 'cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '4',
    name: 'Barcelona Vet Clinic',
    description: 'Full service veterinary clinic.',
    latitude: 41.3755,
    longitude: 2.1670,
    iconType: 'clinic',
    petTypes: ['dog', 'cat', 'ferret'],
    placeType: 'clinic',
  ),
  PointOfInterest(
    id: '5',
    name: 'Montjuïc Pet Care',
    description: 'Pet sitting near Montjuïc park. Great for active dogs.',
    latitude: 41.3710,
    longitude: 2.1620,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '6',
    name: 'Parallel Pet Services',
    description: 'Affordable pet care in Poble Sec.',
    latitude: 41.3740,
    longitude: 2.1650,
    iconType: 'dog',
    petTypes: ['dog', 'cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '7',
    name: 'Blai Street Cat Sitters',
    description: 'Local cat sitters with 10+ years experience.',
    latitude: 41.3728,
    longitude: 2.1638,
    iconType: 'cat',
    petTypes: ['cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '8',
    name: 'Poble Sec Dog Walkers',
    description: 'Morning and evening dog walks available.',
    latitude: 41.3750,
    longitude: 2.1660,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '9',
    name: 'Animal Shelter Poble Sec',
    description: 'Adoption center for dogs and cats.',
    latitude: 41.3735,
    longitude: 2.1645,
    iconType: 'shelter',
    petTypes: ['dog', 'cat'],
    placeType: 'shelter',
  ),
  PointOfInterest(
    id: '10',
    name: 'Emergency Vet Hospital',
    description: 'Emergency pet care available 24/7.',
    latitude: 41.3760,
    longitude: 2.1665,
    iconType: 'hospital',
    petTypes: ['dog', 'cat', 'ferret'],
    placeType: 'hospital',
  ),
  
  // Barceloneta area
  PointOfInterest(
    id: '11',
    name: 'Beach Dog Walkers',
    description: 'Dog walking along Barceloneta beach.',
    latitude: 41.3808,
    longitude: 2.1897,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '12',
    name: 'Barceloneta Pet Sitting',
    description: 'Professional pet care near the beach.',
    latitude: 41.3795,
    longitude: 2.1885,
    iconType: 'dog',
    petTypes: ['dog', 'cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '13',
    name: 'Marina Ferret Care',
    description: 'Specialized ferret sitting for sailors and travelers.',
    latitude: 41.3820,
    longitude: 2.1910,
    iconType: 'ferret',
    petTypes: ['ferret'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '14',
    name: 'Port Vell Vet Clinic',
    description: 'Experienced veterinary clinic.',
    latitude: 41.3785,
    longitude: 2.1870,
    iconType: 'clinic',
    petTypes: ['dog', 'cat'],
    placeType: 'clinic',
  ),
  PointOfInterest(
    id: '15',
    name: 'Passeig Marítim Dog Care',
    description: 'Daily beach walks for your dog.',
    latitude: 41.3800,
    longitude: 2.1890,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '16',
    name: 'Barceloneta Dog Walkers',
    description: 'Morning beach runs with your pet.',
    latitude: 41.3812,
    longitude: 2.1900,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '17',
    name: 'Seaside Cat Sitting',
    description: 'Cat care while you enjoy the beach.',
    latitude: 41.3790,
    longitude: 2.1880,
    iconType: 'cat',
    petTypes: ['cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '18',
    name: 'Moll de la Fusta Pets',
    description: 'Pet sitting near the old port.',
    latitude: 41.3775,
    longitude: 2.1860,
    iconType: 'dog',
    petTypes: ['dog', 'cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '19',
    name: 'Barceloneta Cat Care',
    description: 'Specialized in cat sitting and care.',
    latitude: 41.3805,
    longitude: 2.1895,
    iconType: 'cat',
    petTypes: ['cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '20',
    name: 'Beach Animal Hospital',
    description: 'Emergency veterinary hospital.',
    latitude: 41.3815,
    longitude: 2.1905,
    iconType: 'hospital',
    petTypes: ['dog', 'cat', 'ferret'],
    placeType: 'hospital',
  ),
  
  // More Poble Sec
  PointOfInterest(
    id: '21',
    name: 'Teatre Lliure Pet Care',
    description: 'Pet sitting near the theater district.',
    latitude: 41.3725,
    longitude: 2.1635,
    iconType: 'cat',
    petTypes: ['cat', 'ferret'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '22',
    name: 'Carrer Blesa Dog Sitters',
    description: 'Friendly neighborhood dog sitters.',
    latitude: 41.3738,
    longitude: 2.1648,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '23',
    name: 'Poble Sec Cat Sitters',
    description: 'Expert cat care and feeding.',
    latitude: 41.3742,
    longitude: 2.1652,
    iconType: 'cat',
    petTypes: ['cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '24',
    name: 'Carrer Tapioles Vet',
    description: 'Veterinary clinic for busy professionals.',
    latitude: 41.3748,
    longitude: 2.1658,
    iconType: 'clinic',
    petTypes: ['dog', 'cat'],
    placeType: 'clinic',
  ),
  PointOfInterest(
    id: '25',
    name: 'Magalhaes Dog Walkers',
    description: 'Daily walks and pet sitting.',
    latitude: 41.3715,
    longitude: 2.1625,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  
  // More Barceloneta
  PointOfInterest(
    id: '26',
    name: 'Sant Carles Pet Care',
    description: 'Local pet sitters in Barceloneta.',
    latitude: 41.3798,
    longitude: 2.1888,
    iconType: 'dog',
    petTypes: ['dog', 'cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '27',
    name: 'Carrer Baluard Ferret Care',
    description: 'Specialized ferret sitting and care.',
    latitude: 41.3802,
    longitude: 2.1892,
    iconType: 'ferret',
    petTypes: ['ferret'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '28',
    name: 'Barceloneta Animal Shelter',
    description: 'Adoption center for all types of pets.',
    latitude: 41.3810,
    longitude: 2.1898,
    iconType: 'shelter',
    petTypes: ['dog', 'cat', 'ferret'],
    placeType: 'shelter',
  ),
  PointOfInterest(
    id: '29',
    name: 'Plaça del Poeta Boscà Pets',
    description: 'Pet care in the heart of Barceloneta.',
    latitude: 41.3793,
    longitude: 2.1883,
    iconType: 'cat',
    petTypes: ['cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '30',
    name: 'Carrer de la Maquinista Pets',
    description: 'Affordable pet sitting services.',
    latitude: 41.3807,
    longitude: 2.1896,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  
  // Additional scattered points
  PointOfInterest(
    id: '31',
    name: 'Raval Vet Clinic',
    description: 'Full service veterinary clinic near El Raval.',
    latitude: 41.3780,
    longitude: 2.1700,
    iconType: 'clinic',
    petTypes: ['dog', 'cat', 'ferret'],
    placeType: 'clinic',
  ),
  PointOfInterest(
    id: '32',
    name: 'Sant Antoni Dog Walkers',
    description: 'Dog walking in Sant Antoni.',
    latitude: 41.3765,
    longitude: 2.1680,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '33',
    name: 'Gothic Quarter Cat Sitters',
    description: 'Cat sitting in the old city.',
    latitude: 41.3825,
    longitude: 2.1770,
    iconType: 'cat',
    petTypes: ['cat'],
    placeType: 'sitter',
  ),
  PointOfInterest(
    id: '34',
    name: 'Born Animal Hospital',
    description: 'Professional veterinary hospital in El Born.',
    latitude: 41.3850,
    longitude: 2.1820,
    iconType: 'hospital',
    petTypes: ['dog', 'cat', 'ferret'],
    placeType: 'hospital',
  ),
  PointOfInterest(
    id: '35',
    name: 'Ciutadella Park Dog Walkers',
    description: 'Dog walking in Ciutadella park.',
    latitude: 41.3870,
    longitude: 2.1860,
    iconType: 'dog',
    petTypes: ['dog'],
    placeType: 'sitter',
  ),
];

void main() async {
  final router = Router();

  router.get('/api/pois', (Request request) {
    final pois = mockPOIs.map((poi) => poi.toJson()).toList();
    return Response.ok(
      jsonEncode(pois),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
  });

  router.get('/api/pois/<id>', (Request request, String id) {
    final poi = mockPOIs.where((p) => p.id == id).firstOrNull;
    if (poi == null) {
      return Response.notFound(jsonEncode({'error': 'POI not found'}));
    }
    return Response.ok(
      jsonEncode(poi.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
  });

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '10274');
  final server = await io.serve(handler, '0.0.0.0', port);
  print('API serving at http://${server.address.host}:${server.port}');
}
