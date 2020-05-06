<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=addrCd]").val(data.zonecode);
//            $("[name=addrName]").val(fullRoadAddr);
           
           document.getElementById('addrCd').value = data.zonecode; //5자리 새우편번호 사용
//            document.getElementById('addrName').value = fullRoadAddr;
//            document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; 
       }
    }).open();
}

$(document).ready(function(){
    $("select option[value='C0021']").attr("selected", true); 
});

function subJoDeCheck(){
	var delivName = document.fmJoDetail.delivName;
	var addrCd = document.fmJoDetail.addrCd;
	var addrName = document.fmJoDetail.addrName;
	var mobileTelNo = document.fmJoDetail.mobileTelNo;
	var homeTelNo = document.fmJoDetail.homeTelNo;
	
	if(delivName.value==''){
		alert("성명을 입력하세요")
		document.fmJoDetail.delivName.focus();
		return false;
	}
	else if(addrCd.value==''){
		alert("우편번호찾기로 우편번호를 입력하세요")
		return false;
	}
	else if((mobileTelNo.value=='')&&(homeTelNo.value=='')){
		alert("휴대전화 또는 집전화번호가 필요합니다.")
		return false;
	}
	
}
</script>
<title>상세 정보 페이지</title>
</head>
<body>
	<form action="joinDetail.do" method="post" name="fmJoDetail" id="fmJoDetail" onsubmit="return subJoDeCheck();">

		<table>
			<tr>
				<th>
					상세정보
				</th>			
			</tr>
			
			<tr>
				<th>
					성명 :
				</th>
				<td>
					<input type="text" id="delivName" name="delivName" >
				</td>	
			</tr>
			
			<tr>
				<th>
					관계 : 
				</th>
				<td>
					<select name="relCd" id="relCd" size="1">
						<option value="C0021" selected="selected">본인(기본)</option>
						<option value="C0022">부모님</option>
						<option value="C0023">동생</option>
						<option value="C0024">지인</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th>
					우편번호 : 
				</th>
				<td>
					<input placeholder="우편번호" name="addrCd" id="addrCd" type="text" readonly="readonly" required="required">
    				<button type="button" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>
				</td>
			</tr>
			
			<tr>
				<th>
					주소 : 
				</th>
				<td>
					<input placeholder="주소" name="addrName" id="addrName" type="text" required="required" >
				</td>
			</tr>
			
			<tr>
				<th>
					휴대전화번호 : 
				</th>
				<td>
					<input type="text" id="mobileTelNo" name="mobileTelNo" placeholder="'-'없이 번호만 입력해주세요" >
				</td>
			</tr>
			
			<tr>
				<th>
					집전화번호 :
				</th>
				<td>
					<input type="text" id="homeTelNo" name="homeTelNo" placeholder="'-'없이 번호만 입력해주세요" >
				</td>
			</tr>
			
			<tr>
				<th>
				 	사용여부 : 
				</th>
				<td>
					<input type="checkbox" name="useYN" id="useYN" checked="checked"/>사용
				</td>
			</tr>
			
			<tr>
				<td>
					<button class="btn btn-default" type="submit">저장</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>