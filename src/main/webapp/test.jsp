<%--
  Created by IntelliJ IDEA.
  User: tilme
  Date: 03/08/2022
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Test</title>
</head>
<body>
<c:set var="stuff" value="<%= new java.util.Date()%>" />
Time on the server is ${stuff}
</body>
</html>
