<%@ page import="com.techquiz.entities.User" %>
<nav class="navbar sticky-top navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Quiz</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="index.jsp"><span
                        class="fa fa-home"></span> Home<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="quizzes.jsp"><span
                        class="fa fa-search"></span> Quizzes</a>
            </li>
            <%
                User currentUser = (User) session.getAttribute("currentUser");
                if (currentUser != null) {
                    if (currentUser.getEmail().equals("raj@gmail.com")) {
            %>
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="create_quiz.jsp"><span
                        class="fa fa-plus"></span> Create Quiz</a>
            </li>
            <%
                    }
                }
            %>
        </ul>
        <ul class="navbar-nav mr-right">
            <%
                if (currentUser == null) {
            %>
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="login.jsp"><span
                        class="fa fa-user-circle"></span> Login
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="register.jsp"><span
                        class="fa fa-user-plus"></span> Register</a>
            </li>
            <%
            } else {
            %>
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="profile.jsp"> <span
                        class="fa fa-user-circle"></span> <%=currentUser.getName()%>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link add-active" onclick="addActiveClass(this)" href="LogoutServlet"><span
                        class="fa fa-user-times"></span> Logout</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
<script>
    $(document).ready(function () {
        let defaultActiveRef = $(".add-active")[0]
        addActiveClass(defaultActiveRef);
    })

    function addActiveClass(linkRef) {
        $(".add-active").removeClass("active");
        $(linkRef).addClass("active");
    }
</script>
