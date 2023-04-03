package com.techquiz.servlets;

import com.techquiz.entities.Message;
import com.techquiz.entities.User;
import com.techquiz.helper.FactoryProvider;
import com.techquiz.helper.Helper;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "EditServlet", value = "/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = null;
        HttpSession httpSession = request.getSession();
        try {
            // fetch profile data to update
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String about = request.getParameter("about");
            Part part = request.getPart("image");
            String profile = part.getSubmittedFileName();
            System.out.println(profile.length());
            if(profile.trim().length()<=0){
                profile="default.png";
            }
            //fetch current user to update details
            User user = (User) httpSession.getAttribute("currentUser");
            session = FactoryProvider.getFactory().openSession();

            Transaction tx = session.beginTransaction();

            Query query = session.createQuery("update User set name=:name, email=:email, password=:password, about=:about, profile=:profile where id=:id");
            query.setParameter("name", name);
            query.setParameter("email", email);
            query.setParameter("password", password);
            query.setParameter("about", about);
            query.setParameter("profile", profile);
            query.setParameter("id", user.getId());

            query.executeUpdate();
            tx.commit();

            //updating current user who is already logged in
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            String oldProfile = user.getProfile();
            user.setProfile(profile);
            String newProfile = user.getProfile();
            System.out.println(oldProfile);
            System.out.println(newProfile);


            String oldProfilePath = request.getRealPath("/") + "pics" + File.separatorChar + oldProfile;
            String newProfilePath = request.getRealPath("/") + "pics" + File.separatorChar + newProfile;

            System.out.println(oldProfilePath);
            System.out.println(newProfilePath);

            if (newProfile.length()!=0) {
                if (oldProfile != "default.png") {
                    Helper.deleteFile(oldProfilePath);
                }
                Helper.saveFile(part.getInputStream(), newProfilePath);
            } else {
                Helper.saveFile(part.getInputStream(), oldProfilePath);
            }

            Message msg = new Message("Your profile has been updated successfully..!", "success", "alert-success");
            httpSession.setAttribute("msg", msg);
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            Message msg = new Message("Oops..! Email already in use, Try to edit again!", "error", "alert-danger");
            httpSession.setAttribute("msg", msg);
            response.sendRedirect("profile.jsp");
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
