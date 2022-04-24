import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hdwallet_lib/bip39.dart' as bip39;
import 'package:hdwallet_lib/bip32.dart' as bip32;
import 'package:hex/hex.dart';
void main() {
  group('Bip39 Test', () {
    test('can create a BIP44, bitcoin, account 0, external address', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      String seed=bip39.mnemonicToSeedHex(mnemonic);
      final root = bip32.BIP32.fromSeed(HEX.decode(seed) as Uint8List);
      final child1 = root.derivePath("m/44'/0'/0'/0/0"); //bip44 bitcoin account-0 chain-0 address-0

      print(child1.toBase58());
      print(HEX.encode(child1.chainCode));

      print("public 0 of account 0:");
      print(HEX.encode(child1.publicKey));
      print("private 0 of account 0:");
      print(HEX.encode(child1.privateKey!));
      print("Private Base58:");
      print(child1.toPrivateBase58());
      print("Base 58 public:");
      print(child1.toPublicBase58());
    });
  });
}
