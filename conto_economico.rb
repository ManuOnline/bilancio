=begin
Con la shell MySQL ho creato il database 'bilancio', nome utente 'contabile' e
password: '1234'.
Il nome della tabella sarà: 'conto_economico'
=end

require 'mysql'

begin
  dbh = Mysql.new("localhost", "contabile", "1234", "bilancio")

  dbh.query("DROP TABLE IF EXISTS conto_economico")
  
  dbh.query("CREATE TABLE conto_economico (
            lettera CHAR(4),
            voce CHAR(90) NOT NULL,
            importo FLOAT(12,2) NOT NULL
  );")
  
  puts 'Tabella "conto_economico" creata.'
  
  dbh.query("INSERT INTO conto_economico (lettera, voce, importo) VALUES
            ('A)', 'Valore della produzione', '5000'),
            ('B)', 'Costi della produzione', '4300'),
            ('', 'reddito operativo', '700'),
            ('C)', 'Proventi e oneri finanziari', '0'),
            ('', 'proventi finanziari', '20'),
            ('', 'oneri finanziari', '20'),
            ('D)', 'Rettifiche del valore delle attivita finanziarie', '0'),
            ('', 'Reddito della gestione ordinaria', '700'),
            ('E)', 'Proventi e oneri straordinari', '-500'),
            ('', 'Risultato prima delle imposte', '200'),
            ('', 'Imposte', '50'),
            ('', 'Risultato (utile/perdita) di esercizio', '150')            
  ;")
  
  puts "#{dbh.affected_rows} voci inserite."
  
    result = dbh.query("SELECT * FROM conto_economico")
  
  puts
  puts " . . . . : : : : CONTO ECONOMICO : : : : . . . . ".center(80)
  puts
  
  result.each_hash do |row|
    puts "#{row['lettera']} #{row['voce']}".ljust(64) + "euro".rjust(6) + "#{row['importo']}".rjust(10)
  end
  result.free  
  
  dbh.close
rescue MysqlError => e
  print "Error code: ", e.errno,"\n"
  print "Error message: ", e.error,"\n"
end
