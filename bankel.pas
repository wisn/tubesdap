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
  balance: Integer;
  transaction: Array of TTransaction;
  joined: TDate;
end;
{------------- [ END ]  -------------}

{------------- [ LABEL ]  -------------}
Label main;
{------------- [  END  ]  -------------}

{------------- [ FUNCTION ]  -------------}
Function isItCommand(command: String):Boolean;
var exist: Boolean;
begin
  case command of
    '':        exist := true;
    'beranda': exist := true;
    'info':    exist := true;
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
  writeln('   sunting <id>            Menyunting data nasabah berdasarkan id       ');
  writeln('                           contoh: sunting 2                            ');
  writeln('   lihat                   Tampilkan semua nasabah secara ringkas       ');
  writeln('   lihat <id>              Menampilkan data nasabah berdasarkan id      ');
  writeln('                           contoh: lihat 3                              ');
  writeln('   hapus <id>              Hapus data nasabah berdasarkan id            ');
  writeln('                           contoh: hapus 5                              ');
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
    1: msg := ' [ GALAT ] Perintah tidak dikenali!';
    else msg := '';
  end;

  writeln;
  writeln(msg);
  writeln;
  writeln;
end;
{------------- [    END    ]  -------------}

Var
  customer: Array of TCustomer;
  command: String;
  errnum, indexes, i: Integer;
  tmp: Array of Integer;

Begin
  main: clrscr;
        bankelHead;
        bankelMenu;
        displayMessage(errnum);
        write(' Perintah >>  ');
        readln(command);
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
