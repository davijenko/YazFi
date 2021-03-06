<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<title>YazFi</title>
<link rel="stylesheet" type="text/css" href="index_style.css">
<link rel="stylesheet" type="text/css" href="form_style.css">
<style>
p {
  font-weight: bolder;
}

thead.collapsible {
  color: white;
  padding: 0px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  cursor: pointer;
}

.collapsiblecontent {
  padding: 0px;
  max-height: 0;
  overflow: hidden;
  border: none;
  transition: max-height 0.2s ease-out;
}

.SettingsTable {
  table-layout: fixed !important;
  width: 745px !important;
  text-align: center;
}

.SettingsTable input {
  text-align: center;
}

.SettingsTable th {
  background-color: #1F2D35 !important;
  background: #2F3A3E !important;
  border-bottom: none !important;
  border-top: none !important;
  font-size: 12px !important;
  color: white !important;
  padding: 4px !important;
  font-weight: bolder !important;
  padding: 0px !important;
}

.SettingsTable th.bss {
  color: red !important;
}

.SettingsTable td {
  padding: 4px !important;
  word-wrap: break-word !important;
  overflow-wrap: break-word !important;
  border-right: none;
  border-left: none;
}

.SettingsTable td.settingname {
  border-right: solid 1px black;
  background-color: #1F2D35 !important;
  background: #2F3A3E !important;
  font-weight: bolder !important;
}

.SettingsTable td.settingvalue {
  border-right: solid 1px black;
}

.SettingsTable th:first-child{
  border-left: none !important;
}

.SettingsTable th:last-child {
  border-right: none !important;
}

.SettingsTable .invalid {
  background-color: darkred !important;
}

.SettingsTable .disabled {
  background-color: #CCCCCC !important;
  color: #888888 !important;
}
</style>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/help.js"></script>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/detect.js"></script>
<script language="JavaScript" type="text/javascript" src="/tmhist.js"></script>
<script language="JavaScript" type="text/javascript" src="/tmmenu.js"></script>
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<script language="JavaScript" type="text/javascript" src="/validator.js"></script>
<script language="JavaScript" type="text/javascript" src="/base64.js"></script>
<script>
var $j=jQuery.noConflict();
var custom_settings;
var bands = 0;

function LoadCustomSettings(){
	custom_settings = <% get_custom_settings(); %>;
	for (var prop in custom_settings) {
		if (Object.prototype.hasOwnProperty.call(custom_settings, prop)) {
			if(prop.indexOf("yazfi") != -1){
				eval("delete custom_settings."+prop);
			}
		}
	}
}

function YazHint(hintid) {
	var tag_name= document.getElementsByTagName('a');
	for (var i=0;i<tag_name.length;i++){
		tag_name[i].onmouseout=nd;
	}
	hinttext="My text goes here";
	if(hintid == 1) hinttext="Enable YazFi for this Guest Network";
	if(hintid == 2) hinttext="IP address/subnet to use for Guest Network";
	if(hintid == 3) hinttext="Start of DHCP pool (2-253)";
	if(hintid == 4) hinttext="End of DHCP pool (3-254)";
	if(hintid == 5) hinttext="IP address for primary DNS resolver";
	if(hintid == 6) hinttext="IP address for secondary DNS resolver";
	if(hintid == 7) hinttext="Should Guest Network DNS requests be forced/redirected to DNS1? N.B. This setting is ignored if sending to VPN, and VPN Client's DNS configuration is Exclusive";
	if(hintid == 8) hinttext="Should Guest Network traffic be sent via VPN?";
	if(hintid == 9) hinttext="The number of the VPN Client to send traffic through (1-5)";
	if(hintid == 10) hinttext="Should LAN/Guest Network traffic have unrestricted access to each other? Cannot be enabled if _ONEWAYTOGUEST is enabled";
	if(hintid == 11) hinttext="Should LAN be able to initiate connections to Guest Network clients (but not the opposite)? Cannot be enabled if _TWOWAYTOGUEST is enabled";
	if(hintid == 12) hinttext="Should Guest Network radio prevent clients from talking to each other?";
	return overlib(hinttext, HAUTO, VAUTO);
}

