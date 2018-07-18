import 'package:quiver/collection.dart' as quiver;
import 'package:sortedmap/src/treeset.dart';
import 'package:test/test.dart';
import 'dart:math';
import 'benchmark.dart';

void main() {

  Set<double> createRandomSet(Set<double> set, int count) {
    var random = new Random(1);
    for (var i = 0; i < count; i++) {
      set.add(random.nextDouble());
    }
    return set;
  }

  group('Performance benchmarks', () {

    benchmarkTest('Adding values', () {
      createRandomSet(new TreeSet(), 100);
    });

    var set = createRandomSet(new TreeSet(), 1000);
    benchmarkTest('Cloning', () {
      new TreeSet()..addAll(set);
    });
  });
  group('Performance benchmarks quiver', () {
    benchmarkTest('Adding values quiver', () {
      createRandomSet(new quiver.TreeSet(), 100);
    });

    var set = createRandomSet(new quiver.TreeSet(), 1000);
    benchmarkTest('Cloning quiver', () {
      new quiver.TreeSet()..addAll(set);
    });
  });

  test('compare', () {

    var set1 = createRandomSet(new TreeSet(), 100);
    var set2 = createRandomSet(new quiver.TreeSet(), 100);

    expect(set1.toList(),set2.toList());
  });

  test('iterator', () {


    var set1 = new TreeSet()..addAll(new Iterable.generate(10,(i)=>i));
    //var set1 = new quiver.TreeSet()..addAll(new Iterable.generate(10,(i)=>i));

    expect((set1.iterator..moveNext()).current, 0);
    expect((set1.iterator..movePrevious()).current, null);
    expect((set1.reverseIterator..moveNext()).current, 9);
    expect((set1.reverseIterator..movePrevious()).current, null);
    expect((set1.fromIterator(9)..moveNext()).current, 9);
    expect((set1.fromIterator(9)..moveNext()..moveNext()).current, null);
    expect((set1.fromIterator(9)..moveNext()..moveNext()..movePrevious()).current, 9);

    expect((set1.fromIterator(5)..moveNext()).current, 5);
    expect((set1.fromIterator(5)..moveNext()..movePrevious()).current, 4);
    expect((set1.fromIterator(5)..movePrevious()).current, 5);
    expect((set1.fromIterator(5, reversed: true)..movePrevious()).current, 5);
    expect((set1.fromIterator(5, reversed: true)..moveNext()).current, 5);
    expect((set1.fromIterator(5, reversed: true)..movePrevious()..movePrevious()).current, 6);
    expect((set1.fromIterator(5, reversed: true)..moveNext()..moveNext()).current, 4);

    expect((set1.fromIterator(5, inclusive: false)..moveNext()).current, 6);
    expect((set1.fromIterator(5, inclusive: false)..moveNext()..movePrevious()).current, 5);
    expect((set1.fromIterator(5, inclusive: false)..movePrevious()).current, 4);
    expect((set1.fromIterator(5, inclusive: false, reversed: true)..movePrevious()).current, 6);
    expect((set1.fromIterator(5, inclusive: false, reversed: true)..moveNext()).current, 4);
    expect((set1.fromIterator(5, inclusive: false, reversed: true)..movePrevious()..movePrevious()).current, 7);
    expect((set1.fromIterator(5, inclusive: false, reversed: true)..moveNext()..moveNext()).current, 3);

    expect((set1.fromIterator(4.5)..moveNext()).current, 5);
    expect((set1.fromIterator(4.5)..moveNext()..movePrevious()).current, 4);
    expect((set1.fromIterator(4.5)..movePrevious()).current, 4);
    expect((set1.fromIterator(4.5, reversed: true)..movePrevious()).current, 5);
    expect((set1.fromIterator(4.5, reversed: true)..moveNext()).current, 4);
    expect((set1.fromIterator(4.5, reversed: true)..movePrevious()..movePrevious()).current, 6);
    expect((set1.fromIterator(4.5, reversed: true)..moveNext()..moveNext()).current, 3);
    expect((set1.fromIterator(4.5, reversed: true)..movePrevious()..moveNext()).current, 4);
    expect((set1.fromIterator(4.5, reversed: true)..moveNext()..movePrevious()).current, 5);

    expect((set1.fromIterator(4.5, inclusive: false)..moveNext()).current, 5);
    expect((set1.fromIterator(4.5, inclusive: false)..moveNext()..movePrevious()).current, 4);
    expect((set1.fromIterator(4.5, inclusive: false)..movePrevious()).current, 4);
    expect((set1.fromIterator(4.5, inclusive: false, reversed: true)..movePrevious()).current, 5);
    expect((set1.fromIterator(4.5, inclusive: false, reversed: true)..moveNext()).current, 4);
    expect((set1.fromIterator(4.5, inclusive: false, reversed: true)..movePrevious()..movePrevious()).current, 6);
    expect((set1.fromIterator(4.5, inclusive: false, reversed: true)..moveNext()..moveNext()).current, 3);
  });
}
