{
  Bankel
  ------
  Tugas Besar Dasar Algoritma Pemrograman @ Universitas Telkom

  @author     Wisnu Adi Nurcahyo
  @nim        1301160479
  @class      IF40-04
}

Program Bankel;
Uses crt, sysutils, strutils, dos;

{ TYPES }
  { Type Date }
    Type TDate = record
      day: Integer;
      month: Integer;
      year: Integer;
    end;
  { Type Customer }
    Type TCustomer = record
      fullname: String;
      gender: String;
      job: String;
      role: String;
      balance: Int64;
      joined: TDate;
    end;

{ LABEL }
  Label main;

{ FUNCTIONS }
  { Function toNumber }
    Function toNumber(str: String):Int64;
    { I.S: Mengambil masukan dari User berupa String
      F.S: Keluaran berupa Integer berdasarkan masukan dari User }
    var
      i, len: Integer;
      num: Int64;
      containWords: Boolean;
    begin
      len := length(str);
      num := 0;

      if len > 0 then
      begin
        containWords := false;

        for i := 1 to len do
        begin
          if not (str[i] in ['0' .. '9', '-']) then
          begin
            containWords := true;
            break;
          end;
        end;

        if not containWords then num := strToInt64(str);
      end;

      toNumber := num;
    end;
  { TODO: Remove this one }
  { Function containNumber }
    Function containNumber(str: String):Boolean;
    { I.S: Mengambil masukan dari User berupa String
      F.S: Keluaran berupa Boolean hasil dari identifikasi }
    var i, len: Integer;
    begin
      containNumber := false;
      len := length(str);
      for i := 1 to len do
      begin
        if str[i] in ['0' .. '9'] then
        begin
          containNumber := true;
          break;
        end;
      end;
    end;
  { Function takeCommand }
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
  { Function isItCommand }
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
  { Function takeArgument }
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
  { Function formatCurrency }
    Function formatCurrency(balance: Int64):String;
    var
      converted, result: String;
      i, j, len: Integer;
    begin
      converted := intToStr(balance);
      len := length(converted);
      result := '';

      j := 1;
      for i := len downto 1 do
      begin
        result := concat(result, converted[i]);
        if (j mod 3 = 0) and (j < len) then
          result := concat(result, '.');

        inc(j);
      end;

      result := reverseString(result);
      result := concat(result, ',-');
      result := concat('Rp. ', result);

      formatCurrency := result;
    end;
  { Function onlyWords }
    Function onlyWords(str: String):Boolean;
    var i, len: Integer;
    begin
      onlyWords := true;
      len := length(str);

      for i := 1 to len do
      begin
        if not (str[i] in ['a' .. 'z', 'A' .. 'Z', ' ']) then
        begin
          onlyWords := false;
          break;
        end;
      end;
    end;

