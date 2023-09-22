<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="models.Contact" %>
  <%@ page import="java.util.*" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/em.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.10.2/lottie.min.js" integrity="sha512-fTTVSuY9tLP+l/6c6vWz7uAQqd1rq3Q/GyKBN2jOZvJSLC5RjggSdboIFL1ox09/Ezx/AKwcv/xnDeYN9+iDDA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Contact List</title>
</head>
<body>
    <!--navbar-->
     <nav class="navbar navbar-expand-lg navbar-light bg-light px-0 py-2 ">
  <div class="container-xl">
    
    <!-- Navbar toggle -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <!-- Collapse -->
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <!-- Nav -->
      <div class="navbar-nav mx-lg-auto">
        <a class="nav-item nav-link active" href="contacts">Contact List </a>
      </div>
     
    </div>
  </div>
</nav>
      <!--fin navbar-->
      
  
      <!--liste contact-->
<div class="container mt-5 d-flex flex-column">
   <div class="col-4 m-3">
          <!-- Button trigger modal -->

    <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#add">
      Ajouter Contact    </button>  
     </div>
<div class="m-2">
  <table class="table">
    <thead>
      <tr>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
        <th>Numéro de téléphone</th>
        <th>Adresse</th>
        <th>Modifier</th>
        <th>Supprimer</th>
      </tr>
    </thead>
    <tbody>

   <%
    ArrayList<Contact> contacts = (ArrayList<Contact>) request.getAttribute("contacts");
    if (contacts != null && !contacts.isEmpty()) {
        for (Contact contact : contacts) {
%>
 <!--Modal to delete-->
          <div class="modal fade" id="delete<%= contact.getId() %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Delete Contact</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form action="SupprimerContacts" method="post">
                    <input type="hidden" name="id_user" value="<%= contact.getId() %>"/>
                    <h5>Are you sure you want to delete this contact?</h5>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                    <input type="submit" class="btn btn-dark" name="submit" value="Delete">
                  </form>
                </div>
              </div>
            </div>
          </div>
   <!-- Fin delete modal -->
   
       <!--modal for editing a contact-->
   <div class="modal fade" id="edit<%= contact.getId() %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modifier contact</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form method="post" action="ModifierContacts" autocomplete="off">
        
          <label >Nom</label>
          <input type="text" class="form-control mb-2" name="nom" value="<%= contact.getNom() %>" >          
          <label >Prénom</label>
          <input type="text" class="form-control mb-2" name="prenom" value="<%= contact.getPrenom() %>">
          <label >Email</label>
          <input type="email" class="form-control mb-2" name="email" value="<%= contact.getEmail() %>">
          <label >Tél</label>
          <input type="tel" class="form-control mb-2" name="tel" value="<%= contact.getTel() %>">
          <label >Adresse</label>
          <input type="text" class="form-control mb-2" name="adresse" value="<%= contact.getAdresse() %>">
           <input type="hidden" name="id_user" value="<%= contact.getId() %>"/>
          
          <input type="submit" class="btn btn-dark" name="submit" value="Modifier">
        </form>
      </div>
     
    </div>
  </div>
</div>
   <!-- fin modal edit-->
            <tr>
                <td><%= contact.getNom() %></td>
                <td><%= contact.getPrenom() %></td>
                <td><%= contact.getEmail() %></td>
                <td><%= Integer.toString(contact.getTel()) %></td>
                <td><%= contact.getAdresse() %></td>
                <td> <a data-bs-toggle="modal" data-bs-target="#edit<%= contact.getId() %>">
                <i class="fa-solid fa-pen-to-square"></i>
                </td>
                <td>
                    <a data-bs-toggle="modal" data-bs-target="#delete<%= contact.getId() %>">
                        <i class="fa-solid fa-trash"></i>
                    </a>
                </td>
            </tr>
<%
        }
    } else {
%>
        <tr>
            <td colspan="5">No contacts found.</td>
        </tr>
<%
    }
%>
   
    
</tbody>
        

       
      <!--fin list cotact-->

      <!--modal for adding contact-->
   <div class="modal fade" id="add" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add contact</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form method="post" action="" autocomplete="off">
          <label >Nom</label>
          <input type="text" class="form-control mb-2" name="nom" >          
          <label >Prénom</label>
          <input type="text" class="form-control mb-2" name="prenom">
          <label >Email</label>
          <input type="email" class="form-control mb-2" name="email">
          <label >Tél</label>
          <input type="tel" class="form-control mb-2" name="tel">
          <label >Adresse</label>
          <input type="text" class="form-control mb-2" name="adresse">
          <input type="submit" class="btn btn-dark" name="submit" value="Send">
        </form>
      </div>
     
    </div>
  </div>
</div>

      </div>
    </div>
  </div>
</body>
</html>