import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tatweer_approval/constants.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/models/purchase_request.dart';
import 'package:tatweer_approval/models/purchase_request_line.dart';

class PurchaseRequestsNotifier extends StateNotifier<List<PurchaseRequest>> {
  PurchaseRequestsNotifier() : super([]);

  final Map<String, String> quiriesBasedOnGroup = {
    "CHSITEMG": "PR%3AHTTP+Waiting+CHSITEMG+Approval",
    "FMSM": "PR%3AHTTP+Waiting+FMSM+Approval",
    "CHGM": "PR%3AHTTP+Waiting+CHGM+Approval",
    "CEO": "PRSIMPLE%3AHTTP+Waiting+MD+Approval",
    "DH": "PRSIMPLE%3AHTTP+Waiting+DH+Approval",
    "LM": "PRSIMPLE%3AHTTP+Waiting+LM+Approval"
  };

  Future<http.Response> loadPurchaseRequests(String apikey, String mobileSC) async{
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/PRHTTP?lean=1&savedQuery=${quiriesBasedOnGroup[mobileSC]}&oslc.select=prnum,prtype,description,prid,dept,status,project.value,project.description,totalcost,statusdate,issuedate,chargetoorganization,vendor,companies.name,prline{prlineid,prlinenum,linetype,description,orderqty,unitcost,tax1code,tax1,loadedcost,person.displayname,storeloc,gldebitacct}'),
        headers: <String, String>{
          'apikey': apikey,
        });
    
  }

  Future<http.Response> loadTotalCount(String apikey, String mobileSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/PRHTTP/?lean=1&savedQuery=${quiriesBasedOnGroup[mobileSC]}&count=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> loadPurchaseRequestDoclinks(String apikey, int prid) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/PRHTTP/$prid/doclinks?lean=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> approvePurchaseRequestCall(
      String apikey, String prnum, String securityGroupSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/script/HTTPAPPROVEPR?lean=1&API_PRNUM=$prnum&API_SG=$securityGroupSC'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> rejectPurchaseRequestCall(
      String apikey, String prnum, String rejectionReason) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/script/HTTPREJECTPR?lean=1&API_PRNUM=$prnum&API_REJECTIONREASON=$rejectionReason'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<dynamic> approvePurchaseRequest(String apikey, String wonum, String securityGroupSC) async {
    final response = await approvePurchaseRequestCall(apikey, wonum, securityGroupSC);
    Map<String, dynamic> parsedResponse = {}; 
    if(response.body != ""){
      parsedResponse = json.decode(response.body);
    }
    return parsedResponse;
  }

  Future<dynamic> rejectPurchaseRequest(
      String apikey, String wonum, String rejectionReason) async {
    final response =
        await rejectPurchaseRequestCall(apikey, wonum, rejectionReason);
    Map<String, dynamic> parsedResponse = {};
    if(response.body != ""){
      parsedResponse = json.decode(response.body);
    }
    return parsedResponse;
  }

  Future<dynamic> getTotalCount(String apikey, String mobileSC) async {
    final response = await loadTotalCount(apikey, mobileSC);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    if(parsedResponse["totalCount"] != null){
      return parsedResponse["totalCount"].toString();
    }
    return null;
  }

  Future<List<Doclink>> getPurchaseRequestDoclinks(
      String apikey, int prid) async {
    final response = await loadPurchaseRequestDoclinks(apikey, prid);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    final List<Doclink> loadedDoclinks = [];
    for (final doclink in parsedResponse["member"]) {
      var href =
          '${Constants.baseUrl}oslc/os/PRHTTP/$prid/doclinks/${doclink["describedBy"]["identifier"]}?lean=1';
      loadedDoclinks.add(Doclink(
          ownerid: doclink["describedBy"]["ownerid"],
          docinfoid: doclink["describedBy"]["docinfoid"],
          identifier: doclink["describedBy"]["identifier"],
          attachmentSize: doclink["describedBy"]["attachmentSize"],
          createby: doclink["describedBy"]["createby"],
          title: doclink["describedBy"]["title"],
          description: doclink["describedBy"]["description"],
          filename: doclink["describedBy"]["fileName"],
          format: doclink["describedBy"]["format"]["label"],
          href: href));
    }
    return loadedDoclinks;
  }

  List<PurchaseRequestLine> _setPrLines(dynamic purchaseRequestLines) {
    List<PurchaseRequestLine> lines = [];
    for (final purchaseRequestLine in purchaseRequestLines) {
      lines.add(
        PurchaseRequestLine(
          prLineid: purchaseRequestLine["prlineid"],
          prLineNum: purchaseRequestLine["prlinenum"],
          lineType: purchaseRequestLine["linetype"],
          description: purchaseRequestLine["description"] ?? '',
          quantity: purchaseRequestLine["orderqty"],
          unitCost: purchaseRequestLine["unitcost"],
          vat: purchaseRequestLine["tax1"],
          loadedCost: purchaseRequestLine["loadedcost"],
          requestedByName: purchaseRequestLine["person"]["displayname"] ?? '',
          storeloc: purchaseRequestLine["storeloc"] ?? '',
          glAccount: purchaseRequestLine["gldebitacct"] ?? '',
        ),
      );
    }
    lines.sort((a, b) => a.prLineNum.compareTo(b.prLineNum));
    return lines;
  }

  Future<List<PurchaseRequest>> getPurchaseRequests(
      String apikey, String mobileSC) async {
    final response = await loadPurchaseRequests(apikey, mobileSC);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    final List<PurchaseRequest> loadedPurchaseRequests = [];
    for (final purchaseRequest in parsedResponse["member"]) {
      loadedPurchaseRequests.add(PurchaseRequest(
        prid: purchaseRequest["prid"],
        prnum: purchaseRequest["prnum"],
        prtype: purchaseRequest["prtype"] ?? '',
        prtypeDescription: purchaseRequest["prtype_description"] ?? '',
        description: purchaseRequest["description"] ?? '',
        status: purchaseRequest["status"],
        statusDescription: purchaseRequest["status_description"],
        department: purchaseRequest["dept"] ?? '',
        departmentDescription: purchaseRequest["dept_description"] ?? '',
        vendor: purchaseRequest["vendor"] ?? '',
        vendorDescription: purchaseRequest["companies"]["name"] ?? '',
        chargeToOrgnization: purchaseRequest["chargetoorganization"] ?? '',
        project: purchaseRequest["project"]["value"] ?? '',
        projectDescription: purchaseRequest["project"]["description"] ?? '',
        totalCost: purchaseRequest["totalcost"],
        prLines: _setPrLines(purchaseRequest["prline"]),
        statusDate: purchaseRequest["statusdate"] != null
                ? DateTime.parse(purchaseRequest["statusdate"]).toLocal()
                : null,
        issueDate: purchaseRequest["issuedate"] != null
                ? DateTime.parse(purchaseRequest["issuedate"]).toLocal()
                : null,
      ));
    }
    state = loadedPurchaseRequests;
    return loadedPurchaseRequests;
  }
}

final purchaseRequestsProvider =
    StateNotifierProvider<PurchaseRequestsNotifier, List<PurchaseRequest>>(
        (ref) {
  return PurchaseRequestsNotifier();
});
