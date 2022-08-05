<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*, com.tilmeez.tagdemo.Student" %>

<%
    // just create some sample ta ... normally provided by MVC
    List<Student> data = new ArrayList<>();

    data.add(new Student("John", "Doe", false));
    data.add(new Student("Maxwell", "Johson", false));
    data.add(new Student("Mary", "Public", true));

    pageContext.setAttribute("myStudent", data);
%>
<html>
<body>
    <table border="1">

        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gold Customer</th>
        </tr>

        <c:forEach var="tempStudent" items="${myStudent}">
            <tr>
                <td>${tempStudent.firstName}</td>
                <td>${tempStudent.lastName}</td>
                <td>${tempStudent.goldCustomer}</td>
            </tr>
        </c:forEach>

    </table>

</body>
</html>