function OptionsEnableDisable(forminput){
	var inputname = forminput.name;
	var inputvalue = forminput.value;
	var prefix = inputname.substring(0,inputname.lastIndexOf('_'));
	
	if(inputvalue == "false"){
		$j('input[name='+prefix+'_ipaddr]').addClass("disabled");
		$j('input[name='+prefix+'_ipaddr]').prop("disabled",true);
		$j('input[name='+prefix+'_dhcpstart]').addClass("disabled");
		$j('input[name='+prefix+'_dhcpstart]').prop("disabled",true);
		$j('input[name='+prefix+'_dhcpend]').addClass("disabled");
		$j('input[name='+prefix+'_dhcpend]').prop("disabled",true);
		$j('input[name='+prefix+'_dns1]').addClass("disabled");
		$j('input[name='+prefix+'_dns1]').prop("disabled",true);
		$j('input[name='+prefix+'_dns2]').addClass("disabled");
		$j('input[name='+prefix+'_dns2]').prop("disabled",true);
		$j('input[name='+prefix+'_forcedns]').prop("disabled",true);
		$j('input[name='+prefix+'_redirectalltovpn]').prop("disabled",true);
		$j('input[name='+prefix+'_vpnclientnumber]').addClass("disabled");
		$j('input[name='+prefix+'_vpnclientnumber]').prop("disabled",true);
		$j('input[name='+prefix+'_onewaytoguest]').prop("disabled",true);
		$j('input[name='+prefix+'_twowaytoguest]').prop("disabled",true);
		$j('input[name='+prefix+'_clientisolation]').prop("disabled",true);
	}
	else if(inputvalue == "true"){
		$j('input[name='+prefix+'_ipaddr]').removeClass("disabled");
		$j('input[name='+prefix+'_ipaddr]').prop("disabled",false);
		$j('input[name='+prefix+'_dhcpstart]').removeClass("disabled");
		$j('input[name='+prefix+'_dhcpstart]').prop("disabled",false);
		$j('input[name='+prefix+'_dhcpend]').removeClass("disabled");
		$j('input[name='+prefix+'_dhcpend]').prop("disabled",false);
		$j('input[name='+prefix+'_dns1]').removeClass("disabled");
		$j('input[name='+prefix+'_dns1]').prop("disabled",false);
		$j('input[name='+prefix+'_dns2]').removeClass("disabled");
		$j('input[name='+prefix+'_dns2]').prop("disabled",false);
		$j('input[name='+prefix+'_forcedns]').prop("disabled",false);
		$j('input[name='+prefix+'_redirectalltovpn]').prop("disabled",false);
		$j('input[name='+prefix+'_onewaytoguest]').prop("disabled",false);
		$j('input[name='+prefix+'_twowaytoguest]').prop("disabled",false);
		$j('input[name='+prefix+'_clientisolation]').prop("disabled",false);
		
		if(eval('document.form.'+prefix+'_redirectalltovpn').value == "true"){
			$j('input[name='+prefix+'_vpnclientnumber]').removeClass("disabled");
			$j('input[name='+prefix+'_vpnclientnumber]').prop("disabled",false);
		}
	}
}

function VPNOptionsEnableDisable(forminput){
	var inputname = forminput.name;
	var inputvalue = forminput.value;
	var prefix = inputname.substring(0,inputname.lastIndexOf('_'));
	
	if(eval("document.form."+prefix+"_enabled").value == "true"){
		if(inputvalue == "false"){
			$j('input[name='+prefix+'_vpnclientnumber]').addClass("disabled");
			$j('input[name='+prefix+'_vpnclientnumber]').prop("disabled",true);
		}
		else if(inputvalue == "true"){
			$j('input[name='+prefix+'_vpnclientnumber]').removeClass("disabled");
			$j('input[name='+prefix+'_vpnclientnumber]').prop("disabled",false);
		}
	}
}

