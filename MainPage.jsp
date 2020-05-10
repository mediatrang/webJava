<%-- 
    Document   : MainPage
    Created on : Mar 7, 2020, 12:07:47 AM
    Author     : ASUS
--%>



<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="item.*" %>

<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type ="text/css">
            body{
                background-image: url("https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2018/11/K3A5136_1.jpg?resize=1500%2C994&ssl=1")
                       
            }
            h1{
                position:inherit;
                color: red;
                margin: 5px;
                background-color: black;
            }
            #head{
               padding: 5px;
               background-color: black;
               height: 80px;
            }
            .button_menuBar{
                font-size: 24px;
                font-family: '21st Century', fantasy;
                background-color: orange;
                height:65px;
                margin-left: 10px;
                margin-right: 10px;
                padding: 15px 15px;
                align-items: center;
            }
            .button_item{
                padding:10px;
                width: 260px;
                
                margin: 20px;
            }
            .menu_field{
                margin: 100px;                
            }
            #image_main_page{
               
               height: 300px;
               background-color: whitesmoke;
            }
            .image_main{
                margin-left: 150px;
                margin_right:150px;
                margin-top: 50px;
            }
            #image_display{
                transition-duration: 2s;
            }
            </style>
    </head>
   
    <body >
           
        <div id="head">
        <h1> <a href ="/WebApplication1/MainPage.jsp">
                <image src="./image/logo.jpg" width ="50" height ="60" align ="left">
            </a> PHO LIEM
            <a href="/WebApplication1/InfoPage.html">
            <button class ="button_menuBar" type="button">
                Menu   
            </button></a>
        
            <% 
                Order shoppingCart = (Order)session.getAttribute("shoppingCart");
                if (shoppingCart == null){
                    shoppingCart = new Order();
                    session.setAttribute("shoppingCart", shoppingCart);
                out.println("</h1>"); }
                else out.println("<button class=\"button_menuBar\" type=\"button\">" +
                "Total $" +shoppingCart.getTotal() + "</button></h1>");
            %>
          
        </div> 
        <form method ="post" action="/WebApplication1/ServletItem">
            
            <p>
            <input type="text" maxlength ="25" name ="Search" value="">            
            <input type="button" value="Search" onClick="submit()"> </p>
           
            <p id ="image_main_page">               
             
            <img class ="image_main" name ="animation" src="./image/image_main_1.jpg" width = 1000 height = 200>
            
            <script>
            var aniframe = new Array(3);
            for( var i =0; i< aniframe.length; i++) {
                
                aniframe[i] = "./image/image_main_" +(i+1) +".jpg"; 
            }
            
            var frame =0;
            var timeout_id = null;           
            
            function animate(){
                document.animation.src = aniframe[frame];
                frame = (frame+1) %3;
                timeout_id = setTimeout(animate, 4000);
                
            }            
            onload = animate;
            </script>
            </p>
           
             <p class ="menu_field">            
                <%
                
                String dbDriverName = "org.apache.derby.jdbc.EmbeddedDriver";
                String protocol = "jdbc:derby://localhost:1527/Item";
                Connection conn = null ;
                
                ArrayList<ItemRecord> menu = new ArrayList<ItemRecord>(20);
                ItemRecord item;
             try{
                  Class.forName(dbDriverName).newInstance();
                  conn = DriverManager.getConnection(protocol,"trang","trang");  
                  for (int i = 0; i <ItemRecord.searchedMenu(conn, request.getParameter("Search")).size(); i++)
                  {            
                   item= ItemRecord.searchedMenu(conn, request.getParameter("Search")).get(i).clone();
                   menu.add(i,item);
                  }
                }
            catch(Exception e){}               
                
                for(int i = 0; i<menu.size(); i++){                    
            %>
               <button type ="submit" class ="button_item" name ="button_item" value="<%= menu.get(i).getImageName() %>">
                       <image src = " <%= "./image/"+menu.get(i).getImageName() %> " width =250 height =200>
                        <%= menu.get(i).getName() %><br/>                       
               </button>                                                
                       
            <%    
                if ((i==2)|((i>3) &&((i % 3)==2))) out.println("<br/>");
                }
            %>
           </p>
           
           
        </form>
    </body>
</html>