{ PROCEDURES }
  { Procedure bankelHead }
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
  { Procedure bankelMenu }
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
  { Procedure importDataFrom }
    Procedure importDataFrom(database: String;
                             var customer: Array of TCustomer;
                             var indexes: Integer);
    var
      fileStream: Text;
      i: Integer;
    begin
      assign(fileStream, database);
      reset(fileStream);
      readln(fileStream, indexes);

      if indexes > 0 then
      begin
        for i := 0 to (indexes - 1) do
        begin
          readln(fileStream, customer[i].role);
          readln(fileStream, customer[i].fullname);
          readln(fileStream, customer[i].gender);
          readln(fileStream, customer[i].job);
          readln(fileStream, customer[i].balance);
          readln(fileStream, customer[i].joined.day);
          readln(fileStream, customer[i].joined.month);
          readln(fileStream, customer[i].joined.year);
        end;
      end;

      close(fileStream);
    end;
  { Procedure exportDataTo }
    Procedure exportDataTo(database: String;
                           customer: Array of TCustomer;
                           indexes: Integer);
    var
      fileStream: Text;
      i, j, k: Integer;
      role: String;
      ordinary: Array of TCustomer;
    begin
      assign(fileStream, database);
      rewrite(fileStream);
      writeln(fileStream, indexes);
      setLength(ordinary, 99);

      j := 0;
      if indexes > 0 then
      begin
        for i := 0 to (indexes - 1) do
        begin
          role := customer[i].role;
          if role = 'bisnis' then
          begin
            writeln(fileStream, role);
            writeln(fileStream, customer[i].fullname);
            writeln(fileStream, customer[i].gender);
            writeln(fileStream, customer[i].job);
            writeln(fileStream, customer[i].balance);
            writeln(fileStream, customer[i].joined.day);
            writeln(fileStream, customer[i].joined.month);
            writeln(fileStream, customer[i].joined.year);
          end
          else
          begin
            ordinary[j].role          := role;
            ordinary[j].fullname      := customer[i].fullname;
            ordinary[j].gender        := customer[i].gender;
            ordinary[j].job           := customer[i].job;
            ordinary[j].balance       := customer[i].balance;
            ordinary[j].joined.day    := customer[i].joined.day;
            ordinary[j].joined.month  := customer[i].joined.month;
            ordinary[j].joined.year   := customer[i].joined.year;
            inc(j);
          end;
        end;

        for k := 0 to (j - 1) do
        begin
          writeln(fileStream, ordinary[k].role);
          writeln(fileStream, ordinary[k].fullname);
          writeln(fileStream, ordinary[k].gender);
          writeln(fileStream, ordinary[k].job);
          writeln(fileStream, ordinary[k].balance);
          writeln(fileStream, ordinary[k].joined.day);
          writeln(fileStream, ordinary[k].joined.month);
          writeln(fileStream, ordinary[k].joined.year);
        end;
      end;

      close(fileStream);
    end;
  { Procedure displayErr }
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
  { Procedure displayWarn }
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
  { Procedure displayInfo }
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
  { Procedure displaySucc }
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
  { Procedure displayMsg }
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
  { Procedure displayMessage }
    Procedure displayMessage(number: Byte);
    { I.S: Mengambil nomor error
      F.S: Menampilkan pesan berdasarkan nomor error }
    begin
      case number of
        0: displayMsg(['', '', '', '']);
        1: displayErr(['', 'Perintah tidak dikenali!', '', '']);
        2: displayErr(['', 'Argumen/parameter dibutuhkan!', '', '']);
        3: displayInfo(['', 'Data disimpan di dalam database.txt', '', '']);
        4: displaySucc(['', 'Eksekusi berhasil!', '', '']);
        5: displayErr(['', 'Tidak ada data nasabah yang dapat ditampilkan!', '', '']);
        6: displayErr(['', 'ID yang dicari tidak ada!', '', '']);
        else displayErr(['', 'Kesalahan fatal!', 'Terjadi kesalahan yang tidak diketahui!', '']);
      end;
    end;
  { Procedure askUserFor }
    Procedure askUserFor(var command, argument: String);
    { I.S: Meminta masukan dari User
      F.S: Mengambil Command dan Argument dari User }
    var input: String;
    begin
      write(' Perintah >>  ');
      readln(input);
      command := takeCommand(input);
      argument := takeArgument(input);
    end;
  { Procedure holdOn }
    Procedure holdOn;
    { I.S: -
      F.S: Menahan program hingga User menekan ENTER }
    begin
      write(' (tekan ENTER untuk kembali)');
      readln;
    end;
  { Procedure showInfo }
    Procedure showInfo(indexes: Integer);
    { I.S: -
      F.S: Menampilkan informasi mengenai BANKEL }
    begin
      clrscr;
      bankelHead;

      displayMsg([' Informasi BANKEL', '']);

      writeln('   Nasabah Terdaftar: ', indexes);

      displayMsg(['', '']);
      holdOn;
    end;
  { Procedure addDataToList }
    Procedure addDataToList(var customer: Array of TCustomer;
                            var indexes: Integer;
                            n: Integer;
                            var errnum: Integer);
    var
      i: Integer;
      input, fullname, gender, role, job, balance: String;
      day, month, year, wday: Word;
      num: Int64;
      itIsWords, done, exit: Boolean;
    begin
      if n < 1 then n := 1;

      for i := 1 to n do
      begin
        exit := false;
        repeat
          clrscr;
          bankelHead;

          writeln;
          writeln(' Data ke-', i);
          displayInfo(['', 'Ketik ":k" untuk kembali ke menu utama', '']);

          repeat
            write('  Jenis Akun: (bisnis/pribadi) ');
            readln(role);
            role := lowercase(role);

            if role = ':k' then
            begin
              exit := true;
              break;
            end;

            if (role <> '') and (role <> 'pribadi') and (role <> 'bisnis') then
            begin
              write(' ');
              displayErr(['Harap masukkan "bisnis" atau "pribadi" saja!', '']);
            end;
          until (role = 'bisnis') or (role = 'pribadi');
          writeln;

          if exit = true then break;

          repeat
            write('  Nama Nasabah: ');
            readln(fullname);

            if lowercase(fullname) = ':k' then
            begin
              exit := true;
              break;
            end;

            itIsWords := onlyWords(fullname);

            if not itIsWords then
            begin
              write(' ');
              displayErr(['Harap masukkan huruf dan spasi saja!', '']);
            end;
          until (itIsWords) and (fullname <> '');
          writeln;

          if exit = true then break;

          repeat
            write('  Jenis Kelamin: (P/W) ');
            readln(gender);
            gender := uppercase(gender);

            if gender = ':K' then
            begin
              exit := true;
              break;
            end;

            if ((gender <> 'P') and (gender <> 'W')) and (gender <> '') then
            begin
              write(' ');
              displayErr(['Harap masukkan "P" atau "W" saja!', '']);
            end;
          until (gender = 'P') or (gender = 'W');
          writeln;

          if exit = true then break;

          repeat
            write('  Pekerjaan: ');
            readln(job);

            if lowercase(job) = ':k' then
            begin
              exit := true;
              break;
            end;

            itIsWords := onlyWords(job);

            if not itIsWords then
            begin
              write(' ');
              displayErr(['Harap masukkan huruf dan spasi saja!', '']);
            end;
          until (itIsWords) and (job <> '');
          writeln;

          if exit = true then break;

          repeat
            write('  Tabungan Awal: ');
            readln(balance);

            if lowercase(balance) = ':k' then
            begin
              exit := true;
              break;
            end;

            num := toNumber(balance);

            if num < 1000000 then
            begin
              if role = 'bisnis' then
              begin
                write(' ');
                displayWarn(['Untuk bisnis, tabungan awal minimal Rp. 1.000.000,-', '']);
                write('  Pindahkan ke pribadi? (Y/n) ');
                readln(input);
                writeln;

                if lowercase(input) = 'n' then
                  balance := ''
                else
                  role := 'pribadi';
              end;

              if (role = 'pribadi') and (num < 100000) then
              begin
                write(' ');
                displayWarn(['Untuk pribadi, tabungan awal minimal Rp. 100.000,-', '']);
                write('  Batalkan? (Y/n) ');
                readln(input);
                writeln;

                if lowercase(input) = 'n' then
                  balance := ''
                else
                begin
                  exit := true;
                  break;
                end;
              end;
            end;
          until balance <> '';
          writeln;

          if exit = true then break;

          writeln;
          write('  Sudah benar? (Y/n) ');
          readln(input);
          if lowercase(input) = 'n' then
            done := false
          else
            done := true;
        until done;

        if not exit then
        begin
          customer[indexes].role := role;
          customer[indexes].fullname := fullname;
          customer[indexes].gender := gender;
          customer[indexes].job := job;
          customer[indexes].balance := num;

          getDate(year, month, day, wday);
          customer[indexes].joined.day   := day;
          customer[indexes].joined.month := month;
          customer[indexes].joined.year  := year;

          inc(indexes);
        end;
      end;

      if (not exit) or (i > 1) then errnum := 4;
    end;
  { Procedure resetDataFromList }
    Procedure resetDataFromList(var indexes: Integer;
                                var errnum: Integer);
    var choice: String;
    begin
      clrscr;
      bankelHead;
      writeln(' Menghapus Semua Data Nasabah');
      displayWarn(['', 'Data yang dihapus tidak dapat dikembalikan', '']);

      write(' Yakin hapus? (y/N) ');
      readln(choice);

      if lowercase(choice) = 'y' then
      begin
        indexes := 0;
        errnum := 4;
      end;
    end;
  { Procedure showDataFromList }
    Procedure showDataFromList(customer: Array of TCustomer;
                               arg: Integer;
                               indexes: Integer);
    var i: Integer;
    begin
      clrscr;
      bankelHead;

      displayMsg(['Data Nasabah', '']);
      if arg = 0 then
      begin
        displayMsg(['', '   [ID](tipe akun): Nama Lengkap', '']);

        for i := 0 to (indexes - 1) do
        begin
          writeln('    [', i + 1, ']',
                  '(', customer[i].role, '): ',
                  customer[i].fullname);
        end;
      end
      else
      begin
        arg := arg - 1;
        writeln;
        writeln('   [', arg + 1,']');
        writeln('   Jenis Akun     : ', customer[arg].role);
        writeln('   Nama Lengkap   : ', customer[arg].fullname);
        writeln('   Jenis Kelamin  : ', customer[arg].gender);
        writeln('   Pekerjaan      : ', customer[arg].job);
        writeln('   Tabungan       : ', formatCurrency(customer[arg].balance));
        writeln('   Tanggal Dibuat : ',
                customer[arg].joined.day,
                '/',
                customer[arg].joined.month,
                '/',
                customer[arg].joined.year);
      end;

      displayMsg(['', '']);
      holdOn;
    end;
  { Procedure editDataFromList }
    Procedure editDataFromList(var customer: Array of TCustomer;
                               arg: Integer;
                               var errnum: Integer);
    var
      input, fullname, gender, role, job, balance: String;
      num: Int64;
      done, exit, itIsWords: Boolean;
    begin
      exit := false;
      arg := arg - 1;

      repeat
        clrscr;
        bankelHead;

        writeln;
        writeln(' Menyunting Informasi Nasabah');
        displayInfo(['',
                     'Ketik ":k" untuk kembali ke menu utama',
                     'Biarkan kosong pada bagian yang tidak ingin diubah',
                     '']);

        writeln('                       [', customer[arg].fullname, ']');

        writeln('  [', customer[arg].role, ']');
        repeat
          write('  Jenis Akun: (bisnis/pribadi) ');
          readln(role);
          role := lowercase(role);

          if role = ':k' then
          begin
            exit := true;
            break;
          end;

          if role = '' then
            role := customer[arg].role;

          if role = '' then break;

          if (role <> '') and (role <> 'pribadi') and (role <> 'bisnis') then
          begin
            write(' ');
            displayErr(['Harap masukkan "bisnis" atau "pribadi" saja!', '']);
          end;
        until (role = 'bisnis') or (role = 'pribadi');
        writeln;

        if exit = true then break;

        writeln('  [', customer[arg].fullname, ']');
        repeat
          write('  Nama Nasabah: ');
          readln(fullname);

          if fullname = '' then break;

          if lowercase(fullname) = ':k' then
          begin
            exit := true;
            break;
          end;

          itIsWords := onlyWords(fullname);

          if not itIsWords then
          begin
            write(' ');
            displayErr(['Harap masukkan huruf dan spasi saja!', '']);
          end;
        until itIsWords;
        writeln;

        if exit = true then break;

        writeln('  [', customer[arg].gender, ']');
        repeat
          write('  Jenis Kelamin: (P/W) ');
          readln(gender);
          gender := uppercase(gender);

          if gender = '' then break;

          if gender = ':K' then
          begin
            exit := true;
            break;
          end;

          if ((gender <> 'P') and (gender <> 'W')) and (gender <> '') then
          begin
            write(' ');
            displayErr(['Harap masukkan "P" atau "W" saja!', '']);
          end;
        until (gender = 'P') or (gender = 'W');
        writeln;

        if exit = true then break;

        writeln('  [', customer[arg].job, ']');
        repeat
          write('  Pekerjaan: ');
          readln(job);

          if job = '' then break;

          if lowercase(job) = ':k' then
          begin
            exit := true;
            break;
          end;

          itIsWords := onlyWords(job);

          if not itIsWords then
          begin
            write(' ');
            displayErr(['Harap masukkan huruf dan spasi saja!', '']);
          end;
        until itIsWords;
        writeln;

        if exit = true then break;

        writeln('  [', formatCurrency(customer[arg].balance), ']');
        repeat
          write('  Tabungan: ');
          readln(balance);

          if lowercase(balance) = ':k' then
          begin
            exit := true;
            break;
          end;

          if balance <> '' then
            num := toNumber(balance)
          else
            num := customer[arg].balance;

          if balance = '' then balance := '_';

          if num < 1000000 then
          begin
            if role = 'bisnis' then
            begin
              write(' ');
              displayWarn(['Untuk bisnis, tabungan awal minimal Rp. 1.000.000,-', '']);
              write('  Pindahkan ke pribadi? (Y/n) ');
              readln(input);
              writeln;

              if lowercase(input) = 'n' then
                balance := ''
              else
                role := 'pribadi';
            end;

            if (role = 'pribadi') and (num < 100000) then
            begin
              write(' ');
              displayWarn(['Untuk pribadi, tabungan awal minimal Rp. 100.000,-', '']);
              write('  Batalkan? (Y/n) ');
              readln(input);
              writeln;

              if lowercase(input) = 'n' then
                balance := ''
              else
              begin
                exit := true;
                break;
              end;
            end;
          end;
        until balance <> '';
        writeln;

        if exit = true then break;

        writeln;
        write('  Sudah benar? (Y/n) ');
        readln(input);
        if lowercase(input) = 'n' then
          done := false
        else
          done := true;
      until done;

      if not exit then
      begin
        if role <> '' then customer[arg].role := role;
        if fullname <> '' then customer[arg].fullname := fullname;
        if gender <> '' then customer[arg].gender := gender;
        if job <> '' then customer[arg].job := job;
        if balance <> '' then customer[arg].balance := num;

        if done then errnum := 4;
      end;
    end;
  { Procedure removeDataFromList }
    Procedure removeDataFromList(var customer: Array of TCustomer;
                                 arg: Integer;
                                 var indexes: Integer;
                                 var errnum: Integer);
    var
      i, j: Integer;
      remove: String;
    begin
      clrscr;
      bankelHead;
      arg := arg - 1;

      writeln;
      writeln(' Data nasabah milik "', customer[arg].fullname,
              '" (', customer[arg].role ,') akan dihapus');
      displayWarn(['', 'Data yang dihapus tidak dapat dikembalikan', '']);
      write(' Yakin hapus? (y/N) ');
      readln(remove);

      if lowercase(remove) = 'y' then
      begin
        if arg < (indexes - 1) then
        begin
          for i := arg to (indexes - 2) do
          begin
            j := i + 1;
            customer[i].role     := customer[j].role;
            customer[i].fullname := customer[j].fullname;
            customer[i].gender   := customer[j].gender;
            customer[i].job      := customer[j].job;
            customer[i].balance  := customer[j].balance;
          end;
        end;

        indexes := indexes - 1;
        errnum := 4;
      end;
    end;


