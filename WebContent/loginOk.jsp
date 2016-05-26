<%@ page import = "com.schedule.pt.MemberDto" %>
<%@ page import = "com.schedule.pt.MemberDao" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
	
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	String appKey = request.getParameter("appkey");
	String kakaoId = request.getParameter("kakaoId");
	
	System.out.println("res:" + kakaoId);
	
	MemberDao dao = MemberDao.getInstance();
	if(kakaoId.equals("")) {
		int checkNum = dao.userCheck(email, pw);
		if(checkNum == -1) {
%>

		<script language="javascript">
			alert("���̵� �������� �ʽ��ϴ�.");
			history.go(-1);
		</script>
<%
		} else if (checkNum == 0) {
%>
		<script language="javascript">
			alert("��й�ȣ�� Ʋ���ϴ�.");
			history.go(-1);
		</script>
<%
		} else if (checkNum == 1) {
			MemberDto dto = dao.getMember(email);
		
			if(dto == null) {
%>
			<script language="javascript">
				alert("�������� �ʴ� ȸ�� �Դϴ�.");
				history.go(-1);
			</script>
<%
			} else {
				String name = dto.getName();
				session.setAttribute("email", email);
				session.setAttribute("name", name);
				session.setAttribute("ValidMem", "yes");
			}
		}
	} else {
		int checkNum = dao.confirmKakao(kakaoId);
		if (checkNum == 1) {
			MemberDto dto = dao.getMember(kakaoId);
			
			if(dto == null) {
%>
			<script language="javascript">
				alert("�������� �ʴ� ȸ�� �Դϴ�.");
				history.go(-1);
			</script>
<%
			} else {
				String name = dto.getName();
				session.setAttribute("kakaoId", kakaoId);
				session.setAttribute("name", name);
				session.setAttribute("ValidMem", "yes");
				session.setAttribute("appKey", appKey);
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<%! 
	String email, pw, res;
%>

<%
	email = request.getParameter("email");
	pw = request.getParameter("password");
	res = request.getParameter("kakao");
	System.out.println("email:" + email);
	System.out.println("pw:" + pw);
	System.out.println("res:" + res);
%>


</body>
</html>