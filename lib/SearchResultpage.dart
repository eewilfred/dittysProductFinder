import 'package:flutter/material.dart';
import 'package:untitled/SearchResultModel.dart';
import 'package:untitled/SearchRequest.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xel;



/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);
}

class ListViewHomeLayout extends StatefulWidget {

  String unformatedItemsToSearch;
  ListViewHomeLayout({
    required this.unformatedItemsToSearch,
  });

  @override
  ListViewHome createState() {
    
    return new ListViewHome(unformatedItemsToSearch);
  }
}
class ListViewHome extends State<ListViewHomeLayout> {
  late String unformatedItemsToSearch;

  String formatedResult = "";
  String formatedResultFinal = "";

  var searchMap = Map<String, List<Value>>();
  List<String> searchItems = [
    "LS-FINDITNM-SUB, Cisco50-device license for  FindIT Network Manager - 1 year",
    "SFP-10G-SR-S=, Cisco10GBASE-SR SFP Module, Enterprise-Class",
    "SFP-H10GB-CU1M=, Cisco10GBASE-CU SFP+ Cable 1 Meter",
    "UCS-MR-X16G1RS-H=, Cisco16GB DDR4-2666-MHz RDIMM/PC4-21300/single rank/x4/1.2v",
    "C9105AXI-EWC-I, Cisco Embedded Wireless Controller on C9105AX Access Point",
    "C9200L-STACKKIT-RF, Cisco Catalyst 9200L Stack Module REMANUFACTURED",
    "PWR-C5-600WAC-RF, Cisco600W AC Config 5 Power Supply REMANUFACTURED",
    "CP-6823-3PC-BUN-UK, Cisco IP DECT 6823 Bundle, Handset and Base, MPP, UK",
    "CP-8841-3PCC-K9=, Cisco IP Phone 8841 with Multiplatform Phone firmware",
    "CP-6800-PWR-CE=, Cisco 6800 CE POWER ADAPTER",
    "CP-6825-3PC-CE-K9=, Cisco IP DECT 6825 Handset, MPP, EU and APAC",
    "SG250X-48P-K9-UK, CiscoSG250X-48P 48-Port Gigabit PoE Smart Switch with 10G Uplinks",
    "SG350-10SFP-K9-UK, Cisco SG350-10SFP 10-port Gigabit Managed SFP Switch",
    "SG350-52P-K9-EU, Cisco SG350-52P 52-port Gigabit PoE Managed Switch",
    "SF352-08-K9-EU, Cisco SF352-08 8-port 10/100 Managed Switch",
    "SF352-08MP-K9-UK, Cisco SF352-08MP 8-port 10/100 Max-POE Managed Switch",
    "SF352-08MP-K9-EU, Cisco SF352-08MP 8-port 10/100 Max-POE Managed Switch",
    "SF352-08P-K9-EU, Cisco SF352-08P 8-port 10/100 POE Managed Switch",
    "SF352-08P-K9-UK, Cisco SF352-08P 8-port 10/100 POE Managed Switch",
    "SG250X-24-K9-EU, CiscoSG250X-24 24-Port Gigabit Smart Switch with 10G Uplinks",
    "SG250X-24-K9-UK, CiscoSG250X-24 24-Port Gigabit Smart Switch with 10G Uplinks",
    "LS-CBD-1-1Y=, ",
    "LS-CBD-15-1Y=, CiscoSingle device license for  Business Dashboard - 1 year",
    "LS-CBD-25-1Y=, Cisco15-device license for  Business Dashboard - 1 year",
    "SF220-24-K9-UK, Cisco25-device license for  Business Dashboard - 1 year",
    "LS-CBD-50-1Y=, CiscoSF220-24 24-Port 10/100 Smart Switch",
    "LS-CBD-SUB, Cisco50-device license for  Business Dashboard - 1 year",
    "LS-CBD-DEV, CiscoLicense subscription for  Business Dashboard",
    "LS-FINDITNM-1-1Y=, CiscoDevice license for  Business Dashboard",
    "LS-FINDITNM-15-1Y=, Cisco1-device license for  FindIT Network Manager - 1 year",
    "LS-FINDITNM-25-1Y=, Cisco15-device license for  FindIT Network Manager - 1 year",
    "LS-FINDITNM-50-1Y=, Cisco25-device license for  FindIT Network Manager - 1 year",
    "LS-FINDITNM-SUB, Cisco50-device license for  FindIT Network Manager - 1 year",
    "LS-FNM-KAS-50-1Y=, CiscoLicense subscription for  FindIT Network Manager",
    "LS-FINDITNM-DEV, Cisco50-device Kaseya integration license for FindIT - 1 year",
    "LS-FNM-KAS-15-1Y=, CiscoDevice license for  FindIT Network Manager",
    "LS-FNM-KAS-25-1Y=, Cisco15-device Kaseya integration license for FindIT - 1 year",
    "CBS110-24T-EU, Cisco25-device Kaseya integration license for FindIT - 1 year",
    "CBS110-16PP-EU, CiscoCBS110 Unmanaged 24-port GE, 2x1G SFP Shared",
    "CBS110-24PP-EU, CiscoCBS110 Unmanaged 16-port GE, Partial PoE",
    "CBS110-16PP-UK, CiscoCBS110 Unmanaged 24-port GE, Partial PoE, 2x1G SFP Shared",
    "CBS110-24T-UK, CiscoCBS110 Unmanaged 16-port GE, Partial PoE",
    "CBS110-24PP-UK, CiscoCBS110 Unmanaged 24-port GE, 2x1G SFP Shared",
    "CBW142ACM-I-EU, CiscoCBS110 Unmanaged 24-port GE, Partial PoE, 2x1G SFP Shared",
    "CBS350-48FP-4G-UK, CiscoCBW142ACM 802.11ac 2x2 Wave 2 Mesh Extender Wall Outlet",
    "CBS350-48P-4G-UK, CiscoCBS350 Managed 48-port GE, Full PoE, 4x1G SFP",
    "CBS350-48FP-4G-EU, CiscoCBS350 Managed 48-port GE, PoE, 4x1G SFP",
    "CBS250-48P-4X-UK, CiscoCBS350 Managed 48-port GE, Full PoE, 4x1G SFP",
    "CBS250-48T-4X-UK, CiscoCBS250 Smart 48-port GE, PoE, 4x10G SFP+",
    "SX350X-52-K9-EU, CiscoCBS250 Smart 48-port GE, 4x10G SFP+",
    "SX350X-52-K9-UK, Cisco52-Port 10GBase-T Stackable Managed Switch",
    "SF350-48P-K9-UK, Cisco52-Port 10GBase-T Stackable Managed Switch",
    "SG350X-24PV-K9-UK, Cisco SF350-48P 48-port 10/100 POE Managed Switch",
    "CBS350-8T-E-2G-UK, Cisco24-Port 5G PoE Stackable Managed Switch",
    "SG350X-48PV-K9-EU, CiscoCBS350 Managed 8-port GE, Ext PS, 2x1G Combo",
    "SG350X-48PV-K9-UK, Cisco48-Port 5G PoE Stackable Managed Switch",
    "SG350X-8PMD-K9-EU, Cisco48-Port 5G PoE Stackable Managed Switch",
    "SG350X-8PMD-K9-UK, Cisco SG350-8PMD 8-Port 2.5G PoE Stackable Managed Switch",
    "SG350-28MP-K9-UK, Cisco SG350-8PMD 8-Port 2.5G PoE Stackable Managed Switch",
    "SG350-28-K9-UK, Cisco SG350-28MP 28-port Gigabit POE Managed Switch",
    "SG350-28P-K9-UK, Cisco SG350-28 28-port Gigabit Managed Switch",
    "CBW143ACM-I-EU, Cisco SG350-28P 28-port Gigabit POE Managed Switch",
    "SG350-8PD-K9-EU, CiscoCBW143ACM 802.11ac 2x2 Wave 2 Mesh Extender Wall Mount",
    "SG350-8PD-K9-UK, Cisco SG350-8PD 8-Port 2.5G PoE Managed Switch",
    "SG350X-12PMV-K9-EU, Cisco SG350-8PD 8-Port 2.5G PoE Managed Switch",
    "SG350X-12PMV-K9-UK, Cisco12-Port 5G PoE Stackable Managed Switch",
    "SG350X-24MP-K9-EU, Cisco12-Port 5G PoE Stackable Managed Switch",
    "SG350X-24MP-K9-UK, Cisco SG350X-24MP 24-port Gigabit POE Stackable Switch",
    "SG550X-24-K9-EU, Cisco SG350X-24MP 24-port Gigabit POE Stackable Switch",
    "SG550X-24-K9-UK, Cisco SG550X-24 24-port Gigabit Stackable Switch",
    "SG550X-24P-K9-EU, Cisco SG550X-24 24-port Gigabit Stackable Switch",
    "SG550X-24MP-K9-UK, Cisco SG550X-24P 24-port Gigabit PoE Stackable Switch",
    "SG550X-24MPP-K9-EU, Cisco SG550X-24MP 24-port Gigabit PoE Stackable Switch",
    "SG550X-24MPP-K9-UK, Cisco SG550X-24MPP 24-port Gigabit PoE Stackable Switch",
    "SG550X-24P-K9-UK, Cisco SG550X-24MPP 24-port Gigabit PoE Stackable Switch",
    "CBS350-24FP-4G-EU, Cisco SG550X-24P 24-port Gigabit PoE Stackable Switch",
    "CBS350-24FP-4G-UK, CiscoCBS350 Managed 24-port GE, Full PoE, 4x1G SFP",
    "CBS350-48T-4G-EU, CiscoCBS350 Managed 24-port GE, Full PoE, 4x1G SFP",
    "CBS350-24T-4G-EU, CiscoCBS350 Managed 48-port GE, 4x1G SFP",
    "CBS350-24T-4G-UK, CiscoCBS350 Managed 24-port GE, 4x1G SFP",
    "CBS350-48FP-4X-EU, CiscoCBS350 Managed 24-port GE, 4x1G SFP",
    "CBS350-48T-4X-EU, CiscoCBS350 Managed 48-port GE, Full PoE, 4x10G SFP+",
    "CBS350-24FP-4X-EU, CiscoCBS350 Managed 48-port GE, 4x10G SFP+",
    "CBS350-24P-4X-EU, CiscoCBS350 Managed 24-port GE, Full PoE, 4x10G SFP+",
    "CBS350-48FP-4X-UK, CiscoCBS350 Managed 24-port GE, PoE, 4x10G SFP+",
    "CBS350-48T-4X-UK, CiscoCBS350 Managed 48-port GE, Full PoE, 4x10G SFP+",
    "CBS350-24FP-4X-UK, CiscoCBS350 Managed 48-port GE, 4x10G SFP+",
    "CBS350-24P-4X-UK, CiscoCBS350 Managed 24-port GE, Full PoE, 4x10G SFP+",
    "SG250-26HP-K9-EU, CiscoCBS350 Managed 24-port GE, PoE, 4x10G SFP+",
    "SG250-26P-K9-EU, Cisco SG250-26HP 26-port Gigabit PoE Switch",
    "SG250-26P-K9-UK, Cisco SG250-26P 26-port Gigabit PoE Switch",
    "CBS350-24T-4X-UK, Cisco SG250-26P 26-port Gigabit PoE Switch",
    "SG110-16-EU, CiscoCBS350 Managed 24-port GE, 4x10G SFP+",
    "SG110-16HP-EU, CiscoSG110-16 16-Port Gigabit Switch",
    "SG110-24-EU, CiscoSG110-16HP 16-Port PoE Gigabit Switch",
    "SG110D-08-EU, CiscoSG110-24 24-Port Gigabit Switch",
    "SG112-24-EU, CiscoSG110D-08 8-Port Gigabit Desktop Switch",
    "SG112-24-UK, CiscoSG112-24 Compact 24-Port Gigabit Switch",
    "RV160W-E-K9-G5, CiscoSG112-24 Compact 24-Port Gigabit Switch",
    "RV345-K9-G5, Cisco RV160W Wireless-AC VPN Router",
    "CBW145AC-E, Cisco RV345 Dual WAN Gigabit VPN Router",
    "3-CBW240AC-E, CiscoCBW145AC 802.11ac 2x2 Wave 2 Access Point Wall Plate",
    "5-CBW140AC-E, CiscoCBW240AC 802.11ac 4x4 Wave 2 Access Point Ceiling Mount - 3P",
    "5-CBW240AC-E, CiscoCBW140AC 802.11ac 2x2 Wave 2 Access Point Ceiling Mount - 5P",
    "CBW140AC-G, CiscoCBW240AC 802.11ac 4x4 Wave 2 Access Point Ceiling Mount - 5P",
    "CBW145AC-G, CiscoCBW140AC 802.11ac 2x2 Wave 2 Access Point Ceiling Mount",
    "3-CBW240AC-G, CiscoCBW145AC 802.11ac 2x2 Wave 2 Access Point Wall Plate",
    "5-CBW140AC-G, CiscoCBW240AC 802.11ac 4x4 Wave 2 Access Point Ceiling Mount - 3P",
    "5-CBW240AC-G, CiscoCBW140AC 802.11ac 2x2 Wave 2 Access Point Ceiling Mount - 5P",
    "RV160-K9-G5, CiscoCBW240AC 802.11ac 4x4 Wave 2 Access Point Ceiling Mount - 5P",
    "RV260-K9-G5, Cisco RV160 VPN Router",
    "RV260P-K9-G5, Cisco RV260 VPN Router",
    "RV260W-E-K9-G5, Cisco RV260P VPN Router",
    "CBW140AC-E, Cisco RV260W Wireless-AC VPN Router",
    "CBS110-8T-D-EU, CiscoCBW140AC 802.11ac 2x2 Wave 2 Access Point Ceiling Mount",
    "CBS110-5T-D-EU, CiscoCBS110 Unmanaged 8-port GE, Desktop, Ext PS",
    "CBS110-8PP-D-EU, CiscoCBS110 Unmanaged 5-port GE, Desktop, Ext PS",
    "CBS110-16T-EU, CiscoCBS110 Unmanaged 8-port GE, Partial PoE, Desktop, Ext PS",
    "SG550X-24MP-K9-EU, CiscoCBS110 Unmanaged 16-port GE",
    "CBS110-8T-D-UK, Cisco SG550X-24MP 24-port Gigabit PoE Stackable Switch",
    "CBS110-8PP-D-UK, CiscoCBS110 Unmanaged 8-port GE, Desktop, Ext PS",
    "CBS110-5T-D-UK, CiscoCBS110 Unmanaged 8-port GE, Partial PoE, Desktop, Ext PS",
    "CBS110-16T-UK, CiscoCBS110 Unmanaged 5-port GE, Desktop, Ext PS",
    "CBS350-24T-4X-EU, CiscoCBS110 Unmanaged 16-port GE",
    "CBS350-48T-4G-UK, CiscoCBS350 Managed 24-port GE, 4x10G SFP+",
    "SG350X-48-K9-EU, CiscoCBS350 Managed 48-port GE, 4x1G SFP",
    "SG350X-48-K9-UK, Cisco SG350X-48 48-port Gigabit Stackable Switch",
    "SG350X-48MP-K9-EU, Cisco SG350X-48 48-port Gigabit Stackable Switch",
    "SG350X-48MP-K9-UK, Cisco SG350X-48MP 48-port Gigabit POE Stackable Switch",
    "SG350X-48P-K9-EU, Cisco SG350X-48MP 48-port Gigabit POE Stackable Switch",
    "SG350X-48P-K9-UK, Cisco SG350X-48P 48-port Gigabit POE Stackable Switch",
    "SG350-10-K9-EU, Cisco SG350X-48P 48-port Gigabit POE Stackable Switch",
    "SG350-10-K9-UK, Cisco SG350-10 10-port Gigabit Managed Switch",
    "SG350-10P-K9-UK, Cisco SG350-10 10-port Gigabit Managed Switch",
    "SG350-10MP-K9-EU, Cisco SG350-10P 10-port Gigabit POE Managed Switch",
    "SG350-10MP-K9-UK, Cisco SG350-10MP 10-port Gigabit POE Managed Switch",
    "SG350-10P-K9-EU, Cisco SG350-10MP 10-port Gigabit POE Managed Switch",
    "SG350-28-K9-EU, Cisco SG350-10P 10-port Gigabit POE Managed Switch",
    "SG350-28MP-K9-EU, Cisco SG350-28 28-port Gigabit Managed Switch",
    "SG350-28P-K9-EU, Cisco SG350-28MP 28-port Gigabit POE Managed Switch",
    "SG350X-24-K9-EU, Cisco SG350-28P 28-port Gigabit POE Managed Switch",
    "SG350X-24-K9-UK, Cisco SG350X-24 24-port Gigabit Stackable Switch",
    "SG350X-24P-K9-EU, Cisco SG350X-24 24-port Gigabit Stackable Switch",
    "SG350X-24P-K9-UK, Cisco SG350X-24P 24-port Gigabit POE Stackable Switch",
    "SG355-10P-K9-EU, Cisco SG350X-24P 24-port Gigabit POE Stackable Switch",
    "SG355-10P-K9-UK, Cisco SG355-10P 10-port Gigabit POE Managed Switch",
    "SF110D-05-EU, Cisco SG355-10P 10-port Gigabit POE Managed Switch",
    "SB-PWR-INJ2-EU, CiscoSF110D-05 5-Port 10/100 Desktop Switch",
    "SF250-24-K9-EU, Cisco Gigabit Power over Ethernet Injector-30W",
    "SB-PWR-48V-EU, Cisco SF250-24 24-Port 10/100 Smart Switch",
    "SF110D-05-UK, Cisco Small Business 48V Power Adapter (EU)",
    "CBS220-8T-E-2G-EU, CiscoSF110D-05 5-Port 10/100 Desktop Switch",
    "CBS220-8T-E-2G-UK, CiscoCBS220 Smart 8-port GE, Ext PS, 2x1G SFP",
    "CBS220-8P-E-2G-EU, CiscoCBS220 Smart 8-port GE, Ext PS, 2x1G SFP",
    "CBS220-8P-E-2G-UK, CiscoCBS220 Smart 8-port GE, PoE, Ext PS, 2x1G SFP",
    "CBS220-8FP-E-2G-EU, CiscoCBS220 Smart 8-port GE, PoE, Ext PS, 2x1G SFP",
    "CBS220-8FP-E-2G-UK, CiscoCBS220 Smart 8-port GE, Full PoE, Ext PS, 2x1G SFP",
    "CBS220-16T-2G-EU, CiscoCBS220 Smart 8-port GE, Full PoE, Ext PS, 2x1G SFP",
    "CBS220-16T-2G-UK, CiscoCBS220 Smart 16-port GE, 2x1G SFP",
    "CBS220-16P-2G-EU, CiscoCBS220 Smart 16-port GE, 2x1G SFP",
    "CBS220-16P-2G-UK, CiscoCBS220 Smart 16-port GE, PoE, 2x1G SFP",
    "CBS220-24T-4G-EU, CiscoCBS220 Smart 16-port GE, PoE, 2x1G SFP",
    "CBS220-24T-4G-UK, CiscoCBS220 Smart 24-port GE, 4x1G SFP",
    "CBS220-24P-4G-EU, CiscoCBS220 Smart 24-port GE, 4x1G SFP",
    "CBS220-24P-4G-UK, CiscoCBS220 Smart 24-port GE, PoE, 4x1G SFP",
    "CBS220-24FP-4G-EU, CiscoCBS220 Smart 24-port GE, PoE, 4x1G SFP",
    "CBS220-24FP-4G-UK, CiscoCBS220 Smart 24-port GE, Full PoE, 4x1G SFP",
    "CBS220-48T-4G-EU, CiscoCBS220 Smart 24-port GE, Full PoE, 4x1G SFP",
    "CBS220-48T-4G-UK, CiscoCBS220 Smart 48-port GE, 4x1G SFP",
    "CBS220-48P-4G-EU, CiscoCBS220 Smart 48-port GE, 4x1G SFP",
    "CBS220-48P-4G-UK, CiscoCBS220 Smart 48-port GE, PoE, 4x1G SFP",
    "CBS220-24T-4X-EU, CiscoCBS220 Smart 48-port GE, PoE, 4x1G SFP",
    "CBS220-24T-4X-UK, CiscoCBS220 Smart 24-port GE, 4x10G SFP+",
    "CBS220-24P-4X-EU, CiscoCBS220 Smart 24-port GE, 4x10G SFP+",
    "CBS220-24P-4X-UK, CiscoCBS220 Smart 24-port GE, PoE, 4x10G SFP+",
    "CBS220-24FP-4X-EU, CiscoCBS220 Smart 24-port GE, PoE, 4x10G SFP+",
    "CBS220-24FP-4X-UK, CiscoCBS220 Smart 24-port GE, Full PoE, 4x10G SFP+",
    "CBS220-48T-4X-EU, CiscoCBS220 Smart 24-port GE, Full PoE, 4x10G SFP+",
    "CBS220-48T-4X-UK, CiscoCBS220 Smart 48-port GE, 4x10G SFP+",
    "CBS220-48P-4X-EU, CiscoCBS220 Smart 48-port GE, 4x10G SFP+",
    "CBS220-48P-4X-UK, CiscoCBS220 Smart 48-port GE, PoE, 4x10G SFP+",
    "CBS220-48FP-4X-EU, CiscoCBS220 Smart 48-port GE, PoE, 4x10G SFP+",
    "CBS220-48FP-4X-UK, CiscoCBS220 Smart 48-port GE, Full PoE, 4x10G SFP+",
    "CBS250-8T-D-EU, CiscoCBS220 Smart 48-port GE, Full PoE, 4x10G SFP+",
    "CBS250-8T-D-UK, CiscoCBS250 Smart 8-port GE, Desktop, Ext PSU",
    "CBS250-8PP-D-EU, CiscoCBS250 Smart 8-port GE, Desktop, Ext PSU",
    "CBS250-8PP-D-UK, CiscoCBS250 Smart 8-port GE, Partial PoE, Desktop, Ext PSU",
    "CBS350-8S-E-2G-EU, CiscoCBS250 Smart 8-port GE, Partial PoE, Desktop, Ext PSU",
    "CBS350-8S-E-2G-UK, CiscoCBS350 Managed 8-port SFP, Ext PS, 2x1G Combo",
    "CBS350-24S-4G-EU, CiscoCBS350 Managed 8-port SFP, Ext PS, 2x1G Combo",
    "CBS350-24S-4G-UK, CiscoCBS350 Managed 24-port SFP, 4x1G SFP",
    "CBS350-8XT-EU, CiscoCBS350 Managed 24-port SFP, 4x1G SFP",
    "CBS350-8XT-UK, CiscoCBS350 Managed 8-port 10GE, 2x10G SFP+ Shared",
    "CBS350-12XT-EU, CiscoCBS350 Managed 8-port 10GE, 2x10G SFP+ Shared",
    "CBS350-12XT-UK, CiscoCBS350 Managed 12-port 10GE, 2x10G SFP+ Shared",
    "CBS350-24XS-EU, CiscoCBS350 Managed 12-port 10GE, 2x10G SFP+ Shared",
    "CBS350-24XS-UK, CiscoCBS350 Managed 24-port SFP+, 4x10GE Shared",
    "CBS350-24XT-EU, CiscoCBS350 Managed 24-port SFP+, 4x10GE Shared",
    "CBS350-24XT-UK, CiscoCBS350 Managed 24-port 10GE, 4x10G SFP+ Shared",
    "CBS350-48XT-4X-EU, CiscoCBS350 Managed 24-port 10GE, 4x10G SFP+ Shared",
    "CBS350-48XT-4X-UK, CiscoCBS350 Managed 48-port 10GE, 4x10G SFP+",
    "CBS350-8MGP-2X-EU, CiscoCBS350 Managed 48-port 10GE, 4x10G SFP+",
    "CBS350-8MGP-2X-UK, CiscoCBS350 Managed 2-port 2.5GE, 6-port GE, PoE, 2x10G combo",
    "CBS350-8MP-2X-EU, CiscoCBS350 Managed 2-port 2.5GE, 6-port GE, PoE, 2x10G combo",
    "CBS350-8MP-2X-UK, CiscoCBS350 Managed 8-port 2.5GE, PoE, 2x10G combo",
    "CBS350-24MGP-4X-EU, CiscoCBS350 Managed 8-port 2.5GE, PoE, 2x10G combo",
    "CBS350-24MGP-4X-UK, CiscoCBS350 Managed 4-port 2.5GE, 20-port GE, PoE, 4x10G SFP+",
    "CBS350-12NP-4X-EU, CiscoCBS350 Managed 4-port 2.5GE, 20-port GE, PoE, 4x10G SFP+",
    "CBS350-12NP-4X-UK, CiscoCBS350 Managed 12-port 5GE, PoE, 4x10G SFP+",
    "CBS350-24NGP-4X-UK, CiscoCBS350 Managed 12-port 5GE, PoE, 4x10G SFP+",
    "CBS350-48NGP-4X-EU, CiscoCBS350 Managed 8-port 5GE, 16-port GE, PoE, 4x10G SFP+",
    "CBS350-48NGP-4X-UK, CiscoCBS350 Managed 8-port 5GE, 40-port GE, PoE, 4x10G SFP+",
    "CBS350-12XS-EU, CiscoCBS350 Managed 8-port 5GE, 40-port GE, PoE, 4x10G SFP+",
    "CBS350-12XS-UK, Cisco Business 350-12XS Managed Switch",
    "CBS350-16XTS-EU, Cisco Business 350-12XS Managed Switch",
    "CBS350-16XTS-UK, Cisco Business 350-16XTS Managed Switch",
    "CBS350-24XTS-EU, Cisco Business 350-16XTS Managed Switch",
    "CBS350-24XTS-UK, Cisco Business 350-24XTS Managed Switch",
    "CBS350-24NGP-4X-EU, Cisco Business 350-24XTS Managed Switch",
    "CBS350-8P-2G-EU, CiscoCBS350 Managed 8-port 5GE, 16-port GE, PoE, 4x10G SFP+",
    "CBS350-8T-E-2G-EU, CiscoCBS350 Managed 8-port GE, PoE, 2x1G Combo",
    "CBS250-24FP-4X-EU, CiscoCBS350 Managed 8-port GE, Ext PS, 2x1G Combo",
    "SG550X-48-K9-EU, CiscoCBS250 Smart 24-port GE, Full PoE, 4x10G SFP+",
    "CBS250-24P-4X-EU, Cisco SG550X-48 48-port Gigabit Stackable Switch",
    "CBS250-48P-4G-UK, CiscoCBS250 Smart 24-port GE, PoE, 4x10G SFP+",
    "CBW140MXS-I-EU, CiscoCBS250 Smart 48-port GE, PoE, 4x1G SFP"
  ];

