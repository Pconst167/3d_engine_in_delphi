unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , Math, OpenGL, ComCtrls, Menus;

type
  Tfmain = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    Splitter1: TSplitter;
    GroupBox5: TGroupBox;
    mapxy: TPaintBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    Label7: TLabel;
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    Reset1: TMenuItem;
    OpenMap1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    fscreen: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  TOTAL_OBJ = 100;
  MAX_OBJ_VERTICES = 20;

  
  type tmap = record
    total_objs : integer;
  end;


  type t3vertex = record
    x, y, z : real;
  end;

  type t2vertex = record
    x, y : real;
    distance_vertex_intersection : real;
    distance_vertex_camera : real;
    distance_camera_intersection : real;
    angle : real;
  end;

  type tobj = record
    _3vertices : array[0..MAX_OBJ_VERTICES - 1] of t3vertex;
    _2vertices : array[0..MAX_OBJ_VERTICES - 1] of t2vertex;
    nbr_vertices : integer;
    color : tcolor;
    solid : boolean;
  end;


  type tcamera = record
    x, y, z : real;
    r : real;
    phi, theta, eta : real; // eta is the angle of rotation around the view vector
    vx, vy, vz : real;
    yveloc : real;
    jumping : boolean;
  end;






var
  fmain: Tfmain;
  objs : array[0..TOTAL_OBJ] of tobj;
  camera : tcamera;
  screen, final_screen : tbitmap;
  mapscreen : tbitmap;

  SCREEN_WIDTH : real;
  SCREEN_HEIGHT : real;
  final_screen_width : real;
  final_screen_height : real;
  DISTANCE_CAMERA_SCREEN_SIDE : real;
  DISTANCE_CAMERA_SCREEN_CENTRE : real;
  ANGLE_OF_VISION : real;
  HALF_ANGLE_OF_VISION : real;
  MAX_VIEWING_DISTANCE : real;
  SPEED : real;

  ux, uy, uz : real; // plane span 1
  nx, ny, nz : real; // plane span 2

  oldx, oldy : integer;
  mouse_counter : integer;

  oldwidth, oldheight : integer;

  clock : longint;
implementation

{$R *.dfm}

procedure SetScreenResolution(const width, height, colorDepth : integer); overload;
var
	mode:TDevMode;
begin
	zeroMemory(@mode, sizeof(TDevMode));
	mode.dmSize := sizeof(TDevMode);
  	mode.dmPelsWidth := width;
  	mode.dmPelsHeight := height;
  	mode.dmBitsPerPel := colorDepth;
  	mode.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL;
  	ChangeDisplaySettings(mode, 0);
end;

procedure Tfmain.FormCreate(Sender: TObject);
var
  i, j, k : integer;
begin
  

   
  DISTANCE_CAMERA_SCREEN_CENTRE := 25;
  ANGLE_OF_VISION := pi/2;
  SPEED := 5;
  MAX_VIEWING_DISTANCE := 10000;

  screen := tbitmap.create;
  screen.canvas.Pen.color := clblack;
  screen.Canvas.Brush.color := clteal;

  final_screen := tbitmap.create;
  final_screen.canvas.Pen.color := clblack;
  final_screen.Canvas.Brush.color := clteal;

  mapscreen := tbitmap.create;
  mapscreen.width := fmain.mapxy.width;
  mapscreen.height := fmain.mapxy.height;
  mapscreen.canvas.Pen.color := clwhite;
  mapscreen.Canvas.Brush.color := clblack;

  camera.phi := pi/2;
  camera.theta := 0;
  camera.y := 0;
  camera.x := 0;
  camera.z := 50;

  randomize;
  j := 0;
  k := 0;
  for i := 0 to 98 do
  begin
    objs[i].solid := true;
    objs[i].color := rgb(random(256), random(256), random(256));
    objs[i].nbr_vertices := 4;
    objs[i]._3vertices[0].x := 1*i* cos(2*pi*i/100);
    objs[i]._3vertices[0].y := 1*i* sin(2*pi*i/100);
    objs[i]._3vertices[0].z := i;
    objs[i]._3vertices[1].x := 1*i* cos(2*pi*i/100) + 25;
    objs[i]._3vertices[1].y := 1*i* sin(2*pi*i/100);
    objs[i]._3vertices[1].z := i;
    objs[i]._3vertices[2].x := 1*i* cos(2*pi*i/100) + 25;
    objs[i]._3vertices[2].y := 1*i* sin(2*pi*i/100) + 25;
    objs[i]._3vertices[2].z := i;
    objs[i]._3vertices[3].x := 1*i* cos(2*pi*i/100);
    objs[i]._3vertices[3].y := 1*i* sin(2*pi*i/100) + 25;
    objs[i]._3vertices[3].z := i;

    j := j + 1;
    if j = 5 then
    begin
      k := k + 1;
      j := 0;
    end;
  end;

  objs[99].nbr_vertices := 4;
  objs[99]._3vertices[0].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[0].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[0].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE * cos(camera.phi);
  objs[99]._3vertices[1].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE*2 * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[1].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE*2 * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[1].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE*2 * cos(camera.phi);
  objs[99]._3vertices[2].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[2].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[2].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE * cos(camera.phi);
  objs[99]._3vertices[3].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE*2 * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[3].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE*2 * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[3].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE*2 * cos(camera.phi);
