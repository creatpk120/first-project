<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.Vector"%>
<%@ page import="mysulin.Bean_Admin"%>
<%@ page import="mysulin.Bean_Order_c"%>
<jsp:useBean id="myMgr" class="mysulin.Manager_Mysulin"/>
<%
	String perm1 = request.getParameter("perm1");	//점검상태
	String perm2 = request.getParameter("perm2");	//클릭여부
	int recnum = Integer.parseInt(request.getParameter("numb"));

	if(perm1 == null) perm1 = "Z";
	if(perm2 == null) perm2 = "Z";
	if(perm2.equals("GG"))
		myMgr.updateOrderCheckPerm(recnum, perm1);

	int totalRecord = 0;	//전체 레코드 수
	int listSize = 0;		//현재 읽어온 자료 수
	Vector<Bean_Order_c> vlist = null;
	
	String usid = (String)session.getAttribute("idKey");
	int numb = 0;
	totalRecord = myMgr.getOrderCheckCount(usid);
%>

<html>
<head>
	<title>orderCheck</title>
	<link href="../admin/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function orderCheckUpdate(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="orderCheckUpdate.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function orderCheckDel(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="orderCheckDel.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function orderCheck_perm(numb, check) {
		document.readFrm.numb.value=numb;
		document.readFrm.perm1.value=check;
		document.readFrm.perm2.value="GG";
		document.readFrm.action="orderCheck.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function orderList_c(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.action="orderList_c.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function orderList(numb) {
		document.readFrm.numb.value=numb;
		document.readFrm.numb1.value=0;
		document.readFrm.action="orderList.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}
	
	function open_Stock() {
		url = "order_openStock.jsp";
		window.open(url, "openStock", "width=800,height=600,scrollbars=yes");
	}
	
	function open_Schedule() {
		url = "order_openSchedule.jsp";
		window.open(url, "openSchedule", "width=900,height=500,scrollbars=yes");
	}
</script>
</head>

<body bgcolor="#F0F8FF" leftmargin="0" topmargin="0">
	<div align="center">
		<br/>
		<h2>발주 관리</h2>
		<br/>
		<form name="openFrm" method="get">
			<input type="button" value="재고현황" onClick="open_Stock()"> &nbsp;&nbsp;
			<input type="button" value="일정현황" onClick="open_Schedule()"> &nbsp;&nbsp;
			<input type="button" value="거래처관리" onClick="location.href='orderAgnt.jsp'">
		</form>
		
		<table align="center" width="800" border="1">
			<tr>
				<td bgcolor="#D9E5FF">&nbsp;&nbsp;발주 횟수 : <%=totalRecord%></td>
			</tr>
		</table>
		<table align="center" width="800" cellpadding="3" border="1">
			<tr>
				<td align="center" colspan="3">
				<%
					vlist = myMgr.getOrderCheckList(usid);
						listSize = vlist.size();	//브라우저 화면에 보여질 자료 수
						if(vlist.isEmpty()) {
							out.println("등록된 자료가 없습니다.");
						} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0" border="1">
						<tr bgcolor="#D9E5FF" align="center" height="120%">
							<td>순서</td>
							<td>담당자</td>
							<td>발주일</td>
							<td>배송일</td>
							<td>배송여부</td>
							<td>목 록</td>
							<td>점 검</td>
							<td>수 정</td>
							<td>삭 제</td>
						</tr>
						<%
							for(int i = 0; i < listSize; i++) {
								Bean_Order_c bean = vlist.get(i);
								numb = bean.getNumb();
								String usid1 = bean.getO_usid();
								String y_date = bean.getO_y_date();
								String t_date = bean.getO_t_date();
								String check = bean.getO_check();
						%>
						<tr>
							<td align="center"><%=numb%></td>
							<td align="center"><%=usid1%></td>
							<td align="center"><%=y_date%></td>
							<td align="center"><%=t_date%></td>
							<td align="center">
								<a href="javascript:orderCheck_perm('<%=numb%>','<%=check%>')"><%=check%></a>
							</td>
							<td align="center">
								<a href="javascript:orderList_c('<%=numb%>')">목록생성</a>
							</td>
							<td align="center">
								<a href="javascript:orderList('<%=numb%>')">점검하기</a>
							</td>
							<td align="center">
								<a href="javascript:orderCheckUpdate('<%=numb%>')">수정</a>
							</td>
							<td align="center">
								<a href="javascript:orderCheckDel('<%=numb%>')">삭제</a>
							</td>
						</tr>
						<%	}//for%>
					</table> <%
					}//if
				%>
				</td>
			</tr>
		</table>
		<form name="readFrm" method="get">
			<br/>
			<input type="button" value="신규내역" onClick="location.href='orderCheckWrite.jsp'"> &nbsp;&nbsp;
			<input type="hidden" name="numb">
			<input type="hidden" name="numb1">
			<input type="hidden" name="perm1">
			<input type="hidden" name="perm2">
		</form>
	</div>
</body>

</html>