  List<ListItem> listViewData = [];

  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  var request = SearchRequest();
  List<Value> _results = [];
  ListViewHome(String unformatedItemsToSearch) {

    this.unformatedItemsToSearch = unformatedItemsToSearch;
    getSearchResults();
  }

  Future<void> getSearchResults() async {
    createExcel();
    for (var searchterm in searchItems) {
      List<Value>? tempResults = await request.getResults(searchterm, "");
      List<Value> results = [];
      if (tempResults != null) {
        results = tempResults;
      } else {
        continue;
      }

      updateExcel(searchterm, results);
      setState(() {
        formatedResult = formatedResult + "\n==================================================================================\n\n" + searchterm;
        formatedResult = formatedResult + "\n----------------------------------\n";
        searchMap[searchterm] = results;
        listViewData.add(
          HeadingItem(searchterm)
        );
        for(var result in results) {
          formatedResult = formatedResult + "\nTitle: \n\t" + result.title + "\ndescription: \n\t" + result.description + "\nURL: \n" + result.url;
          listViewData.add(
              MessageItem(result)
          );
          formatedResult = formatedResult + "\n\n -----------------------------------------\n NEXT Result\n -----------------------------------------";
        }
        listViewData.add(Spacer());
      });
      print(formatedResult);
      formatedResultFinal = formatedResultFinal + formatedResult;
      formatedResult = "";
    }
    // write(formatedResultFinal, 'final');
    saveAndCloseExcel();
  }

