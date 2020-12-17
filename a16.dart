import 'dart:io';

class Rule {
  int from;
  int to;
  bool ok(int n) => from <= n && n <= to;
}

class RuleSet {
  RuleSet(this.name, String r) {
    for (final rule in r.split(' or ')) {
      final ru = Rule();
      final x = rule.split('-');
      ru.from = int.parse(x.first.trim());
      ru.to = int.parse(x.last.trim());
      rules.add(ru);
    }
  }
  String name;
  List<Rule> rules = [];
  bool ok(int n) => rules.any((e) => e.ok(n));
  List<int> candidates = <int>[];
  int n;
}

void main() {
  final rules = <RuleSet>[];
  final tickets = <List<int>>[];
  final valid = <List<int>>[];
  while (true) {
    final l = stdin.readLineSync();
    if (l == null) {
      break;
    }
    if (l.contains(':')) {
      final s = l.split(':');
      if (s.first.startsWith('your ticket')) {
        final my = stdin.readLineSync();
        var myTicket = <int>[];
        for (var n in my.split(',')) {
          myTicket.add(int.parse(n.trim()));
        }
        valid.add(myTicket);
      } else if (s.last.isNotEmpty) {
        rules.add(RuleSet(s.first, s.last));
      }
    } else if (l.contains(',')) {
      final t = <int>[];
      tickets.add(t);
      for (var n in l.split(',')) {
        t.add(int.parse(n.trim()));
      }
    }
  }
  final sum = tickets.expand(
    (ticket) {
      var err = ticket.map(
        (i) => rules.any((rule) => rule.ok(i)) ? null : i,
      );
      if (err.every((element) => element == null)) {
        valid.add(ticket);
      }
      return err;
    },
  ).reduce((value, element) => (value ?? 0) + (element ?? 0));
  print(sum);
  rules.forEach((element) {
    element.candidates = Iterable.generate(rules.length, (i) => i).toList();
  });
  while (rules
      .where((r) => r.name.startsWith('departure'))
      .any((r) => r.n == null)) {
    for (var rule in rules) {
      rule.candidates.removeWhere(
          (candi) => !valid.every((ticket) => rule.ok(ticket[candi])));
      if (rule.candidates.length == 1) {
        final c = rule.candidates.first;
        rule.n = c;
        rules.forEach((element) {
          element.candidates.remove(c);
        });
      }
    }
  }
  print(rules.where((r) => r.name.startsWith('departure')).map((element) {
    return valid[0][element.n];
  }).reduce((value, element) => value * element));
}
