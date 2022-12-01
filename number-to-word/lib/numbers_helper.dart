import 'locales/en.dart';
import 'locales/vi.dart';
import 'locales/vi.dart';

/// Returns an array of strings from one-nineteen
getNumsNames(String locale) {
  switch (locale) {
    case "vi":
      return numNames_vi;
    case "en":
      return numNames;
    default:
      return numNames;
  }
}

/// Returns an array of strings from one-nineteen
getTensNames(String locale) {
  switch (locale) {
    case "vi":
      return tensNames_vi;
    case "en":
      return tensNames;
    default:
      return tensNames;
  }
}

/// Returns zero based on locale
getZero(String locale) {
  switch (locale) {
    case "vi":
      return zero_vi;
    case "en":
      return zero;
    default:
      return zero;
  }
}

/// Returns hundred based on locale
getHundred(String locale) {
  switch (locale) {
    case "vi":
      return hundred_vi;
    case "en":
      return hundred;
    default:
      return hundred;
  }
}

/// Returns thousand based on locale
getThousand(String locale) {
  switch (locale) {
    case "vi":
      return thousand_vi;
    case "en":
      return thousand;
    default:
      return thousand;
  }
}

/// Returns million based on locale
getMillion(String locale) {
  switch (locale) {
    case "vi":
      return million_vi;
    case "en":
      return million;
    default:
      return million;
  }
}

/// Returns billion based on locale
getBillion(String locale) {
  switch (locale) {
    case "vi":
      return billion_vi;
    case "en":
      return billion;
    default:
      return billion;
  }
}