end;

procedure read_keyboard();
begin
  if fmain.checkbox1.checked then
  begin
    if mouse_counter = 0 then
  begin
    oldx := mouse.CursorPos.X;
    oldy := mouse.CursorPos.y;
  end;

  mouse_counter := mouse_counter + 1;
  if mouse_counter = 2 then
  begin
    if mouse.CursorPos.x <> oldx then
      camera.theta := camera.theta + 2*pi*((mouse.cursorpos.x - oldx) / screen.width);
    if mouse.CursorPos.y <> oldx then
      camera.phi := camera.phi + 2*pi*((mouse.cursorpos.y - oldy) / screen.height);

    mouse_counter := 0;
  end;
  end;

    


  if getkeystate(vk_space) < 0 then
  begin
    if camera.z <= 50 then
      camera.yveloc := 12;
  end;
  if getkeystate($57) < 0 then
    begin
      camera.x := camera.x + SPEED * cos(camera.theta);
      camera.y := camera.y + SPEED * sin(camera.theta);
    //  camera.z := camera.z + SPEED * cos(camera.phi);
    end;
    if getkeystate($53) < 0 then
    begin
      camera.x := camera.x - SPEED * cos(camera.theta);
      camera.y := camera.y - SPEED * sin(camera.theta);
    //  camera.z := camera.z - SPEED * cos(camera.phi);
    end;
    if (getkeystate(VK_DOWN) < 0) then
    begin
      //if camera.phi + 0.01 <= pi then
        camera.phi := camera.phi + 0.025;
    end;
    if (getkeystate(VK_UP) < 0) then
    begin
      //if camera.phi - 0.01 >= 0 then
        camera.phi := camera.phi - 0.025;
    end;
    if getkeystate(VK_SHIFT) < 0 then
    begin
      if getkeystate(VK_LEFT) < 0 then
      begin
        camera.eta := camera.eta - 0.025;
      end;
      if getkeystate(VK_RIGHT) < 0 then
      begin
        camera.eta := camera.eta + 0.025;
      end;
    end
    else
    begin
      if getkeystate(VK_LEFT) < 0 then
      begin
        camera.theta := camera.theta - 0.025;
      end;
      if getkeystate(VK_RIGHT) < 0 then
      begin
        camera.theta := camera.theta + 0.025;
      end;
    end;

    if getkeystate($41) < 0 then
    begin
      camera.x := camera.x - SPEED * nx;
      camera.y := camera.y - SPEED * ny;
      camera.z := camera.z - SPEED * nz;
    end;
    if getkeystate($44) < 0 then
    begin
      camera.x := camera.x + SPEED * nx;
      camera.y := camera.y + SPEED * ny;
      camera.z := camera.z + SPEED * nz;
    end;
  
    if getkeystate($51) < 0 then
    begin
      camera.x := camera.x - SPEED * ux;
      camera.y := camera.y - SPEED * uy;
      camera.z := camera.z - SPEED * uz;
    end;
    if getkeystate($45) < 0 then
    begin
      camera.x := camera.x + SPEED * ux;
      camera.y := camera.y + SPEED * uy;
      camera.z := camera.z + SPEED * uz;
    end;

    if getkeystate($46) < 0 then
    begin
    
    end;

  SPEED := fmain.trackbar2.position;
  DISTANCE_CAMERA_SCREEN_CENTRE := fmain.trackbar1.position;
  ANGLE_OF_VISION := (fmain.trackbar3.position / 360) * 2 * pi;
  HALF_ANGLE_OF_VISION := ANGLE_OF_VISION / 2;
  MAX_VIEWING_DISTANCE := fmain.trackbar4.position;
  SCREEN_WIDTH := 2 * DISTANCE_CAMERA_SCREEN_CENTRE * abs( tan(HALF_ANGLE_OF_VISION) );
  SCREEN_HEIGHT := 2 * DISTANCE_CAMERA_SCREEN_CENTRE * abs( tan(HALF_ANGLE_OF_VISION) );
  DISTANCE_CAMERA_SCREEN_SIDE := DISTANCE_CAMERA_SCREEN_CENTRE / abs( cos(HALF_ANGLE_OF_VISION) );
