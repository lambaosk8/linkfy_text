import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/utils/regex.dart';

class Link {
  String? displayString;
  String? value;
  LinkType? type;

  Link();

  Link.fromMatch(RegExpMatch match) {
    String _match = match.input.substring(match.start, match.end);
    type = getMatchedType(_match);
    value = _match;
    displayString = _match;
  }
}
