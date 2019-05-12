# 2D game editor
<h3>Shortcuts</h3>

<table>
  <tr>
    <td>Z/Y</td>
    <td>block</td>
  </tr>
  <tr>
    <td>X</td>
    <td>spike</td>
  </tr>
  <tr>
    <td>C</td>
    <td>checkpoint/finish</td>
  </tr>
  <tr>
    <td>V</td>
    <td>invisible block</td>
  </tr>
  <tr>
    <td>B</td>
    <td>jumppad</td>
  </tr>
  <tr>
    <td>N</td>
    <td>enemy</td>
  </tr>
  <tr>
    <td>Space</td>
    <td>generate .txt file</td>
  </tr>
</table>

<h3>Structure of .txt file</h3>
Every block has 7 parameters and every parameter is on 1 line <br>
Parameters:
<table>
  <tr>
    <td>x</td>
    <td>x-position</td>
  </tr>
  <tr>
    <td>y</td>
    <td>y-position</td>
  </tr>
  <tr>
    <td>width</td>
    <td>width if the block</td>
  </tr>
  <tr>
    <td>height</td>
    <td>height of the block</td>
  </tr>
  <tr>
    <td>type</td>
    <td>type of block (jumppad, spike etc.) (/other)</td>
  </tr>
  <tr>
    <td>type of dirt block</td>
    <td>there are 15 types of block (/dirt)</td>
  </tr>
  <tr>
    <td>rotation of dirt block</td>
    <td>0-3, rotation = rotate[x][y] * PI/2</td>
  </tr>
</table>