function Validate_IP(forminput,iptype){
	var inputvalue = forminput.value;
	var inputname = forminput.name;
	if(iptype == "DNS"){
		if(inputvalue.substring(inputvalue.lastIndexOf(".")) == ".0"){
			forminput.value = inputvalue.substring(0,inputvalue.lastIndexOf("."))+".1";
		}
	}
	if(/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(inputvalue)){
		if(iptype != "DNS"){
			var fixedip = inputvalue.substring(0,inputvalue.lastIndexOf("."))+".0";
			$j(forminput).val(fixedip);
			if (/(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^192\.168\.)/.test(fixedip)){
				if(! checkIPConflict("LAN",fixedip,"255.255.255.0",document.form.lan_ipaddr.value,document.form.lan_netmask.value).state){
					matchfound=false;
					for(var i = 0; i < bands; i++){
						for(var i2 = 1; i2 < 4; i2++){
							if("yazfi_wl"+i.toString()+i2.toString()+"_ipaddr" != inputname){
								if(eval("document.form.yazfi_wl"+i.toString()+i2.toString()+"_ipaddr.value") == fixedip){
									matchfound=true;
								}
							}
						}
					}
					if(matchfound){
						$j(forminput).addClass("invalid");
						return false;
					}
					else{
						$j(forminput).removeClass("invalid");
						return true;
					}
				}
				else{
					$j(forminput).addClass("invalid");
					return false;
				}
			}
			else{
				$j(forminput).addClass("invalid");
				return false;
			}
		}
		else{
			$j(forminput).removeClass("invalid");
			return true;
		}
	}
	else{
		$j(forminput).addClass("invalid");
		return false;
	}
}

function Validate_DHCP(forminput){
	var startend = "";
	var inputname = forminput.name;
	var inputvalue = forminput.value*1;
	
	(inputname.indexOf("start") != -1) ? startend = "start" : startend = "end";
	if(startend == "start"){
		if(inputvalue >= eval("document.form."+inputname.substring(0,inputname.indexOf("start"))+"end.value")*1){
			$j(forminput).addClass("invalid");
			return false;
		}
		else{
			if(inputvalue > 254 || inputvalue < 2){
				$j(forminput).addClass("invalid");
				return false;
			}
			else{
				$j(forminput).removeClass("invalid");
				return true;
			}
		}
	}
	else {
		if(inputvalue <= eval("document.form."+inputname.substring(0,inputname.indexOf("end"))+"start.value")*1){
			$j(forminput).addClass("invalid");
			return false;
		}
		else{
			if(inputvalue > 254 || inputvalue < 2){
				$j(forminput).addClass("invalid");
				return false;
			}
			else{
				$j(forminput).removeClass("invalid");
				return true;
			}
		}
	}
}

function Validate_VPNClientNo(forminput){
	var inputname = forminput.name;
	var inputvalue = forminput.value*1;
	
	if(inputvalue > 5 || inputvalue < 1){
		$j(forminput).addClass("invalid");
		return false;
	}
	else{
		$j(forminput).removeClass("invalid");
		return true;
	}
}

function Validate_OneTwoWay(forminput){
	var onetwo = "";
	var inputname = forminput.name;
	var inputvalue = forminput.value;
	
	(inputname.indexOf("oneway") != -1) ? onetwo = "one" : onetwo = "two";
	if(onetwo == "one"){
		if(inputvalue == "true"){
			eval("document.form."+inputname.substring(0,inputname.indexOf("one"))+"twowaytoguest.value=false");
		}
	}
	else{
		if(inputvalue == "true"){
			eval("document.form."+inputname.substring(0,inputname.indexOf("two"))+"onewaytoguest.value=false");
		}
	}
}

function Validate_All(){
	var validationfailed = false;
	for(var i=0; i < bands; i++){
		for(var i2=1; i2 < 4; i2++){
			if(! Validate_IP(eval("document.form.yazfi_wl"+i+i2+"_ipaddr"),"IP")){validationfailed=true;}
			if(! Validate_DHCP(eval("document.form.yazfi_wl"+i+i2+"_dhcpstart"))){validationfailed=true;}
			if(! Validate_DHCP(eval("document.form.yazfi_wl"+i+i2+"_dhcpend"))){validationfailed=true;}
			if(! Validate_IP(eval("document.form.yazfi_wl"+i+i2+"_dns1"),"DNS")){validationfailed=true;}
			if(! Validate_IP(eval("document.form.yazfi_wl"+i+i2+"_dns2"),"DNS")){validationfailed=true;}
			if(! Validate_VPNClientNo(eval("document.form.yazfi_wl"+i+i2+"_vpnclientnumber"))){validationfailed=true;}
		}
	}
	if(validationfailed){
		alert("Validation for some fields failed. Please correct invalid values and try again.");
		return false;
	}
	else{
		return true;
	}
}