  final xel.Workbook workbook = xel.Workbook();
  List<int> bytes = [];
  var rowCounter = 1;

  Future<void> createExcel() async {
    final xel.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('SKU');
    sheet.getRangeByName('B1').setText('Description 1');
    sheet.getRangeByName('C1').setText('Description 2');
    sheet.getRangeByName('D1').setText('Description 3');

    rowCounter++;
  }

  String letterForIndex(int index) {

    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      case 4:
        return 'E';
      case 5:
        return 'F';
      case 6:
        return 'G';
      case 7:
        return 'H';
      case 8:
        return 'I';
      case 9:
        return 'J';
      case 10:
        return 'K';
      case 11:
        return 'L';
        default:
          return 'AA';
    }
  }

  Future<void> updateExcel(String searchTerm, List<Value> result) async {

    print(rowCounter);
    final xel.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A$rowCounter').setText(searchTerm);
    for (int i = 0; i < result.length; i++) {
      var letter = letterForIndex(i + 1);
      letter = letter + '$rowCounter';
      final xel.Hyperlink hyperlink1 = sheet.hyperlinks.add(sheet.getRangeByName(letter),
          xel.HyperlinkType.url, result[i].url);
      hyperlink1.textToDisplay = result[i].description;
    }
    //
    //
    //
    //
    // final xel.Hyperlink hyperlink2 = sheet.hyperlinks.add(sheet.getRangeByName('C$rowCounter'),
    //     xel.HyperlinkType.url, result[1].url);
    // hyperlink2.textToDisplay = result[1].description;
    //
    // final xel.Hyperlink hyperlink3 = sheet.hyperlinks.add(sheet.getRangeByName('D$rowCounter'),
    //     xel.HyperlinkType.url, result[2].url);
    // hyperlink3.textToDisplay = result[2].description;

    rowCounter++;
  }

  Future<void> saveAndCloseExcel() async {

    bytes.addAll(workbook.saveAsStream());
    html.AnchorElement(
        href:
        "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "output.xlsx")
      ..click();
  }

  Future<void>  write(String text, String fileName) async {
    final bytes = utf8.encode(text);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = fileName + '.txt';
    html.document.body!.children.add(anchor);
    // download
    anchor.click();

// cleanup
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listViewData.length ,
        itemBuilder: (context, index) {
          final item = listViewData[index];
          return item.buildTitle(context);
        });
  }
}



/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.double,
    );
    return SelectableText(
      heading,
      style: textStyle,
    );
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {

  final Value result;

  MessageItem(this.result);

  @override
  Widget buildTitle(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
        child: Column(
          children: [
            ListTile(

              title: SelectableText(result.title),
              subtitle: SelectableText(result.description),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(onSurface: Colors.red),
              onPressed: () {
                print("\n\n\nURL:::" + result.url);
                html.window.open(result.url,"_blank");
              },
              child: Text(result.url),
            )
          ],
        )
    );
  }
}

class Spacer implements ListItem {

  @override
  Widget buildTitle(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ColoredBox(
        color: Colors.white,
      ),
    );
  }
}