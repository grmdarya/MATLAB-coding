global c N  x y z   ax ay az    Nx Ny Nz    Px Py Pz    Ix Iy Iz
global PxIx  PyIy  PzIz  H_x  H_x_n  H_conv_x  H_y  H_y_n  H_conv_y  H_z  H_z_n  H_conv_z
global Xaffman_x  Xaffman_y  Xaffman_z  L_x  e_x  L_y  e_y  L_z  e_z  R_x  R_y  R_z
global X_l  Y_l  Z_l  Px_s  Py_s  Pz_s  ax_s  ay_s  az_s  Cx  Cy  Cz  % _s(sorting)
global Gilbert_x  Gilbert_y  Gilbert_z  Code_x  Code_y  Code_z

[ c N x y z ] = ReadFromFile;
%--------------------------------------------------------------------------
% Частота появления символов
% Подсчёт энтропии (n-мерная, средняя, условная), определение информационных характеристик источника
[ ax, Nx, Px, Ix, PxIx ] = statistics_x( x, N ); %частота появления
[ H_x, H_x_n, H_conv_x] = f_H_x(PxIx);		 % энтропия
[ ay, Ny, Py, Iy, PyIy ] = statistics_y( y, N );
[ H_y, H_y_n, H_conv_y] = f_H_y(PyIy, H_conv_x);
[ az, Nz, Pz, Iz, PzIz ] = statistics_z( z, N );
[ H_z, H_z_n, H_conv_z] = f_H_z(PzIz, H_conv_x, H_conv_y);

WriteToFileX( ax, Nx, Px, Ix, PxIx );
WriteToFileY( ay, Ny, Py, Iy, PyIy );
WriteToFileZ( az, Nz, Pz, Iz, PzIz );
WriteToFile_H(H_x, H_x_n, H_conv_x, H_y, H_y_n, H_conv_y, H_z, H_z_n, H_conv_z);
%--------------------------------------------------------------------------
% Кодирование методом Хаффмана
[ Xaffman_x ] = Xaffman_coder(Nx);
[ Xaffman_y ] = Xaffman_coder(Ny);
[ Xaffman_z ] = Xaffman_coder(Nz);
[ L_x, e_x, R_x, L_y, e_y, R_y, L_z, e_z, R_z ] = LEN( Xaffman_x, Xaffman_y, Xaffman_z, Nx, Px, e_x, R_x, Ny, Py, e_y, R_z, Nz, Pz, e_z, R_z );
WriteToFileXaffman( Xaffman_x, Xaffman_y, Xaffman_z, ax, Px, L_x, e_x, R_x, ay, Py, L_y, e_y, R_y, az, Pz, L_z, e_z, R_z );
%--------------------------------------------------------------------------
% Кодирование методом Шеннона
[ Px_s, ax_s] = sorting( Px, ax);
[ Py_s, ay_s] = sorting_2( Py, ay);
[ Pz_s, az_s] = sorting_2( Pz, az);
[ X_l,  Cx ] = Shennon_coder(Px_s);
[ Y_l,  Cy ] = Shennon_coder(Py_s);
[ Z_l,  Cz ] = Shennon_coder(Pz_s);
WriteToFileShennon(Px_s, ax_s, X_l, Cx, Py_s, ay_s, Y_l, Cy, Pz_s, az_s, Z_l, Cz);
%--------------------------------------------------------------------------
% Кодирование методом Гилберта-Мура
[ Gilbert_x, Code_x] = Gilber_Moor(Px);
[ Gilbert_y, Code_y] = Gilber_Moor(Py);
[ Gilbert_z, Code_z] = Gilber_Moor(Pz);
WriteToFileGilbertMoor(Px, ax, Gilbert_x, Code_x, Py, ay, Gilbert_y, Code_y, Pz, az, Gilbert_z, Code_z);
%--------------------------------------------------------------------------
% Арифметическое кодирование
Arithmetic_coder(c, ax, Px, ay, Py, az, Pz);