<%@ page import="com.techquiz.entities.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login: TechQuiz</title>
    <%@include file="all_css_js.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<main class="primary-background banner-background py-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card style-3D">
                    <div class="card-header primary-background text-white text-center">
                        <span class="fa fa-user-circle fa-3x"></span>
                        <br>
                        <p>Login here</p>
                    </div>
                    <%
                        Message msg = (Message) session.getAttribute("msg");
                        if (msg != null) {
                    %>
                    <div class="alert <%=msg.getCssClass()%> text-center" role="alert"><%=msg.getContent()%>
                    </div>
                    <%
                            session.removeAttribute("msg");
                        }
                    %>
                    <div class="card-body">
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input name="email" type="email" class="form-control" id="exampleInputEmail1"
                                       aria-describedby="emailHelp" placeholder="Enter email" required>
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with
                                    anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label>
                                <input name="password" type="password" class="form-control"
                                       id="exampleInputPassword1" placeholder="Password" required>
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
