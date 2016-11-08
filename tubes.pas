{
  Bankel
  ------
  Tugas Besar Dasar Algoritma Pemrograman @ Universitas Telkom

  @author     Wisnu Adi Nurcahyo
  @nim        1301160479
  @class      IF40-04

  TODO
  ----
  1. Create procedure for display and ask the command
}

program bankel;

uses crt, sysutils;

type User = record
              id: Integer;
              fullname: String;
              career: String;
              balance: Integer;
              category: String;
            end;


//= HEAD SECTION
procedure head;
{ I.S: -
  F.S: Menampilkan header program Bankel }
begin
  clrscr;
  writeln ('Bankel');
  writeln ('======');
  writeln;
end;

//= ABOUT MSG
procedure about;
{ I.S: -
  F.S: Menampilkan pesan mengenai program Bankel }
begin
  head;
  writeln (' Tugas Besar Dasar Algoritma Pemrograman @ Universitas Telkom');
  writeln (' oleh Wisnu Adi Nurcahyo (1301160479) dari IF40-04.');
end;

//=
function askCommand:String;
var command: String;
begin
  writeln;
  writeln;
  write(' Perintah >>  ');
  readln(command);
  command := lowercase(command);

  askCommand := command;
end;

procedure displayMenu(space: String; menu: Array of String);
var i, j: Integer;
begin
  writeln;
  writeln(space, 'Daftar Perintah');
  writeln(space, '----------------');

  for i := 0 to (length(menu) - 1) do
  begin
    for j := 1 to (length(space) + 1) do
      write(space);
    writeln (menu[i]);
  end;
end;

procedure customerHead;
begin
  head;
  writeln(' Nasabah');
  writeln(' --------');
  writeln;
end;

//= MAIN PROGRAM
var
  command: String;
  commands: Array [1..4] of String = (
                                    'Beranda          Tampilkan Beranda',
                                    'Nasabah          Masuk ke Program Nasabah',
                                    'Tentang          Tampilkan Tentang Program Bankel',
                                    'Keluar           Keluar dari Program Bankel'
                                  );

  customer: Array [0..50] of User;
  customerCmd: Array [1..7] of String = (
                                          'Lihat          Lihat Informasi Lengkap Nasabah',
                                          'Tambah         Tambahkan Nasabah Baru',
                                          'Sunting        Sunting Informasi Nababah',
                                          'Hapus          Hapus Nasabah',
                                          'Simpan         Simpan Data Nasabah ke Inline-Database',
                                          'Kembali        Kembali ke Halaman Depan Program Bankel',
                                          'Keluar         Keluar dari Program Bankel'
                                        );

begin
  head;
  displayMenu(' ', commands);

  command := askCommand;

  while (command <> 'keluar') do
  begin
    if command = 'q' then exit;

    case command of
      '': command := 'beranda';
      ' ': command := 'beranda';
      'beranda': begin
                    head;
                    displayMenu(' ', commands);
                    command := askCommand;
                 end;
      'tentang': begin
                    head;
                    about;
                    displayMenu(' ', commands);
                    command := askCommand;
                 end;
      'nasabah': begin
                    customerHead;

                    if customer[0].id = 0 then
                    begin
                      writeln('  Belum ada data. Tambahkan?');
                      writeln;
                    end;

                    displayMenu('  ', customerCmd);

                    command := askCommand;

                    while (command <> 'kembali') do
                    begin
                      case command of
                        '': begin
                              customerHead;
                              if customer[0].id = 0 then
                              begin
                                writeln('  Belum ada data. Tambahkan?');
                                writeln;
                              end;
                              displayMenu('  ', customerCmd);
                              command := askCommand;
                            end;

                        else begin
                                if (command = 'keluar') or (command = 'q') then exit;

                                customerHead;
                                if customer[0].id = 0 then
                                begin
                                  writeln('  Belum ada data. Tambahkan?');
                                  writeln;
                                end;
                                displayMenu('  ', customerCmd);
                                writeln;
                                writeln(' Perintah "', command, '" tidak dikenali!');
                                command := askCommand;
                             end;
                      end;
                    end;

                    command := 'beranda';
                 end;
      else begin
              head;
              displayMenu(' ', commands);
              writeln;
              writeln(' Perintah "', command, '" tidak dikenali!');
              command := askCommand;
           end;
    end;
  end;

end.
