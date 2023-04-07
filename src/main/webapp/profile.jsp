<%@ page import="com.techquiz.entities.User" %>
<%@ page import="com.techquiz.entities.Message" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.techquiz.helper.FactoryProvider" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="com.techquiz.entities.Result" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        Message msg = new Message("To access profile page, Please login first..!", "error", "alert-danger");
        session.setAttribute("msg", msg);
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Profile: TechQuiz</title>
    <%@include file="all_css_js.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>
<main class="primary-background banner-background py-5">
    <div class="container mb-3">
        <div class="row">
            <div class="col my-2 style-3D">
                <div class="text-center text-white py-2">
                    <img src="pics/<%=user.getProfile()%>" class="img-fluid"
                         style="border-radius:50%;max-width: 150px;;">
                    <br>
                    <h4 class="modal-title mt-2" id="exampleModalLabel"><%= user.getName()%>
                    </h4>
                    <!-- Profile details-->
                    <div id="profile-details" class="bg-white">

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

                        <table class="table">
                            <tbody>
                            <tr>
                                <th scope="row">Email :</th>
                                <td><%= user.getEmail()%>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Gender :</th>
                                <td><%= user.getGender()%>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">About :</th>
                                <td><%= user.getAbout()%>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Registered on :</th>
                                <td style="color: blue"><%= user.getReg_date()%>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="container text-center">
                            <button type="button" class="btn btn-primary mb-2" id="edit-profile-button">Edit Profile
                            </button>
                        </div>
                    </div>
                    <!-- Profile Edit-->
                    <div id="profile-edit" class="bg-white">
                        <form class="pb-2" action="EditServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tbody>
                                <tr>
                                    <th scope="row">Name :</th>
                                    <td><input type="text" name="name" value="<%= user.getName()%>" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">Email :</th>
                                    <td><input type="email" name="email" value="<%= user.getEmail()%>" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">Password :</th>
                                    <td><input type="password" name="password" value="<%= user.getPassword()%>"
                                               required>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender :</th>
                                    <td><%= user.getGender()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">About :</th>
                                    <td><textarea name="about"><%= user.getAbout()%></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">Registered on :</th>
                                    <td style="color: blue"><%= user.getReg_date()%>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">Profile pic:</th>
                                    <td><input name="image" type="file"
                                               value="<%=user.getProfile()%>">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-success mx-1">Update</button>
                                <a href="profile.jsp" id="cancel-btn mx-1" class="btn btn-primary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col my-2 style-3D">
                <div class="text-white">
                    <h3 class="text-center text-white py-1">Previous Quiz Results</h3>
                    <%
                        Session session1 = FactoryProvider.getFactory().openSession();
                        Query query = session1.createQuery("from Result where user.id=:uid");
                        query.setParameter("uid", user.getId());
                        List<Result> resultList = query.setHint("org.hibernate.cacheable", true).list();
                        int rowReturned = resultList.size();
                    %>
                    <span class="text-white">No Of Rows Returned: <%=rowReturned%></span>
                    <table class="table">
                        <thead class="table-dark">
                        <tr>
                            <th scope="col">Tech Category</th>
                            <th scope="col">Question Type</th>
                            <th scope="col">Score</th>
                            <th scope="col">Quiz Date</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Result value : resultList) {
                        %>
                        <tr class="text-white">
                            <td><%=value.getTechCategory().getName()%>
                            </td>
                            <td><%=value.getQuestionType().getName()%>
                            </td>
                            <td><%=value.getScoreObtained()%> out of <%=value.getScoreTotal()%>
                            </td>
                            <td><%=value.getResultDate()%>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
<script>
    $(document).ready(function () {
        $("#profile-edit").hide();
        $("#edit-profile-button").click(function () {
            $("#profile-details").hide();
            $("#profile-edit").show();
        })
    })
</script>
</body>
</html>
