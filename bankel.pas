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
Uses crt;

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
Function takeCommand(text: String):String;
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
  writeln('   info                    Menampilkan informasi Bankel (status)        ');
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
Procedure displayMessage(number: Byte);
{ I.S: Mengambil nomor pesan
  F.S: Menampilkan pesan berdasarkan nomor }
var
  msg: String;
begin
  case number of
    1: begin
      writeln;
      write(' [ ');
      TextColor(4);
      write('GALAT');
      TextColor(7);
      write(' ] ');
      writeln('Perintah tidak dikenali!');
      writeln;
      writeln;
    end;
    2: begin
      writeln;
      write(' [ ');
      TextColor(14);
      write('PERINGATAN');
      TextColor(7);
      write(' ] ');
      writeln('---');
      writeln;
      writeln;
    end;
    3: begin
      writeln;
      write(' [ ');
      TextColor(1);
      write('INFO');
      TextColor(7);
      write(' ] ');
      writeln('Data disimpan di dalam database.txt');
      writeln;
      writeln;
    end;
    4: begin
      writeln;
      write(' [ ');
      TextColor(2);
      write('SUKSES');
      TextColor(7);
      write(' ] ');
      writeln('Eksekusi berhasil!');
      writeln;
      writeln;
    end;
    else begin
      writeln;
      writeln;
      writeln;
      writeln;
    end;
  end;
end;
{------------- [    END    ]  -------------}

Var
  database: Text;
  customer: Array of TCustomer;
  input, command: String;
  errnum, indexes, i: Integer;
  tmp: Array of Integer;

Begin
  errnum := 3;
  TextColor(7);
  main: clrscr;
        bankelHead;
        bankelMenu;
        displayMessage(errnum);
        write(' Perintah >>  ');
        readln(input);
        command := takeCommand(input);
        while command <> 'keluar' do
        begin
          if isItCommand(command) then
          begin
            errnum := 0;
            goto main;
          end
          else
          begin
            errnum := 1;
            goto main;
          end;
        end;
End.