end;

procedure draw_maps();
var
  i, j : integer;
begin
    mapscreen.canvas.Brush.color := clblack;
    mapscreen.canvas.FillRect(rect(0, 0, mapscreen.width, mapscreen.height));
    mapscreen.canvas.Pen.color := clwhite;

    // draw field of view lines
    mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x), mapscreen.height div 2 - round(camera.y)),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta - HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta - HALF_ANGLE_OF_VISION)))
      ]);

    mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x), mapscreen.height div 2 - round(camera.y)),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION)))
      ]);


    // draw projection plane
    mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta - HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta - HALF_ANGLE_OF_VISION))),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION)))
      ]);


    // draw max viewing distance plane
    mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION))),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION) + cos(camera.theta+HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION) +
        sin(camera.theta+HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)))
      ]);
    mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta - HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta - HALF_ANGLE_OF_VISION))),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta - HALF_ANGLE_OF_VISION) + cos(camera.theta-HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta - HALF_ANGLE_OF_VISION) +
        sin(camera.theta-HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)))
      ]);
      mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION))),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION) + cos(camera.theta+HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION) +
        sin(camera.theta+HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)))
      ]);
    mapscreen.canvas.Polygon([
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta + HALF_ANGLE_OF_VISION) + cos(camera.theta+HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta + HALF_ANGLE_OF_VISION) +
        sin(camera.theta+HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION))),
      point(mapscreen.width div 2 + round(camera.x + DISTANCE_CAMERA_SCREEN_SIDE * cos(camera.theta - HALF_ANGLE_OF_VISION) + cos(camera.theta-HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)),
        mapscreen.height div 2 - round(camera.y + DISTANCE_CAMERA_SCREEN_SIDE * sin(camera.theta - HALF_ANGLE_OF_VISION) +
        sin(camera.theta-HALF_ANGLE_OF_VISION)*MAX_VIEWING_DISTANCE/cos(HALF_ANGLE_OF_VISION)))
      ]);





    


    // draw xy axis
    mapscreen.canvas.Pen.color := clblue;
    mapscreen.canvas.MoveTo(0, mapscreen.height div 2);
    mapscreen.canvas.lineTo(mapscreen.width, mapscreen.height div 2);
    mapscreen.canvas.MoveTo(mapscreen.width div 2, 0);
    mapscreen.canvas.lineTo(mapscreen.width div 2, mapscreen.height);
  // draw mapscreen objects
    mapscreen.canvas.Pen.color := clwhite;
    for i := 0 to TOTAL_OBJ - 1 do
      for j := 0 to objs[i].nbr_vertices - 2 do
      begin     
        mapscreen.Canvas.MoveTo(mapscreen.Width div 2 + round(objs[i]._3vertices[j].x), mapscreen.height div 2 - round(objs[i]._3vertices[j].y));
        mapscreen.Canvas.lineTo(mapscreen.Width div 2 + round(objs[i]._3vertices[j + 1].x),  mapscreen.height div 2 - round(objs[i]._3vertices[j + 1].y));
      end;    
