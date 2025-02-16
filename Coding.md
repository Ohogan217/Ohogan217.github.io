<html>
  <head>
    <link rel="stylesheet" href="Mystyle.css">
  </head>
  <script>
  function openPage(pageName, elmnt, color) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }
  document.getElementById(pageName).style.display = "block";

  elmnt.style.backgroundColor = color;
  
  }
  </script>
## Software Projects
<div class="btn-group">
<button class="tablink" onclick="openPage('1', this, '#78A1BF')"id = "defaultOpen>Popliteal Stent</button>
<button class="tablink" onclick="openPage('2', this, '#78A1BF')" ">Electrodeposition System</button>
<button class="tablink" onclick="openPage('3', this, '#78A1BF')">Guitar Strummer</button>
<button class="tablink" onclick="openPage('4', this, '#78A1BF')">Mars Rover Wheel</button>
<button class="tablink" onclick="openPage('5', this, '#78A1BF')">Toy Boat</button>
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
