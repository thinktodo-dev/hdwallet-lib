import 'dart:typed_data';
import 'package:hdwallet_lib/bip32.dart';
import 'package:hdwallet_lib/bip39.dart';
import 'package:hex/hex.dart';
import 'package:web3lib/web3lib.dart';


import '../models/networks.dart';
import '../payments/index.dart';
import '../payments/p2pkh.dart';

/// @Author Thong Minh Nguyen playerthong@gmail.com
/// HDWallet will be implemented with definition like https://iancoleman.io/bip39/
/// It helps developer to understand more clearly
class HDWallet{

  late BIP32 _bip32;
  bool _isMaster=false;
  String? _coinType;
  NetworkType? _networkType;
  P2PKH? _p2pkh; //using for bitcoin of child hdwallet
  EthPrivateKey? _ethPrivateKey; //using for ethereum of child hdwallet

  HDWallet(BIP32 bip32,{bool pIsMaster=false,String? coinType,NetworkType? overrideNetwork}){
    _bip32=bip32;
    _isMaster=pIsMaster;
    _coinType=coinType;
    _networkType=overrideNetwork;
    //Bitcoin
    if(_coinType == "0"){
       _p2pkh =  P2PKH(
          data:  PaymentData(pubkey: _bip32.publicKey), network: _networkType ?? bitcoin);
    }else if(_coinType=="60"){
      _ethPrivateKey = EthPrivateKey.fromHex(HEX.encode(_bip32.privateKey!));
    }
  }

  String? get bip32RootKey =>  _isMaster ? _bip32.toBase58() : null;
  String get publicKey =>  HEX.encode(_bip32.publicKey);
  String? get extendedPrivateKey => _isMaster ? null : _bip32.toPrivateBase58();
  String? get extendedPublicKey => _isMaster ? null : _bip32.toPublicBase58();
  bool get isMaster => _isMaster;
  //String? get address => _p2pkh != null ? _p2pkh!.data.address : null;
  String? get address{
    if(_coinType == null) return null;
    //Bitcoin
    if(_coinType == "0"){
      return  _p2pkh?.data.address;
    }else if(_coinType=="60"){ //Ethereum
      return _ethPrivateKey?.address.hex;
    }
    return null;
  }

  String? get privateKey{
    if(_coinType == null) return HEX.encode(_bip32.privateKey!);
    //Bitcoin
    if(_coinType == "0"){
      return  _bip32.toWIF();
    }else if(_coinType=="60"){ //Ethereum
      if(_ethPrivateKey==null) return null;
      return HEX.encode(_ethPrivateKey!.privateKey);
    }
    return null;
  }


  /// derivePath will return child hdwallet
  HDWallet derivePath(String path){
    BIP32 child=_bip32.derivePath(path);
    String coinType=getCoinType(path);
    return HDWallet(child,coinType: coinType);
  }

  String getCoinType(String path){
    //m / purpose' / coin_type' / account' / change / address_index
    final regex =  RegExp(r"^(m\/)?(\d+'?\/)*\d+'?$");
    if (!regex.hasMatch(path)) throw  ArgumentError("Expected BIP32 Path");
    List<String> splitPath = path.split("/");
    String coinType=splitPath[2].replaceAll("'", "");
    return coinType;
  }

  ///seed is HEX string
  factory HDWallet.fromSeed(String seed) {
    BIP32 bip32 = BIP32.fromSeed(HEX.decode(seed) as Uint8List);
    return HDWallet(bip32,pIsMaster: true);
  }

  ///mnemonic is string
  factory HDWallet.fromMnemonic(String mnemonic) {
    bool isValidate=validateMnemonic(mnemonic);
    if(isValidate){
      String seed=mnemonicToSeedHex(mnemonic);
      BIP32 bip32 = BIP32.fromSeed(HEX.decode(seed) as Uint8List);
      return HDWallet(bip32,pIsMaster: true);
    }else{
      throw  ArgumentError("mnemonic is validated");
    }

  }



}