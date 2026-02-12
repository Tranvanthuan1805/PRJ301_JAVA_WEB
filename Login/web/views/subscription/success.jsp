<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5 text-center">
    <div class="alert alert-success d-inline-block shadow-sm p-5">
        <h1 class="display-4 text-success mb-3">✔ Payment Successful!</h1>
        <p class="lead">Thank you for subscribing.</p>
        <p class="text-muted">You now have access to advanced features.</p>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/user.jsp" class="btn btn-primary btn-lg">Back to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>
