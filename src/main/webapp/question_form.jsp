<%@ page import="org.hibernate.Session" %>
<%@ page import="com.techquiz.helper.FactoryProvider" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techquiz.entities.TechCategory" %>
<%@ page import="com.techquiz.entities.QuestionType" %>
<div id="addQueCard" class="card style-3D" style="display: none">
    <div class="card-header primary-background text-white text-center">
        <span class="fa fa-pencil fa-3x"></span>
        <br>
        <p>Add Question</p>
    </div>
    <div class="card-body">
        <form id="addQueForm" action="QuestionServlet" method="post">
            <div id="first-half">
                <div class="form-group">
                    <select class="form-control" name="techCatId" id="techCatSelectMenu" required>
                        <option value="" selected disabled hidden>Select Tech Category</option>
                        <%
                            Session session1 = FactoryProvider.getFactory().openSession();
                            Query query1 = session1.createQuery("from TechCategory");
                            List<TechCategory> techCategories = query1.setHint("org.hibernate.cacheable", true).getResultList();

                            for (TechCategory tc : techCategories) {
                        %>
                        <option value="<%=tc.getId()%>"><%=tc.getName()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" name="queTypeId" id="queTypeSelectMenu" required>
                        <option value="" selected disabled hidden>Select Question Type</option>
                        <%
                            Query query2 = session1.createQuery("from QuestionType");
                            List<QuestionType> questionTypes = query2.setHint("org.hibernate.cacheable", true).getResultList();

                            for (QuestionType qt : questionTypes) {
                        %>
                        <option value="<%=qt.getId()%>"><%=qt.getName()%>
                        </option>
                        <%
                            }
                            session1.close();
                        %>
                    </select>
                </div>
                <div class="container text-center">
                    <button type="button" class="btn btn-outline-primary" id="next-btn">Next</button>
                </div>
            </div>


            <div id="second-half" style="display: none">
                <div class="form-group">
                    <label for="queName">Question</label>
                    <input name="question" type="text" class="form-control" id="queName"
                           placeholder="Enter Question" required>
                </div>

                <%-- 3 options beacause Quetype selected as multiple choice --%>
                <div class="form-group" id="options-3">
                    <label for="option1">Option:1</label>
                    <input name="option1" type="text" class="form-control" id="option1"
                           placeholder="Enter 1st Option" required>
                    <label for="option2">Option:2</label>
                    <input name="option2" type="text" class="form-control" id="option2"
                           placeholder="Enter 2nd Option" required>
                    <label for="option3">Option:3</label>
                    <input name="option3" type="text" class="form-control" id="option3"
                           placeholder="Enter 3rd Option" required>
                </div>

                <%-- 2 options beacause Quetype selected as True / False --%>
                <div class="form-group" id="options-2">
                    <label for="optionT">Option:1</label>
                    <input name="optT" type="text" value="True" class="form-control" id="optionT"
                           required disabled>
                    <label for="optionF">Option:2</label>
                    <input name="optF" type="text" value="False" class="form-control" id="optionF"
                           required disabled>
                </div>

                <div class="form-group">
                    <label for="answer">Answer</label>
                    <input name="answer" type="text" class="form-control" id="answer"
                           placeholder="Enter Answer" required>
                </div>
                <br>
                <div class="container text-center" id="loader3" style="display: none;">
                    <span class="fa fa-refresh fa-spin fa-4x"></span>
                    <h4>Please wait..</h4>
                </div>
                <div class="container text-center">
                    <button type="submit" id="submit-btn3" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>
    </div>
</div>