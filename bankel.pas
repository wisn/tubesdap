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

Program Bankel;
Uses crt, sysutils;

{------------- [ TYPE ]  -------------}
{ Type Date }
Type TDate = record
  minute: Integer;
  hour: Integer;
  day: Integer;
  month: Integer;
  year: Integer;
end;
{ Type Transaction }
Type TTransaction = record
  date: TDate;
  iocome: Integer;
end;
{ Type Customer }
Type TCustomer = record
  fullname: String;
  gender: Char;
  role: String;
  balance: Integer;
  transaction: Array of TTransaction;
  joined: TDate;
end;
{------------- [ END ]  -------------}

{------------- [ LABEL ]  -------------}
Label main;
{------------- [  END  ]  -------------}

{------------- [ FUNCTION ]  -------------}
Function toNumber(str: String):Integer;
var i, len, num, x: Integer;
begin
  len := length(str);
  num := 0;

  if len > 0 then
  begin
    x := 1;
    for i := 1 to len do
    begin
      if not (str[i] in ['0' .. '9']) then
      begin
        x := 0;
        break;
      end;
    end;

    if x > 0 then num := strToInt(str);
  end;

  toNumber := num;
end;
Function takeCommand(text: String):String;
{ I.S: Mengambil masukan dari user
  F.S: Keluaran berupa kata yang dianggap sebagai command }
var
  result: String;
  len, i: Integer;
begin
  len := length(text);
  text := concat(text, ' ');
  result := '';
  for i := 1 to len do
  begin
    if text[i] <> ' ' then
    begin
      result := concat(result, text[i]);
      if text[i + 1] = ' ' then break;
    end;
  end;
  takeCommand := result;
end;
Function isItCommand(command: String):Boolean;
{ I.S: Mengambil masukan dari user
  F.S: Keluaran berupa Boolean dari hasil apakah itu command atau bukan }
var exist: Boolean;
begin
  case command of
    '':        exist := true;
    'beranda': exist := true;
    'info':    exist := true;
    'tambah':  exist := true;
    'sunting': exist := true;
    'lihat':   exist := true;
    'hapus':   exist := true;
    'reset':   exist := true;
    else       exist := false;
  end;
  isItCommand := exist;
end;
Function takeArgument(text: String):String;
{ I.S: Mengambil masukan dari user
  F.S: Keluaran berupa kata yang dianggap sebagai argument }
var
  result: String;
  len, i, x: Integer;
begin
  len := length(text);
  text := concat(text, ' ');
  result := '';
  x := 0;
  for i := 1 to len do
  begin
    if text[i] <> ' ' then
    begin
      if x > 0 then
      begin
        result := concat(result, text[i]);
        if text[i + 1] = ' ' then break;
      end;
      if text[i + 1] = ' ' then inc(x);
    end;
  end;
  takeArgument := result;
end;
{------------- [   END   ]  -------------}

{------------- [ PROCEDURE ]  -------------}
Procedure bankelHead;
{ I.S: -
  F.S: Menampilkan Header Program }
begin
  writeln('                                                                        ');
  writeln('                                 BANKEL                                 ');
  writeln('                        Program Manajemen Nasabah                       ');
  writeln('                                                                        ');
  writeln;
end;
Procedure bankelMenu;
{ I.S: -
  F.S: Menampilkan Menu Program }
begin
  writeln(' Daftar Perintah                                                        ');
  writeln('   beranda                 Menuju ke Beranda                            ');
  writeln('   info                    Menampilkan informasi BANKEL (status)        ');
  writeln('   tambah                  Menambahkan nasabah baru                     ');
  writeln('   tambah <n>              Menambahkan nasabah baru sebanyak n          ');
  writeln('                           contoh: tambah 2                            ');
  writeln('   sunting <id>            Menyunting data nasabah berdasarkan id       ');
  writeln('                           contoh: sunting 3                            ');
  writeln('   lihat                   Tampilkan semua nasabah secara ringkas       ');
  writeln('   lihat <id>              Menampilkan data nasabah berdasarkan id      ');
  writeln('                           contoh: lihat 5                              ');
  writeln('   hapus <id>              Hapus data nasabah berdasarkan id            ');
  writeln('                           contoh: hapus 7                              ');
  writeln('   reset                   Hapus semua data nasabah                     ');
  writeln('   keluar                  Keluar dari Bankel                           ');
  writeln;
end;
Procedure importDataFrom(database: String; var customer: Array of TCustomer);
var fileStream: Text;
begin
  assign(fileStream, database);
  reset(fileStream);
  close(fileStream);