function get_conf_file(){
	$j.ajax({
		url: '/ext/YazFi/config.htm',
		dataType: 'text',
		error: function(xhr){
			setTimeout("get_conf_file();", 1000);
		},
		success: function(data){
			var settings=data.split("\n");
			settings.reverse();
			settings = settings.filter(Boolean);
			var settingcount=settings.length;
			window["yazfi_settings"] = new Array();
			for (var i = 0; i < settingcount; i++) {
				var commentstart=settings[i].indexOf("#");
				if (commentstart != -1){
					continue;
				}
				var setting=settings[i].split("=");
				window["yazfi_settings"].unshift(setting);
			}
			if(wl_info.band2g_support){$j("#table_buttons").before(BuildConfigTable("wl0","2.4GHz Guest Networks"));bands = bands + 1;}
			if(wl_info.band5g_support){$j("#table_buttons").before(BuildConfigTable("wl1","5GHz-1 Guest Networks"));bands = bands + 1;}
			if(wl_info.band5g_2_support){$j("#table_buttons").before(BuildConfigTable("wl2","5GHz-2 Guest Networks"));bands = bands + 1;}
			var settingcount = bands*12*3;
			for (var i = 0; i < settingcount; i++) {
				var settingname = window["yazfi_settings"][i][0].toLowerCase();
				var settingvalue = window["yazfi_settings"][i][1];
				eval("document.form.yazfi_"+settingname).value = settingvalue;
				if(settingname.indexOf("redirectalltovpn") != -1) VPNOptionsEnableDisable($j("#yazfi_"+settingname.replace("_redirectalltovpn","")+"_redir_"+settingvalue)[0]);
				if(settingname.indexOf("enabled") != -1) OptionsEnableDisable($j("#yazfi_"+settingname.replace("_enabled","")+"_en_"+settingvalue)[0]);
			}
			
			if(productid == "RT-AX88U"){
				$j("input[name*=clientisolation][value=false]").prop("checked",true);
				$j("input[name*=clientisolation]").attr('disabled',true);
			}
			
			for (var i = 0; i < bands; i++) {
				for (var i2 = 1; i2 < 4; i2++) {
					if( eval('document.form.wl'+i+i2+'_bss_enabled').value == 0){
						OptionsEnableDisable($j("#yazfi_wl"+i+i2+"_en_false")[0]);
						$j('input[name=yazfi_wl'+i+i2+'_enabled]').prop("disabled",true);
					}
				}
			}
		AddEventHandlers();
		}
	});
}

function GetCookie(cookiename) {
	var s;
	if ((s = cookie.get("yazfi_"+cookiename)) != null) {
		return cookie.get("yazfi_"+cookiename);
	}
	else {
		return "";
	}
}

function SetCookie(cookiename,cookievalue) {
	cookie.set("yazfi_"+cookiename, cookievalue, 31);
}

function SetCurrentPage(){
	document.form.next_page.value = window.location.pathname.substring(1);
	document.form.current_page.value = window.location.pathname.substring(1);
}

function reload() {
	location.reload(true);
}

function applyRule() {
	if(Validate_All()){
		$j('[name*=yazfi_]').prop("disabled",false);
		document.getElementById('amng_custom').value = JSON.stringify($j('form').serializeObject());
		var action_script_tmp = "start_yazfi";
		document.form.action_script.value = action_script_tmp;
		document.form.action_script.value = action_script_tmp;
		var restart_time = 30;
		document.form.action_wait.value = restart_time;
		showLoading();
		document.form.submit();
	}
	else{
		return false;
	}
}

function initial(){
	SetCurrentPage();
	LoadCustomSettings();
	show_menu();
	get_conf_file();
}

