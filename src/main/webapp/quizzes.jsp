<%@ page import="org.hibernate.Session" %>
<%@ page import="com.techquiz.helper.FactoryProvider" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techquiz.entities.*" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        Message msg = new Message("To access quizzes, Please login first..!", "error", "alert-danger");
        session.setAttribute("msg", msg);
        response.sendRedirect("login.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quizzes: TechQuiz</title>
    <%@include file="all_css_js.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<main class="primary-background banner-background">
    <div class="container">
        <h3 class="text-center text-white py-1">Select the tech category to take the relevant quiz</h3>
        <%-- First row START--%>
        <div class="row text-center py-3">
            <%
                Session session1 = FactoryProvider.getFactory().openSession();
                Query query = session1.createQuery("from TechCategory ");
                List<TechCategory> techCategories = query.setHint("org.hibernate.cacheable", true).getResultList();
                for (TechCategory tc : techCategories) {
            %>
            <div class="col my-1">
                <button id="techCat-btn" onclick="getTCId(<%=tc.getId()%>, this)"
                        class="tcActive-class btn btn-outline-light"><%=tc.getName()%>
                </button>
            </div>
            <%
                }
                session1.close();
            %>
        </div>
        <%-- First row END --%>
        <hr>
        <%-- Second row START--%>
        <div id="row-2" class="row mt-1 pt-3 pb-5">
        </div>
        <%-- Second row END--%>
    </div>
</main>
<script>
    $(document).ready(function () {
        $("#quiz-submit").submit(function (event) {
            event.preventDefault();
            $("#submit-quiz-btn").hide();
            $("#loader-quiz-submission").show();
            let form = $("#quiz-submit");
            $.ajax({
                url: 'ResultServlet',
                type: 'post',
                data: form.serialize(),
                success: function (data) {
                    if (data.trim() === "success") {
                        $("#submit-quiz-btn").show();
                        $("#loader-quiz-submission").hide();
                        swal("Good job!", "Quiz has been added Successfully..! We are redirecting to profile page to see the result", "success")
                            .then(value => {
                                window.location = "profile.jsp"
                            })
                    } else {
                        $("#submit-quiz-btn").show();
                        $("#loader-quiz-submission").hide();
                        swal("Oops!", "Something went wrong.. Try Again! ", "error");
                    }
                },
                error: function (data) {
                    $("#submit-quiz-btn").show();
                    $("#loader-quiz-submission").hide();
                    swal("Oops!", "Something went wrong", "error");
                }
            })
        })
    })
    let tcId;
    let qtId;

    function getTCId(id, ref) {
        tcId = id;
        console.log(tcId);
        $(".tcActive-class").removeClass('active');
        $(ref).addClass('active');
        $("#row-2").show();
        $.ajax({
            url: "row-2-quizzes.jsp",
            success: function (data) {
                $("#row-2").html(data);
            },
            error: function (data) {
                swal("Something went wrong", "error");
            }
        })
    }

    function getQTId(id, ref) {
        qtId = id;
        console.log(qtId);
        $(".qtActive-class").removeClass('active');
        $(ref).addClass('active');
        getQuestionsByTCIdAndQTId(tcId, qtId);
    }

    function getQuestionsByTCIdAndQTId(tcId, qtId) {
        $("#loader1").show();
        $.ajax({
            url: 'load_questions.jsp',
            data: {tcId: tcId, qtId: qtId},
            success: function (data) {
                $("#loader1").hide();
                $("#questions").html(data);
            },
            error: function (data) {
                $("#loader1").hide();
                swal("Something went wrong", "error");
            }
        })
    }
</script>
</body>
</html>
