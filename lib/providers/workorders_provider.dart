import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tatweer_maximo/constants.dart';
import 'package:tatweer_maximo/models/doclink.dart';
import 'package:tatweer_maximo/models/workorder.dart';
import 'package:tatweer_maximo/models/workorder_feecharge.dart';
import 'package:tatweer_maximo/models/workorder_material.dart';
import 'package:tatweer_maximo/models/workorder_service.dart';

class WorkordersNotifier extends StateNotifier<List<Workorder>> {
  WorkordersNotifier() : super([]);

  final Map<String, String> quiriesBasedOnGroup = {
    "CHSITEMG": "PLUSPWO%3AHTTP+WOs+Waiting+for+CHSITEMG+approval",
    "FMSM": "PLUSPWO%3AHTTP+WOs+Waiting+for+FMSM+approval",
    "SAMFM": "PLUSPWO%3AHTTP+WOs+Waiting+for+SAMFM+approval",
    "CHGM": "PLUSPWO%3AHTTP+WOs+Waiting+for+CHGM+approval",
    "FMDIR": "PLUSPWO%3AHTTP+WOs+Waiting+for+FMDIR+approval"
  };

  Future<http.Response> loadWorkorders(String apikey, String mobileSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/WOHTTP?lean=1&savedQuery=${quiriesBasedOnGroup[mobileSC]}&oslc.select=wonum,vendor,schedstart,description,workorderid,worktype,status,reportdate,estmatcost,wodepartments,owner,supervisor,ownergroup.description,pluspwopricetotals.estimatedtotalprice,rel.location{location,description,unit},rel.wpitem{location,description,itemqty,unitcost,linecost,plusplineprice},rel.wpservice{description,itemqty,plusplineprice},rel.pluspwpgenbill{type,description,lineprice}&ignorekeyref=1&ignorers=1&ignorecollectionref=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> loadTotalCount(String apikey, String mobileSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/WOHTTP/?lean=1&savedQuery=${quiriesBasedOnGroup[mobileSC]}&count=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<http.Response> loadWorkorderDoclinks(String apikey, int workorderid) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/os/WOHTTP/$workorderid/doclinks?lean=1'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<dynamic> approveWorkorderCall(
      String apikey, String wonum, String securityGroupSC) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/script/HTTPAPPROVEWO?lean=1&API_WONUM=$wonum&API_SG=$securityGroupSC'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<dynamic> rejectWorkorderCall(
      String apikey, String wonum, String rejectionReason) {
    return http.get(
        Uri.parse(
            '${Constants.baseUrl}oslc/script/HTTPREJECTWO?lean=1&API_WONUM=$wonum&API_REJECTIONREASON=$rejectionReason'),
        headers: <String, String>{
          'apikey': apikey,
        });
  }

  Future<dynamic> approveWorkorder(
      String apikey, String wonum, String securityGroupSC) async {
    final response = await approveWorkorderCall(apikey, wonum, securityGroupSC);
    Map<String, dynamic> parsedResponse = {};
    if (response.body != "") {
      parsedResponse = json.decode(response.body);
    }
    return parsedResponse;
  }

  Future<dynamic> rejectWorkorder(
      String apikey, String wonum, String rejectionReason) async {
    final response = await rejectWorkorderCall(apikey, wonum, rejectionReason);
    Map<String, dynamic> parsedResponse = {};
    if (response.body != "") {
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

  Future<List<Doclink>> getWorkorderDoclinks(
      String apikey, int workorderidid) async {
    final response = await loadWorkorderDoclinks(apikey, workorderidid);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    final List<Doclink> loadedDoclinks = [];
    for (final doclink in parsedResponse["member"]) {
      var href =
          '${Constants.baseUrl}oslc/os/WOHTTP/$workorderidid/doclinks/${doclink["describedBy"]["identifier"]}?lean=1';
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

  Future<List<Workorder>> getWorkorders(String apikey, String mobileSC) async {
    final response = await loadWorkorders(apikey, mobileSC);
    final Map<String, dynamic> parsedResponse = json.decode(response.body);
    final List<Workorder> loadedWorkorders = [];
    List<WorkorderMaterial> woMaterials = [];
    List<WorkorderService> woServices = [];
    List<WorkorderFeeCharge> woFeeCharges = [];

    for (final workorder in parsedResponse["member"]) {
      if (workorder["wpitem"] != null) {
        for (final material in workorder["wpitem"]) {
          woMaterials.add(
            WorkorderMaterial(
              description: material["description"],
              quantity: material["itemqty"],
              unitCost: material["unitcost"] ?? 0.0,
              lineCost: material["linecost"] ?? 0.0,
              linePrice: material["plusplineprice"] ?? 0.0,
              storeroom: material["location"] ?? "",
            ),
          );
        }
      }

      if (workorder["wpservice"] != null) {
        for (final service in workorder["wpservice"]) {
          woServices.add(
            WorkorderService(
              description: service["description"],
              quantity: service["itemqty"],
              linePrice: service["plusplineprice"] ?? 0.0,
            ),
          );
        }
      }

      if (workorder["pluspwpgenbill"] != null) {
        for (final feeCharge in workorder["pluspwpgenbill"]) {
          woFeeCharges.add(
            WorkorderFeeCharge(
              type: feeCharge["type"] ?? "",
              description: feeCharge["description"] ?? "",
              linePrice: feeCharge["lineprice"] ?? 0.0,
            ),
          );
        }
      }
      loadedWorkorders.add(Workorder(
          workorderid: workorder["workorderid"],
          wonum: workorder["wonum"],
          description: workorder["description"] ?? '',
          status: workorder["status"],
          statusDescription: workorder["status_description"],
          department: workorder["wodepartments"] ?? '',
          departmentDescription: workorder["wodepartments_description"] ?? '',
          location: workorder["location"][0]["location"] ?? '',
          locationDescription: workorder["location"][0]["description"] ?? '',
          locationIsUint: workorder["location"][0]["unit"],
          serviceProvider: workorder["vendor"] ?? '',
          ownergroupDescription: workorder["ownergroup"]["description"] ?? '',
          technician: workorder["owner"] ?? '',
          planner: workorder["supervisor"] ?? '',
          estimatedMaterialCost: workorder["estmatcost"] ?? 0.0,
          estimatedTotalPrice: workorder["pluspwopricetotals"]["estimatedtotalprice"] ?? 0.0,
          worktype: workorder["worktype"] ?? '',
          schedStartDate: workorder["schedstart"] != null
              ? DateTime.parse(workorder["schedstart"]).toLocal()
              : null,
          reportDate: workorder["reportdate"] != null
              ? DateTime.parse(workorder["reportdate"]).toLocal()
              : null,
          woMaterials: woMaterials,
          woServices: woServices,
          woFeeCharges: woFeeCharges));
          woMaterials = [];
          woServices = [];
          woFeeCharges = [];
    }
    state = loadedWorkorders;
    return loadedWorkorders;
  }
}

final workordersProvider =
    StateNotifierProvider<WorkordersNotifier, List<Workorder>>((ref) {
  return WorkordersNotifier();
});
