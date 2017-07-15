<%@ page language="java" import="java.util.*,user.*,java.sql.*,dao.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'usermanage.jsp' starting page</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="/onlinebookstore/css/usermanage.css">
	

  </head>
  
  <body>
  	<div class="content">
    <div class="user">
  	<table>
  		<tr>
  			<th>用户名</th>
  			<th>密码</th>
  			<th>姓名</th>
  			<th>性别</th>
  			<th>电话</th>
  			<th>删除</th>
  		</tr>
    <%  
    	String admin = (String)request.getParameter("admin");
    
    	int pageNow = 1; //当前页
    	String spageNow = request.getParameter("pageNow");
    	
    	if(spageNow != null)
    		pageNow = Integer.parseInt(spageNow);
		int pageSize = 6;  //每页显示多少行数据
   		ResultSet rs = null;
    	String sql1 = "select count(*) from user";
    	rs = dao.query(sql1);
    	rs.next();
    	int rowCount = rs.getInt(1);	//一共有多少行数据
    	int pageCount = (rowCount-1)/pageSize+1;  //一共有多少页
    	dao.close(dao.getConn(), dao.getSt(), rs);
    	String sql2 = "select * from user where idd limit "+ (pageNow-1)*pageSize +","+ pageSize;
    	rs = dao.query(sql2);
    	while(rs.next()) {
    %>
    <tr>
	    <td><%=rs.getString(1) %></td>
	    <td>******</td>
	    <td><%=rs.getString(3) %></td>
	    <td><%=rs.getString(4) %></td>
	    <td><%=rs.getString(5) %></td>
	    <td><a href="/onlinebookstore/usermanage?admin=<%= admin %>&id=<%= rs.getString(1) %>">
	    		<input type="button" value="删除" id="delete">
	    	</a>
	    </td>
    </tr>
    <%
    	}
    	dao.close(dao.getConn(), dao.getSt(), rs);
    %>
    </table>
    <div class="page">
    <%
    	if(pageNow != 1) {
    %>
    		<a href="/onlinebookstore/admin/deluser/usermanage.jsp?admin=<%= admin %>&pageNow=<%= pageNow-1 %>">&lt;上一页</a>
    <% 	
    	}	
    	for(int i = 1; i <= pageCount; i++) {
    		if(i == pageNow) {
    %>
    			<input type="text" style="width:22px;text-align:center;" disabled="disabled" value=<%= i %>>
    <% 
    		}else {
    %>
    			<a href="/onlinebookstore/admin/deluser/usermanage.jsp?admin=<%= admin %>&pageNow=<%= i %>"><input type="button" value=<%= i %> id="pageNow"></a>
    <%
    		}
    	}
    	if(pageNow != pageCount) {
    %>
    		<a href="/onlinebookstore/admin/deluser/usermanage.jsp?admin=<%= admin %>&pageNow=<%= pageNow+1 %>">下一页&gt;</a>
    <% 
    	}
    %>
    </div>
    </div>
    </div>
  </body>
</html>