function BuildConfigTable(prefix,title){
	var charthtml = '<div style="line-height:10px;">&nbsp;</div>';
	charthtml+='<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="table_config_'+prefix+'">';
	charthtml+='<thead class="collapsible" id="'+prefix+'">';
	charthtml+='<tr>';
	charthtml+='<td colspan="2">'+title+' Configuration (click to expand/collapse)</td>';
	charthtml+='</tr>';
	charthtml+='</thead>';
	charthtml+='<div class="collapsiblecontent">';
	charthtml+='<tr>';
	charthtml+='<td colspan="2" align="center" style="padding: 0px;">';
	
	charthtml+='<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable">';
	charthtml+='<col style="width:130px;">';
	charthtml+='<col style="width:205px;">';
	charthtml+='<col style="width:205px;">';
	charthtml+='<col style="width:205px;">';
	charthtml+='<thead>';
	charthtml+='<tr>';
	charthtml+='<th>&nbsp;</th>';
	charthtml+='<th>Guest Network 1</th>';
	charthtml+='<th>Guest Network 2</th>';
	charthtml+='<th>Guest Network 3</th>';
	charthtml+='</tr>';
	charthtml+='<tr>';
	charthtml+='<th>&nbsp;</th>';
	charthtml+='<th>'+eval('document.form.'+prefix+'1_ssid.value')+'</th>';
	charthtml+='<th>'+eval('document.form.'+prefix+'2_ssid.value')+'</th>';
	charthtml+='<th>'+eval('document.form.'+prefix+'3_ssid.value')+'</th>';
	charthtml+='</tr>'
	
	var enabled1 = eval('document.form.'+prefix+'1_bss_enabled.value');
	var enabled2 = eval('document.form.'+prefix+'2_bss_enabled.value');
	var enabled3 = eval('document.form.'+prefix+'3_bss_enabled.value');
	
	if( enabled1 == 0 || enabled2 == 0 || enabled3 == 0){
		charthtml+='<tr>';
		charthtml+='<th>&nbsp;</th>';
		if(enabled1 == 0){
			charthtml+='<th class="bss">Disabled on Guest Network Tab</th>';
		}
		else{
			charthtml+='<th>&nbsp;</th>';
		}
		if(enabled2 == 0){
			charthtml+='<th class="bss">Disabled on Guest Network Tab</th>';
		}
		else{
			charthtml+='<th>&nbsp;</th>';
		}
		if(enabled3 == 0){
			charthtml+='<th class="bss">Disabled on Guest Network Tab</th>';
		}
		else{
			charthtml+='<th>&nbsp;</th>';
		}
		charthtml+='</tr>'
	}
	
	charthtml+='</thead>';
	
	/* ENABLED */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(1);">Enabled</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_enabled" id="yazfi_'+prefix+'1_en_true" onChange="OptionsEnableDisable(this)" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_enabled" id="yazfi_'+prefix+'1_en_false" onChange="OptionsEnableDisable(this)" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_enabled" id="yazfi_'+prefix+'2_en_true" onChange="OptionsEnableDisable(this)" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_enabled" id="yazfi_'+prefix+'2_en_false" onChange="OptionsEnableDisable(this)" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_enabled" id="yazfi_'+prefix+'3_en_true" onChange="OptionsEnableDisable(this)" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_enabled" id="yazfi_'+prefix+'3_en_false" onChange="OptionsEnableDisable(this)" class="input" value="false" checked>No</td>';
	charthtml+='</tr>';
	
	/* IPADDR */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(2);">IP Address</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'1_ipaddr" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'IP\')" data-lpignore="true" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'2_ipaddr" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'IP\')" data-lpignore="true" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'3_ipaddr" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'IP\')" data-lpignore="true" /></td>';
	charthtml+='</tr>';
	
	/* DHCP START */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(3);">DHCP Start</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="3" class="input_6_table" name="yazfi_'+prefix+'1_dhcpstart" value="2" onkeypress="return validator.isNumber(this, event)" onblur="Validate_DHCP(this)" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="3" class="input_6_table" name="yazfi_'+prefix+'2_dhcpstart" value="2" onkeypress="return validator.isNumber(this, event)" onblur="Validate_DHCP(this)" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="3" class="input_6_table" name="yazfi_'+prefix+'3_dhcpstart" value="2" onkeypress="return validator.isNumber(this, event)" onblur="Validate_DHCP(this)" /></td>';
	charthtml+='</tr>';
	
	/* DHCP END */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(4);">DHCP End</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="3" class="input_6_table" name="yazfi_'+prefix+'1_dhcpend" value="254" onkeypress="return validator.isNumber(this, event)" onblur="Validate_DHCP(this)" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="3" class="input_6_table" name="yazfi_'+prefix+'2_dhcpend" value="254" onkeypress="return validator.isNumber(this, event)" onblur="Validate_DHCP(this)" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="3" class="input_6_table" name="yazfi_'+prefix+'3_dhcpend" value="254" onkeypress="return validator.isNumber(this, event)" onblur="Validate_DHCP(this)" /></td>';
	charthtml+='</tr>';
	
	/* DNS1 */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(5);">DNS Server 1</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'1_dns1" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'DNS\')" data-lpignore="true" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'2_dns1" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'DNS\')" data-lpignore="true" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'3_dns1" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'DNS\')" data-lpignore="true" /></td>';
	charthtml+='</tr>';
	
	/* DNS2 */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(6);">DNS Server 2</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'1_dns2" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'DNS\')" data-lpignore="true" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'2_dns2" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'DNS\')" data-lpignore="true" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="15" class="input_20_table" name="yazfi_'+prefix+'3_dns2" value="0.0.0.0" onkeypress="return validator.isIPAddr(this, event)" onblur="Validate_IP(this,\'DNS\')" data-lpignore="true" /></td>';
	charthtml+='</tr>';
	
	/* FORCEDNS */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(7);">Force DNS</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_forcedns" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_forcedns" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_forcedns" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_forcedns" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_forcedns" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_forcedns" class="input" value="false" checked>No</td>';
	charthtml+='</tr>';
	
	/* REDIRECTALLTOVPN */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(8);">Redirect all to VPN</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_redirectalltovpn" id="yazfi_'+prefix+'1_redir_true" onChange="VPNOptionsEnableDisable(this)" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_redirectalltovpn" id="yazfi_'+prefix+'1_redir_false" onChange="VPNOptionsEnableDisable(this)" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_redirectalltovpn" id="yazfi_'+prefix+'2_redir_true" onChange="VPNOptionsEnableDisable(this)" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_redirectalltovpn" id="yazfi_'+prefix+'2_redir_false" onChange="VPNOptionsEnableDisable(this)" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_redirectalltovpn" id="yazfi_'+prefix+'3_redir_true" onChange="VPNOptionsEnableDisable(this)" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_redirectalltovpn" id="yazfi_'+prefix+'3_redir_false" onChange="VPNOptionsEnableDisable(this)" class="input" value="false" checked>No</td>';
	charthtml+='</tr>';
	
	/* VPNCLIENTNUMBER */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(9);">VPN Client No.</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="1" class="input_6_table" name="yazfi_'+prefix+'1_vpnclientnumber" value="2" onkeypress="return validator.isNumber(this, event)" onblur="Validate_VPNClientNo(this)" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="1" class="input_6_table" name="yazfi_'+prefix+'2_vpnclientnumber" value="2" onkeypress="return validator.isNumber(this, event)" onblur="Validate_VPNClientNo(this)" /></td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="text" maxlength="1" class="input_6_table" name="yazfi_'+prefix+'3_vpnclientnumber" value="2" onkeypress="return validator.isNumber(this, event)" onblur="Validate_VPNClientNo(this)" /></td>';
	charthtml+='</tr>';
	
	/* TWOWAYTOGUEST */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(10);">Two way to guest</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_twowaytoguest" class="input" value="true" onchange="Validate_OneTwoWay(this)">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_twowaytoguest" class="input" value="false" onchange="Validate_OneTwoWay(this)" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_twowaytoguest" class="input" value="true" onchange="Validate_OneTwoWay(this)" >Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_twowaytoguest" class="input" value="false" onchange="Validate_OneTwoWay(this)" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_twowaytoguest" class="input" value="true" onchange="Validate_OneTwoWay(this)" >Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_twowaytoguest" class="input" value="false" onchange="Validate_OneTwoWay(this)" checked>No</td>';
	charthtml+='</tr>';
	
	/* ONEWAYTOGUEST */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(11);">One way to guest</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_onewaytoguest" class="input" value="true" onchange="Validate_OneTwoWay(this)" >Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_onewaytoguest" class="input" value="false" onchange="Validate_OneTwoWay(this)" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_onewaytoguest" class="input" value="true" onchange="Validate_OneTwoWay(this)" >Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_onewaytoguest" class="input" value="false" onchange="Validate_OneTwoWay(this)" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_onewaytoguest" class="input" value="true" onchange="Validate_OneTwoWay(this)" >Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_onewaytoguest" class="input" value="false" onchange="Validate_OneTwoWay(this)" checked>No</td>';
	charthtml+='</tr>';
	
	/* CLIENT ISOLATION */
	charthtml+='<tr>';
	charthtml+='<td class="settingname"><a class="hintstyle" href="javascript:void(0);" onclick="YazHint(12);">Client isolation</a></td><td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_clientisolation" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'1_clientisolation" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_clientisolation" class="input" value="true">Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'2_clientisolation" class="input" value="false" checked>No</td>';
	charthtml+='<td class="settingvalue"><input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_clientisolation" class="input" value="true" >Yes<input autocomplete="off" autocapitalize="off" type="radio" name="yazfi_'+prefix+'3_clientisolation" class="input" value="false" checked>No</td>';
	charthtml+='</tr>';
	
	charthtml+='</table>';
	charthtml+='</td>';
	charthtml+='</tr>';
	charthtml+='</div>';
	charthtml+='</table>';
	charthtml+='<div style="line-height:10px;">&nbsp;</div>';
	return charthtml;
}

