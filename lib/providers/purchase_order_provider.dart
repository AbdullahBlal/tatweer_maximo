import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tatweer_approval/constants.dart';
import 'package:tatweer_approval/models/doclink.dart';
import 'package:tatweer_approval/models/purchase_order.dart';
import 'package:tatweer_approval/models/purchase_order_line.dart';

class PurchaseOrdersNotifier extends StateNotifier<List<PurchaseOrder>> {
  PurchaseOrdersNotifier() : super([]);

  final Map<String, String> quiriesBasedOnGroup = {
    "PM": "PO%3AHTTP+Waiting+PM+Approval",
    "FC": "PO%3AHTTP+Waiting+FC+Approval",
    "FD": "PO%3AHTTP+Waiting+FD+Approval",
    "CFO": "PO%3AHTTP+Waiting+CFO+Approval",
    "CEO": "PO%3AHTTP+Waiting+MD+Approval",
  };

  Future<http.Response> loadPurchaseOrders(String apikey, String mobileSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/POHTTP?lean=1&savedQuery=${quiriesBasedOnGroup[mobileSC]}&oslc.select=ponum,potypee,description,poid,dept,status,project,totalcost,chargetoorganization,purchaseagent,vendor,statusdate,orderdate,paymentterms,poline{polineid,polinenum,linetype,description,orderqty,unitcost,tax1code,tax1,loadedcost,person.displayname,storeloc,gldebitacct}&ignorekeyref=1&ignorers=1&ignorecollectionref=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> loadTotalCount(String apikey, String mobileSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/POHTTP/?lean=1&savedQuery=${quiriesBasedOnGroup[mobileSC]}&count=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> loadPurchaseOrderDoclinks(String apikey, int poid) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/POHTTP/$poid/doclinks?lean=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> approvePurchaseOrderCall(
      String apikey, String ponum, String securityGroupSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/script/HTTPAPPROVEPO?lean=1&API_PONUM=$ponum&API_SG=$securityGroupSC'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> rejectPurchaseOrderCall(
      String apikey, String ponum, String rejectionReason) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/script/HTTPREJECTPO?lean=1&API_PONUM=$ponum&API_REJECTIONREASON=$rejectionReason'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }


  Future<dynamic> approvePurchaseOrder(String apikey, String ponum, String securityGroupSC) async {
    final response = await approvePurchaseOrderCall(apikey, ponum, securityGroupSC);
    Map<String, dynamic> parsedResponse = {}; 
    if(response.body != ""){
      parsedResponse = json.decode(response.body);
    }
    return parsedResponse;
  }

  Future<dynamic> rejectPurchaseOrder(
      String apikey, String ponum, String rejectionReason) async {
    final response =
        await rejectPurchaseOrderCall(apikey, ponum, rejectionReason);
    Map<String, dynamic> parsedResponse = {};
    if(response.body != ""){
      parsedResponse = json.decode(response.body);
    }
    return parsedResponse;
  }

  Future<List<Doclink>> getPurchaseOrderDoclinks(
      String apikey, int poid) async {
    final response = await loadPurchaseOrderDoclinks(apikey, poid);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    final List<Doclink> loadedDoclinks = [];
    for (final doclink in parsedResponse["member"]) {
      var href =
          '${Constants.baseUrl}oslc/os/POHTTP/$poid/doclinks/${doclink["describedBy"]["identifier"]}?lean=1';
      print(href);
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

  Future<dynamic> getTotalCount(String apikey, String mobileSC) async{
    final response = await loadTotalCount(apikey, mobileSC);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    if(parsedResponse["totalCount"] != null){
      return parsedResponse["totalCount"].toString();
    }
    return null;
  }

  List<PurchaseOrderLine> _setPoLines(dynamic purchaseOrderLines) {
    List<PurchaseOrderLine> lines = [];
    for (final purchaseOrderLine in purchaseOrderLines) {
      lines.add(
        PurchaseOrderLine(
          poLineid: purchaseOrderLine["polineid"],
          polinenum: purchaseOrderLine["polinenum"],
          lineType: purchaseOrderLine["linetype"],
          description: purchaseOrderLine["description"] ?? '',
          quantity: purchaseOrderLine["orderqty"],
          unitCost: purchaseOrderLine["unitcost"],
          vat: purchaseOrderLine["tax1"],
          loadedCost: purchaseOrderLine["loadedcost"],
          requestedByName: purchaseOrderLine["person"]["displayname"] ?? '',
          storeloc: purchaseOrderLine["storeloc"] ?? '',
          glAccount: purchaseOrderLine["gldebitacct"] ?? ''
        ),
      );
    }
    lines.sort((a, b) => a.polinenum.compareTo(b.polinenum));
    return lines;
  }

  Future<List<PurchaseOrder>> getPurchaseOrders(String apikey, String mobileSC) async{
    final response = await loadPurchaseOrders(apikey, mobileSC);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    final List<PurchaseOrder> loadedPurchaseOrders = [];
    for (final purchaseOrder in parsedResponse["member"]) {
      loadedPurchaseOrders.add(PurchaseOrder(
        poid: purchaseOrder["poid"],
        ponum: purchaseOrder["ponum"],
        description: purchaseOrder["description"] ?? '',
        status: purchaseOrder["status"],
        statusDescription: purchaseOrder["status_description"],
        department: purchaseOrder["dept"] ?? '',
        departmentDescription: purchaseOrder["dept_description"] ?? '',
        vendor: purchaseOrder["vendor"] ?? '',
        vendorDescription: purchaseOrder["vendor"] ?? '', // not available in the main call
        chargeToOrgnization: purchaseOrder["chargetoorganization"] ?? '',
        project: purchaseOrder["project"] ?? '',
        projectDescription: purchaseOrder["project"] ?? '', // not available in the main call
        purchaseAgent: purchaseOrder["purchaseagent"] ?? '',
        paymentTerms: purchaseOrder["paymentterms"] ?? '',
        paymentTermsDetails: purchaseOrder["paymentterms_description"] ?? '',
        totalCost: purchaseOrder["totalcost"],
        potype: purchaseOrder["potypee"] ?? '',
        potypeDescription: purchaseOrder["potypee_description"] ?? '',
        poLines: _setPoLines(purchaseOrder["poline"]),
        statusDate: purchaseOrder["statusdate"] != null
                ? DateTime.parse(purchaseOrder["statusdate"]).toLocal()
                : null,
        orderDate: purchaseOrder["orderdate"] != null
                ? DateTime.parse(purchaseOrder["orderdate"]).toLocal()
                : null,
      ));
    }
    state = loadedPurchaseOrders;
    return loadedPurchaseOrders;
  }
}


final purchaseOrdersProvider = StateNotifierProvider<PurchaseOrdersNotifier, List<PurchaseOrder>>((ref){
  return PurchaseOrdersNotifier();
});