import 'package:flutter_test/flutter_test.dart';

import 'package:hdwallet_lib/hdwallet.dart';

void main() {
  group('Unit Test HDWallet and compare all values with https://iancoleman.io/bip39/', () {
    test('Create HDWallet from mnemonic', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      HDWallet hdWallet=HDWallet.fromMnemonic(mnemonic);
      String bip32RootKeyExpected="xprv9s21ZrQH143K2Hb4tFoe745QeXWmsLS9R6NTTbPpFwZ5Zviogybqoa43osQz1SSXnR4ew4sfZeCrxCefiSZC7LWsaiPQjYXTfTcmQSrVuNo";
      String seedHexExpected="a9e80c7b9a172ae97891733088210272870bace8f87788d357c95c3f8535433d66666c9c9090408a30fa95d7077afd88296e16a3d1778f01d35802375b819151";
      expect(bip32RootKeyExpected, hdWallet.bip32RootKey);
    });

    test('Create child HDWallet bitcon level 0 (account 0) from mnemonic', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      HDWallet masterWallet=HDWallet.fromMnemonic(mnemonic);
      HDWallet childWallet=masterWallet.derivePath("m/44'/0'/0'/0");
      String bip32ExtendedPrivateKey="xprvA1E8zXdN93WeGU3dfLLgKVp8mhKDcG7e36Ed6YsKNrjpRKVSZwfft5zrvczyJDMoWanHHnVqpTeZHybH5Tw3idTEGNh7QiWP8tWZLQZai6C";
      String bip32ExtendedPublicKey="xpub6EDVQ3AFyR4wUx86mMsggdksKj9i1iqVQKADtwGvwCGoJ7pb7UyvRtKLmtJb5nZsRPnSZAVRidpXfC5f7RrdYn9uJVR8dcvedjf999ZX7ub";
      expect(bip32ExtendedPrivateKey, childWallet.extendedPrivateKey);
      expect(bip32ExtendedPublicKey, childWallet.extendedPublicKey);
    });

    test('Create child HDWallet ethereum level 0 (account 0) from mnemonic', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      HDWallet masterWallet=HDWallet.fromMnemonic(mnemonic);
      HDWallet childWallet=masterWallet.derivePath("m/44'/60'/0'/0");
      String bip32ExtendedPrivateKey="xprvA1fuuyKZ9vPVZfBQ2xLtyboU9cFwRLa3GMqK5ADouGu96j7dUtLE5p2XuoeG8i5oDDeFATeFmi3CfvWS15TGXxCHLiVEGzT51hGwus2ag3L";
      String bip32ExtendedPublicKey="xpub6EfGKUrSzHwnn9Fs8ysuLjkChe6RpoHtdakusYdRTcS7yXSn2ReUdcM1m6DnSHTMTnCZPkoesfUdkSLtP6FeBCWNxk3uTUJ4VMvPznCTmrp";
      expect(bip32ExtendedPrivateKey, childWallet.extendedPrivateKey);
      expect(bip32ExtendedPublicKey, childWallet.extendedPublicKey);
    });

    test('Create grand children HDWallet bitcon level 0 (account 0) from mnemonic', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      HDWallet masterWallet=HDWallet.fromMnemonic(mnemonic);
      HDWallet childrenWallet=masterWallet.derivePath("m/44'/0'/0'/0/0");
      expect(childrenWallet.address,"1AxgSjSD5jsMcUMKXYpewZXMPtrBm6Yv75");
      expect(childrenWallet.publicKey,"02bd5ce14966eaad995a5d553f905317b3311bdd2eabcfd3a146922455ec0d4fd0");
      expect(childrenWallet.privateKey,"L2b7Ahkh4HW1w4jmvreufHZyswzzeyb1ToWdMLt6BcuUDNBf2b9f");
    });

    test('Create grand children HDWallet bitcon level 0 (account 0) from mnemonic ', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      HDWallet masterWallet=HDWallet.fromMnemonic(mnemonic);
      HDWallet childrenWallet=masterWallet.derivePath("m/44'/0'/0'/0/1");
      expect(childrenWallet.address,"1QCaMkWFniNxrRRsVAkzXVChCNViVtBqdQ");
      expect(childrenWallet.publicKey,"02533e3a3457c70402b65f3df2e62141b875a89a59e1973d6d5d46de7befaa4dd3");
      expect(childrenWallet.privateKey,"L1ZH8isP4rQnoZUDN4P6mLucSPUcbBT7myuVvxB6GMxXMDJ1xhUy");
    });

    test('Create grand children HDWallet ethereum level 0 (account 0) from mnemonic ', () {
      String mnemonic="any flee habit later unfair skin cake first very purse symbol spatial";
      HDWallet masterWallet=HDWallet.fromMnemonic(mnemonic);
      HDWallet childrenWallet=masterWallet.derivePath("m/44'/60'/0'/0/0");
      expect(childrenWallet.address,"0x84b517aa6e8b7d06d27e3b0421e37551649b044a");
      expect(childrenWallet.publicKey,"0248f5b64d28cc6f291b31969ef03c09a152690f7970e85b46d421ba25c7ca4153");
      expect(childrenWallet.privateKey,"537596d315637b0b0c0a01d39de85c6bdcf6a88225f1e202ba0121a0c32e5686");
    });

  });

}