end;
Procedure exportDataTo(database: String; customer: Array of TCustomer);
var
  fileStream: Text;
  len: Integer;
begin
  assign(fileStream, database);
  rewrite(fileStream);
  len := length(customer);

  writeln(fileStream, 'BANKEL DATABASE');
  if len > 0 then
  begin

  end;

  close(fileStream);
end;
Procedure displayErr(text: Array of String);
{ I.S: Mengambil array dengan isi String
  F.S: Mencetak masing-masing nilai array }
var i, len: Integer;
begin
  len := length(text);
  for i := 0 to (len - 1) do
  begin
    if text[i] = '' then
      writeln
    else
    begin
      write(' [ ');
      TextColor(4);
      write('ERR');
      TextColor(7);
      write(' ] ');
      writeln(text[i]);
    end;
  end;
end;
Procedure displayWarn(text: Array of String);
{ I.S: Mengambil array dengan isi String
  F.S: Mencetak masing-masing nilai array }
var i, len: Integer;
begin
  len := length(text);
  for i := 0 to (len - 1) do
  begin
    if text[i] = '' then
      writeln
    else
    begin
      write(' [ ');
      TextColor(14);
      write('WARN');
      TextColor(7);
      write(' ] ');
      writeln(text[i]);
    end;
  end;
end;
Procedure displayInfo(text: Array of String);
{ I.S: Mengambil array dengan isi String
  F.S: Mencetak masing-masing nilai array }
var i, len: Integer;
begin
  len := length(text);
  for i := 0 to (len - 1) do
  begin
    if text[i] = '' then
      writeln
    else
    begin
      write(' [ ');
      TextColor(1);
      write('INFO');
      TextColor(7);
      write(' ] ');
      writeln(text[i]);
    end;
  end;
end;
Procedure displaySucc(text: Array of String);
{ I.S: Mengambil array dengan isi String
  F.S: Mencetak masing-masing nilai array }
var i, len: Integer;
begin
  len := length(text);
  for i := 0 to (len - 1) do
  begin
    if text[i] = '' then
      writeln
    else
    begin
      write(' [ ');
      TextColor(2);
      write('SUCC');
      TextColor(7);
      write(' ] ');
      writeln(text[i]);
    end;
  end;
end;
Procedure displayMsg(text: Array of String);
{ I.S: Mengambil array dengan isi String
  F.S: Mencetak masing-masing nilai array }
var i, len: Integer;
begin
  len := length(text);
  for i := 0 to (len - 1) do
  begin
    if text[i] = '' then
      writeln
    else
      writeln(' ', text[i]);
  end;
end;
Procedure displayMessage(number: Byte);
{ I.S: Mengambil nomor error
  F.S: Menampilkan pesan berdasarkan nomor error }
begin
  case number of
    0: displayMsg(['', '', '', '']);
    1: displayErr(['', 'Perintah tidak dikenali!', '', '']);
    2: displayWarn(['', 'Perintah tidak dikenali!', '', '']);
    3: displayInfo(['', 'Data disimpan di dalam database.txt!', '', '']);
    4: displaySucc(['', 'Eksekusi berhasil!', '', '']);
    else displayErr(['', 'Kesalahan fatal!', 'Terjadi kesalahan yang tidak diketahui!', '']);
  end;
end;
Procedure askUserFor(var command, argument: String);
var input: String;
begin
  write(' Perintah >>  ');
  readln(input);
  command := takeCommand(input);
  argument := takeArgument(input);
end;
Procedure showInfo;
begin
  clrscr;
  bankelHead;
  displayMsg(['Informasi BANKEL',
              '  Nasabah terdaftar: XXX',
              '',
              '']);
end;
{------------- [    END    ]  -------------}

Var
  customer: Array of TCustomer;
  input, command, argument, database: String;
  errnum, indexes, i: Integer;
  tmp: Array of Integer;

Begin
  database := 'database.txt';
  if fileExists(database) then
    importDataFrom(database, customer);

  errnum := 3;
  command := '';
  TextColor(7);

  main: clrscr;
        bankelHead;
        bankelMenu;
        displayMessage(errnum);

        askUserFor(command, argument);

        while command <> 'keluar' do
        begin
          if isItCommand(command) then
          begin
            errnum := 0;

            case command of
              'info': showInfo;
              'tambah': goto main;
              'sunting': goto main;
              'lihat': goto main;
              'hapus': goto main;
              'reset': goto main;
            end;

            if (command <> '') and (command <> 'beranda') then
              askUserFor(command, argument);

            goto main;
          end
          else
          begin
            errnum := 1;
            goto main;
          end;
        end;

  exportDataTo(database, customer);
End.
