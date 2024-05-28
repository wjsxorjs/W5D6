<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.btn{
		width: 70px;
		height: 20px;
		text-align: center;
		padding: 0px;
	}
	.btn a{
		display: block;
		width: 100%;
		height: 20px;
		padding: 4px;
		line-height: 20px;
		background: #27a;
		color: #fff;
		border-radius: 3px;
		text-decoration: none;
		font-weight: bold;
		font-size: 12px;
	}
	.btn a:hover{
		background: #fff;
		color: #27a;
		border: 1px solid #27a;
	}	
	div#wrap{
		width: 400px;
		margin: 30px auto;
	}
	table th, table td{
		padding: 3px;
	}
	table tbody td>input{
		width: 120px;
		border: 1px solid #27a;
		padding: 4px;
	}
	
	.phone{ width: 50px; }
	.txt_R{ text-align: right; }
	
	.success{
		color: #00f;
		font-weight: bold;
		font-size: 11px;
	}
	.fail{
		color: #f00;
		font-weight: bold;
		font-size: 11px;
	}
	div#box{
		display: inline-block;
		width: 65px;
		height: 20px;
		padding: 0;
		margin: 0;
		margin-left: 3px;
	}

	div#my_win{
		display: none;
	}
</style>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
</head>
<body>
	<div id="wrap">
		<form action="" method="post">
			<table>
				<colgroup>
					<col width="100px"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="txt_R"><label for="s_id">ID:</label></th>
						<td>
							<input type="text" id="s_id" name="id"/>
							<div id="box"></div>
						</td>
					</tr>
					<tr>
						<th class="txt_R"><label for="s_pw">PW:</label></th>
						<td>
							<input type="password" id="s_pw" name="pw"/>
						</td>
					</tr>
					<tr>
						<th class="txt_R"><label for="s_name">NAME:</label></th>
						<td>
							<input type="text" id="s_name" name="name"/>
						</td>
					</tr>
					<tr>
						<th class="txt_R"><label for="s_email">EMAIL:</label></th>
						<td>
							<input type="text" id="s_email" name="email"/>
						</td>
					</tr>
					<tr>
						<th class="txt_R"><label for="s_phone">PHONE:</label></th>
						<td>
							<input type="text" id="s_phone" name="phone" class="phone"/>
							- <input type="text" name="phone" class="phone"/>
							- <input type="text" name="phone" class="phone"/>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<p class="btn">
								<a href="javascript:reg()">등록</a>
							</p>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>

	<div id="my_win" title="결과">
		asdf
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
	<script>
		$(function(){
			$("my_win").dialog();

			// 현재문서 안에 아이디가 s_id인 요소에
			// 키보드가 누를 때마다 수행하는 함수를 이벤트로 적용하자
			$("#s_id").bind("keyup",function(){
				// 아이디가 s_id 요소의 값을 가져와서 변수 str에 저장

				let str = $("#s_id").val().trim();
				str = clrSpace(str);
				if(str.length>=4){
					$.ajax({
						url: "checkId.jsp",
						type: "post",
						data: "m_id="+encodeURIComponent(str),
					}).done(function(res){
						$("#box").html(res)
					});
				} else{
					$.ajax({
						url: "checkId.jsp",
						type: "post",
						data: "m_id=-1",
					}).done(function(res){
						$("#box").html(res)
					});
				}
			});

		});

		function reg(){
			id = clrSpace($("#s_id").val());
			pw = clrSpace($("#s_pw").val());
			name = clrSpace($("#s_name").val());
			email = clrSpace($("#s_email").val());
			
			if(id.length<1){
				alert("아이디를 입력해주세요.");
				$("#s_id").val("");
				$("#s_id").focus();
				return;
			}
			if(pw.length<1){
				alert("비밀번호를 입력해주세요.");
				$("#s_pw").val("");
				$("#s_pw").focus();
				return;
			}
			if(name.length<1){
				alert("이름을 입력해주세요.");
				$("#s_name").val("");
				$("#s_name").focus();
				return;
			}
			if(email.length<1){
				alert("이메일을 입력해주세요.");
				$("#s_email").val("");
				$("#s_email").focus();
				return;
			}


			let phone_arr = $(".phone");
			let phone_0 = clrSpace(phone_arr[0].value);
			let phone_1 = clrSpace(phone_arr[1].value);
			let phone_2 = clrSpace(phone_arr[2].value);
			
			if(phone_0.length<1){
				alert("전화번호 앞자리를 입력해주세요.");
				$(".phone")[0].value="";
				$(".phone")[0].focus();
				return;
			}
			if(phone_1.length<1){
				alert("전화번호 가운데 자리를 입력해주세요.");
				$(".phone")[1].value="";
				$(".phone")[1].focus();
				return;
			}
			if(phone_2.length<1){
				alert("전화번호 뒷자리를 입력해주세요.");
				$(".phone")[2].value="";
				$(".phone")[2].focus();
				return;
			}

			phone = phone_0+"-"+
					phone_1+"-"+
					phone_2;
			
			
			let param = "m_id="+encodeURIComponent(id)+"&"+
						"m_pw="+encodeURIComponent(pw)+"&"+
						"m_name="+encodeURIComponent(name)+"&"+
						"m_email="+encodeURIComponent(email)+"&"+
						"m_phone="+encodeURIComponent(phone);
			
			// console.log(param);

			if($("#box>span.success").val() != null){
				$.ajax({
						url: "addMember.jsp",
						type: "post",
						data: param,
					}).done(function(res){
						// alert("저장 성공");
						$("#s_id").val("");
						$("#s_pw").val("");
						$("#s_name").val("");
						$("#s_email").val("");
						$(".phone")[0].value="";
						$(".phone")[1].value="";
						$(".phone")[2].value="";

						
						$("#my_win").html(res.trim());
						$("#my_win").dialog({
							buttons: {
								"확인": function() {
									$( this ).dialog( "close" );
									$(this).click(location.href = "index.jsp");
								}
							}
						});
						
					}).fail(function(res){
						alert("저장 실패");
					});
			} else{
				alert("아이디가 유효하지않습니다.");
			}
		}
		
		function clrSpace(str){
        	return str.replace(/^\s+|\s+|\s+$/g,"");
    	}
			

		
	</script>
</body>
</html>







