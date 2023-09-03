<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Hello Neuromancer</title>
        <style>
            body {
                background-color: black;
                color: #33ff33;
                font-family: "Courier New", monospace;
                text-align: center;
                margin-top: 20%;
            }
            h1 {
                font-size: 40px;
                text-shadow: 0 0 10px #33ff33, 0 0 20px #33ff33, 0 0 30px #33ff33;
            }
            p {
                font-size: 24px;
                margin-top: 20px;
            }
            #ip {
                font-size: 20px;
                color: #66ccff;
            }
        </style>
    </head>
    <body>
        <h1>Hello Neuromancer</h1>
        <p>Date and Time: <%= new java.util.Date() %></p>
        <p id="ip">Remote Addr: <%= request.getRemoteAddr() %></p>
        <p id="ip">Machine IP: <%= java.net.InetAddress.getLocalHost().getHostAddress() %></p>
    </body>
</html>
