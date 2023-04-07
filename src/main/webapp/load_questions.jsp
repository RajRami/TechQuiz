<%@ page import="org.hibernate.Session" %>
<%@ page import="com.techquiz.helper.FactoryProvider" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="com.techquiz.entities.QuestionType" %>
<%@ page import="com.techquiz.entities.TechCategory" %>
<%@ page import="com.techquiz.entities.Question" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techquiz.entities.Option" %>
<%@ page import="java.io.PrintWriter" %>

<%
    Session session1 = FactoryProvider.getFactory().openSession();
    int qtId = Integer.parseInt(request.getParameter("qtId"));
    int tcId = Integer.parseInt(request.getParameter("tcId"));
    int queNo = 1;
%>
<form id="quiz-submit" action="ResultServlet" method="post">
    <input name="qtId" value="<%=qtId%>" hidden>
    <input name="tcId" value="<%=tcId%>" hidden>
    <input name="totalQue" value="<%=queNo%>" hidden>
    <%
        Query query = session1.createQuery("from Question where questionType.id=:qt and techCategory.id=:tc");
        query.setParameter("qt", qtId);
        query.setParameter("tc", tcId);
        List<Question> questions = query.setHint("org.hibernate.cacheable", true).list();
        PrintWriter out1 = response.getWriter();
        if (questions.size() == 0) {
            out1.println("<h3 class='text-white'>No questions available based on selected criteria..!</h3>");
            return;
        }
        for (Question q : questions) {
    %>
    <div class="row my-1">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title"><input name="queNo<%=queNo%>" value="<%=q.getId()%>"
                                              hidden><%=queNo%>. <%=q.getQuestion()%>
                </h5>
                <ul class="list-group">
                    <%
                        List<Option> options = q.getOptions();
                        for (Option opt : options) {
                    %>
                    <li class="list-group-item px-4">
                        <input class="form-check-input" type="radio" name="selectedAnsForQue<%=queNo%>"
                               value="<%=opt.getOption()%>" required>
                        <label class="form-check-label"><%=opt.getOption()%>
                        </label>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>
    <%
            queNo++;
        }
        session1.close();
    %>
    <div class="container text-center text-white" id="loader-quiz-submission" style="display: none">
        <span class="fa fa-refresh fa-spin fa-4x"></span>
        <h4>Please wait..</h4>
    </div>
    <div class="container text-center">
        <button type="submit" id="submit-quiz-btn" class="btn btn-outline-light px-5 my-1">Submit</button>
    </div>
</form>