{ MAIN }
Var
  customer: Array of TCustomer;
  command, argument, database: String;
  arg, errnum, indexes: Integer;

Begin
  database := 'database.txt';
  indexes := 0;
  setLength(customer, 99);

  if fileExists(database) then
    importDataFrom(database, customer, indexes);

  errnum := 3;
  command := '';
  TextColor(7);

  main: clrscr;
        bankelHead;
        bankelMenu;
        displayMessage(errnum);

        exportDataTo(database, customer, indexes);
        importDataFrom(database, customer, indexes);

        askUserFor(command, argument);
        arg := toNumber(argument);

        while command <> 'keluar' do
        begin
          if isItCommand(command) then
          begin
            errnum := 0;

            case command of
              'info'   : showInfo(indexes);
              'tambah' : addDataToList(customer, indexes, arg, errnum);
              'sunting': begin
                            if arg = 0 then
                              errnum := 2
                            else
                            begin
                              if (arg > 0) and (arg <= indexes) then
                                editDataFromList(customer, arg, errnum)
                              else
                                errnum := 6;
                            end;
                         end;
              'lihat'  : begin
                            if indexes > 0 then
                            begin
                              if (arg = 0) or ((arg > 0) and (arg <= indexes)) then
                                showDataFromList(customer, arg, indexes)
                              else
                                errnum := 6;
                            end
                            else
                              errnum := 5;
                         end;
              'hapus'  : begin
                            if arg = 0 then
                              errnum := 2
                            else
                            begin
                              if (arg > 0) and (arg <= indexes) then
                                removeDataFromList(customer, arg, indexes, errnum)
                              else
                                errnum := 6;
                            end;
                         end;
              'reset'  : resetDataFromList(indexes, errnum);
            end;

            goto main;
          end
          else
          begin
            errnum := 1;
            goto main;
          end;
        end;

  exportDataTo(database, customer, indexes);
End.
