import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking {
  final String rpcURL = "http://10.0.2.2:7545";
  // final String rpcURL = "http://127.0.0.1:7545";
  final String wssURL = "ws://10.0.2.2:7545";
  // final String wssURL = "ws://127.0.0.1:7545";
  final String privateKey =
      "c9268c0d08975246af63834bbd941933ffe78c1f49bda252f1cc97ff45e56c75";

  Web3Client? web3client;
  bool isLoading = true;

  String? abiCode;
  EthereumAddress? contractAddress;

  Credentials? credentials;

  DeployedContract? contract;

  // Hello world json
  ContractFunction? message;
  ContractFunction? setMessage;
  String? deployedName;

  // NFT json
  ContractFunction? _uris;
  ContractFunction? _createTokenURL;
  List<String>? uris;

  ContractLinking() {
    setup();
  }

  setup() async {
    try {
      web3client = Web3Client(
        rpcURL,
        http.Client(),
        socketConnector: () {
          return IOWebSocketChannel.connect(wssURL).cast<String>();
        },
      );
      // await getAbi();
      await getCredentials();
      await getAbiForNFT();
      await getDeployedContractForNFT();
      // await getDeployedContract();
    } catch (e) {
      print("e.toString(): ${e.toString()}");
      print("e.toString(): ${e}");
    }
  }

  getAbi() async {
    String abiStringFile = await rootBundle.loadString(
      'build/contracts/HelloWorld.json',
    );

    final jsonABI = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonABI['abi']);
    contractAddress = EthereumAddress.fromHex(
      jsonABI['networks']['5777']['address'],
    );
  }

  Future<void> getAbiForNFT() async {
    String abiStringFile = await rootBundle.loadString(
      'build/contracts/CreateNFT.json',
    );

    final jsonABI = jsonDecode(abiStringFile);
    abiCode = jsonEncode(jsonABI['abi']);
    contractAddress = EthereumAddress.fromHex(
      jsonABI['networks']['5777']['address'],
    );
  }

  String revealPrivateKey() {
    var rng = Random.secure();
    EthPrivateKey priKey = EthPrivateKey.createRandom(rng);
    String s = bytesToHex(priKey.privateKey);
    return s;
  }

  Future<void> getCredentials() async {
    // credentials = revealPrivateKey();
    // credentials = EthPrivateKey.createRandom(Random.secure());
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  Future<void> getDeployedContract() async {
    contract = DeployedContract(
      ContractAbi.fromJson(abiCode!, "HelloWorld"),
      contractAddress!,
    );

    message = contract!.function("message");
    setMessage = contract!.function("setMessage");
    getMessage();
  }

  Future<void> getDeployedContractForNFT() async {
    contract = DeployedContract(
      ContractAbi.fromJson(abiCode!, "CreateNFT"),
      contractAddress!,
    );

    _uris = contract!.function("getAllTokenURIs");
    _createTokenURL = contract!.function("createTokenURI");
    await getURIs();
  }

  Future<void> getURIs() async {
    final _myURIs = await web3client?.call(
      contract: contract!,
      function: _uris!,
      params: [],
    );

    uris = (_myURIs?[0] as List<dynamic>).map((e) => e.toString()).toList();
    print("_myURIs: ${uris?.length}");
    isLoading = false;
  }

  Future<void> createTokenURIs(String uri) async {
    isLoading = true;
    await web3client?.sendTransaction(
      credentials!,
      Transaction.callContract(
        contract: contract!,
        function: _createTokenURL!,
        parameters: [uri],
      ),
    );
    await getURIs();
  }

  void getMessage() async {
    final myMessage = await web3client?.call(
      contract: contract!,
      function: message!,
      params: [],
    );

    deployedName = myMessage?[0];
    isLoading = false;
  }

  setAMessage(String message) async {
    isLoading = true;
    await web3client?.sendTransaction(
      credentials!,
      Transaction.callContract(
        contract: contract!,
        function: setMessage!,
        parameters: [message],
      ),
    );
  }
}
