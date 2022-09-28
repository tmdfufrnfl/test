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
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	<form name="insertForm">
		<input type="hidden" id="num" name="num" value="${freeBoardDto.num }" />
		<input type="hidden" name="codeType" value="${freeBoardDto.codeType }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select name="codeType" id="codeType">
							<option value="01">����</option>
							<option value="02">�͸�</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"   value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea  name="content" id="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="����" onclick="modify()">
					<input type="button" value="����" onclick="delete_button()">
					<input type="button" value="���" onclick="location.href='./main.ino'">
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
		if(confirm("���� �����Ͻðڽ��ϱ� ?")){
			 if($('#title').val() == "" || $('#content').val() ==""){
				alert("���� �ۼ����ּ���");
				return false;
			}else{
				
				
			$.ajax({
				url : "./freeBoardModify.ino",
				type : "POST",
				data : modify_1,
				success : function(result){
					if(result.mv){
						if(confirm("�Խñ� ���� �Ϸ� ����ȭ������ ���ðٽ��ϱ� ?")){
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
		if(confirm("���� �����Ͻðڽ��ϱ� ?")){
			$.ajax({
				url : "./freeBoardDelete.ino",
				type : "POST",
				data : delete_button_1,
				success : function(result){
					if(result.mv){
						if(confirm("���� �Ϸ� ")){
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