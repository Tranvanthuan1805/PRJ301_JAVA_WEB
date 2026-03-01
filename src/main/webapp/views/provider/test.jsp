<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Test Page</title>
    </head>

    <body>
        <h1>Test Page Works!</h1>
        <p>Context Path: ${pageContext.request.contextPath}</p>
        <p>Servlet Path: ${pageContext.request.servletPath}</p>
        <p>Request URI: ${pageContext.request.requestURI}</p>

        <h2>Providers Data:</h2>
        <p>Total Providers: ${totalProviders}</p>
        <p>Providers List: ${providers}</p>

        <hr>
        <a href="${pageContext.request.contextPath}/">Back to Home</a>
    </body>

    </html>