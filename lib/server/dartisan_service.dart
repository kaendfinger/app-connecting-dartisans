// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_server;

@app.Group("/services")
@Encode()
class DartisanService extends MongoDbService<Dartisan> {
  DartisanService() : super("dartisans");

  @app.Route("/dartisan/:openId", methods: const [app.GET])
  Future<Dartisan> get(String openId) {
    return findOne({"openId": openId}).then((dartisan) {
      if (dartisan == null) {
        return new Dartisan();
      } else {
        return dartisan;
      }
    });
  }

  @app.Route("/dartisans", methods: const [app.GET])
  Future<List<Dartisan>> load() => find();

  @app.Route("/dartisan/:openId", methods: const [app.POST])
  Future<Dartisan> addOrUpdate(@Decode() Dartisan inputDartisan) {
    return findOne({"openId": inputDartisan.openId}).then((existingDartisan) {
      if (existingDartisan == null) {
        return insert(inputDartisan).then((_) => inputDartisan);
      } else {
        return update({"openId": existingDartisan.openId}, inputDartisan).then((_) => inputDartisan);
      }
    });
  }
}