<%@ page import="org.hibernate.query.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.techquiz.helper.FactoryProvider" %>
<%@ page import="com.techquiz.entities.QuestionType" %>
<%@ page import="java.util.List" %><%-- 1st COL: Fech question types from database --%>
<div class="col-md-4 text-center">
    <h3 class="text-white">Select the Question Type</h3>
    <%
        Session session2 = FactoryProvider.getFactory().openSession();
        Query query1 = session2.createQuery("from QuestionType");
        List<QuestionType> questionTypes = query1.setHint("org.hibernate.cacheable", true).list();
        for (QuestionType qt : questionTypes) {
    %>
    <div class="list-group my-1">
        <button id="queType-btn" onclick="getQTId(<%=qt.getId()%>, this)"
                class="qtActive-class list-group-item"><%=qt.getName()%>
        </button>
    </div>
    <%
        }
        session2.close();
    %>
</div>

<%-- Fech questions based on QueTypes and TechCategory selected --%>
<div class="col-md-8">
    <div class="container text-white text-center" id="loader1" style="display: none">
        <i class="fa fa-refresh fa-spin fa-3x"></i>
        <h3 class="mt-2">Loading...</h3>
    </div>
    <div class="container-fluid" id="questions">

    </div>
</div>