end;

procedure update_info();
begin
  fmain.labelededit1.Text := floattostr(round(camera.x)) + ', ' + floattostr(round(camera.y)) + ', ' + floattostr(round(camera.z)) + ', ' + floattostr(round(sqrt(camera.x*camera.x + camera.y*camera.y + camera.z*camera.z)));
  fmain.labelededit2.Text := 'Theta: ' + inttostr(round(360 * camera.theta / (2*pi)) mod 360) + ', Phi: ' + inttostr(round(360 * camera.phi / (2*pi)) mod 360);

  fmain.labelededit3.Text := floattostr(round(camera.vx)) + ', ' + floattostr(round(camera.vy)) + ', ' + floattostr(round(camera.vz));

  fmain.labelededit4.Text := floattostr(round(1000*ux)) + ', ' + floattostr(round(1000*uy)) + ', ' + floattostr(round(1000*uz));
  fmain.labelededit5.Text := floattostr(round(1000*nx)) + ', ' + floattostr(round(1000*ny)) + ', ' + floattostr(round(1000*nz));
end;

function dot(a, b, c, x, y, z : real) : real;
begin
  result := a * x + b * y + c * z;
end;

function length(x, y, z : real) : real;
begin
  result := sqrt(x*x + y*y + z*z);
end;

procedure draw_perspective();
var
  i, j, k : integer;

  len : real; // vector length

  uux, uuy, uuz : real;
  nnx, nny, nnz : real;

  t : real;
  ax, ay, az : real;
  verx, very, verz : real;
  px, py, pz : real;
  inter_x, inter_y, inter_z : real;
  centre_to_inter_x, centre_to_inter_y, centre_to_inter_z : real;
  xx, yy : real;
  vertex_anglex, vertex_angley : real;
  cosine : real;
  angle : real;

  distance_vertex_intersection : real;
  distance_camera_intersection : real;
  distance_vertex_camera : real;

  within_bounds : boolean;
