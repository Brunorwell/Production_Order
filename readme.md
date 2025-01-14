<p width="100%" align="center">
<!-- a largura é 100%, pois representa a proporção completa da faixa superior do paragrafo -->
    <img src="./images/GitHub-Logo.png" width="200px">
</p>    
<!-- Usei barra antes do "p" para fechar paragrafo -->
<h1 id = "projectDescription" align="center">Production Order Data Base</h1>
<p>This project reproduce what already happens in the company that I currently work for. I realized that some sheets that I have to deal with are basically a database - You can even identify the primary and foreign keys playing their roles. I decided  to build a database that contains the same data presented in the sheets and the relationships between the tables. </p>


## Content Table

<ul>
    <li><a href = "#context">General Context</a></li>
    <li><a href = "databasedesign">Database Design</a></li>

</ul>

<br>
<h2 id="context"> General Context </h2>
<p>The Fini Company is a Spanish company that manufactures candies. There's a Brazilian branch where I work.<p>

<p>In my experience at the factory, I realized that a production order sheet, generated by the ERP system Protheus, is formed by the relationships between multiple tables.<p>

<p>I would like to define what Production Order stands for: Whenever, a product request is made, a sheet is generated with all information the machine operator needs, this includes requesting supplies from the logistic department, guiding the operator to label the packaging and knowing how much needs to be produced. <p>
<br>

<h2 id="databasedesign">The Database Design</h2>
<p>The database design is based on the relationships between the entities involved in the production order workflow. Since the production order itself is not organized as a database, it was necessary to identify all the entities related to the workflow and ensure that the structure has proper connections to better represent the business rules and preserve cohesion.<p>

<p>The following image represents the Entity Relationship Diagram (ERD) of the structure:   <p>
<img src="images/erd.jpeg" style-width: 100%; height: auto;>

