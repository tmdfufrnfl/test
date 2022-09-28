<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>

</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div>
	
	
		<select id="selectbox" name="selectbox" >
		
			<option value="0">전체</option>
			<option value="1">타입</option> <!-- selectbox -->
			<option value="2">번호</option> <!-- input type text 검색버튼 클릭시 숫자인지체크할것.-->
			<option value="3">내용</option> <!-- input type text -->
			<option value="4">제목</option> <!-- input type text -->
			<option value="5">작성자</option> <!-- input type text -->
			<option value="6">기간</option>  <!-- input type text input type text 검색버튼 클릭시 숫자인지체크할것. 자리수 8자리 체크할것.20220926-->
		</select>
		<button type="button" onclick="search()">검색</button>
	</div>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td><input id="allCheck" type="checkbox" name="allCheck"/></td>	
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>

	</div>
	<hr style="width: 600px;">
				
	<div>
		<table border="1" id="lsitTable">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
					<input type="hidden" name="lists" id="lists" value="${dto}">
						<tr>
							<td class="text_ct"><input name="RowCheck" type="checkbox" value="${dto.num }">
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px; "" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
	<tr>
	
</tr>
		<div style="width:650px;" align="right">
				<input type="button" value="선택삭제" class="btn btn-outline-info" onclick="deleteValue();">
				</div>
	</div>
</body>

<script type="text/javascript">

		 $("#selectbox").click(function() {
				
				var remover =  $("#texta").remove(); // remove = 초기화
					remover += $("#between").remove();
					remover += $("#between2").remove();
					remover += $("#types").remove();
				
				var result = $('#selectbox option:selected').val(); //
				
				if(result == 0){ // 0번일시 
					remover; // 리셋
				}else if(result == 1){ // 1번일시
			    	remover; // 리셋 후
			    	$("#selectbox").after( // after 사용하여 1번 클릭시 type출력
			    	 	"<select name='types' id='types'>" +
			    		"<option value = '01'> 자유 </option>" +
			    		"<option value = '02'> 익명 </option>" +
			    		"<option value = '03'> QnA </option>" +
			    		"</select>"
			    	)
				  }else if(result > 1 && result < 6){
					if(!document.getElementById('texta')){ // remover가 아니라면
						remover; // remover해준뒤 input박스 출력
						$("#selectbox").after('<input type="text" name="texta" id="texta" />');
					}
				}else if(result == 6 && !document.getElementById('between')){ // result가 6과 같고 remover가 아니라면
			   		remover; // 리셋 후 after 후 출력
					$("#selectbox").after('<input type="text" name="between" id="between" />  <input type="text" name="between2" id="between2" />');
				};
			});
			
		 
			function search() {
				var result = $('#selectbox option:selected').val();
				
				if(result == 2){
					var check = /^[0-9]*$/; // 정규식 사용 0~9 사용 가능
					if(!check.test($("#texta").val())){ // test사용하여 검사
						alert("숫자만 검색이 가능합니다");
						false;
					}else{
						true
					}
				}else if(result == 6){
					var check = /^[0-9]{8}$/; // 정규식 사용하여 0~9의 숫자 중 8자리 숫자만 사용 가능
					if(!check.test($("#between").val() || !check.test($("#between2").val()))){ // test사용하여 검사
						alert("8자리의 숫자만 검색이 가능합니다.");
						false;
					}else{
						true
					}
				}
			
				
			if(true){
				$.ajax({
					url:'./search.ino',
					type:'POST',
					contentType: 'application/json',
					traditional : true,
					data:JSON.stringify({
					"selectbox" : $("#selectbox").val(),
					"types" : $("#types").val(),
					"texta" : $("#texta").val(),
					"between" : $("#between").val(),
					"between2" : $("#between2").val()
					}),
					success : function(data){
						console.log(data+"123123");
						// 테이블 초기화
						$("#tb").empty(); // 
						
						var html =""; // 초기값
						
						for(var i=0;i<data.searchdata.length;i++){ // data의 길이를 구해서 for문 사용
							console.log(data.searchdata);
							html += "<tr>";
							
							html +="	<td><input type='checkbox' name='check_board' id='check_board' value="+data.searchdata[i].num +"></td>";
							html +="	<td style='width: 55px; padding-left: 30px;' align='center'>" +data.searchdata[i].codeType +"</td>";
							html +=" 	<td style='width: 55px; padding-left: 30px;' align='center'>"+ data.searchdata[i].num +"</td>";
							html +=" 	<td style='width: 125px;  align='center'>";
							html +="	<a href='./freeBoardDetail.ino?num="+	data.searchdata[i].num +"'>";
							html +=		data.searchdata[i].title;
							html += "	</a></td> ";
							html +="	<td style='width: 48px; padding-left: 50px;' align='center'>"+data.searchdata[i].name+ "</td> ";
							html +="	<td style='width: 100px; padding-left: 95px;' align='center'>"+ data.searchdata[i].regdate +"</td>";
							
							html +="</tr>";
						};
						$("#tb").prepend(html); // 결과 출력
					}
				})
			}
		}
			
		
		
		
		
		
		
		
		
		
		// ---------------선택삭제

		$(function() {
			var chkObj = document.getElementsByName("RowCheck");
			var rowCnt = chkObj.length;
		
		
			$("input[name='allCheck']").click(function(){
				var chk_listArr = $("input[name='RowCheck']");
				for (var i =0; i < chk_listArr.length; i++){
					chk_listArr[i].checked = this.checked;
				}
			});
		$("input[name='RowCheck']").click(function(){
			if($("input[name='RowCheck']:checked").length == rowCnt){
				$("input[name='allCheck']")[0].checked = true;
			}
			else{
				$("input[name='allCheck']")[0].checked = false;
			}
		});
	});
		
		
		function deleteValue() {
				var valueArr = new Array();
				var list = $("input[name='RowCheck']");
				for(var i =0; i< list.length; i++){
					if(list[i].checked){
						valueArr.push(list[i].value);
					}
				}
				if(valueArr.length == 0){
					alert("선택한글이 없습니다.")
				}
				else{
					var chk = confirm("정말 삭제하시겠습니까?");
					
					$.ajax({
						url : "./delete.ino",
						type : 'POST',
						traditional : true,
						data : {"valueArr": valueArr},
						success : function(result){
							if(result =1){
								alert("삭제성공");
								 location.replace("main.ino") 
							}
							else{
								alert("삭제실패");
							}
						}
						
					});
					
				}
			} 
	
	
	</script>

</html>