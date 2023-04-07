<%@ page import="com.techquiz.entities.Message" %><%
    User user = (User) session.getAttribute("currentUser");
    if (user != null) {
        if (!user.getEmail().equals("raj@gmail.com")) {
            Message msg = new Message("You are restricted to access admin page, Use admin credentials to proceed..!", "error", "alert-danger");
            session.setAttribute("msg", msg);
            response.sendRedirect("login.jsp");
        }
    } else {
        Message msg = new Message("You are not logged in, Please login first..!", "error", "alert-danger");
        session.setAttribute("msg", msg);
        response.sendRedirect("login.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Quiz: TechQuiz</title>
    <%@include file="all_css_js.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<main class="primary-background banner-background">
    <div class="container">
        <h3 class="text-center text-white py-1">Click on a specific button to create relevant item</h3>

        <%-- First row START--%>
        <div class="row text-center py-3">
            <div class="col-md-4 my-1">
                <button id="techCat-btn" class="btn btn-outline-light">Create Tech Category</button>
            </div>
            <div class="col-md-4 my-1">
                <button id="que-btn" class="btn btn-outline-light">Create Question</button>
            </div>
            <div class="col-md-4 my-1">
                <button id="queType-btn" class="btn btn-outline-light">Create Question Type</button>
            </div>
        </div>
        <%-- First row END --%>
        <hr>
        <%-- Second row START--%>
        <div class="row mt-1 pt-3 pb-5">
            <div class="col-md-4 offset-md-4">
                <%--Add tech category START--%>
                <div id="addTechCatCard" class="card style-3D" style="display: none">
                    <div class="card-header primary-background text-white text-center">
                        <span class="fa fa-pencil fa-3x"></span>
                        <br>
                        <p>Add Tech Category</p>
                    </div>
                    <div class="card-body">
                        <form id="addTechCatForm" action="TechCategoryServlet" method="post">
                            <div class="form-group">
                                <label for="techCatName">Tech Category</label>
                                <input name="techCat" type="text" class="form-control" id="techCatName"
                                       placeholder="Enter Tech Category" required>
                            </div>
                            <br>
                            <div class="container text-center" id="loader1" style="display: none;">
                                <span class="fa fa-refresh fa-spin fa-4x"></span>
                                <h4>Please wait..</h4>
                            </div>
                            <div class="container text-center">
                                <button type="submit" id="submit-btn1" class="btn btn-primary">Add</button>
                            </div>
                        </form>
                    </div>
                </div>
                <%--Add tech category END--%>

                <%--Add question type START--%>
                <div id="addQueTypeCard" class="card style-3D" style="display: none">
                    <div class="card-header primary-background text-white text-center">
                        <span class="fa fa-pencil fa-3x"></span>
                        <br>
                        <p>Add Question Type</p>
                    </div>
                    <div class="card-body">
                        <form id="addQueTypeForm" action="QuestionTypeServlet" method="post">
                            <div class="form-group">
                                <label for="qTypeName">Question Type</label>
                                <input name="queType" type="text" class="form-control" id="qTypeName"
                                       placeholder="Enter Question type" required>
                            </div>
                            <br>
                            <div class="container text-center" id="loader2" style="display: none;">
                                <span class="fa fa-refresh fa-spin fa-4x"></span>
                                <h4>Please wait..</h4>
                            </div>
                            <div class="container text-center">
                                <button type="submit" id="submit-btn2" class="btn btn-primary">Add</button>
                            </div>
                        </form>
                    </div>
                </div>
                <%--Add question type END--%>
            </div>

            <div class="col-md-6 offset-md-3">
                <%--Add question START--%>
                <%@include file="question_form.jsp" %>
                <%--Add question END--%>
            </div>
        </div>
        <%-- Second row END--%>

    </div>
</main>
<script>
    $("#techCat-btn").click(function () {
        $("#addTechCatCard").show();
        $("#addQueTypeCard").hide();
        $("#addQueCard").hide();
    })

    $("#queType-btn").click(function () {
        $("#addQueTypeCard").show();
        $("#addTechCatCard").hide();
        $("#addQueCard").hide();
    })

    $("#que-btn").click(function () {
        $("#addQueCard").show();
        $("#addTechCatCard").hide();
        $("#addQueTypeCard").hide();
    })
</script>
<script>
    $(document).ready(function () {

        $("#next-btn").click(function () {
            let tech_cat = $("#techCatSelectMenu").val();
            let que_type = $("#queTypeSelectMenu").val();
            if (tech_cat != null && que_type != null) {
                $("#first-half").hide();
                $("#second-half").show();
                if (que_type == 2) {
                    $("#options-3").hide();
                    $("#options-2").show();

                    // removing required to those options which are hidden, helped get rid of the problem interrupting the question form submission
                    $("#option1").removeAttr("required");
                    $("#option2").removeAttr("required");
                    $("#option3").removeAttr("required");

                } else {
                    $("#options-3").show();
                    $("#options-2").hide();
                }
            }
        })

        $("#addTechCatForm").submit(function (event) {
            event.preventDefault();
            $("#submit-btn1").hide();
            $("#loader1").show();
            let form = $("#addTechCatForm");
            $.ajax({
                url: 'TechCategoryServlet',
                type: 'post',
                data: form.serialize(),
                success: function (data) {
                    $("#submit-btn1").show();
                    $("#loader1").hide();
                    if (data.trim() === "success") {
                        swal("Good job!", "Tech Category has been added Successfully..!", "success")
                            .then(value => {
                                window.location = "create_quiz.jsp"
                            })
                    } else {
                        $("#submit-btn1").show();
                        $("#loader1").hide();
                        swal("Oops!", "Tech Category is already added.. Try Different One!", "error");
                    }
                },
                error: function (data) {
                    $("#submit-btn1").show();
                    $("#loader1").hide();
                    swal("Something went wrong", "error");
                }
            })
        })

        $("#addQueTypeForm").submit(function (event) {
            event.preventDefault();
            $("#submit-btn2").hide();
            $("#loader2").show();
            let form = $("#addQueTypeForm");
            $.ajax({
                url: 'QuestionTypeServlet',
                type: 'post',
                data: form.serialize(),
                success: function (data) {
                    if (data.trim() === "success") {
                        $("#submit-btn2").show();
                        $("#loader2").hide();
                        swal("Good job!", "Question Type has been added Successfully..!", "success")
                            .then(value => {
                                window.location = "create_quiz.jsp"
                            })
                    } else {
                        $("#submit-btn2").show();
                        $("#loader2").hide();
                        swal("Oops!", "Question Type is already added.. Try Different One!", "error");
                    }
                },
                error: function (data) {
                    $("#submit-btn2").show();
                    $("#loader2").hide();
                    swal("Something went wrong", "error");
                }
            })
        })

        $("#addQueForm").submit(function (event) {
            event.preventDefault();
            $("#submit-btn3").hide();
            $("#loader3").show();
            let form = $("#addQueForm");
            $.ajax({
                url: 'QuestionServlet',
                type: 'post',
                data: form.serialize(),
                success: function (data) {
                    if (data.trim() === "success") {
                        $("#submit-btn3").show();
                        $("#loader3").hide();
                        swal("Good job!", "Question has been added Successfully..!", "success")
                            .then(value => {
                                window.location = "create_quiz.jsp"
                            })
                    } else {
                        $("#submit-btn3").show();
                        $("#loader3").hide();
                        swal("Oops!", "Something went wrong.. Try Again! ", "error");
                    }
                },
                error: function (data) {
                    $("#submit-btn3").show();
                    $("#loader3").hide();
                    swal("Something went wrong", "error");
                }
            })
        })
    })
</script>
</body>
</html>
