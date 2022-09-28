<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
	<form name="insertForm">
		<input type="hidden" id="num" name="num" value="${freeBoardDto.num }" />
		<input type="hidden" name="codeType" value="${freeBoardDto.codeType }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType" id="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"   value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea  name="content" id="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" onclick="modify()">
					<input type="button" value="삭제" onclick="delete_button()">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</body>
<script type="text/javascript">

		$(function() {
			$("#codeType").val($('input[name=codeType]').val());
		});

	function modify() {
		var modify_1 = {
			codeType : $('select[name=codeType] option:selected').val(),
			num : $('#num').val(),
			title : $('#title').val(),
			content : $('#content').val()
		}
		if(confirm("글을 수정하시겠습니까 ?")){
			 if($('#title').val() == "" || $('#content').val() ==""){
				alert("글을 작성해주세요");
				return false;
			}else{
				
				
			$.ajax({
				url : "./freeBoardModify.ino",
				type : "POST",
				data : modify_1,
				success : function(result){
					if(result.mv){
						if(confirm("게시글 수정 완료 메인화면으로 가시겟습니까 ?")){
							location.href = "./main.ino";
						}else{
	                        location.href = "./freeBoardDetail.ino?num="+result.num;
						}
					}else{
						alert(result.err);
					}
				}
			});
		}
	}else{
		return;
	}
		
	}
		
			
	function delete_button() {
		var delete_button_1 = {
			num : $('#num').val()
		}
		if(confirm("글을 삭제하시겠습니까 ?")){
			$.ajax({
				url : "./freeBoardDelete.ino",
				type : "POST",
				data : delete_button_1,
				success : function(result){
					if(result.mv){
						if(confirm("삭제 완료 ")){
							location.href = "./main.ino";
						}
					}else{
						alert(result.err);
					}
				}
			});
		}else{
			false;
		}
		
	}


</script>

</html>