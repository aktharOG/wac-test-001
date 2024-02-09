
import 'package:floor/floor.dart';
import 'package:wac_test_001/model/services/local_db/db_entity.dart';

@dao
abstract class ContentDao {
  @Query('SELECT * FROM ContentDao')
  Future<List<ContentEntity>> findAllPeople();

  @Query('SELECT name FROM ContentDao')
  Stream<List<String>> findAllPeopleName();


  @insert
  Future<void> insertPerson(ContentEntity person);
}