begin
{

        n
        n
        n
        n
        n
          u u u u u
       v
      v
     v
    v

}
  screen.width := fmain.fscreen.width;
  screen.height := fmain.fscreen.Height;
  screen.canvas.fillrect(rect(0, 0, screen.width, screen.height));

  // lets find the vision angle vector
  camera.vx := DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * cos(camera.theta);
  camera.vy := DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * sin(camera.theta);
  camera.vz := DISTANCE_CAMERA_SCREEN_CENTRE * cos(camera.phi);

  // now lets calculate the first perpendicular vector (u) by doing a dot product with the view vector
  // for this vector we want the Z component to be 0 so that it is parallel top the ground.
  // the Y component can be anything, and then we find the X component
  // we will use this vector and the one perpendicular to it as a building set for the actual vectors we will use
  // as the vectors we use to calculate distances inside the vision plane
  uz := 0;
  if cos(camera.theta) >= 0 then
  begin
    uy := 1;
    ux := -camera.vy/camera.vx;
  end
  else
  begin
    uy := -1;
    ux := camera.vy/camera.vx;
  end;
  // and convert it into a unit vector
  len := length(ux, uy, uz);
  ux := ux / len;
  uy := uy / len;
  uz := uz / len;

  // now calculate the second perpendicular to the view vector by taking the cross product
  nx := uz*camera.vy - uy*camera.vz;
  ny := ux*camera.vz - uz*camera.vx;
  nz := uy*camera.vx - ux*camera.vy;
  // and convert it into a unit vector
  len := length(nx, ny, nz);
  nx := nx/len;
  ny := ny/len;
  nz := nz/len;

  // we now build the actual vectors we use inside the plane by using the previous two vectors as building vectors
  // we do this so that we can freely choose 2 vectors based on the angle eta.
  uux := ux * cos(camera.eta) + nx * sin(camera.eta);
  uuy := uy * cos(camera.eta) + ny * sin(camera.eta);
  uuz := uz * cos(camera.eta) + nz * sin(camera.eta);
  nnx := ux * cos(camera.eta + pi/2) + nx * sin(camera.eta + pi/2);
  nny := uy * cos(camera.eta + pi/2) + ny * sin(camera.eta + pi/2);
  nnz := uz * cos(camera.eta + pi/2) + nz * sin(camera.eta + pi/2);

  // camera coordinates
  px := camera.x;
  py := camera.y;
  pz := camera.z;

  // vision plane centre
  ax := px + camera.vx;
  ay := py + camera.vy;
  az := pz + camera.vz;
      
  // now we find the intersection of each vertex with the vision plane
  for i := 0 to TOTAL_OBJ - 1 do
  if length(objs[i]._3vertices[0].x - camera.x, objs[i]._3vertices[0].y - camera.y, objs[i]._3vertices[0].z - camera.z) <= 5000 then
  begin
    for j := 0 to objs[i].nbr_vertices - 1 do
    begin
      // current vertex coordinates
      verx := objs[i]._3vertices[j].x;
      very := objs[i]._3vertices[j].y;
      verz := objs[i]._3vertices[j].z;

      // parameter for line from camera to current vertex
      t := ( camera.vx*sin(camera.phi)*cos(camera.theta) + camera.vy*sin(camera.phi)*sin(camera.theta) + camera.vz*cos(camera.phi) )
           / ( (verx - px) * sin(camera.phi)*cos(camera.theta) + (very - py)*sin(camera.phi)*sin(camera.theta) + (verz - pz)*cos(camera.phi) );

      // this is the intersection point on the plane
      inter_x := px + (verx - px) * t;
      inter_y := py + (very - py) * t;
      inter_z := pz + (verz - pz) * t;

      // this is a vector from the plane centre to the intersection point on the plane
      centre_to_inter_x := inter_x - ax;
      centre_to_inter_y := inter_y - ay;
      centre_to_inter_z := inter_z - az;

      // now we need to find the lengths of both components of the inside vector
      // and check if they are within the bounds of the plane
      // to do this we take the dot product between the unit vectors which span the vision plane
      //and the vectors from the plane centre to the intersection
      xx := dot(centre_to_inter_x, centre_to_inter_y, centre_to_inter_z, uux, uuy, uuz);
      yy := dot(centre_to_inter_x, centre_to_inter_y, centre_to_inter_z, nnx, nny, nnz);

      // distances
      distance_vertex_intersection := length(verx - inter_x, very - inter_y, verz - inter_z);
      distance_camera_intersection := length(inter_x - px, inter_y - py, inter_z - pz);
      distance_vertex_camera := length(verx - px, very - py, verz - pz);
      // cosine between viewing vector and vertex vector to check if the vertex is within field of view (a circle)
      cosine := dot(camera.vx, camera.vy, camera.vz, verx-px, very-py, verz-pz) / (length(camera.vx, camera.vy, camera.vz) * length(verx-px, very-py, verz-pz));
      angle := arccos(cosine);
      
      objs[i]._2vertices[j].x := xx / (SCREEN_WIDTH / 2);
      objs[i]._2vertices[j].y := yy / (SCREEN_HEIGHT / 2);
      objs[i]._2vertices[j].distance_vertex_intersection := distance_vertex_intersection;
      objs[i]._2vertices[j].distance_camera_intersection := distance_camera_intersection;
      objs[i]._2vertices[j].distance_vertex_camera := distance_vertex_camera;
      objs[i]._2vertices[j].angle := angle;
    end;


    within_bounds := true;
    for k := 0 to objs[i].nbr_vertices - 1 do
    begin
      if ( objs[i]._2vertices[k].distance_vertex_camera < objs[i]._2vertices[k].distance_camera_intersection)
        or ( objs[i]._2vertices[k].distance_vertex_intersection > MAX_VIEWING_DISTANCE)
        or ( abs(objs[i]._2vertices[k].angle) > HALF_ANGLE_OF_VISION)
      then
      begin
        within_bounds := false;
        break;
      end;
    end;
    if within_bounds then
    begin
      screen.canvas.brush.color := objs[i].color;
      screen.canvas.pen.color := objs[i].color;
        screen.canvas.Polygon([
          point(
            screen.width div 2 + round( (screen.width/2) * objs[i]._2vertices[0].x ),
            screen.height div 2 - round( (screen.height/2) * objs[i]._2vertices[0].y )
          ),
          point(
            screen.width div 2 + round( (screen.width/2) * objs[i]._2vertices[1].x ),
            screen.height div 2 - round( (screen.height/2) * objs[i]._2vertices[1].y )
          ),
          point(
            screen.width div 2 + round( (screen.width/2) * objs[i]._2vertices[2].x ),
            screen.height div 2 - round( (screen.height/2) * objs[i]._2vertices[2].y )
          ),
          point(
            screen.width div 2 + round( (screen.width/2) * objs[i]._2vertices[3].x ),
            screen.height div 2 - round( (screen.height/2) * objs[i]._2vertices[3].y )
          )
        ]);
    end;
  end;
  
   screen.canvas.brush.color := clwhite;
