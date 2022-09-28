<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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

	<form action="./freeBoardInsert.ino" id="form" method="post">
	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id = "codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" id="name" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" id="title" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea id="content" name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" id="submit" value="글쓰기" onclick="insert()">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</body>

<script type="text/javascript">

		function insert() {
			var insert_1 = {
				codeType : $('#codeType').val(),
				name : $('#name').val(),
				title : $('#title').val(),
				content : $('#content').val()
			}
			
			if(confirm("글을 작성하시겠습니까 ?")){
				 if($('#name').val() == "" ||  $('#title').val() =="" ||  $('#content').val() ==""){
					alert("글을 작성해주세요");
					return false;
				}else{
					
				$.ajax({
					url : "./freeBoardInsertPro.ino",
					type : "POST",
					data : insert_1,
					success : function(result){
						if(result.mv){
							if(confirm("게시글 등록 완료")){
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
			false;
		}
			
	}

</script>
</html>