function AddEventHandlers(){
	$j("thead.collapsible").click(function(){
		$j(this).siblings().toggle("fast");
	})
}

$j.fn.serializeObject = function(){
	var o = custom_settings;
	var a = this.serializeArray();
	$j.each(a, function() {
		if (o[this.name] !== undefined && this.name.indexOf("yazfi") != -1) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else if (this.name.indexOf("yazfi") != -1){
			o[this.name] = this.value || '';
		}
	});
	return o;
};

</script>
</head>
<body onload="initial();" onunload="return unload_body();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="about:blank" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">
<input type="hidden" name="current_page" value="">
<input type="hidden" name="next_page" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_wait" value="30">
<input type="hidden" name="first_time" value="">
<input type="hidden" name="SystemCmd" value="">
<input type="hidden" name="action_script" value="start_yazfi">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>">
<input type="hidden" name="lan_ipaddr" value="<% nvram_get("lan_ipaddr"); %>">
<input type="hidden" name="lan_netmask" value="<% nvram_get("lan_netmask"); %>">
<input type="hidden" name="wl01_ssid" value="<% nvram_get("wl0.1_ssid"); %>">
<input type="hidden" name="wl02_ssid" value="<% nvram_get("wl0.2_ssid"); %>">
<input type="hidden" name="wl03_ssid" value="<% nvram_get("wl0.3_ssid"); %>">
<input type="hidden" name="wl11_ssid" value="<% nvram_get("wl1.1_ssid"); %>">
<input type="hidden" name="wl12_ssid" value="<% nvram_get("wl1.2_ssid"); %>">
<input type="hidden" name="wl13_ssid" value="<% nvram_get("wl1.3_ssid"); %>">
<input type="hidden" name="wl21_ssid" value="<% nvram_get("wl2.1_ssid"); %>">
<input type="hidden" name="wl22_ssid" value="<% nvram_get("wl2.2_ssid"); %>">
<input type="hidden" name="wl23_ssid" value="<% nvram_get("wl2.3_ssid"); %>">
<input type="hidden" name="wl01_bss_enabled" value="<% nvram_get("wl0.1_bss_enabled"); %>">
<input type="hidden" name="wl02_bss_enabled" value="<% nvram_get("wl0.2_bss_enabled"); %>">
<input type="hidden" name="wl03_bss_enabled" value="<% nvram_get("wl0.3_bss_enabled"); %>">
<input type="hidden" name="wl11_bss_enabled" value="<% nvram_get("wl1.1_bss_enabled"); %>">
<input type="hidden" name="wl12_bss_enabled" value="<% nvram_get("wl1.2_bss_enabled"); %>">
<input type="hidden" name="wl13_bss_enabled" value="<% nvram_get("wl1.3_bss_enabled"); %>">
<input type="hidden" name="wl21_bss_enabled" value="<% nvram_get("wl2.1_bss_enabled"); %>">
<input type="hidden" name="wl22_bss_enabled" value="<% nvram_get("wl2.2_bss_enabled"); %>">
<input type="hidden" name="wl23_bss_enabled" value="<% nvram_get("wl2.3_bss_enabled"); %>">
<input type="hidden" name="amng_custom" id="amng_custom" value="">
<table class="content" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="17">&nbsp;</td>
<td valign="top" width="202">
<div id="mainMenu"></div>
<div id="subMenu"></div></td>
<td valign="top">
<div id="tabMenu" class="submenuBlock"></div>
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr>
<td align="left" valign="top">
<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
<tr>
<td bgcolor="#4D595D" colspan="3" valign="top">
<div>&nbsp;</div>
<div class="formfonttitle" id="scripttitle" style="text-align:center;">YazFi - v4.1.4</div>
<div style="margin:10px 0 10px 5px;" class="splitLine"></div>
<div class="formfontdesc">Feature expansion of guest WiFi networks on AsusWRT-Merlin.</div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" style="border:0px;" id="table_buttons">
<tr class="apply_gen" valign="top" height="35px">
<td style="background-color:rgb(77, 89, 93);border:0px;">
<input name="button" type="button" class="button_gen" onclick="applyRule();" value="Apply"/>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</form>
<div id="footer"></div>
</body>
</html>
