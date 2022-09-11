import 'package:linkfy_text/src/enum.dart';

String urlRegExp = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.,&]+';

String hashtagRegExp = r'(#+[a-zA-Z0-9(_)]{1,})';

String userTagRegExp = r'(<a[\s]+([^>]+)>((?:.(?!\<\/a\>))*.)<\/a>)';

String emailRegExp =
    r"([a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+)";

/// construct regexp. pattern from provided link types
RegExp constructRegExpFromLinkType(List<LinkType> types) {
  // default case where we always want to match url strings
  final len = types.length;
  if (len == 1 && types.first == LinkType.url) {
    return RegExp(urlRegExp);
  }
  final buffer = StringBuffer();
  for (var i = 0; i < len; i++) {
    final type = types[i];
    final isLast = i == len - 1;
    switch (type) {
      case LinkType.url:
        isLast ? buffer.write("($urlRegExp)") : buffer.write("($urlRegExp)|");
        break;
      case LinkType.hashTag:
        isLast
            ? buffer.write("($hashtagRegExp)")
            : buffer.write("($hashtagRegExp)|");
        break;
      case LinkType.userTag:
        isLast
            ? buffer.write("($userTagRegExp)")
            : buffer.write("($userTagRegExp)|");
        break;
      case LinkType.email:
        isLast
            ? buffer.write("($emailRegExp)")
            : buffer.write("($emailRegExp)|");
        break;
      default:
    }
  }
  return RegExp(buffer.toString());
}

LinkType getMatchedType(String match) {
  late LinkType type;
  if (RegExp(emailRegExp).hasMatch(match)) {
    type = LinkType.email;
  } else if (RegExp(userTagRegExp).hasMatch(match)) {
    type = LinkType.userTag;
  } else if (RegExp(hashtagRegExp).hasMatch(match)) {
    type = LinkType.hashTag;
  } else if (RegExp(urlRegExp).hasMatch(match)) {
    type = LinkType.url;
  }
  return type;
}
