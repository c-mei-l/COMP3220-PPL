load "TinyToken.rb"
load "TinyScanner.rb"
# if the file(s) are in the same directory, you can simply precede
# the file name(s) with ./

# filename.txt below is simply the "source code"
# that you write that adheres to your grammar rules
# if it is in the same directory as this file, you can
# simply include the file name, otherwise, you will need
# to specify the entire path to the file as we did above
# to load the other ruby modules

if File.exists?("filename.txt")

scan = Scanner.new("filename.txt")


# the code below will open a file so that I
# can save tokens to it
tokenFile = File.open("tokens", "w")
tok = scan.nextToken()

# keep "fetching" one token at a time, using your scanner
# until there are no tokens left to scan
while (tok.get_type != Token::EOF)
  puts "Token: #{tok} type: #{tok.get_type}"

   # The instruction below writes your token into a file.
   tokenFile.write ("Token: #{tok} type: #{tok.get_type} \n")

   # get the next token available (if there is one)
   tok = scan.nextToken()
end

puts "Token: #{tok} type: #{tok.get_type}"
tokenFile.write("Token:#{tok} type: #{tok.get_type} \n")

# There should be one token left (see the boolean condition above)
# putting the last token in the file and closing the file

tokenFile.close
else
  puts "The file dose not exist"
end
