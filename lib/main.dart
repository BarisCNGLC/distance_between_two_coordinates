import 'dart:math';

class Coordinates {
  double latitude, longitude;

  Coordinates(this.latitude, this.longitude);
}

int haversineDistance(Coordinates coord1, Coordinates coord2) {
  const earthRadius = 6371.0; // Dünya'nın yarıçapı km cinsinden

  // Enlem ve boylam farkları radyan cinsinden hesaplanır
  var dLat = (coord2.latitude - coord1.latitude) * (pi / 180);
  var dLon = (coord2.longitude - coord1.longitude) * (pi / 180);

  // Haversine formülü uygulanır
  var a = sin(dLat / 2) * sin(dLat / 2) +
      cos(coord1.latitude * (pi / 180)) *
          cos(coord2.latitude * (pi / 180)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Mesafe hesaplanır ve tam sayı kısmı döndürülür
  var distance = (earthRadius * c).toInt();
  return distance;
}

int bearingFromTekirdag(Coordinates tekirdag, Coordinates other) {
  // İki nokta arasındaki açıyı hesaplamak için formül kullanılır
  var dLon = (other.longitude - tekirdag.longitude) * (pi / 180);

  var x = cos(other.latitude * (pi / 180)) * sin(dLon);
  var y =
      cos(tekirdag.latitude * (pi / 180)) * sin(other.latitude * (pi / 180)) -
          sin(tekirdag.latitude * (pi / 180)) *
              cos(other.latitude * (pi / 180)) *
              cos(dLon);

  var bearing = atan2(x, y);

  // Radyan cinsinden açıyı dereceye çevirir ve tam sayı kısmı döndürülür
  var bearingDegrees = ((bearing * (180 / pi) + 360) % 360).toInt();

  return bearingDegrees;
}

void main2() {
  // Tekirdağ koordinatları örneği
  Coordinates tekirdag = Coordinates(40.9830, 27.5216);

  // kabe koordinatları
  Coordinates kabe = Coordinates(21.4224779, 39.8251832);

  // Mesafe ve açıyı hesapla
  var distance = haversineDistance(tekirdag, kabe);
  var angleFromTekirdag = bearingFromTekirdag(tekirdag, kabe);

  // Sonuçları ekrana yazdır
  print('Mesafe: $distance km');
  print(
      'Kabe, Tekirdağ\'daki kişinin kuzeyine göre $angleFromTekirdag derecesindedir.');
}
