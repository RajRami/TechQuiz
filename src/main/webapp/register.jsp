<%@ page import="com.techquiz.entities.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register: TechQuiz</title>
    <%@include file="all_css_js.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<main class="primary-background banner-background py-5">
    <div class="container">
        <div class="col-md-6 offset-md-3">
            <div class="card style-3D">
                <div class="card-header text-center primary-background text-white">
                    <span class="fa fa-3x fa-user-plus"></span>
                    <br>
                    Register here
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
                    <form id="reg-form" action="RegisterServlet" method="POST">
                        <div class="form-group">
                            <label for="user_name">Name</label>
                            <input name="user_name" type="text" class="form-control" id="user_name"
                                   aria-describedby="emailHelp" placeholder="Enter name" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input name="user_email" type="email" class="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp" placeholder="Enter email" required>
                            <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone
                                else.</small>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input name="user_password" type="password" class="form-control" id="exampleInputPassword1"
                                   placeholder="Password" required>
                        </div>
                        <div class="form-group">
                            <label>Select Gender</label>
                            <br>
                            <input type="radio" name="gender" value="male" required>Male
                            <input type="radio" name="gender" value="female" required>Female
                        </div>
                        <div class="form-group">
                            <textarea name="about" class="form-control" id="" rows="5"
                                      placeholder="Enter something about yourself"></textarea>
                        </div>
                        <div class="form-check">
                            <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1" required>
                            <label class="form-check-label text-danger" for="exampleCheck1">*agree terms and
                                conditions</label>
                        </div>
                        <br>
                        <div class="container text-center" id="loader" style="display: none;">
                            <span class="fa fa-refresh fa-spin fa-4x"></span>
                            <h4>Please wait..</h4>
                        </div>

                        <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<script>

    $(document).ready(function () {
        $("#opt").addEventListener()
    //     $("#submit-btn").show();
    //     $("#loader").hide();
    //     $("#reg-form").submit(function () {
    //         $("#submit-btn").hide();
    //         $("#loader").show();
    //     })
    })

    // $(document).ready(function () {
    //     $("#reg-form").submit(function (event) {
    //         event.preventDefault();
    //         $("#submit-btn").hide();
    //         $("#loader").show();
    //         let form = $("#reg-form");
    //         $.ajax({
    //             url: 'RegisterServlet',
    //             type: 'post',
    //             data: form.serialize(),
    //             success: function (data) {
    //                 $("#submit-btn").show();
    //                 $("#loader").hide();
    //                 if (data.trim() === "success") {
    //                     swal("Good job!", "Registered Successfully..!", "success")
    //                         .then(value => {
    //                             window.location = "index.jsp"
    //                         })
    //                 } else {
    //                     $("#submit-btn").show();
    //                     $("#loader").hide();
    //                     swal("Oops!", "Email Already in use.. Try Again!", "error")
    //                         .then(value => {
    //                             window.location = "register.jsp";
    //                         })
    //                 }
    //             },
    //             error: function (data) {
    //
    //                 $("#submit-btn").show();
    //                 $("#loader").hide();
    //                 swal("Something went wrong", "error");
    //             }
    //         })
    //     })
    // })

</script>
</body>
</html>