end;

procedure process_physics();
begin
  camera.z := camera.z + camera.yveloc;
  if camera.z > 50 then
    camera.yveloc := camera.yveloc - 0.3;
  if camera.z < 50 then camera.z := 50;
end;

procedure animate();
var
  i, j, k : integer;
begin

  
end;





procedure Tfmain.FormActivate(Sender: TObject);
var
  i, j, k : integer;
  x, y, z : real;
begin
  oldheight := screen.Height;
  oldwidth := screen.Width;
	//SetScreenResolution(800, 600, 16);
     
  while not Application.Terminated do
  begin
    clock := clock + 1;
    read_keyboard();

    animate();
    //process_physics();
    draw_maps();
    draw_perspective();  
    update_info();


  objs[99]._3vertices[0].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[0].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[0].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE * cos(camera.phi) + 100;
  objs[99]._3vertices[1].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE*5 * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[1].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE*5 * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[1].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE*5 * cos(camera.phi) + 100;
  objs[99]._3vertices[2].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[2].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[2].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE * cos(camera.phi) + 100;
  objs[99]._3vertices[3].x := camera.x + DISTANCE_CAMERA_SCREEN_CENTRE*5 * sin(camera.phi) * cos(camera.theta);
  objs[99]._3vertices[3].y := camera.y + DISTANCE_CAMERA_SCREEN_CENTRE*5 * sin(camera.phi) * sin(camera.theta);
  objs[99]._3vertices[3].z := camera.z + DISTANCE_CAMERA_SCREEN_CENTRE*5 * cos(camera.phi) + 100;

{
    j:=0;
    k:=0;
    for i := 0 to TOTAL_OBJ - 1 do
    begin

      x := objs[i]._3vertices[0].x * cos(pi/100) - objs[i]._3vertices[0].y * sin(pi/100);
      y := objs[i]._3vertices[0].x * sin(pi/100) + objs[i]._3vertices[0].y * cos(pi/100);
      objs[i]._3vertices[0].x := x;
      objs[i]._3vertices[0].y := y;
      x := objs[i]._3vertices[1].x * cos(pi/100) - objs[i]._3vertices[1].y * sin(pi/100);
      y := objs[i]._3vertices[1].x * sin(pi/100) + objs[i]._3vertices[1].y * cos(pi/100);
      objs[i]._3vertices[1].x := x;
      objs[i]._3vertices[1].y := y;
      x := objs[i]._3vertices[2].x * cos(pi/100) - objs[i]._3vertices[2].y * sin(pi/100);
      y := objs[i]._3vertices[2].x * sin(pi/100) + objs[i]._3vertices[2].y * cos(pi/100);
      objs[i]._3vertices[2].x := x;
      objs[i]._3vertices[2].y := y;
      x := objs[i]._3vertices[3].x * cos(pi/100) - objs[i]._3vertices[3].y * sin(pi/100);
      y := objs[i]._3vertices[3].x * sin(pi/100) + objs[i]._3vertices[3].y * cos(pi/100);
      objs[i]._3vertices[3].x := x;
      objs[i]._3vertices[3].y := y;

      j := j + 1;
      if j = 25 then
      begin
        k := k + 1;
        j := 0;
      end;
    end;}


    

    fmain.fscreen.canvas.Draw(0, 0, screen);
    fmain.mapxy.canvas.Draw(0, 0, mapscreen);
    application.ProcessMessages;
  end;

end;

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure Tfmain.FormDestroy(Sender: TObject);
begin
   SetScreenResolution(oldwidth, oldheight, 32);
end;



end.
