# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
#
#  "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID
#
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Class Scanner - Reads a TINY program and emits tokens
#
class Scanner
# Constructor - Is passed a file to scan and outputs a token
#               each time nextToken() is invoked.
#   @c        - A one character lookahead
	def initialize(filename)
		# Need to modify this code so that the program
		# doesn't abend if it can't open the file but rather
		# displays an informative message



		# Go ahead and read in the first character in the source
		# code file (if there is one) so that you can begin
		# lexing the source code file
		if(!File.exist?(filename))
				puts "The file does not exist"
				exit

			else
				@f = File.open(filename,'r:utf-8')

				if (! @f.eof?)
					@c = @f.getc()
				else
					@c = "!eof!"
					@f.close()
				end
			end
		end



	# Method nextCh() returns the next character in the file
	def nextCh()
		if (!@f.eof?)
			@c = @f.getc
		else
			@c = "!eof!"
		end
	end

	# Method nextToken() reads characters in the file and returns
	# the next token
	# You should also print what you find. Follow the format from the
	# example given in the instructions.
	def nextToken()
		if @c == "!eof!"
			Token.new(Token::EOF,"!eof!")

		elsif (whitespace?(@c))
			str =""

			while whitespace?(@c)
				str += @c
				nextCh()
			end

			Token.new(Token::WS,str)

		# elsif ...
		# more code needed here! complete the code here
		# so that your lexer can correctly recognize,
		# display and return all tokens
		# in our grammar that we found in the source code file

	elsif (letter?(@c))
		str = ""

		while (letter?(@c))
			str += @c
			nextCh()
		end


		if (str == "print")
			Token.new(Token:: PRINT, str)

		else
			Token.new(Token::ID,str)
		end

	elsif (numeric? (@c))
		str = ""

		while (numeric? (@c))
			str += @c
			nextCh()
		end

		 Token.new(Token::INT, str)

	elsif (@c == "=")
		nextCh()
		 Token.new(Token::ASSIGNOP, "=")

	elsif (@c == "*")
		nextCh()
		Token.new(Token::MULTOP, "*")

	elsif (@c == "/")
		nextCh()
		Token.new(Token::DIVOP, "/")

	elsif (@c == "+")
		nextCh()
		Token.new(Token::ADDOP, "+")

	elsif (@c == "-")
		nextCh()
		Token.new(Token::SUBOP, "-")

	elsif (@c == "(")
		nextCh()
		Token.new(Token::LPAREN, "(")

	elsif (@c == ")")
		nextCh()
		Token.new(Token::RPAREN, ")")


		# FYI: You don't HAVE to just stick to if statements
		# any type of selection statement "could" work. We just need
		# to be able to programatically identify tokens that we
		# encounter in our source code file.

		# don't want to give back nil token!
		# remember to include some case to handle
		# unknown or unrecognized tokens.
		# below I make the token that you should pass back

	elsif (@c =="!")
		nextCh()
		Token.new(Token:: UNKNOWN, unknown)

	else
		unknown = @c
		nextCh()
		Token.new(Token:: UNKNOWN,unknown)
	end
 end
end

#
# Helper methods for Scanner
#
def letter?(lookAhead)
	lookAhead =~ /^[a-z]|[A-Z]$/
end

def numeric?(lookAhead)
	lookAhead =~ /^(\d)+$/
end

def whitespace?(lookAhead)
	lookAhead =~ /^(\s)+$/
end
