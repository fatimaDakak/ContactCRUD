<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="ressources/css/Commandes.css" />

	<title>Ship From Store</title>
	 <link rel="icon" href="ressources/images/logo.png" type="image/x-icon">
     <style>
        .logo {
            width: 1000px; /* Ajustez la largeur souhaitée */
            height: 1000px; /* Ajustez la hauteur souhaitée */
            transform: scale(100);
        }
    </style>
	<link rel="stylesheet" type="text/css" href="style.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

 <style>
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background-color: transparent;
            color: #000;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            min-width: 200px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: #000;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #b70f0a;
            color: white;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover .dropbtn {
            background-color: #f1f1f1;
        }
        table th {

  background-color: #b70f0a;
color :white;
}
.sidebar {
    width: 20%;
    position: fixed; /* Change to fixed position */
    top: 0; /* Align to the top of the page */
    left: 0; /* Align to the left of the page */
    background: var(--blue);
    height: 100vh;
    overflow-y: auto; /* Enable vertical scrolling */
    z-index: 1; /* Ensure sidebar is above other elements */
}

.main {
    width: 75%;
    float: right; /* Adjust the width of the main content */
    height: 90vh;
    padding: 30px;
    margin-left: 20%; /* Account for the width of the sidebar */
}

    </style>

</head>
<body>
<sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/projet"
        user="root" password=""
    />
     
    <sql:query var="listUsers"   dataSource="${myDS}">
        SELECT * FROM commande where status ='traite' and checked='0';
    </sql:query>
<section>
	<div class="sidebar">
		<div class="menu-logo">
                <img src="ressources/images/logo.png" alt="logo">
            </div>

		<ul class="nav">
            <li><a href="accueil"><i class="fa fa-window-restore"></i> Acceuil</a></li>
            <li  class="active"><a href="CommandesALivrer"><i class="fa fa-truck"></i> Commandes à livrer</a></li> 
             <li ><a href="ConfirmLivraison"><i class="fa fa-check"></i> Confirmation de livraison</a></li>     
        </ul>
        
			<!-- <li><a href="#"><i class="fa fa-pie-chart"></i> Statistic</a></li>
			<li><a href="#"><i class="fa fa-cube"></i> Product</a></li> -->
			<!-- <li><a href="#"><i class="fa fa-cubes"></i> Stock</a></li> -->

			<ul class="social">
  <li><a href="accueil"><i class="fa fa-power-off"></i>Déconnexion</a></li>
</ul>	
	</div>
	<div class="main">
		
		<div class="head-section">
			<div class="col-6">
        <h2>Bienvenue <%= session.getAttribute("prenom") %></h2>
			</div>

			<div class="col-6" style="text-align: right;">
 <div class="dropdown">
                    <button class="dropbtn">
                        <i class="fa fa-bell"></i>
                        <span class="badge">${listUsers.rowCount}</span>
                    </button>
                    <div class="dropdown-content">
                        <c:forEach var="row" items="${listUsers.rows}">
                            <a >Nouvelle commande à livrer à <strong>${row.client}</strong></a>
                        </c:forEach>
                    </div>
                </div>            <i class="user">
      <%= session.getAttribute("prenom") %> <%= session.getAttribute("prenom") %> 
                </i> 
			</div>
			<div class="clearfix"></div>
		</div>

		<br><br>
		<div class="content">
		<p>Commandes à livrer</p><br><br>
<table id="myTable">
  
  <thead>
    <tr>
      <th scope="col" width="100px">Référence du colis </th>
      <th scope="col" width="100px"> Localité </th>
      <th scope="col"  width="100px">Nom Client </th>
      <th scope="col"  width="120px">Num tel client </th>
      <th scope="col"  width="50px"> </th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="row" items="${listUsers.rows}">
					<tr id="${row.id}" >
					    <td>${row.ref_produit}</td>
						<td>${row.localite} </td>
						<td>${row.client} </td>
						<td>${row.tel} </td>	
					 <td>
					    <form action="CommandesALivrer" method="post">
					        <input type="hidden" name="rowId" value="${row.id}">
					        <input type="hidden" name="userId" value="${sessionScope.id}">
					        <button id="status-btn" type="submit">
					          Check
					        </button>
					      </form>
					</td >
					</tr>
	</c:forEach>
  
        <tbody>
  </tbody>
  
</table>
		</div>
	</div>
</section>
<script>
    function deleteRow(row) {
      swal({
        title: "Êtes-vous sûr?",
        text: "Vous confirmez votre choix!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Oui, confirmer!",
        cancelButtonText: "Annuler",
        closeOnConfirm: false
      },
      function(){
        var i = row.parentNode.parentNode.rowIndex;
        document.getElementById("myTable").deleteRow(i);
        swal("Supprimée!", "La commande a été supprimée.", "success");
      });
    }
</script>
</body>
</html>