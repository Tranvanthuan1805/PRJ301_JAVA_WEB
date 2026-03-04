<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Destinations</title>
</head>
<body>
    <h1>Test Destinations Debug</h1>
    
    <h2>Destinations List:</h2>
    <p>Size: ${destinations.size()}</p>
    
    <ul>
        <c:forEach var="dest" items="${destinations}">
            <li>${dest}</li>
        </c:forEach>
    </ul>
    
    <h2>All Request Attributes:</h2>
    <ul>
        <li>destinations: ${destinations}</li>
        <li>totalTours: ${totalTours}</li>
        <li>currentPage: ${currentPage}</li>
    </ul>
</body>
</html>
