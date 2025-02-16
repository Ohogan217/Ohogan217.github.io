<html>
  <head>
    <link rel="stylesheet" href="Mystyle.css">
  </head>
  <script>
  function openCity(evt, cityName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
} 
  </script>
## Software Projects
 <!-- Tab links -->
<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'London')">London</button>
  <button class="tablinks" onclick="openCity(event, 'Paris')">Paris</button>
  <button class="tablinks" onclick="openCity(event, 'Tokyo')">Tokyo</button>
</div>

<!-- Tab content -->
<div id="London" class="tabcontent">
  <h3>London</h3>
  <p>London is the capital city of England.</p>
</div>

<div id="Paris" class="tabcontent">
  <h3>Paris</h3>
  <p>Paris is the capital of France.</p>
</div>

<div id="Tokyo" class="tabcontent">
  <h3>Tokyo</h3>
  <p>Tokyo is the capital of Japan.</p>
</div> 


Here are some of the projects I've worked on, which showcase my skills and experience in various engineering domains.

### 1. [Project Name: Patience](https://github.com/Ohogan217/Ohogan217.github.io/tree/main/Patience)
Playable game of Patience (Solitatire) created using Java Object-Oreinted programing.

### 2. [Project Name: Hang Man](https://github.com/Ohogan217/Ohogan217.github.io/tree/main/Hangman)
Playable Hang Man game created using C programming

### 3. [Project Name: Biomedical Signal Processing Assignment](https://github.com/Ohogan217/Ohogan217.github.io/tree/main/Biosigs)
Matlab signal processing of biomedical signals, such as ECG, EMG and EEG. 

### 4. [Project Name: Modelling and Simulation Bridge Stress](https://github.com/Ohogan217/Ohogan217.github.io/tree/main/MandS)
Matlab modelled and simulated 3d stresses in bridge as a lorry drives over it.

### 5. [Project Name: Machine Learning Assignments](https://github.com/Ohogan217/Ohogan217.github.io/tree/main/ML)
Machine learning assignments that used Matlab to create algorithms from scratch to predict Parkinson's disease based on recorded force sensor data from individuals.

</html>
